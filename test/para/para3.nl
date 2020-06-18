in 0 0_0 # a0
in 1 0_1 # a1
in 2 0_2 # a2
in 3 0_3 # a3
in 4 1_0 # b0
in 5 1_1 # b1
in 6 1_2 # b2
in 7 1_3 # b3
ref 8  # r0
ref 9  # r1
ref 10 # r2
ref 11 # r3
and 4 0 # a0b0
and 5 1 # a1b1
and 6 2 # a2b2
and 7 3 # a3b3
xor 8 12  # a0b0 + r0
xor 9 13  # a1b1 + r1
xor 10 14 # a2b2 + r2
xor 11 15 # a3b3 + r3
reg 16
reg 17
reg 18
reg 19
and 7 0 # a0b3
and 4 1 # a1b0
and 5 2 # a2b1
and 6 3 # a3b2
xor 20 24 # a0b0 + r0 + a0b3
xor 21 25 # a1b1 + r1 + a1b0
xor 22 26 # a2b2 + r2 + a2b1
xor 23 27 # a3b3 + r3 + a3b2
reg 28
reg 29
reg 30
reg 31
and 4 3 # a3b0
and 5 0 # a0b1
and 6 1 # a1b2
and 7 2 # a2b3
xor 32 36 # a0b0 + r0 + a0b3 + a3b0
xor 33 37 # a1b1 + r1 + a1b0 + a0b1
xor 34 38 # a2b2 + r2 + a2b1 + a1b2
xor 35 39 # a3b3 + r3 + a3b2 + a2b3
reg 40
reg 41
reg 42
reg 43
xor 44 11 # a0b0 + r0 + a0b3 + a3b0 + r3
xor 45 8  # a1b1 + r1 + a1b0 + a0b1 + r0
xor 46 9  # a2b2 + r2 + a2b1 + a1b2 + r1
xor 47 10 # a3b3 + r3 + a3b2 + a2b3 + r2
reg 48
reg 49
reg 50
reg 51
and 6 0 # a0b2
and 7 1 # a1b3
and 4 2 # a2b0
and 5 3 # a3b1
xor 52 56 # a0b0 + r0 + a0b3 + a3b0 + r3 + a0b2
xor 53 57 # a1b1 + r1 + a1b0 + a0b1 + r0 + a1b3
xor 54 58 # a2b2 + r2 + a2b1 + a1b2 + r1 + a2b0
xor 55 59 # a3b3 + r3 + a3b2 + a2b3 + r2 + a3b1
out 60
out 61
out 62
out 63