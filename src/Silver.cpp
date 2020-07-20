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
 * Please see LICENSE and README for license and further instructions.
 */

#include <util.hpp>
#include <Silver.hpp>

#include <sylvan/sylvan_ext.h>

using namespace boost;
using namespace sylvan;

/**
 * Implementation of Netlist static class functions.
 */

/* Circuit parsing and graph generation */
Circuit 
Silver::parse(const std::string filePath)
{
    std::vector<std::string> tokens, annotations;
    std::string line, token;
    Circuit model;

    std::ifstream description(filePath);

    while(std::getline(description, line))
    {
        tokens = split(line, ' ');

        Node node = add_vertex(model);

        model[node].setType(tokens[0]);

        if (unary.find(tokens[0]) != unary.end()) {
            add_edge(std::stoi(tokens[1]), node, model);
        } else if (binary.find(tokens[0]) != binary.end()) {
            add_edge(std::stoi(tokens[1]), node, model);
            add_edge(std::stoi(tokens[2]), node, model);
        } else if (!(tokens[0] == "in" || tokens[0] == "ref")) {
            std::cerr << "[ERR-PARSER] Unsupported node detected: line #" << node+1 << std::endl;
        }

        if (model[node].getType() == "in" || model[node].getType() == "reg" || model[node].getType() == "out") {
            if (tokens.size() > 2 && tokens[2].find("#") != 0) {
                annotations = split(tokens[2], '_');
                if (annotations.size() == 2) {
                    model[node].setSharing({std::stoi(annotations[0]),std::stoi(annotations[1])});
                } else {
                    std::cerr << "[ERR-PARSER] Unsupported annotations detected: line #" << node+1 << std::endl;
                }
            } else {
                model[node].setSharing({std::stoi(tokens[1]),0});
            }
        }
    }

    description.close();

    return model;
}

/* Circuit elaboration */
std::map<int, std::vector<Node>>
Silver::elaborate(Circuit &model) {

    std::map<int, std::vector<Node>> sharedInputs;
    std::vector<Node> sorted;
    Node op1, op2;

    boost::topological_sort(model, std::back_inserter(sorted));

    for (auto node = sorted.rbegin(); node != sorted.rend(); ++node) {
        
        if (unary.find(model[*node].getType()) != unary.end()) {
            op1 = source(*(in_edges(*node, model).first+0), model);
        } else if (binary.find(model[*node].getType()) != binary.end()) {
            op1 = source(*(in_edges(*node, model).first+0), model);
            op2 = source(*(in_edges(*node, model).first+1), model);
        } else if (!(model[*node].getType() == "in" || model[*node].getType() == "ref")) {
            std::cerr << "ERR1: Unsupported node detected. (ELABORATE)" << std::endl;
        }

        model[*node].clearVariables();
        if (model[*node].getType() == "in") {
            model[*node].setFunction(sylvan_ithvar(*node));
        } else if (model[*node].getType() == "ref") {
            model[*node].setFunction(sylvan_ithvar(*node));
        } else if (model[*node].getType() == "out" || model[*node].getType() == "reg") {
            model[*node].setFunction(model[op1].getFunction());
        } else if (model[*node].getType() == "not") {    
            model[*node].setFunction(!model[op1].getFunction());
        } else if (model[*node].getType() == "and") {
            model[*node].setFunction((model[op1].getFunction() & model[op2].getFunction()));
        } else if (model[*node].getType() == "nand") {
            model[*node].setFunction(!(model[op1].getFunction() & model[op2].getFunction()));
        } else if (model[*node].getType() == "or") {
            model[*node].setFunction((model[op1].getFunction() | model[op2].getFunction()));
        } else if (model[*node].getType() == "nor") {
            model[*node].setFunction(!(model[op1].getFunction() | model[op2].getFunction()));
        } else if (model[*node].getType() == "xor") {
            model[*node].setFunction((model[op1].getFunction() ^ model[op2].getFunction()));
        } else if (model[*node].getType() == "xnor") {
            model[*node].setFunction(!(model[op1].getFunction() ^ model[op2].getFunction()));
        } else {
            std::cerr << "ERR2: Unsupported node detected. (ELABORATE)" << std::endl;
        }

        model[*node].clearVariables();
        if (model[*node].getType() == "in") {
            model[*node].addVariables(Bdd::bddVar(*node));
        } else if (model[*node].getType() == "ref") {
            model[*node].addVariables(Bdd::bddVar(*node));
        } else if (unary.find(model[*node].getType()) != unary.end()) {       
            model[*node].addVariables(model[op1].getVariables());
        } else if (binary.find(model[*node].getType()) != binary.end()) {
            model[*node].addVariables(model[op1].getVariables());
            model[*node].addVariables(model[op2].getVariables());
        } else {
            std::cerr << "ERR: Unsupported node detected. (ELABORATE)" << std::endl;
        }

        model[*node].clearRegisters();
        if (model[*node].getType() == "in") {
            model[*node].addRegisters(Bdd::bddVar(*node));
        } else if (model[*node].getType() == "ref") {
            model[*node].addRegisters(Bdd::bddVar(*node));
        } else if (unary.find(model[*node].getType()) != unary.end()) {
            if (model[op1].getType() == "reg")  model[*node].addRegisters(Bdd::bddVar(op1));
            else                                model[*node].addRegisters(model[op1].getRegisters());
        } else if (binary.find(model[*node].getType()) != binary.end()) {
            if (model[op1].getType() == "reg")  model[*node].addRegisters(Bdd::bddVar(op1));
            else                                model[*node].addRegisters(model[op1].getRegisters());
            if (model[op2].getType() == "reg")  model[*node].addRegisters(Bdd::bddVar(op2));
            else                                model[*node].addRegisters(model[op2].getRegisters());
        } else {
            std::cerr << "ERR: Unsupported node detected. (ELABORATE)" << std::endl;
        }

        if (model[*node].getType() == "in") {
            sharedInputs[model[*node].getSharing().first].push_back(*node);
        }
    }

    return sharedInputs;
}

/* Uniformity check */
bool
Silver::check_Uniform(Circuit &model)
{
    LACE_ME;

    int varcount = 0;
    for (auto node = vertices(model).first; node != vertices(model).second; node++)
        if (model[*node].getType() == "in" || model[*node].getType() == "ref") varcount++;

    std::vector<Bdd> inputs, outputs;
    for (auto gate = vertices(model).first; gate != vertices(model).second; ++gate) {
        if (model[*gate].getType() == "in" || model[*gate].getType() == "ref") inputs.push_back(model[*gate].getFunction());
        if (model[*gate].getType() == "out") outputs.push_back(model[*gate].getFunction());
    }
    
    if (inputs.size() == outputs.size()) {

        std::vector<uint32_t> from(inputs.size()), to(inputs.size());
        for (int index = 0; index < inputs.size(); index++) {
            from[index] = inputs[index].TopVar(); to[index] = 2 * index;
        }

        std::vector<Bdd> relations(outputs.size());
        std::vector<BddSet> variables(outputs.size());

        for (int index = 0; index < outputs.size(); index++) {
            relations[index] = (outputs[index].Permute(from, to) ^ sylvan_nithvar(2 * index + 1));
            variables[index] = (outputs[index].Support());
        }

        for (int index = relations.size() - 1; index >= 0; index--) {
            for (int r = 0; r < index; r++) {
                BddSet curr = variables[r]; curr.remove(variables[index]);

                if (curr.size() != variables[r].size()) {

                    relations[r] &= relations[index]; relations.erase(relations.begin() + index);
                    variables[r].add(variables[index]); variables.erase(variables.begin() + index);
                    break;
                }
            }
        }

        Bdd states = Bdd::bddOne().RelNext(relations[0], BddSet(sylvan_false));
        for (int index = 1; index < relations.size(); index++) {
            states &= Bdd::bddOne().RelNext(relations[index], BddSet(sylvan_false));
        }
        
        return (mtbdd_satcountln(states.GetBDD(), outputs.size()) == outputs.size());

    } else {
        std::map<int, std::vector<Node>> shares;
        for (auto node = vertices(model).first; node != vertices(model).second; node++) {
            if (model[*node].getType() == "out") shares[model[*node].getSharing().first].push_back(*node);
        }

        std::vector<std::vector<Bdd>> intra(shares.size());
        for (int idx = 0; idx < shares.size(); idx++) {
            for (int comb = 1; comb < (1 << shares[idx].size()); comb++) {
                if (__builtin_popcount(comb) < shares[idx].size()) {
                    intra[idx].push_back(sylvan::sylvan_false);
                    for (int elem = 0; elem < shares[idx].size(); elem++) {
                        if (comb & (1 << elem)) intra[idx].back() ^= model[shares[idx][elem]].getFunction();
                    }
                    if (abs(mtbdd_satcountln(intra[idx].back().GetBDD(), varcount) - varcount + 1) > DOUBLE_COMPARE_THRESHOLD) return false; 
                }
            }
        }
                 
        return inter_vector_combinations_xor(intra, 0, Bdd::bddZero(), varcount);
    }
}

/* Probing security */
std::vector<Node>
Silver::check_Probing(Circuit &model, std::map<int, Probes> inputs, const int probingOrder, const bool robustModel)
{
    LACE_ME;

    std::vector<Node> positions = (robustModel) ? get_nodes_of_types(model, rprobes) : get_nodes_of_types(model, sprobes); 

    int minimal = get_minimal_sharing(inputs);

    if (probingOrder == 0 || inputs[minimal].size() < 2 || inputs[minimal].size() < probingOrder) return inputs[minimal];

    std::vector<Bdd> secrets(1 << inputs.size());
    for (int index = 0; index < inputs.size(); index++) {
        secrets[index] = model[inputs[index][0]].getFunction();
        for (int elem = 1; elem < inputs[index].size(); elem++) secrets[index] ^= model[inputs[index][elem]].getFunction();
    }

    for (int comb = inputs.size() + 1; comb < (1 << inputs.size()); comb++) {
        secrets[comb-1] = Bdd::bddOne();
        for (int elem = 0; elem < inputs.size(); elem++) if (comb & (1 << elem)) secrets[comb-1] &= secrets[elem];
    }
    
    int varcount = 0;
    for (auto node = vertices(model).first; node != vertices(model).second; node++)
        if (model[*node].getType() == "in" || model[*node].getType() == "ref") varcount++;

    for (int order = 0; order < probingOrder; order++) {
        std::vector<Node> probes(order + 1);
        std::vector<bool> bitmask(positions.size()); std::fill(bitmask.begin(), bitmask.begin() + (order + 1), true);
        do {
            int probe = 0; for (int idx = 0; idx < bitmask.size(); idx++) if (bitmask[idx]) probes[probe++] = positions[idx];

            if (robustModel) {
                Bdd observation = model[probes[0]].getRegisters();
                for (int probe = 1; probe < probes.size(); probe++)
                    observation &= model[probes[probe]].getRegisters();

                std::vector<uint32_t> extended = BddSet(observation).toVector();

                for (int comb = 1; comb < (1 << extended.size()); comb++) {
                    observation = sylvan::sylvan_true;
                    for (int elem = 0; elem < extended.size(); elem++) 
                        if (comb & (1 << elem)) observation &= model[extended[elem]].getFunction();

                    bool independent = true;
                    for (int idx = 0; idx < secrets.size() && independent; idx++) independent &= CALL(mtbdd_statindependence, observation.GetBDD(), varcount, secrets[idx].GetBDD(), varcount);                        
                    //for (int idx = 0; idx < secrets.size(); idx++) independent &= SYNC(mtbdd_statindependence);
                    if (!independent) return probes; 
                }
            } else {
                Bdd observation = model[probes[0]].getFunction();
                for (int probe = 1; probe < probes.size(); probe++)
                    observation &= model[probes[probe]].getFunction();

                bool independent = true;
                for (int idx = 0; idx < secrets.size() && independent; idx++) independent &= CALL(mtbdd_statindependence, observation.GetBDD(), varcount, secrets[idx].GetBDD(), varcount);                        
                //for (int idx = 0; idx < secrets.size(); idx++) independent &= SYNC(mtbdd_statindependence);
                if (!independent) return probes; 
            }
        } while (std::prev_permutation(bitmask.begin(), bitmask.end()));
    }

    return inputs[minimal];
}

/* Non-interference */
std::vector<Node>
Silver::check_NI(Circuit &model, std::map<int, Probes> inputs, const int probingOrder, const bool robustModel)
{
    LACE_ME;

    std::vector<Node> positions = (robustModel) ? get_nodes_of_types(model, rprobes) : get_nodes_of_types(model, sprobes); 

    int minimal = get_minimal_sharing(inputs);

    if (probingOrder == 0 || inputs[minimal].size() < 2 || inputs[minimal].size() < probingOrder) return inputs[minimal];

    Bdd variables = Bdd::bddOne();
    for (int index = 0; index < inputs.size(); index++)
        for (int elem = 0; elem < inputs[index].size(); elem++) variables &= model[inputs[index][elem]].getFunction();
    std::vector<uint32_t> secvar = BddSet(variables).toVector();

    int varcount = 0;
    for (auto node = vertices(model).first; node != vertices(model).second; node++)
        if (model[*node].getType() == "in" || model[*node].getType() == "ref") varcount++;

    for (int order = 1; order <= probingOrder; order++) {
        std::vector<Node> probes(order);
        std::vector<bool> probemask(positions.size()); std::fill(probemask.begin(), probemask.begin() + order, true);
        do {
            int probe = 0; for (int idx = 0; idx < probemask.size(); idx++) if (probemask[idx]) probes[probe++] = positions[idx];

            if (robustModel) {
                Bdd observation = model[probes[0]].getRegisters();
                for (int probe = 1; probe < probes.size(); probe++)
                    observation &= model[probes[probe]].getRegisters();

                std::vector<uint32_t> extended = BddSet(observation).toVector();

                for (int comb = 1; comb < (1 << extended.size()); comb++) {
                    observation = sylvan::sylvan_true;
                    for (int elem = 0; elem < extended.size(); elem++) 
                        if (comb & (1 << elem)) observation &= model[extended[elem]].getFunction();

                    bool trivial_solution = true;
                    std::vector<std::vector<Node>> shares(inputs.size());
                    std::vector<uint32_t> variables = BddSet(observation.Support()).toVector();
                    for (int var = variables.size() - 1; var >= 0; var--) {
                        for (int idx = inputs.size() - 1; idx >= 0; idx--) {
                            if (std::find(inputs[idx].begin(), inputs[idx].end(), variables[var]) != inputs[idx].end()) {
                                shares[idx].push_back(variables[var]); trivial_solution &= (shares[idx].size() <= order); break;
                            }
                        }
                    }

                    if (!trivial_solution) {
                        std::vector<std::vector<Bdd>> intra(shares.size());
                        for (int idx = 0; idx < shares.size(); idx++) {
                            for (int comb = 0; comb < (1 << shares[idx].size()); comb++) {
                                if (__builtin_popcount(comb) <= order) {
                                    intra[idx].push_back(sylvan::sylvan_true);
                                    for (int elem = 0; elem < shares[idx].size(); elem++)
                                        if (comb & (1 << elem)) intra[idx][intra[idx].size() - 1] &= model[shares[idx][elem]].getFunction();
                                }
                            }
                        }
      
                        std::vector<Bdd> inter; inter_vector_combinations_and(intra, 0, Bdd::bddOne(), inter);

                        bool independent = false;

                        for (int idx = 0; idx < inter.size() && !independent; idx++) {
                            independent = true;
                            std::vector<uint32_t> combination = BddSet(inter[idx]).toVector(), complement;

                            for (int elem = 0; elem < secvar.size(); elem++)
                                if (std::find(combination.begin(), combination.end(), secvar[elem]) == combination.end())
                                    complement.push_back(secvar[elem]);

                            for (int s = 0; s < (1 << combination.size()) && independent; s++) {                            
                                Bdd simulate = observation;
                                for (int elem = 0; elem < combination.size(); elem++) if (s & (1 << elem)) simulate &= model[combination[elem]].getFunction();

                                for (int r = 1; r < (1 << complement.size()) && independent; r++) {
                                    Bdd free  = sylvan::sylvan_true;
                                    for (int elem = 0; elem < complement.size(); elem++) if (r & (1 << elem)) free &= model[complement[elem]].getFunction();

                                    independent &= CALL(mtbdd_statindependence, simulate.GetBDD(), varcount, free.GetBDD(), varcount);
                                }
                            }
                        }

                        if (!independent) return probes;
                    }
                }
            } else {
                Bdd observation = model[probes[0]].getFunction();
                for (int probe = 1; probe < probes.size(); probe++) observation &= model[probes[probe]].getFunction();

                bool trivial_solution = true;
                std::vector<std::vector<Node>> shares(inputs.size());
                std::vector<uint32_t> variables = BddSet(observation.Support()).toVector();
                for (int var = variables.size() - 1; var >= 0; var--) {
                    for (int idx = inputs.size() - 1; idx >= 0; idx--) {
                        if (std::find(inputs[idx].begin(), inputs[idx].end(), variables[var]) != inputs[idx].end()) {
                            shares[idx].push_back(variables[var]); trivial_solution &= (shares[idx].size() <= order); break;
                        }
                    }
                }

                if (!trivial_solution) {
                    std::vector<std::vector<Bdd>> intra(shares.size());
                    for (int idx = 0; idx < shares.size(); idx++) {
                        for (int comb = 0; comb < (1 << shares[idx].size()); comb++) {
                            if (__builtin_popcount(comb) <= order) {
                                intra[idx].push_back(sylvan::sylvan_true);
                                for (int elem = 0; elem < shares[idx].size(); elem++)
                                    if (comb & (1 << elem)) intra[idx][intra[idx].size() - 1] &= model[shares[idx][elem]].getFunction();
                            }
                        }
                    }
      
                    std::vector<Bdd> inter; inter_vector_combinations_and(intra, 0, Bdd::bddOne(), inter);

                    bool independent = false;

                    for (int idx = 0; idx < inter.size() && !independent; idx++) {
                        independent = true;
                        std::vector<uint32_t> combination = BddSet(inter[idx]).toVector(), complement;

                        for (int elem = 0; elem < secvar.size(); elem++)
                            if (std::find(combination.begin(), combination.end(), secvar[elem]) == combination.end())
                                complement.push_back(secvar[elem]);

                        for (int s = 0; s < (1 << combination.size()) && independent; s++) {                            
                            Bdd simulate = observation;
                            for (int elem = 0; elem < combination.size(); elem++) if (s & (1 << elem)) simulate &= model[combination[elem]].getFunction();

                            for (int r = 1; r < (1 << complement.size()) && independent; r++) {
                                Bdd free  = sylvan::sylvan_true;
                                for (int elem = 0; elem < complement.size(); elem++) if (r & (1 << elem)) free &= model[complement[elem]].getFunction();

                                independent &= CALL(mtbdd_statindependence, simulate.GetBDD(), varcount, free.GetBDD(), varcount);
                            }
                        }
                    }
                    
                    if (!independent) return probes;
                }
            }
        } while (std::prev_permutation(probemask.begin(), probemask.end()));
    }

    return inputs[minimal];
}

/* Strong Non-interference */
std::vector<Node>
Silver::check_SNI(Circuit &model, std::map<int, Probes> inputs, const int probingOrder, const bool robustModel)
{
    LACE_ME;

    std::vector<Node> positions = (robustModel) ? get_nodes_of_types(model, rprobes) : get_nodes_of_types(model, sprobes); 

    for (auto gate = vertices(model).first; gate != vertices(model).second; gate++) 
        if (!robustModel && model[*gate].getType() == "out") positions.push_back(*gate);
    
    int minimal = get_minimal_sharing(inputs);

    if (probingOrder == 0 || inputs[minimal].size() < 2 || inputs[minimal].size() < probingOrder) return inputs[minimal];

    Bdd variables = Bdd::bddOne();
    for (int index = 0; index < inputs.size(); index++)
        for (int elem = 0; elem < inputs[index].size(); elem++) variables &= model[inputs[index][elem]].getFunction();
    std::vector<uint32_t> secvar = BddSet(variables).toVector();

    int varcount = 0;
    for (auto node = vertices(model).first; node != vertices(model).second; node++)
        if (model[*node].getType() == "in" || model[*node].getType() == "ref") varcount++;

    for (int order = 1; order <= probingOrder; order++) {

        std::vector<Node> probes(order);
        std::vector<bool> probemask(positions.size()); std::fill(probemask.begin(), probemask.begin() + order, true);
        do {
            int probe = 0; for (int idx = 0; idx < probemask.size(); idx++) if (probemask[idx]) probes[probe++] = positions[idx];

            int outputs = 0; for (int probe = 0; probe < probes.size(); probe++) if(model[probes[probe]].getType() == "out") outputs++;

            if (robustModel) {
                Bdd observation = model[probes[0]].getRegisters();
                for (int probe = 1; probe < probes.size(); probe++)
                    observation &= model[probes[probe]].getRegisters();

                std::vector<uint32_t> extended = BddSet(observation).toVector();

                for (int comb = 1; comb < (1 << extended.size()); comb++) {
                    observation = sylvan::sylvan_true;
                    for (int elem = 0; elem < extended.size(); elem++) 
                        if (comb & (1 << elem)) observation &= model[extended[elem]].getFunction();

                    bool trivial_solution = true;
                    std::vector<std::vector<Node>> shares(inputs.size());
                    std::vector<uint32_t> variables = BddSet(observation.Support()).toVector();
                    for (int var = variables.size() - 1; var >= 0; var--) {
                        for (int idx = inputs.size() - 1; idx >= 0; idx--) {
                            if (std::find(inputs[idx].begin(), inputs[idx].end(), variables[var]) != inputs[idx].end()) {
                                shares[idx].push_back(variables[var]); trivial_solution &= (shares[idx].size() <= (order - outputs)); break;
                            }
                        }
                    }

                    if (!trivial_solution) {
                        std::vector<std::vector<Bdd>> intra(shares.size());
                        for (int idx = 0; idx < shares.size(); idx++) {
                            for (int comb = 0; comb < (1 << shares[idx].size()); comb++) {
                                if (__builtin_popcount(comb) <= (order - outputs)) {
                                    intra[idx].push_back(sylvan::sylvan_true);
                                    for (int elem = 0; elem < shares[idx].size(); elem++)
                                        if (comb & (1 << elem)) intra[idx][intra[idx].size() - 1] &= model[shares[idx][elem]].getFunction();
                                }
                            }
                        }
             
                        std::vector<Bdd> inter; inter_vector_combinations_and(intra, 0, Bdd::bddOne(), inter);

                        bool independent = false;

                        for (int idx = 0; idx < inter.size() && !independent; idx++) {                                
                            std::vector<uint32_t> combination = BddSet(inter[idx]).toVector(), complement; independent = true;

                            for (int elem = 0; elem < secvar.size(); elem++)
                                if (std::find(combination.begin(), combination.end(), secvar[elem]) == combination.end())
                                    complement.push_back(secvar[elem]);

                            for (int s = 0; s < (1 << combination.size()) && independent; s++) {                            
                                Bdd simulate = observation;
                                for (int elem = 0; elem < combination.size(); elem++) if (s & (1 << elem)) simulate &= model[combination[elem]].getFunction();

                                for (int r = 1; r < (1 << complement.size()) && independent; r++) {
                                    Bdd free  = sylvan::sylvan_true;
                                    for (int elem = 0; elem < complement.size(); elem++) if (r & (1 << elem)) free &= model[complement[elem]].getFunction();

                                    independent  &= CALL(mtbdd_statindependence, simulate.GetBDD(), varcount, free.GetBDD(), varcount);
                                }
                            }
                        }

                        if (!independent) return probes;
                    }
                }
            } else {
                Bdd observation = model[probes[0]].getFunction();
                for (int probe = 1; probe < probes.size(); probe++) observation &= model[probes[probe]].getFunction();

                bool trivial_solution = true;
                std::vector<std::vector<Node>> shares(inputs.size());
                std::vector<uint32_t> variables = BddSet(observation.Support()).toVector();
                for (int var = variables.size() - 1; var >= 0; var--) {
                    for (int idx = inputs.size() - 1; idx >= 0; idx--) {
                        if (std::find(inputs[idx].begin(), inputs[idx].end(), variables[var]) != inputs[idx].end()) {
                            shares[idx].push_back(variables[var]); trivial_solution &= (shares[idx].size() <= (order - outputs)); break;
                        }
                    }
                }

                if (!trivial_solution) {
                    std::vector<std::vector<Bdd>> intra(shares.size());
                    for (int idx = 0; idx < shares.size(); idx++) {
                        for (int comb = 0; comb < (1 << shares[idx].size()); comb++) {
                            if (__builtin_popcount(comb) <= (order - outputs)) {
                                intra[idx].push_back(sylvan::sylvan_true);
                                for (int elem = 0; elem < shares[idx].size(); elem++)
                                    if (comb & (1 << elem)) intra[idx][intra[idx].size() - 1] &= model[shares[idx][elem]].getFunction();
                            }
                        }
                    }
           
                    std::vector<Bdd> inter; inter_vector_combinations_and(intra, 0, Bdd::bddOne(), inter);

                    bool independent = false;

                    for (int idx = 0; idx < inter.size() && !independent; idx++) {
                        std::vector<uint32_t> combination = BddSet(inter[idx]).toVector(), complement; independent = true;

                        for (int elem = 0; elem < secvar.size(); elem++)
                            if (std::find(combination.begin(), combination.end(), secvar[elem]) == combination.end())
                                complement.push_back(secvar[elem]);

                        for (int s = 0; s < (1 << combination.size()) && independent; s++) {                            
                            Bdd simulate = observation;
                            for (int elem = 0; elem < combination.size(); elem++) if (s & (1 << elem)) simulate &= model[combination[elem]].getFunction();

                            for (int r = 1; r < (1 << complement.size()) && independent; r++) {
                                Bdd free  = sylvan::sylvan_true;
                                for (int elem = 0; elem < complement.size(); elem++) if (r & (1 << elem)) free &= model[complement[elem]].getFunction();

                                independent  &= CALL(mtbdd_statindependence, simulate.GetBDD(), varcount, free.GetBDD(), varcount);
                            }
                        }
                    }

                    if (!independent) return probes;
                }
            }
        } while (std::prev_permutation(probemask.begin(), probemask.end()));
    }

    return inputs[minimal];
}

/* Probe-Isolating Non-interference */
std::vector<Node>
Silver::check_PINI(Circuit &model, std::map<int, Probes> inputs, const int probingOrder, const bool robustModel)
{
    LACE_ME;

    std::vector<Node> positions = (robustModel) ? get_nodes_of_types(model, rprobes) : get_nodes_of_types(model, sprobes); 

    for (auto gate = vertices(model).first; gate != vertices(model).second; gate++) 
        if (!robustModel && model[*gate].getType() == "out") positions.push_back(*gate);

    int minimal = get_minimal_sharing(inputs);

    if (probingOrder == 0 || inputs[minimal].size() < 2 || inputs[minimal].size() < probingOrder) return inputs[minimal];

    Bdd variables = Bdd::bddOne();
    for (int index = 0; index < inputs.size(); index++)
        for (int elem = 0; elem < inputs[index].size(); elem++) variables &= model[inputs[index][elem]].getFunction();
    std::vector<uint32_t> secvar = BddSet(variables).toVector();

    int varcount = 0;
    for (auto node = vertices(model).first; node != vertices(model).second; node++)
        if (model[*node].getType() == "in" || model[*node].getType() == "ref") varcount++;

    for (int order = 1; order <= probingOrder; order++) {
        std::vector<Node> probes(order);
        std::vector<bool> probemask(positions.size()); std::fill(probemask.begin(), probemask.begin() + order, true);
        do {  
            int probe = 0; for (int idx = 0; idx < probemask.size(); idx++) if (probemask[idx]) probes[probe++] = positions[idx];

            int outputs = 0; for (int probe = 0; probe < probes.size(); probe++) if(model[probes[probe]].getType() == "out") outputs++;

            std::set<int> odomains;
            for (int probe = 0; probe < probes.size(); probe++)
                if(model[probes[probe]].getType() == "out") odomains.insert(model[probes[probe]].getSharing().second);

            if (robustModel) {
                Bdd observation = model[probes[0]].getRegisters();
                for (int probe = 1; probe < probes.size(); probe++)
                    observation &= model[probes[probe]].getRegisters();

                std::vector<uint32_t> extended = BddSet(observation).toVector();

                for (int comb = 1; comb < (1 << extended.size()); comb++) {
                    observation = sylvan::sylvan_true;
                    for (int elem = 0; elem < extended.size(); elem++) 
                        if (comb & (1 << elem)) observation &= model[extended[elem]].getFunction();

                    std::vector<std::vector<Node>> shares(inputs.size());
                    std::vector<uint32_t> variables = BddSet(observation.Support()).toVector();
                    for (int var = variables.size() - 1; var >= 0; var--) {
                        for (int idx = inputs.size() - 1; idx >= 0; idx--) {
                            if (std::find(inputs[idx].begin(), inputs[idx].end(), variables[var]) != inputs[idx].end()) {
                                shares[idx].push_back(variables[var]); break;
                            }
                        }
                    }

                    std::set<int> domains;
                    for (int idx = 0; idx < shares.size(); idx++)
                        for (int elem = 0; elem < shares[idx].size(); elem++) domains.insert(model[shares[idx][elem]].getSharing().second);
                    domains.insert(odomains.begin(), odomains.end());

                    if (domains.size() > order) {
                        std::vector<std::vector<Bdd>> intra(shares.size());
                        for (int idx = 0; idx < shares.size(); idx++) {
                            for (int comb = 0; comb < (1 << shares[idx].size()); comb++) {
                                if (__builtin_popcount(comb) <= order) {
                                    intra[idx].push_back(sylvan::sylvan_true);
                                    for (int elem = 0; elem < shares[idx].size(); elem++)
                                        if (comb & (1 << elem)) intra[idx][intra[idx].size() - 1] &= model[shares[idx][elem]].getFunction();
                                }
                            }
                        }
               
                        std::vector<Bdd> inter; inter_vector_combinations_and(intra, 0, Bdd::bddOne(), inter);
                        bool independent = false;

                        for (int idx = 0; idx < inter.size() && !independent; idx++) {
                            std::vector<uint32_t> combination = BddSet(inter[idx]).toVector(), complement;

                            domains.clear();
                            for (int idx = 0; idx < combination.size(); idx++)
                                for (int elem = 0; elem < combination.size(); elem++) domains.insert(model[combination[elem]].getSharing().second);
                            domains.insert(odomains.begin(), odomains.end());

                            if (domains.size() <= order) {
                                independent = true;

                                for (int elem = 0; elem < secvar.size(); elem++)
                                    if (std::find(combination.begin(), combination.end(), secvar[elem]) == combination.end())
                                        complement.push_back(secvar[elem]);

                                for (int s = 0; s < (1 << combination.size()) && independent; s++) {                            
                                    Bdd simulate = observation;
                                    for (int elem = 0; elem < combination.size(); elem++) if (s & (1 << elem)) simulate &= model[combination[elem]].getFunction();

                                    for (int r = 1; r < (1 << complement.size()) && independent; r++) {
                                        Bdd free  = sylvan::sylvan_true;
                                        for (int elem = 0; elem < complement.size(); elem++) if (r & (1 << elem)) free &= model[complement[elem]].getFunction();

                                        independent  &= CALL(mtbdd_statindependence, simulate.GetBDD(), varcount, free.GetBDD(), varcount);
                                    }
                                }
                            }
                        }

                        if (!independent) return probes;
                    }
                }
            } else {
                Bdd observation  = model[probes[0]].getFunction();
                for (int probe = 1; probe < probes.size(); probe++) observation &= model[probes[probe]].getFunction();

                std::vector<std::vector<Node>> shares(inputs.size());
                std::vector<uint32_t> variables = BddSet(observation.Support()).toVector();
                for (int var = variables.size() - 1; var >= 0; var--) {
                    for (int idx = inputs.size() - 1; idx >= 0; idx--) {
                        if (std::find(inputs[idx].begin(), inputs[idx].end(), variables[var]) != inputs[idx].end()) {
                            shares[idx].push_back(variables[var]); break;
                        }
                    }
                }

                std::set<int> domains;
                for (int idx = 0; idx < shares.size(); idx++)
                    for (int elem = 0; elem < shares[idx].size(); elem++) domains.insert(model[shares[idx][elem]].getSharing().second);
                domains.insert(odomains.begin(), odomains.end());

                if (domains.size() > order) {
                    std::vector<std::vector<Bdd>> intra(shares.size());
                    for (int idx = 0; idx < shares.size(); idx++) {
                        for (int comb = 0; comb < (1 << shares[idx].size()); comb++) {
                            if (__builtin_popcount(comb) <= order) {
                                intra[idx].push_back(sylvan::sylvan_true);
                                for (int elem = 0; elem < shares[idx].size(); elem++)
                                    if (comb & (1 << elem)) intra[idx][intra[idx].size() - 1] &= model[shares[idx][elem]].getFunction();
                            }
                        }
                    }
            
                    std::vector<Bdd> inter; inter_vector_combinations_and(intra, 0, Bdd::bddOne(), inter);

                    bool independent = false;

                    for (int idx = 0; idx < inter.size() && !independent; idx++) {
                        std::vector<uint32_t> combination = BddSet(inter[idx]).toVector(), complement;

                        domains.clear();
                        for (int idx = 0; idx < combination.size(); idx++)
                            for (int elem = 0; elem < combination.size(); elem++) domains.insert(model[combination[elem]].getSharing().second);
                        domains.insert(odomains.begin(), odomains.end());

                        if (domains.size() <= order) {
                            independent = true;

                            for (int elem = 0; elem < secvar.size(); elem++)
                                if (std::find(combination.begin(), combination.end(), secvar[elem]) == combination.end())
                                    complement.push_back(secvar[elem]);

                            for (int s = 0; s < (1 << combination.size()) && independent; s++) {                            
                                Bdd simulate = observation;
                                for (int elem = 0; elem < combination.size(); elem++) if (s & (1 << elem)) simulate &= model[combination[elem]].getFunction();

                                for (int r = 1; r < (1 << complement.size()) && independent; r++) {
                                    Bdd free  = sylvan::sylvan_true;
                                    for (int elem = 0; elem < complement.size(); elem++) if (r & (1 << elem)) free &= model[complement[elem]].getFunction();

                                    independent  &= CALL(mtbdd_statindependence, simulate.GetBDD(), varcount, free.GetBDD(), varcount);
                                }
                            }
                        }
                    }

                    if (!independent) return probes;
                }
            }

        } while (std::prev_permutation(probemask.begin(), probemask.end()));
    }

    return inputs[minimal];
}

/* Internal helper functions */
std::vector<Node> 
Silver::get_nodes_of_types(Circuit &model, const std::set<std::string> types)
{
    std::vector<Node> selection;

    for (auto gate = vertices(model).first; gate != vertices(model).second; gate++) 
        if (types.find(model[*gate].getType()) != types.end())
            selection.push_back(*gate);
  
    return selection;
}

int 
Silver::get_minimal_sharing(std::map<int, Probes> inputs)
{
    int minimal = 0;

    for (int index = 0; index < inputs.size(); index++)
        minimal = (inputs[index].size() < inputs[minimal].size()) ? index : minimal;

    return minimal;
}

void
Silver::print_node_vector(const Circuit &model, const std::vector<Node> nodes)
{
    std::cout << "<";
    for (int n = 0; n < nodes.size(); n++) {
            std::cout << model[nodes[n]].getType() << ":line" << nodes[n] + 1;
        if (n != nodes.size() - 1) std::cout << ",";
    }
    std::cout << ">" << std::endl;
}

void
Silver::inter_vector_combinations_and(const std::vector<std::vector<Bdd>> &intra, int offset, Bdd combination, std::vector<Bdd> &inter)
{
    if (offset < intra.size()) {
        for (int idx = 0; idx < intra[offset].size(); idx++) inter_vector_combinations_and(intra, offset + 1, combination & intra[offset][idx], inter);
    } else {
        inter.push_back(combination);
    }
}

bool
Silver::inter_vector_combinations_xor(const std::vector<std::vector<Bdd>> &intra, int offset, Bdd combination, int varcount)
{
    LACE_ME;

    if (offset < intra.size()) {
        bool balanced = true;
        for (int idx = 0; idx < intra[offset].size() && balanced; idx++) 
            balanced &= inter_vector_combinations_xor(intra, offset + 1, combination ^ intra[offset][idx], varcount);
        if (!balanced) return false;
    } else {
        return (abs(mtbdd_satcountln(combination.GetBDD(), varcount) - varcount + 1) < DOUBLE_COMPARE_THRESHOLD);
    }

    return true;
}
