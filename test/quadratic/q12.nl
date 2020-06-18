in 0 0_0 # a1
in 1 1_0 # b1
in 2 2_0 # c1
in 3 3_0 # d1
in 4 0_1 # a2
in 5 1_1 # b2
in 6 2_1 # c2
in 7 3_1 # d2
and 0 1 # a1b1
and 0 5 # a1b2
and 4 1 # a2b1
and 4 5 # a2b2
and 0 2 # a1c1
and 0 6 # a1c2
and 4 2 # a2c1
and 4 6 # a2c2
xor 12 1  # a1c1 + b1
xor 14 5  # a2c1 + b2
xor 8 12  # a1b1 + a1c1
xor 9 13  # a1b2 + a1c2
xor 10 14 # a2b1 + a2c1
xor 11 15 # a2b2 + a2c2
xor 18 2  # a1b1 + a1c1 + c1
xor 21 6  # a2b2 + a2c2 + c2
reg 13
reg 15
reg 16
reg 17
reg 19
reg 20
reg 22
reg 23
xor 26 24 # y1 + y2
xor 27 25 # y3 + y4
xor 30 28 # z1 + z2
xor 31 29 # z3 + z4
reg 0
reg 3
reg 4
reg 7
out 36 0_0
out 32 1_0
out 34 2_0
out 37 3_0
out 38 0_1
out 33 1_1
out 35 2_1
out 39 3_1