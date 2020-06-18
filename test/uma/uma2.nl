in 0 0_0 # x0
in 1 0_1 # x1
in 2 0_2 # x2
in 3 1_0 # b0
in 4 1_1 # b1
in 5 1_2 # b2
ref 6 # r0
ref 7 # r1
xor 7 6 # r
and 0 4 # x0b1
and 1 3 # x1b0
and 0 3 # x0b0
and 1 5 # x1b2
and 2 4 # x2b1
and 1 4 # x1b1
and 2 3 # x2b0
and 0 5 # x0b2
and 2 5 # x2b2
reg 6 # r0ff
reg 7 # r1ff
reg 8 # rff
xor 18 9  # r0ff + x0b1
xor 19 12 # r1ff + x1b2
xor 20 15 # rff  + x2b0
reg 21 # s00
reg 22 # s01
reg 23 # s02
xor 24 10 # s00 + x1b0
xor 25 13 # s01 + x2b1
xor 26 16 # s02 + x0b2
reg 27 # s10
reg 28 # s11
reg 29 # s12
xor 30 11 # s10 + x0b0
xor 31 14 # s11 + x1b1
xor 32 17 # s12 + x2b2
reg 33 # s20
reg 34 # s21
reg 35 # s22
out 36
out 37
out 38