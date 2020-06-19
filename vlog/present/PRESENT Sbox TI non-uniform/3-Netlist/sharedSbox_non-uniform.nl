in 0 3_0 # sboxIn1[3]
in 1 2_0 # sboxIn1[2]
in 2 1_0 # sboxIn1[1]
in 3 0_0 # sboxIn1[0]
in 4 3_1 # sboxIn2[3]
in 5 2_1 # sboxIn2[2]
in 6 1_1 # sboxIn2[1]
in 7 0_1 # sboxIn2[0]
in 8 3_2 # sboxIn3[3]
in 9 2_2 # sboxIn3[2]
in 10 1_2 # sboxIn3[1]
in 11 0_2 # sboxIn3[0]
nand 5 11 # g1_U18
not 11 # g1_U16
nand 9 6 # g1_U12
xor 9 10 # g1_U7
nand 5 10 # g1_U6
nand 5 6 # g1_U4
or 5 6 # g1_U2
xnor 5 6 # g1_U1
xnor 0 9 # g2_U19
xnor 2 1 # g2_U16
xor 10 9 # g2_U15
xnor 8 1 # g2_U11
xor 10 0 # g2_U8
nand 9 8 # g2_U4
or 9 8 # g2_U2
nand 8 1 # g2_U1
nand 7 1 # g3_U17
nand 4 1 # g3_U13
nor 4 1 # g3_U10
nand 6 1 # g3_U8
not 3 # g3_U6
not 2 # g3_U1
xnor 7 19 # g1_U22
nand 13 6 # g1_U17
xnor 19 15 # g1_U8
nand 18 8 # g1_U3
xor 11 22 # g2_U24
nor 24 3 # g2_U21
and 3 20 # g2_U20
xnor 21 22 # g2_U17
xnor 0 23 # g2_U12
nand 9 24 # g2_U9
nand 2 26 # g2_U3
nor 7 33 # g3_U21
nand 29 33 # g3_U14
xor 30 5 # g3_U11
xnor 33 1 # g3_U2
reg 22 # y2_s_current_state_reg_2_
reg 19 # y1_s_current_state_reg_2_
xnor 50 49 # f3_U1
nand 35 12 # g1_U19
nand 36 7 # g1_U15
nand 4 36 # g1_U9
nand 37 17 # g1_U5
nor 40 39 # g2_U22
nand 41 11 # g2_U18
nand 42 10 # g2_U13
nand 44 25 # g2_U5
xor 48 3 # g3_U24
nand 47 2 # g3_U12
xnor 48 6 # g3_U3
reg 48 # y3_s_current_state_reg_2_
reg 38 # y2_s_current_state_reg_3_
reg 34 # y1_s_current_state_reg_3_
xnor 49 63 # f1_U1
xnor 63 50 # f2_U7
xnor 52 8 # g1_U20
xor 16 54 # g1_U10
xnor 57 56 # g2_U23
xor 11 59 # g2_U6
xor 62 5 # g3_U18
nand 61 46 # g3_U15
xnor 5 62 # g3_U4
reg 60 # y3_s_current_state_reg_3_
xnor 75 65 # f2_U1
xnor 53 68 # g1_U21
xor 7 69 # g1_U11
xnor 27 71 # g2_U7
nor 32 72 # g3_U19
nand 74 0 # g3_U5
reg 70 # y2_s_current_state_reg_1_
xor 82 49 # f1_U8
xnor 78 14 # g1_U13
xnor 79 43 # g2_U10
xor 4 80 # g3_U20
xor 81 32 # g3_U7
reg 77 # y1_s_current_state_reg_1_
xor 88 50 # f3_U8
xnor 55 84 # g1_U14
xnor 85 58 # g2_U14
xor 86 45 # g3_U22
xnor 87 31 # g3_U9
xnor 28 92 # g3_U23
xnor 93 73 # g3_U16
reg 91 # y2_s_current_state_reg_0_
reg 90 # y1_s_current_state_reg_0_
nand 75 96 # f1_U7
not 96 # f1_U2
nand 63 97 # f2_U11
nand 97 75 # f2_U4
nand 82 97 # f3_U14
xor 97 96 # f3_U9
nand 64 97 # f3_U7
nand 50 96 # f3_U5
not 97 # f3_U2
reg 95 # y3_s_current_state_reg_0_
reg 94 # y3_s_current_state_reg_1_
nor 75 99 # f1_U17
nand 108 96 # f1_U14
xor 96 107 # f1_U9
nand 49 107 # f1_U5
nor 66 99 # f1_U3
nand 97 108 # f2_U18
xnor 108 88 # f2_U15
not 107 # f2_U8
xor 108 63 # f2_U3
nand 76 107 # f2_U2
nor 64 106 # f3_U17
nand 103 88 # f3_U13
nand 65 103 # f3_U10
nor 51 106 # f3_U3
nand 111 82 # f1_U13
nand 64 111 # f1_U10
xor 82 113 # f1_U4
nor 115 116 # f2_U16
nor 116 76 # f2_U13
nor 67 116 # f2_U9
xnor 117 101 # f2_U5
xnor 120 102 # f3_U15
xnor 89 121 # f3_U11
xor 88 122 # f3_U4
xnor 123 110 # f1_U15
xnor 83 124 # f1_U11
xnor 125 112 # f1_U6
xor 75 126 # f2_U17
xor 129 127 # f2_U14
xor 108 128 # f2_U10
xnor 118 129 # f2_U6
xor 131 119 # f3_U18
xnor 65 130 # f3_U16
xnor 104 131 # f3_U12
xnor 132 105 # f3_U6
xor 134 109 # f1_U18
xnor 64 133 # f1_U16
xnor 98 134 # f1_U12
xnor 136 114 # f2_U19
xnor 138 100 # f2_U12
out 144 3_0 # share1[3]
out 145 2_0 # share1[2]
out 146 1_0 # share1[1]
out 135 0_0 # share1[0]
out 139 3_1 # share2[3]
out 147 2_1 # share2[2]
out 137 1_1 # share2[1]
out 148 0_1 # share2[0]
out 140 3_2 # share3[3]
out 141 2_2 # share3[2]
out 142 1_2 # share3[1]
out 143 0_2 # share3[0]
