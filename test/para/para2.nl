in 0 0_0 # a0
in 1 0_1 # a1
in 2 0_2 # a2
in 3 1_0 # b0
in 4 1_1 # b1
in 5 1_2 # b2
ref 6
ref 7
ref 8
and 3 0 # a0b0
and 4 1 # a1b1
and 5 2 # a2b2
xor 9 6  # a0b0 + r0
xor 10 7 # a1b1 + r1
xor 11 8 # a2b2 + r2
reg 12
reg 13
reg 14
and 5 0 # a0b2 
and 3 1 # a1b0
and 4 2 # a2b1
xor 15 18 # a0b0 + r0 + a0b2
xor 16 19 # a1b1 + r1 + a1b0
xor 17 20 # a2b2 + r2 + a2b1
reg 21
reg 22
reg 23
and 3 2 # a2b0
and 4 0 # a0b1
and 5 1 # a1b2
xor 24 27 # a0b0 + r0 + a0b2 + a2b0
xor 25 28 # a1b1 + r1 + a1b0 + a0b1
xor 26 29 # a2b2 + r2 + a2b1 + a1b2
reg 30
reg 31
reg 32
xor 33 7 # a0b0 + r0 + a0b1 + a2b0 + r1
xor 34 8 # a1b1 + r1 + a1b2 + a0b1 + r2
xor 35 6 # a2b2 + r2 + a2b0 + a1b2 + r0
reg 36
reg 37
reg 38
out 39
out 40
out 41
