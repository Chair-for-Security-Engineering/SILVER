in 0 3_0 # input_s1[3]
in 1 2_0 # input_s1[2]
in 2 1_0 # input_s1[1]
in 3 0_0 # input_s1[0]
in 4 3_1 # input_s2[3]
in 5 2_1 # input_s2[2]
in 6 1_1 # input_s2[1]
in 7 0_1 # input_s2[0]
in 8 3_2 # input_s3[3]
in 9 2_2 # input_s3[2]
in 10 1_2 # input_s3[1]
in 11 0_2 # input_s3[0]
xor 3 0 # InAff_inst_s1_U1
xor 7 4 # InAff_inst_s2_U1
not 11 # InAff_inst_s3_U2
not 9 # InAff_inst_s3_U1
reg 1 # reg1_s2_s_current_state_reg_2_
reg 5 # reg1_s3_s_current_state_reg_2_
xnor 8 14 # InAff_inst_s3_U3
nor 13 15 # Q_294N_1_inst_s1_U6
nor 13 14 # Q_294N_1_inst_s1_U1
nor 12 5 # Q_294N_1_inst_s3_U6
xnor 13 12 # Q_294N_1_inst_s3_U2
nor 12 7 # Q_294N_1_inst_s3_U1
reg 15 # reg1_s1_s_current_state_reg_2_
reg 12 # reg1_s2_s_current_state_reg_3_
reg 13 # reg1_s3_s_current_state_reg_3_
xnor 18 13 # Q_294N_1_inst_s1_U2
nor 18 1 # Q_294N_1_inst_s2_U6
xnor 12 18 # Q_294N_1_inst_s2_U2
nor 18 3 # Q_294N_1_inst_s2_U1
nor 1 22 # Q_294N_1_inst_s3_U7
nor 3 22 # Q_294N_1_inst_s3_U3
reg 18 # reg1_s1_s_current_state_reg_3_
nor 5 27 # Q_294N_1_inst_s1_U7
nor 7 27 # Q_294N_1_inst_s1_U3
nor 15 29 # Q_294N_1_inst_s2_U7
nor 14 29 # Q_294N_1_inst_s2_U3
xnor 21 31 # Q_294N_1_inst_s3_U8
xnor 23 32 # Q_294N_1_inst_s3_U4
xnor 19 34 # Q_294N_1_inst_s1_U8
xnor 20 35 # Q_294N_1_inst_s1_U4
xnor 28 36 # Q_294N_1_inst_s2_U8
xnor 30 37 # Q_294N_1_inst_s2_U4
xnor 7 38 # Q_294N_1_inst_s3_U9
xnor 6 39 # Q_294N_1_inst_s3_U5
xnor 14 40 # Q_294N_1_inst_s1_U9
xnor 10 41 # Q_294N_1_inst_s1_U5
xnor 3 42 # Q_294N_1_inst_s2_U9
xnor 2 43 # Q_294N_1_inst_s2_U5
reg 45 # reg1_s3_s_current_state_reg_0_
reg 44 # reg1_s3_s_current_state_reg_1_
reg 47 # reg1_s1_s_current_state_reg_0_
reg 46 # reg1_s1_s_current_state_reg_1_
reg 49 # reg1_s2_s_current_state_reg_0_
reg 48 # reg1_s2_s_current_state_reg_1_
nor 50 24 # Q_294N_2_inst_s2_U1
xor 51 50 # M2Aff_inst_s1_U1
reg 51 # reg2_s1_s_current_state_reg_0_
not 53 # M1Aff_inst_s1_U1
nor 54 51 # Q_294N_2_inst_s1_U6
xnor 50 54 # Q_294N_2_inst_s1_U2
nor 54 17 # Q_294N_2_inst_s1_U1
xnor 52 50 # Q_294N_2_inst_s2_U2
nor 52 55 # Q_294N_2_inst_s3_U6
xnor 54 52 # Q_294N_2_inst_s3_U2
nor 52 16 # Q_294N_2_inst_s3_U1
xor 55 54 # M2Aff_inst_s3_U1
reg 57 # reg2_s1_s_current_state_reg_1_
reg 55 # reg2_s3_s_current_state_reg_0_
nor 55 61 # Q_294N_2_inst_s1_U7
nor 16 61 # Q_294N_2_inst_s1_U3
nor 51 63 # Q_294N_2_inst_s2_U7
nor 50 59 # Q_294N_2_inst_s2_U6
nor 17 63 # Q_294N_2_inst_s2_U3
nor 59 65 # Q_294N_2_inst_s3_U7
nor 24 65 # Q_294N_2_inst_s3_U3
xor 59 52 # M2Aff_inst_s2_U1
reg 59 # reg2_s2_s_current_state_reg_0_
reg 67 # reg2_s3_s_current_state_reg_1_
xnor 60 70 # Q_294N_2_inst_s1_U8
xnor 62 71 # Q_294N_2_inst_s1_U4
xnor 73 72 # Q_294N_2_inst_s2_U8
xnor 56 74 # Q_294N_2_inst_s2_U4
xnor 64 75 # Q_294N_2_inst_s3_U8
xnor 66 76 # Q_294N_2_inst_s3_U4
reg 77 # reg2_s2_s_current_state_reg_1_
xnor 17 80 # Q_294N_2_inst_s1_U9
xnor 26 81 # Q_294N_2_inst_s1_U5
xnor 24 82 # Q_294N_2_inst_s2_U9
xnor 33 83 # Q_294N_2_inst_s2_U5
xnor 16 84 # Q_294N_2_inst_s3_U9
xnor 25 85 # Q_294N_2_inst_s3_U5
xor 88 87 # M2Aff_inst_s1_U2
xnor 90 89 # M2Aff_inst_s2_U2
xor 92 91 # M2Aff_inst_s3_U2
reg 88 # reg2_s1_s_current_state_reg_2_
reg 90 # reg2_s2_s_current_state_reg_2_
reg 92 # reg2_s3_s_current_state_reg_2_
reg 93 # reg2_s1_s_current_state_reg_3_
reg 94 # reg2_s2_s_current_state_reg_3_
reg 95 # reg2_s3_s_current_state_reg_3_
nor 100 98 # Q_294N_3_inst_s1_U6
xnor 101 100 # Q_294N_3_inst_s1_U2
nor 100 79 # Q_294N_3_inst_s1_U1
nor 101 96 # Q_294N_3_inst_s2_U6
xnor 99 101 # Q_294N_3_inst_s2_U2
nor 101 68 # Q_294N_3_inst_s2_U1
nor 99 97 # Q_294N_3_inst_s3_U6
xnor 100 99 # Q_294N_3_inst_s3_U2
nor 99 86 # Q_294N_3_inst_s3_U1
xor 98 101 # OutAff_inst_s1_U3
xor 96 99 # OutAff_inst_s2_U3
xor 97 100 # OutAff_inst_s3_U3
nor 97 103 # Q_294N_3_inst_s1_U7
nor 86 103 # Q_294N_3_inst_s1_U3
nor 98 106 # Q_294N_3_inst_s2_U7
nor 79 106 # Q_294N_3_inst_s2_U3
nor 96 109 # Q_294N_3_inst_s3_U7
nor 68 109 # Q_294N_3_inst_s3_U3
xnor 102 114 # Q_294N_3_inst_s1_U8
xnor 104 115 # Q_294N_3_inst_s1_U4
xnor 105 116 # Q_294N_3_inst_s2_U8
xnor 107 117 # Q_294N_3_inst_s2_U4
xnor 108 118 # Q_294N_3_inst_s3_U8
xnor 110 119 # Q_294N_3_inst_s3_U4
xnor 79 120 # Q_294N_3_inst_s1_U9
xnor 69 121 # Q_294N_3_inst_s1_U5
xnor 68 122 # Q_294N_3_inst_s2_U9
xnor 58 123 # Q_294N_3_inst_s2_U5
xnor 86 124 # Q_294N_3_inst_s3_U9
xnor 78 125 # Q_294N_3_inst_s3_U5
xor 127 98 # OutAff_inst_s1_U2
xor 127 126 # OutAff_inst_s1_U1
xnor 129 96 # OutAff_inst_s2_U2
xnor 129 128 # OutAff_inst_s2_U1
xor 131 97 # OutAff_inst_s3_U2
xor 131 130 # OutAff_inst_s3_U1
out 111 3_0 # output_s1[3]
out 126 2_0 # output_s1[2]
out 132 1_0 # output_s1[1]
out 133 0_0 # output_s1[0]
out 112 3_1 # output_s2[3]
out 128 2_1 # output_s2[2]
out 134 1_1 # output_s2[1]
out 135 0_1 # output_s2[0]
out 113 3_2 # output_s3[3]
out 130 2_2 # output_s3[2]
out 136 1_2 # output_s3[1]
out 137 0_2 # output_s3[0]
