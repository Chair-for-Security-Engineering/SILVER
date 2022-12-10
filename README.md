# SILVER - Statistical Independence and Leakage Verification

This repository contains the source code for the paper [SILVER - Statistical Independence and Leakage Verification](https://eprint.iacr.org/2020/634.pdf). 

## Features
SILVER is a framework written in C++ which particulary relies on Reduced Ordered Binary Decision Diagrams (ROBDDs) and the concept of statistical independence of probability distributions. This framework allows to analyze and verify masked implementations (given as verilog design or instruction list) against the following security notions (using different security models as reference):
- Probing Security (standard / robust model)
- Non-Interference Security (standard / robust model)
- Strong Non-Interference Security (standard / robust model)
- Probe-Isolating Non-Interference Security (standard / robust model)
- Uniformity (of output sharing)

## Contact and Support
Please contact Pascal Sasdrich (pascal.sasdrich@rub.de) if you have any questions, comments, if you found a bug that should be corrected, or if you want to reuse the framework or parts of it for your own research projects.

## Build Instructions
Please follow the instructions below to build the SILVER framework:

1. Download and include the [Boost Graph Library (BGL)](https://www.boost.org/doc/libs/1_73_0/libs/graph/doc/index.html).
2. Update the `BOOST` variable in the makefile with the path to your copy of BGL.
3. Clone and build the [Sylvan](https://github.com/trolando/sylvan) BDD library. Make sure you check out 5e9da9782885f6215f6b509ac250212df30aaf70.
4. Copy (replace) the Sylvan library to `/lib/`
5. Copy (replace) the Sylvan header files to `/inc/sylvan/`
6. `make release`

## Quick Start
Build the SILVER framework using the instructions above. You can configure the framework via the [command line](#Command-line-options) to specify the number of cores and RAM used by Sylvan. Besides, you can enable Verilog parsing or parse instruction files directly (cf. examples in `test/`). If Verilog parsing is enabled, please specify necessary parameters in `/inc/config.hpp` and describe your cell library used during synthesis in `cell/` (example given for constrained NANG45).

1. `make release`
2. `./bin/verify`

Examplary output for `/test/dom/dom1.nl` (instruction file) with `--verbose=1`:

```
[     0.000] Netlist: test/dom/dom1.nl
[     0.000] Parse: 19 gate(s) / 22 signal(s)
[     0.001] Elaborate: 19 gate(s) / 22 signal(s)
[     0.003] probing.standard (d ≤ 1) -- PASS.  >> Probes: <in:line2,in:line1>
[     0.004] probing.robust   (d ≤ 1) -- PASS.  >> Probes: <in:line2,in:line1>
[     0.006] NI.standard      (d ≤ 1) -- PASS.  >> Probes: <in:line2,in:line1>
[     0.006] NI.robust        (d ≤ 1) -- PASS.  >> Probes: <in:line2,in:line1>
[     0.006] SNI.standard     (d ≤ 1) -- PASS.  >> Probes: <in:line2,in:line1>
[     0.007] SNI.robust       (d ≤ 1) -- FAIL.  >> Probes: <out:line18>
[     0.007] PINI.standard    (d ≤ 1) -- FAIL.  >> Probes: <and:line6>
[     0.007] PINI.robust      (d ≤ 1) -- FAIL.  >> Probes: <reg:line14>
[     0.007] uniformity               -- PASS.
```

## Command line options

The following shows the main command line options to the program:

```sh
$> ./bin/verify --help
Silver arguments:
  --help                                Show the help message
  --cores arg (=0)                      Maximum number of CPU cores to use. Set
                                        to 0 (default) for auto-detect
  --memory arg (=1073741824)            RAM (in Bytes) used by Sylvan BDD 
                                        library.
  --verbose arg (=0)                    Be verbose (or not) in printing 
                                        detailed test reports.
  --verilog arg (=0)                    Parse the verilog design described by 
                                        the --verilog-* parameters.
  --verilog-libfile arg (=cell/Library.txt)
                                        Technology library description.
  --verilog-libname arg (=NANG45)       Technology library name.
  --verilog-design_file arg (=vlog/aes/AES_Sbox_DOM/2-Synthesized/aes_sbox_dom1.v)
                                        Verilg source file containing the 
                                        design.
  --verilog-module_name arg (=aes_sbox) Module contained within the verilog 
                                        source to verify.
  --insfile arg (=test/aes/aes_sbox_dom1.nl)
                                        Instruction list to parse and process. 
                                        Either externally provided or result of
                                        verilog parser
```

Note that if you do not set `--verilog=1` then all other `--verilog-*` arguments will be ignored.

## Verilog annotations

The verification of all security notions implemented in SILVER is based on the correct identification of secret and random inputs. For this, SILVER expects additional annotations on any secret input and output signal indicating the corresponding sharing properties. Any other (non-secret) signal is considered as random.

### Synthesis (Synopsis Design Compiler)

The given examples are based on designs synthesized by NANG45 standard cell library and Synopsis Design Compiler. The following commands (for synthesis script) can be used to restrict the resulting netlist to only those cells which are supported by SILVER.

```
set_dont_use [get_lib_cells NangateOpenCellLibrary/FA*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/HA*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/AOI*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/OAI*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/MUX*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/CLKBUF*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/OR3*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/OR4*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/OR5*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/NOR3*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/NOR4*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/NOR5*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/XNOR3*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/XNOR4*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/XNOR5*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/XOR3*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/XOR4*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/XOR5*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/AND3*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/AND4*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/AND5*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/NAND3*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/NAND4*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/NAND5*]
set_dont_use [get_lib_cells NangateOpenCellLibrary/BUF*]
```

The flowing commands can be used to force the synthesizer to compile, keep the hierarchy and make a flattened netlist of the design.

```
compile -map_effort medium -area_effort medium
compile_ultra -no_autoungroup
ungroup -all -flatten
```

In the current version (as of 10 Dec 2022), the netlist must not be flattened. Hence the command ```ungroup -all -flatten``` is not necessary.

### Synthesis (Yosys)

SILVER can also parse and evaluate the netlist generated by open-source synthesizer Yosys (http://www.clifford.at/yosys/). The generated netlist should be flattened and based on a certain library whose cells are supported by SILVER. As reference, we refer to folder 'Yosys' where an examplary synthesis script in addition to a customized library are given.

### Verilog attribute syntax

If verilog parsing is enabled, the parser will take care of the correct annotations for the internal circuit representation used by SILVER. However, for this, all input and output signals of the verilog module have to be annotated using custom attributes. In general, the annotation should use the following verilog syntax:

```
(* attribute *) input inputname;
/* ... */

(* attribute *) output outputname;
/* ... */
```

### SILVER attributes

In particular, the verilog parser will any attribute preceded by the SILVER keyword, i.e., follwing the syntax: `(* SILVER="attribute" *)`. In addition, the following different attributes are defined and recognized by the parser:

| attribute | description |
| --------- | ----------- |
| *clock*         | Keyword for identification of clock signals. |
| *control*       | Keyword for identification of control signals. |
| *refresh*       | Keyword for identification of fresh mask signals (i.e., random signals). |
| *Vn_Sn*         | Keyword for identification of a single shared signal (with Vn the variable number and Sn the share number) |
| *[Vn:Vm]_Sn*    | Keyword for identification of a shared vector with Vn to Vm -- either ascending or descending --  the variable numbers and Sn the share number) |
| *Vn_[Sn:Sm]*    | Keyword for identification of a shared vector with Vn the variable number and Sn to Sm -- either ascending or descending --  the share numbers) |

### Examples

In addition, different combination of the attributes are supported as well, for example:

```
(* SILVER="[3:0]_0" *)         input [3:0]  sboxIn1;
(* SILVER="[3:0]_1" *)         input [0:3]  sboxIn2;
(* SILVER="3_2,2_2,1_2,0_2" *) input [3:0]  sboxIn3;
(* SILVER="[3:0]_0" *)         output [3:0] share1;
(* SILVER="[3:2]_1,[1:0]_1" *) output [3:0] share2;
(* SILVER="3_2,[2:1]_2,0_2" *) output [3:0] share3;
(* SILVER="refresh" *)         input mask;
(* SILVER="clock" *)           input clk;
(* SILVER="control" *)         input rst;
```

## Troubleshooting

Here are some common issues you may encounter during execution along with possible fixes.

### Shared libraries (libsylvan.so)
In case you get an error message similar to: 

```
./bin/verify: error while loading shared libraries: libsylvan.so: cannot open shared object file: No such file or directory
```

please export the `/lib` directory to your linker library path, e.g., using `export LD_LIBRARY_PATH=``pwd``/lib` before executing the binary.

Note that you may get a similar error referring to `libboost_program_options.so`. You will need to add the path to your boost installation to `LD_LIBRARY_PATH`. E.g. `export LD_LIBRARY_PATH=$BOOST/lib:$LD_LIBRARY_PATH`.

### Cache creation (memory allocation)
In case you get an error message similar to: 

```
cache_create: Unable to allocate memory: Cannot allocate memory!
```

please decrease the memory size provided in `inc/config.hpp` according to your available system memory.

## Licensing
Copyright (c) 2020, Pascal Sasdrich, Amir Moradi (verilogParser.h).
All rights reserved.

Please see `LICENSE` for further license instructions.

## Publications
D. Knichel, P. Sasdrich, A. Moradi (2020): [SILVER - Statistical Independence and Leakage Verification, ASIACRYPT 2020, pp. 787-816](https://doi.org/10.1007/978-3-030-64837-4_26)
[(pre-print)](https://eprint.iacr.org/2020/634.pdf)

## Acknowledgements
We kindly thank [Ben Marshall](https://github.com/ben-marshall) for adding proper command-line parsing to SILVER.


