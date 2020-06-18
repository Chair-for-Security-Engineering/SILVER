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
reg 36 # x0
reg 37 # x1
reg 38 # x2
reg 3 # b0
reg 4 # b1
reg 5 # b2
ref 8 # r0
ref 9 # r1
xor 46 45 # r
and 39 43 # x0b1
and 40 42 # x1b0
and 39 42 # x0b0
and 40 44 # x1b2
and 41 43 # x2b1
and 40 43 # x1b1
and 41 42 # x2b0
and 39 44 # x0b2
and 41 44 # x2b2
reg 45 # r0ff
reg 46 # r1ff
reg 47 # r2ff
xor 57 48 # r0ff + x0b1
xor 58 51 # r1ff + x1b2
xor 59 54 # rff  + x2b0
reg 60 # s00
reg 61 # s01
reg 62 # s02
xor 63 49 # s00 + x1b0
xor 64 52 # s01 + x2b1
xor 65 55 # s02 + x0b2
reg 66 # s10
reg 67 # s11
reg 68 # s12
xor 69 50 # s10 + x0b0
xor 70 53 # s11 + x1b1
xor 71 56 # s12 + x2b2
reg 72 # s20
reg 73 # s21
reg 74 # s22
out 75
out 76
out 77