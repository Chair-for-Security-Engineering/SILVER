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
nand 10 5 # g1_U23
nand 9 6 # g1_U22
nor 6 8 # g1_U19
and 6 8 # g1_U18
not 5 # g1_U16
not 7 # g1_U15
nand 10 7 # g1_U11
or 7 10 # g1_U7
nand 1 11 # g2_U21
or 1 11 # g2_U19
nand 9 3 # g2_U16
xor 10 9 # g2_U15
nand 10 1 # g2_U8
not 9 # g2_U6
xor 8 0 # g2_U4
xnor 10 1 # g2_U1
nand 6 3 # g3_U17
or 6 3 # g3_U15
xnor 1 6 # g3_U10
xnor 0 5 # g3_U7
nand 1 6 # g3_U2
not 2 # g3_U1
xor 13 12 # g1_U24
nor 16 14 # g1_U20
xor 16 6 # g1_U17
nand 9 19 # g1_U8
not 16 # g1_U3
nand 16 6 # g1_U1
xor 23 11 # g2_U28
nand 11 23 # g2_U26
nand 2 21 # g2_U20
xor 25 3 # g2_U17
xnor 25 0 # g2_U12
xor 11 24 # g2_U9
xnor 2 26 # g2_U5
xnor 2 27 # g2_U2
xnor 33 7 # g3_U23
nor 7 33 # g3_U21
nand 29 5 # g3_U16
xnor 5 30 # g3_U11
xnor 31 1 # g3_U8
xnor 1 33 # g3_U4
xnor 32 3 # g3_U3
reg 23 # y2_s_current_state_reg_2_
xor 36 17 # g1_U31
xor 36 10 # g1_U27
xnor 17 34 # g1_U25
nor 15 35 # g1_U21
nand 18 37 # g1_U12
nor 36 17 # g1_U9
nand 38 11 # g1_U4
nor 11 39 # g1_U2
nand 42 20 # g2_U22
nand 43 10 # g2_U18
nand 10 44 # g2_U13
nor 46 25 # g2_U7
nand 47 8 # g2_U3
xor 53 3 # g3_U27
nand 1 48 # g3_U24
xor 4 49 # g3_U22
nand 53 3 # g3_U19
nand 50 28 # g3_U18
nand 51 0 # g3_U12
nand 52 2 # g3_U9
nand 53 4 # g3_U5
reg 53 # y3_s_current_state_reg_2_
reg 40 # y2_s_current_state_reg_3_
reg 36 # y1_s_current_state_reg_2_
xnor 55 77 # f1_U1
xnor 77 79 # f2_U7
xnor 79 55 # f3_U1
xnor 9 57 # g1_U28
xnor 59 58 # g1_U26
xor 8 61 # g1_U10
nor 6 62 # g1_U5
xor 0 64 # g2_U23
xnor 67 45 # g2_U10
xnor 71 70 # g3_U25
xnor 73 72 # g3_U20
xnor 75 74 # g3_U13
xnor 54 76 # g3_U6
reg 69 # y3_s_current_state_reg_3_
reg 56 # y1_s_current_state_reg_3_
xnor 93 94 # f2_U1
nand 83 4 # g1_U29
xnor 60 85 # g1_U13
nor 63 86 # g1_U6
xnor 65 87 # g2_U24
xnor 68 88 # g2_U11
xor 90 89 # g3_U26
xnor 92 91 # g3_U14
xor 84 96 # g1_U30
xnor 98 97 # g1_U14
xnor 22 99 # g2_U25
xnor 100 66 # g2_U14
reg 102 # y3_s_current_state_reg_0_
reg 101 # y3_s_current_state_reg_1_
nand 55 107 # f1_U5
not 107 # f2_U8
xor 108 77 # f2_U3
nand 95 107 # f2_U2
xnor 105 41 # g2_U27
reg 106 # y2_s_current_state_reg_0_
reg 103 # y1_s_current_state_reg_0_
reg 104 # y1_s_current_state_reg_1_
nand 108 114 # f1_U14
xor 114 107 # f1_U9
nand 93 114 # f1_U7
not 114 # f1_U2
nand 115 108 # f2_U18
xnor 108 116 # f2_U15
nor 110 95 # f2_U13
nand 77 115 # f2_U11
nor 81 110 # f2_U9
nand 115 93 # f2_U4
xor 115 114 # f3_U9
xor 116 79 # f3_U8
nand 78 115 # f3_U7
nand 79 114 # f3_U5
not 115 # f3_U2
reg 113 # y2_s_current_state_reg_1_
nor 93 120 # f1_U17
nand 118 132 # f1_U13
nand 78 118 # f1_U10
xor 132 55 # f1_U8
nor 80 120 # f1_U3
nor 122 110 # f2_U16
xor 108 125 # f2_U10
xnor 111 126 # f2_U5
nor 78 131 # f3_U17
nand 132 115 # f3_U14
nand 127 116 # f3_U13
nand 94 127 # f3_U10
nor 82 131 # f3_U3
xnor 134 117 # f1_U15
xnor 136 135 # f1_U11
xor 132 137 # f1_U4
xor 93 138 # f2_U17
xor 140 123 # f2_U14
xnor 139 124 # f2_U12
xnor 112 140 # f2_U6
xnor 143 142 # f3_U15
xnor 128 144 # f3_U11
xor 116 145 # f3_U4
xor 147 133 # f1_U18
xnor 78 146 # f1_U16
xnor 119 147 # f1_U12
xnor 148 109 # f1_U6
xnor 149 121 # f2_U19
xor 154 141 # f3_U18
xnor 94 153 # f3_U16
xnor 129 154 # f3_U12
xnor 155 130 # f3_U6
out 156 3_0 # share1[3]
out 157 2_0 # share1[2]
out 158 1_0 # share1[1]
out 159 0_0 # share1[0]
out 152 3_1 # share2[3]
out 160 2_1 # share2[2]
out 150 1_1 # share2[1]
out 151 0_1 # share2[0]
out 161 3_2 # share3[3]
out 162 2_2 # share3[2]
out 163 1_2 # share3[1]
out 164 0_2 # share3[0]
