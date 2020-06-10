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
 
#ifndef __NODECONTEXT_HPP_
#define __NODECONTEXT_HPP_

#include <set>
#include <string>
#include <vector>

#include <sylvan_obj.hpp>

class NodeContext {

public:

    /**
     * @brief Return node type (gate functionality) stored in node context
     */
    std::string
    getType() const
    {
        return this->type;
    }

    /**
     * @brief Store node type (gate functionality) in node context
     * @param type Node type in circuit model
     */
    void 
    setType(const std::string type)
    {
        this->type = type;
    };

    /**
     * @brief Return sharing details (of node) stored in node context
     */
    std::pair<int,int>
    getSharing() const
    {
        return this->sharing;
    }

    /**
     * @brief Store sharing details (of node) in node context
     * @param sharing Sharing details (of node) in circuit model
     */
    void 
    setSharing(std::pair<int,int> sharing)
    {
        this->sharing = sharing;
    };

    /**
     * @brief Return node partition number in node context
     */
    int
    getPartition() const
    {
        return this->partition;
    }

    /**
     * @brief Store node partition number in node context
     * @param partition Node partition number in circuit model
     */
    void
    setPartition(const int p)
    {
        this->partition = p;
    }

    /**
     * @brief Clear input variable dependencies
     */
    void
    clearVariables()
    {
        this->variables = sylvan::Bdd::bddOne();
    }

    /**
     * @brief Add variable(s) to input variable dependencies
     */
    void
    addVariables(sylvan::Bdd var)
    {
        this->variables *= var;
    }

    /**
     * @brief Get all input variable dependencies
     */
    sylvan::Bdd
    getVariables() const
    {
        return this->variables;
    }

    /**
     * @brief Clear input variable dependencies
     */
    void
    clearRegisters()
    {
        this->registers = sylvan::Bdd::bddOne();
    }

    /**
     * @brief Add variable(s) to input variable dependencies
     */
    void
    addRegisters(sylvan::Bdd var)
    {
        this->registers *= var;
    }

    /**
     * @brief Get all input variable dependencies
     */
    sylvan::Bdd
    getRegisters() const
    {
        return this->registers;
    }

    /**
     * @brief Return BDD representation of node function (in circuit model)
     */
    sylvan::Bdd 
    getFunction() const
    {
        return this->function;
    }

    /**
     * @brief Store BDD representation of node function (in circuit model)
     * @param function BDD representation of node function (in circuit model)
     */
    void 
    setFunction(sylvan::Bdd function) 
    {
        this->function = function;
    }
    
private:

    /**
     * @brief Node type (gate functionality)
     */
    std::string type;

    /**
     * @brief Sharing information <index,domain>
     */
    std::pair<int,int> sharing;

    /**
     * @brief Partitioning information
     */
    int partition;

    /**
     * @brief BDD representation of node function (in circuit model)
     */
    sylvan::Bdd function;
    
    /**
     * @brief BDD representation of input variable dependecies (in circuit model)
     */
    sylvan::Bdd variables;

    /**
     * @brief BDD representation of register dependecies (in circuit model)
     */
    sylvan::Bdd registers;
    
    /**
     * @brief Key of BDD representation in function database (.fdb) file
     */
    uint64_t key;
};

#endif // __NODECONTEXT_HPP_