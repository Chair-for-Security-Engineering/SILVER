/*
 * -----------------------------------------------------------------
 * COMPANY : Ruhr-Universit�t Bochum, Chair for Security Engineering
 * AUTHOR  : Pascal Sasdrich (pascal.sasdrich@rub.de)
 * DOCUMENT: https://doi.org/10.1007/978-3-030-64837-4_26
 *           https://eprint.iacr.org/2020/634.pdf
 * -----------------------------------------------------------------
 *
 * Copyright (c) 2020, Pascal Sasdrich
 *
 * All rights reserved.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTERS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Please see LICENSE and README for license and further instructions.
 */

#include "config.hpp"
#include "Silver.hpp"

#include "parser/verilogParser.h"

#include <chrono>
#include <iomanip>
#include <iostream>

#include <boost/program_options.hpp>

namespace po = boost::program_options;

static std::chrono::time_point<std::chrono::high_resolution_clock> start;

static void INFO(const std::string info) {
    std::chrono::duration<double, std::ratio<1>> elapsed = std::chrono::high_resolution_clock::now() - start;
    std::cout << "[" << std::setw(10) << std::fixed << std::setprecision(3) << elapsed.count() << "] " << info;
};

#define str(i) std::to_string(i)
#define time std::chrono::high_resolution_clock::now()

//
// Construct an argument parser using the boost program_options libary.
po::options_description build_argument_parser(
    silver_config_t * cfg
) {
    po::options_description all("Silver arguments");
    all.add_options()
    ("help" , "Show the help message")

    ("cores", po::value<unsigned int>(&cfg->CORES)->default_value(0),
        "Maximum number of CPU cores to use. Set to 0 (default) for auto-detect")

    ("memory", po::value<size_t>(&cfg->MEMORY)->default_value(1*1024*1024*1024ull),
        "RAM (in Bytes) used by Sylvan BDD library.")

    ("verbose", po::value<bool>(&cfg->VERBOSE)->default_value(false),
        "Be verbose (or not) in printing detailed test reports.")

    ("verilog", po::value<bool>(&cfg->PARSE_VERILOG)->default_value(false),
        "Parse the verilog design described by the --verilog-* parameters.")

    ("verilog-libfile",po::value<std::string>(&cfg->LIBFILE)->default_value("cell/Library.txt"),
        "Technology library description.")

    ("verilog-libname",po::value<std::string>(&cfg->LIBNAME)->default_value("NANG45"),
        "Technology library name.")

    ("verilog-design_file",po::value<std::string>(&cfg->DESIGN)->default_value("vlog/aes/AES_Sbox_DOM/2-Synthesized/aes_sbox_dom1.v"),
        "Verilg source file containing the design.")

    ("verilog-module_name",po::value<std::string>(&cfg->MODULE)->default_value("aes_sbox"),
        "Module contained within the verilog source to verify.")

    ("insfile",po::value<std::string>(&cfg->INSFILE)->default_value("test/aes/aes_sbox_dom1.nl"),
        "Instruction list to parse and process. Either externally provided or result of verilog parser")

    ("disable-probing-standard", po::value<bool>(&cfg->PROBING_S)->default_value(true)->implicit_value(false),
        "Disables the standard probing security check.")

    ("disable-probing-robust", po::value<bool>(&cfg->PROBING_R)->default_value(true)->implicit_value(false),
        "Disables the robust probing security check.")

    ("disable-ni-standard", po::value<bool>(&cfg->NI_S)->default_value(true)->implicit_value(false),
        "Disables the standard NI security check.")

    ("disable-ni-robust", po::value<bool>(&cfg->NI_R)->default_value(true)->implicit_value(false),
        "Disables the robust NI security check.")

    ("disable-sni-standard", po::value<bool>(&cfg->SNI_S)->default_value(true)->implicit_value(false),
        "Disables the standard SNI security check.")

    ("disable-sni-robust", po::value<bool>(&cfg->SNI_R)->default_value(true)->implicit_value(false),
        "Disables the robust SNI security check.")

    ("disable-pini-standard", po::value<bool>(&cfg->PINI_S)->default_value(true)->implicit_value(false),
        "Disables the standard PINI security check.")

    ("disable-pini-robust", po::value<bool>(&cfg->PINI_R)->default_value(true)->implicit_value(false),
        "Disables the robust PINI security check.")

    ("disable-uniformity", po::value<bool>(&cfg->UNIFORMITY)->default_value(true)->implicit_value(false),
        "Disables the uniformity check.")
    ;

    return all;
}

int main (int argc, char * argv[]) {

    /* Configuration options / command line arguments */
    silver_config_t cfg;

    /* Build the argument parser and run it on argc/argv */
    po::options_description desc = build_argument_parser(&cfg);
    po::variables_map vm;
    po::store(po::parse_command_line(argc, argv, desc), vm);
    po::notify(vm);

    if (vm.count("help")) {
        std::cout << desc << std::endl;
        return 0;
    }

    /* Variable declarations */    
    Circuit model;
    std::vector<Node> probes;

    int order, minimal = 0;
    bool check;

    /* Start LACE framework */
    lace_init(cfg.CORES, 0);
    lace_startup(0, NULL, NULL);

    /* Start BDD session */
    sylvan::sylvan_set_limits(cfg.MEMORY, 0, 10);
    sylvan::sylvan_init_package();
    sylvan::sylvan_init_mtbdd();

    /* Extract Designs Under Test */
    std::string dut = cfg.INSFILE;

    /* Start time tracking */
    start = std::chrono::high_resolution_clock::now();

    /* Parse & convert verilog design to instruction list */
    if(cfg.PARSE_VERILOG) {
        INFO("Parsing verilog design " + cfg.DESIGN + " with top module " + cfg.MODULE +"\n");
        int res = parse_and_convert_wrapper(
            cfg.LIBFILE, cfg.LIBNAME, cfg.DESIGN, cfg.MODULE, cfg.INSFILE
        );
        if (res) {
            std::cout << "Verilog design parsing failed." << std::endl;
            return res;
        }
    }

    /* Parse circuit from text file*/
    INFO("Netlist: " + dut + "\n");
    model = Silver::parse(dut);
    if (cfg.VERBOSE) INFO("Parse: " + str(num_vertices(model)) + " gate(s) / " + str(num_edges(model))  + " signal(s)\n");

    /* Elabotare circuit model */
    std::map<int, Probes> inputs = Silver::elaborate(model);
    if (cfg.VERBOSE) INFO("Elaborate: " + str(num_vertices(model)) + " gate(s) / " + str(num_edges(model))  + " signal(s)\n");

    /* Find smallest sharing */
    for (int index = 0; index < inputs.size(); index++) {
        minimal = (inputs[index].size() < inputs[minimal].size()) ? index : minimal;
    }

    /* Define order of security (based on minimal sharing) */
    order = inputs[minimal].size() - 1;

    /* Standard probing security */
    if (cfg.PROBING_S) {
        probes = Silver::check_Probing(model, inputs, order, false);

        if (probes.size() - 1 != 0) INFO("probing.standard (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
        else                        INFO("probing.standard (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
        if (cfg.VERBOSE) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }
    }

    /* Robust probing security */
    if (cfg.PROBING_R) {
        probes = Silver::check_Probing(model, inputs, order, true);

        if (probes.size() - 1 != 0) INFO("probing.robust   (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
        else                        INFO("probing.robust   (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
        if (cfg.VERBOSE) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }   
    }
    
    /* Standard non-interference */
    if (cfg.NI_S) {
        probes = Silver::check_NI(model, inputs, order, false);

        if (probes.size() - 1 != 0) INFO("NI.standard      (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
        else                        INFO("NI.standard      (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
        if (cfg.VERBOSE) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }
    }

    /* Robust non-interference */
    if (cfg.NI_R) {
        probes = Silver::check_NI(model, inputs, order, true);

        if (probes.size() - 1 != 0) INFO("NI.robust        (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
        else                        INFO("NI.robust        (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
        if (cfg.VERBOSE) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }
    }
    
    /* Standard strong non-interference */
    if (cfg.SNI_S) {
        probes = Silver::check_SNI(model, inputs, order, false);

        if (probes.size() - 1 != 0) INFO("SNI.standard     (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
        else                        INFO("SNI.standard     (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
        if (cfg.VERBOSE) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }
    }

    /* Robust strong non-interference */
    if (cfg.SNI_R) {
        probes = Silver::check_SNI(model, inputs, order, true);

        if (probes.size() - 1 != 0) INFO("SNI.robust       (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
        else                        INFO("SNI.robust       (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
        if (cfg.VERBOSE) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }
    }
    
    /* Standard probe-isolating non-interference */
    if (cfg.PINI_S) {
        probes = Silver::check_PINI(model, inputs, order, false);

        if (probes.size() - 1 != 0) INFO("PINI.standard    (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
        else                        INFO("PINI.standard    (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
        if (cfg.VERBOSE) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }
    }

    /* Robust probe-isolating non-interference */
    if (cfg.PINI_R) {
        probes = Silver::check_PINI(model, inputs, order, true);

        if (probes.size() - 1 != 0) INFO("PINI.robust      (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
        else                        INFO("PINI.robust      (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
        if (cfg.VERBOSE) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }
    }

    /* Standard uniformity check */
    if (cfg.UNIFORMITY) {
        bool uniform = Silver::check_Uniform(model);

        if (uniform)  INFO("uniformity               -- \033[1;32mPASS\033[0m.\n");
        else          INFO("uniformity               -- \033[1;31mFAIL\033[0m.\n");
    }

    /* Remove model graph from memory */
    model.clear();

    /* Terminate BDD session */
    sylvan::sylvan_stats_report(stdout);
    sylvan::sylvan_quit();

    lace_exit();

    return 0;
}
