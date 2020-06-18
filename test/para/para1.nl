in 0 0_0 # a0
in 1 0_1 # a1
in 2 1_0 # b0
in 3 1_1 # b1
ref 4 # r0
ref 5 # r1
and 2 0 # a0b0
and 3 1 # a1b1
xor 6 4 # a0b0 + r0
xor 7 5 # a1b1 + r1
reg 8 # a0b0 + r0
reg 9 # a1b1 + r1
and 2 1 # a0b1
and 3 0 # a1b0
xor 12 10 # a0b0 + a0b1 + r0
xor 13 11 # a1b1 + a1b0 + r1
xor 14 5 # a0b0 + a0b1 + r0 + r1
xor 15 4 # a1b1 + a1b0 + r1 + r0
reg 16
reg 17
out 18 0_0
out 19 0_1