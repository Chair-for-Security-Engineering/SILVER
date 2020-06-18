in 0 7_0 # input_s1[7]
in 1 6_0 # input_s1[6]
in 2 5_0 # input_s1[5]
in 3 4_0 # input_s1[4]
in 4 3_0 # input_s1[3]
in 5 2_0 # input_s1[2]
in 6 1_0 # input_s1[1]
in 7 0_0 # input_s1[0]
in 8 7_1 # input_s2[7]
in 9 6_1 # input_s2[6]
in 10 5_1 # input_s2[5]
in 11 4_1 # input_s2[4]
in 12 3_1 # input_s2[3]
in 13 2_1 # input_s2[2]
in 14 1_1 # input_s2[1]
in 15 0_1 # input_s2[0]
in 16 7_2 # input_s3[7]
in 17 6_2 # input_s3[6]
in 18 5_2 # input_s3[5]
in 19 4_2 # input_s3[4]
in 20 3_2 # input_s3[3]
in 21 2_2 # input_s3[2]
in 22 1_2 # input_s3[1]
in 23 0_2 # input_s3[0]
nor 16 9 # Stage1_CF1_U8
xnor 9 17 # Stage1_CF1_U6
nor 20 13 # Stage1_CF1_U3
xnor 13 21 # Stage1_CF1_U1
nor 0 17 # Stage1_CF2_U8
xnor 17 1 # Stage1_CF2_U6
nor 4 21 # Stage1_CF2_U3
xnor 21 5 # Stage1_CF2_U1
nor 8 1 # Stage1_CF3_U8
xnor 1 9 # Stage1_CF3_U6
nor 12 5 # Stage1_CF3_U3
xnor 5 13 # Stage1_CF3_U1
reg 18 # reg1_s1_s_current_state_reg_0_
reg 20 # reg1_s1_s_current_state_reg_1_
reg 17 # reg1_s1_s_current_state_reg_4_
reg 16 # reg1_s1_s_current_state_reg_5_
reg 22 # reg1_s1_s_current_state_reg_6_
reg 21 # reg1_s1_s_current_state_reg_7_
reg 2 # reg1_s2_s_current_state_reg_0_
reg 4 # reg1_s2_s_current_state_reg_1_
reg 1 # reg1_s2_s_current_state_reg_4_
reg 0 # reg1_s2_s_current_state_reg_5_
reg 6 # reg1_s2_s_current_state_reg_6_
reg 5 # reg1_s2_s_current_state_reg_7_
reg 10 # reg1_s3_s_current_state_reg_0_
reg 12 # reg1_s3_s_current_state_reg_1_
reg 9 # reg1_s3_s_current_state_reg_4_
reg 8 # reg1_s3_s_current_state_reg_5_
reg 14 # reg1_s3_s_current_state_reg_6_
reg 13 # reg1_s3_s_current_state_reg_7_
xnor 24 19 # Stage1_CF1_U9
nor 25 8 # Stage1_CF1_U7
xnor 26 23 # Stage1_CF1_U4
nor 27 12 # Stage1_CF1_U2
xnor 28 3 # Stage1_CF2_U9
nor 29 16 # Stage1_CF2_U7
xnor 30 7 # Stage1_CF2_U4
nor 31 20 # Stage1_CF2_U2
xnor 32 11 # Stage1_CF3_U9
nor 33 0 # Stage1_CF3_U7
xnor 34 15 # Stage1_CF3_U4
nor 35 4 # Stage1_CF3_U2
nor 53 46 # Stage2_CF1_U8
xnor 46 52 # Stage2_CF1_U6
nor 41 52 # Stage2_CF2_U8
xnor 52 40 # Stage2_CF2_U6
nor 47 40 # Stage2_CF3_U8
xnor 40 46 # Stage2_CF3_U6
reg 51 # reg2_s1_s_current_state_reg_0_
reg 52 # reg2_s1_s_current_state_reg_4_
reg 53 # reg2_s1_s_current_state_reg_5_
reg 49 # reg2_s1_s_current_state_reg_6_
reg 39 # reg2_s2_s_current_state_reg_0_
reg 40 # reg2_s2_s_current_state_reg_4_
reg 41 # reg2_s2_s_current_state_reg_5_
reg 37 # reg2_s2_s_current_state_reg_6_
reg 45 # reg2_s3_s_current_state_reg_0_
reg 46 # reg2_s3_s_current_state_reg_4_
reg 47 # reg2_s3_s_current_state_reg_5_
reg 43 # reg2_s3_s_current_state_reg_6_
xnor 55 54 # Stage1_CF1_U10
xnor 57 56 # Stage1_CF1_U5
xnor 59 58 # Stage1_CF2_U10
xnor 61 60 # Stage1_CF2_U5
xnor 63 62 # Stage1_CF3_U10
xnor 65 64 # Stage1_CF3_U5
xnor 66 50 # Stage2_CF1_U9
nor 67 47 # Stage2_CF1_U7
xnor 68 38 # Stage2_CF2_U9
nor 69 53 # Stage2_CF2_U7
xnor 70 44 # Stage2_CF3_U9
nor 71 41 # Stage2_CF3_U7
xnor 79 83 # Stage3_CF1_U6
xnor 83 75 # Stage3_CF2_U6
xnor 75 79 # Stage3_CF3_U6
reg 82 # reg3_s1_s_current_state_reg_0_
reg 83 # reg3_s1_s_current_state_reg_4_
reg 74 # reg3_s2_s_current_state_reg_0_
reg 75 # reg3_s2_s_current_state_reg_4_
reg 78 # reg3_s3_s_current_state_reg_0_
reg 79 # reg3_s3_s_current_state_reg_4_
reg 85 # reg1_s1_s_current_state_reg_2_
reg 84 # reg1_s1_s_current_state_reg_3_
reg 87 # reg1_s2_s_current_state_reg_2_
reg 86 # reg1_s2_s_current_state_reg_3_
reg 89 # reg1_s3_s_current_state_reg_2_
reg 88 # reg1_s3_s_current_state_reg_3_
xnor 91 90 # Stage2_CF1_U10
xnor 93 92 # Stage2_CF2_U10
xnor 95 94 # Stage2_CF3_U10
nor 110 107 # Stage2_CF1_U3
xnor 107 109 # Stage2_CF1_U1
nor 106 109 # Stage2_CF2_U3
xnor 109 105 # Stage2_CF2_U1
nor 108 105 # Stage2_CF3_U3
xnor 105 107 # Stage2_CF3_U1
reg 110 # reg2_s1_s_current_state_reg_1_
reg 111 # reg2_s1_s_current_state_reg_3_
reg 109 # reg2_s1_s_current_state_reg_7_
reg 106 # reg2_s2_s_current_state_reg_1_
reg 112 # reg2_s2_s_current_state_reg_3_
reg 105 # reg2_s2_s_current_state_reg_7_
reg 108 # reg2_s3_s_current_state_reg_1_
reg 113 # reg2_s3_s_current_state_reg_3_
reg 107 # reg2_s3_s_current_state_reg_7_
xnor 114 48 # Stage2_CF1_U4
nor 115 108 # Stage2_CF1_U2
xnor 116 36 # Stage2_CF2_U4
nor 117 110 # Stage2_CF2_U2
xnor 118 42 # Stage2_CF3_U4
nor 119 106 # Stage2_CF3_U2
nor 128 79 # Stage3_CF1_U8
nor 96 125 # Stage3_CF1_U7
nor 122 83 # Stage3_CF2_U8
nor 97 128 # Stage3_CF2_U7
nor 125 75 # Stage3_CF3_U8
nor 98 122 # Stage3_CF3_U7
reg 127 # reg3_s1_s_current_state_reg_1_
reg 128 # reg3_s1_s_current_state_reg_5_
reg 126 # reg3_s1_s_current_state_reg_6_
reg 121 # reg3_s2_s_current_state_reg_1_
reg 122 # reg3_s2_s_current_state_reg_5_
reg 120 # reg3_s2_s_current_state_reg_6_
reg 124 # reg3_s3_s_current_state_reg_1_
reg 125 # reg3_s3_s_current_state_reg_5_
reg 123 # reg3_s3_s_current_state_reg_6_
xnor 130 129 # Stage2_CF1_U5
xnor 132 131 # Stage2_CF2_U5
xnor 134 133 # Stage2_CF3_U5
xnor 135 81 # Stage3_CF1_U9
xnor 137 73 # Stage3_CF2_U9
xnor 139 77 # Stage3_CF3_U9
xnor 146 149 # Stage4_CF1_U6
xnor 149 143 # Stage4_CF2_U6
xnor 143 146 # Stage4_CF3_U6
reg 150 # reg2_s1_s_current_state_reg_2_
reg 151 # reg2_s2_s_current_state_reg_2_
reg 152 # reg2_s3_s_current_state_reg_2_
xnor 136 153 # Stage3_CF1_U10
xnor 138 154 # Stage3_CF2_U10
xnor 140 155 # Stage3_CF3_U10
nor 127 160 # Stage3_CF1_U3
xnor 160 161 # Stage3_CF1_U1
nor 121 161 # Stage3_CF2_U3
xnor 161 159 # Stage3_CF2_U1
nor 124 159 # Stage3_CF3_U3
xnor 159 160 # Stage3_CF3_U1
reg 162 # reg3_s1_s_current_state_reg_3_
reg 161 # reg3_s1_s_current_state_reg_7_
reg 163 # reg3_s2_s_current_state_reg_3_
reg 159 # reg3_s2_s_current_state_reg_7_
reg 164 # reg3_s3_s_current_state_reg_3_
reg 160 # reg3_s3_s_current_state_reg_7_
xnor 165 80 # Stage3_CF1_U4
nor 166 124 # Stage3_CF1_U2
xnor 167 72 # Stage3_CF2_U4
nor 168 127 # Stage3_CF2_U2
xnor 169 76 # Stage3_CF3_U4
nor 170 121 # Stage3_CF3_U2
nor 176 146 # Stage4_CF1_U8
nor 156 174 # Stage4_CF1_U7
nor 172 149 # Stage4_CF2_U8
nor 157 176 # Stage4_CF2_U7
nor 174 143 # Stage4_CF3_U8
nor 158 172 # Stage4_CF3_U7
xnor 178 177 # Stage3_CF1_U5
xnor 180 179 # Stage3_CF2_U5
xnor 182 181 # Stage3_CF3_U5
xnor 183 104 # Stage4_CF1_U9
xnor 185 100 # Stage4_CF2_U9
xnor 187 102 # Stage4_CF3_U9
reg 189 # reg3_s1_s_current_state_reg_2_
reg 190 # reg3_s2_s_current_state_reg_2_
reg 191 # reg3_s3_s_current_state_reg_2_
xnor 184 192 # Stage4_CF1_U10
xnor 186 193 # Stage4_CF2_U10
xnor 188 194 # Stage4_CF3_U10
nor 175 196 # Stage4_CF1_U3
xnor 196 197 # Stage4_CF1_U1
nor 171 197 # Stage4_CF2_U3
xnor 197 195 # Stage4_CF2_U1
nor 173 195 # Stage4_CF3_U3
xnor 195 196 # Stage4_CF3_U1
xnor 201 103 # Stage4_CF1_U4
nor 202 173 # Stage4_CF1_U2
xnor 203 99 # Stage4_CF2_U4
nor 204 175 # Stage4_CF2_U2
xnor 205 101 # Stage4_CF3_U4
nor 206 171 # Stage4_CF3_U2
xnor 208 207 # Stage4_CF1_U5
xnor 210 209 # Stage4_CF2_U5
xnor 212 211 # Stage4_CF3_U5
out 176 7_0 # output_s1[7]
out 149 6_0 # output_s1[6]
out 148 5_0 # output_s1[5]
out 198 4_0 # output_s1[4]
out 175 3_0 # output_s1[3]
out 147 2_0 # output_s1[2]
out 197 1_0 # output_s1[1]
out 213 0_0 # output_s1[0]
out 172 7_1 # output_s2[7]
out 143 6_1 # output_s2[6]
out 142 5_1 # output_s2[5]
out 199 4_1 # output_s2[4]
out 171 3_1 # output_s2[3]
out 141 2_1 # output_s2[2]
out 195 1_1 # output_s2[1]
out 214 0_1 # output_s2[0]
out 174 7_2 # output_s3[7]
out 146 6_2 # output_s3[6]
out 145 5_2 # output_s3[5]
out 200 4_2 # output_s3[4]
out 173 3_2 # output_s3[3]
out 144 2_2 # output_s3[2]
out 196 1_2 # output_s3[1]
out 215 0_2 # output_s3[0]
