# SILVER - Statistical Independence and Leakage Verification

This repository contains the source code for the paper [SILVER - Statistical Independence and Leakage Verification](https://eprint.iacr.org/2020/634.pdf). 

## Features
SILVER is a framework written in C++ which particulary relies on Reduced Ordered Binary Decision Diagrams (ROBDDs) and the concept of statistical independence of probability distributions. This framework allows to analyze and verify masked implementations against the following security notions (using different security models as reference):
- Probing Security (standard / robust model)
- Non-Interference Security (standard / robust model)
- Strong Non-Interference Security (standard / robust model)
- Probe-Isolating Non-Interference Security (standard / robust model)
- Uniformity (of output sharing)

## Contact and Support
Please contact Pascal Sasdrich (pascal.sasdrich@rub.de) if you have any questions, comments, if you found a bug that should be corrected, or if you want to reuse the framework or parts of it for your own research projects.

## Build Instructions
Please follow the instructions below to build the SILVER framework:

1. Download and build the [Boost Graph Library (BGL)](https://www.boost.org/doc/libs/1_73_0/libs/graph/doc/index.html).
2. Update the `BOOST` variable in the makefile with the path to your copy of BGL.
3. Clone and build the [Sylvan](https://github.com/trolando/sylvan) BDD library.
4. Copy (replace) the Sylvan library to `/lib/`
5. Copy (replace) the Sylvan header files to `/inc/sylvan/`
6. `make release`

## Quick Start
Build the SILVER framework using the instructions above. You can configure the framework in `/inc/config.hpp` to specify the number of cores and RAM used by Sylvan. Specify your Design Under Test (DUT) in `/src/verify.cpp` or use one of our examples provided in `/test/`.

1. `make release`
2. `./bin/verify`

Examplary output for `/test/dom/dom1.nl` with `VERBOSE 1`:

```
[     0.000] Netlist: test/dom/dom1.nl
[     0.001] Parse: 19 gate(s) / 22 signal(s)
[     0.002] Elaborate: 19 gate(s) / 22 signal(s)
[     0.005] probing.standard (d ≤ 1) -- PASS.  >> Probes: <in:1,in:0>
[     0.006] probing.robust   (d ≤ 1) -- PASS.  >> Probes: <in:1,in:0>
[     0.008] NI.standard      (d ≤ 1) -- PASS.  >> Probes: <in:1,in:0>
[     0.009] NI.robust        (d ≤ 1) -- PASS.  >> Probes: <in:1,in:0>
[     0.010] SNI.standard     (d ≤ 1) -- PASS.  >> Probes: <in:1,in:0>
[     0.010] SNI.robust       (d ≤ 1) -- FAIL.  >> Probes: <out:17>
[     0.010] PINI.standard    (d ≤ 1) -- FAIL.  >> Probes: <and:5>
[     0.010] PINI.robust      (d ≤ 1) -- FAIL.  >> Probes: <reg:13>
[     0.011] uniformity               -- PASS.
```

## Licensing
Copyright (c) 2020, Pascal Sasdrich.
All rights reserved.

Please see `license.rtf` for further license instructions.

## Publications
D. Knichel, P. Sasdrich, A. Moradi (2020): [SILVER - Statistical Independence and Leakage Verification](https://eprint.iacr.org/2020/634.pdf)