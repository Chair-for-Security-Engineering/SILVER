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

#ifndef __SILVER_CONFIG_HPP_
#define __SILVER_CONFIG_HPP_

#include <sylvan/sylvan.h>
#include <sylvan/sylvan_obj.hpp>

/* Specify number of cores (0 for auto-detect) and RAM (in Byte) used by Sylvan BDD library */
#define CORES 0
#define MEMORY 1*1024*1024*1024ull

/* Enable (1) / disable (0) detailed test reporting */
#define VERBOSE 1

/* Enable (defined) / disable (undefined) verilog design parsing */
#define VERILOG

/* Instruction list (either externally provided or result of verilog parser) */
#define INSFILE "test/aes/aes_sbox_dom1.nl"

/* If VERILOG is defined, specify verilog design details here */
#ifdef VERILOG
#define LIBFILE "cell/Library.txt"
#define LIBNAME "NANG45"
#define DESIGN  "vlog/aes/AES_Sbox_DOM/2-Synthesized/aes_sbox_dom1.v"
#define MODULE  "aes_sbox"
#endif

#endif // __SILVER_CONFIG_HPP_
