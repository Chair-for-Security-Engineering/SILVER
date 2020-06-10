/*
 * -----------------------------------------------------------------
 * COMPANY : Ruhr-Universität Bochum, Chair for Security Engineering
 * AUTHOR  : Pascal Sasdrich (pascal.sasdrich@rub.de)
 * DOCUMENT: https://eprint.iacr.org/2020/634.pdf
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
 * Please see license.rtf and README for license and further instructions.
 */

#include "config.hpp"
#include "Silver.hpp"

#include <chrono>
#include <iomanip>
#include <iostream>

static std::chrono::time_point<std::chrono::high_resolution_clock> start;

static void INFO(const std::string info) {
    std::chrono::duration<double, std::ratio<1>> elapsed = std::chrono::high_resolution_clock::now() - start;
    std::cout << "[" << std::setw(10) << std::fixed << std::setprecision(3) << elapsed.count() << "] " << info;
};

#define str(i) std::to_string(i)
#define time std::chrono::high_resolution_clock::now()

int main (int argc, char * argv[]) {

    /* Variable declarations */    
    Circuit model;
    std::vector<Node> probes;

    int order, minimal = 0;
    bool check;

    /* Start LACE framework */
    lace_init(CORES, 0);
    lace_startup(0, NULL, NULL);

    /* Start BDD session */
    sylvan::sylvan_set_limits(MEMORY, 0, 10);
    sylvan::sylvan_init_package();
    sylvan::sylvan_init_mtbdd();

    /* Extract Designs Under Test */
    std::string dut = "test/dom/dom1.nl";

    /* Start time tracking */
    start = std::chrono::high_resolution_clock::now();

    /* Parse circuit from text file*/
    INFO("Netlist: " + dut + "\n");
    model = Silver::parse(dut);
    if (VERBOSE > 0) INFO("Parse: " + str(num_vertices(model)) + " gate(s) / " + str(num_edges(model))  + " signal(s)\n");

    /* Elabotare circuit model */
    std::map<int, Probes> inputs = Silver::elaborate(model);
    if (VERBOSE > 0) INFO("Elaborate: " + str(num_vertices(model)) + " gate(s) / " + str(num_edges(model))  + " signal(s)\n");

    /* Find smallest sharing */
    for (int index = 0; index < inputs.size(); index++) {
        minimal = (inputs[index].size() < inputs[minimal].size()) ? index : minimal;
    }

    /* Define order of security (based on minimal sharing) */
    order = inputs[minimal].size() - 1;

    /* Standard probing security */
    probes = Silver::check_Probing(model, inputs, order, false);

    if (probes.size() - 1 != 0) INFO("probing.standard (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
    else                        INFO("probing.standard (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
    if (VERBOSE > 0) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }

    /* Robust probing security */
    probes = Silver::check_Probing(model, inputs, order, true);

    if (probes.size() - 1 != 0) INFO("probing.robust   (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
    else                        INFO("probing.robust   (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
    if (VERBOSE > 0) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }
    
    /* Standard non-interference */
    probes = Silver::check_NI(model, inputs, order, false);

    if (probes.size() - 1 != 0) INFO("NI.standard      (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
    else                        INFO("NI.standard      (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
    if (VERBOSE > 0) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }

    /* Robust non-interference */
    probes = Silver::check_NI(model, inputs, order, true);

    if (probes.size() - 1 != 0) INFO("NI.robust        (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
    else                        INFO("NI.robust        (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
    if (VERBOSE > 0) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }
    
    /* Standard strong non-interference */
    probes = Silver::check_SNI(model, inputs, order, false);

    if (probes.size() - 1 != 0) INFO("SNI.standard     (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
    else                        INFO("SNI.standard     (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
    if (VERBOSE > 0) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }

    /* Robust strong non-interference */
    probes = Silver::check_SNI(model, inputs, order, true);

    if (probes.size() > order)  INFO("SNI.robust       (d \u2264 " + str(order) + ") -- \033[1;32mPASS\033[0m.");
    else                        INFO("SNI.robust       (d \u2264 " + str(order) + ") -- \033[1;31mFAIL\033[0m.");
    if (VERBOSE > 0) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }
    
    /* Standard probe-isolating non-interference */
    probes = Silver::check_PINI(model, inputs, order, false);

    if (probes.size() - 1 != 0) INFO("PINI.standard    (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
    else                        INFO("PINI.standard    (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
    if (VERBOSE > 0) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }

    /* Robust probe-isolating non-interference */
    probes = Silver::check_PINI(model, inputs, order, true);

    if (probes.size() - 1 != 0) INFO("PINI.robust      (d \u2264 " + str(probes.size() - 1) + ") -- \033[1;32mPASS\033[0m.");
    else                        INFO("PINI.robust      (d \u2264 " + str(probes.size() - 0) + ") -- \033[1;31mFAIL\033[0m.");
    if (VERBOSE > 0) { std::cout << "\t>> Probes: "; Silver::print_node_vector(model, probes); } else { std::cout << std::endl; }

    /* Standard uniformity check */
    bool uniform = Silver::check_Uniform(model);

    if (uniform)  INFO("uniformity               -- \033[1;32mPASS\033[0m.\n");
    else          INFO("uniformity               -- \033[1;31mFAIL\033[0m.\n");

    /* Remove model graph from memory */
    model.clear();

    /* Terminate BDD session */
    sylvan::sylvan_stats_report(stdout);
    sylvan::sylvan_quit();

    lace_exit();

    return 0;
}
