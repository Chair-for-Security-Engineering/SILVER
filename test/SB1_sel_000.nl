in 0 7_0 # input1[7]
in 1 6_0 # input1[6]
in 2 5_0 # input1[5]
in 3 4_0 # input1[4]
in 4 3_0 # input1[3]
in 5 2_0 # input1[2]
in 6 1_0 # input1[1]
in 7 0_0 # input1[0]
in 8 7_1 # input2[7]
in 9 6_1 # input2[6]
in 10 5_1 # input2[5]
in 11 4_1 # input2[4]
in 12 3_1 # input2[3]
in 13 2_1 # input2[2]
in 14 1_1 # input2[1]
in 15 0_1 # input2[0]
in 16 7_2 # input3[7]
in 17 6_2 # input3[6]
in 18 5_2 # input3[5]
in 19 4_2 # input3[4]
in 20 3_2 # input3[3]
in 21 2_2 # input3[2]
in 22 1_2 # input3[1]
in 23 0_2 # input3[0]
buf 7 # MUX1_mux_inst_0_U1
buf 6 # MUX1_mux_inst_1_U1
buf 5 # MUX1_mux_inst_2_U1
buf 4 # MUX1_mux_inst_3_U1
buf 3 # MUX1_mux_inst_4_U1
buf 2 # MUX1_mux_inst_5_U1
buf 1 # MUX1_mux_inst_6_U1
buf 0 # MUX1_mux_inst_7_U1
buf 15 # MUX2_mux_inst_0_U1
buf 14 # MUX2_mux_inst_1_U1
buf 13 # MUX2_mux_inst_2_U1
buf 12 # MUX2_mux_inst_3_U1
buf 11 # MUX2_mux_inst_4_U1
buf 10 # MUX2_mux_inst_5_U1
buf 9 # MUX2_mux_inst_6_U1
buf 8 # MUX2_mux_inst_7_U1
buf 23 # MUX3_mux_inst_0_U1
buf 22 # MUX3_mux_inst_1_U1
buf 21 # MUX3_mux_inst_2_U1
buf 20 # MUX3_mux_inst_3_U1
buf 19 # MUX3_mux_inst_4_U1
buf 18 # MUX3_mux_inst_5_U1
buf 17 # MUX3_mux_inst_6_U1
buf 16 # MUX3_mux_inst_7_U1
reg 40 # SB_reg_state3_reg_0_
reg 41 # SB_reg_state3_reg_1_
reg 42 # SB_reg_state3_reg_2_
reg 43 # SB_reg_state3_reg_3_
reg 44 # SB_reg_state3_reg_4_
reg 45 # SB_reg_state3_reg_5_
reg 46 # SB_reg_state3_reg_6_
reg 47 # SB_reg_state3_reg_7_
reg 32 # SB_reg_state2_reg_0_
reg 33 # SB_reg_state2_reg_1_
reg 34 # SB_reg_state2_reg_2_
reg 35 # SB_reg_state2_reg_3_
reg 36 # SB_reg_state2_reg_4_
reg 37 # SB_reg_state2_reg_5_
reg 38 # SB_reg_state2_reg_6_
reg 39 # SB_reg_state2_reg_7_
reg 24 # SB_reg_state1_reg_0_
reg 25 # SB_reg_state1_reg_1_
reg 26 # SB_reg_state1_reg_2_
reg 27 # SB_reg_state1_reg_3_
reg 28 # SB_reg_state1_reg_4_
reg 29 # SB_reg_state1_reg_5_
reg 30 # SB_reg_state1_reg_6_
reg 31 # SB_reg_state1_reg_7_
not 50 # SB_SB_U3
xor 49 57 # SB_SB_Right_inst_s1_U7
nand 51 57 # SB_SB_Right_inst_s1_U6
xor 59 51 # SB_SB_Right_inst_s1_U2
nand 50 59 # SB_SB_Right_inst_s1_U1
xor 65 49 # SB_SB_Right_inst_s2_U7
nand 67 49 # SB_SB_Right_inst_s2_U6
xor 51 67 # SB_SB_Right_inst_s2_U2
nand 66 51 # SB_SB_Right_inst_s2_U1
xor 57 65 # SB_SB_Right_inst_s3_U7
nand 59 65 # SB_SB_Right_inst_s3_U6
xor 67 59 # SB_SB_Right_inst_s3_U2
nand 58 67 # SB_SB_Right_inst_s3_U1
nand 73 59 # SB_SB_Right_inst_s1_U8
nand 75 58 # SB_SB_Right_inst_s1_U3
nand 77 51 # SB_SB_Right_inst_s2_U8
nand 79 50 # SB_SB_Right_inst_s2_U3
nand 81 67 # SB_SB_Right_inst_s3_U8
nand 83 66 # SB_SB_Right_inst_s3_U3
xnor 74 85 # SB_SB_Right_inst_s1_U9
xnor 76 86 # SB_SB_Right_inst_s1_U4
xnor 78 87 # SB_SB_Right_inst_s2_U9
xnor 80 88 # SB_SB_Right_inst_s2_U4
xnor 82 89 # SB_SB_Right_inst_s3_U9
xnor 84 90 # SB_SB_Right_inst_s3_U4
xnor 48 91 # SB_SB_Right_inst_s1_U10
xnor 49 92 # SB_SB_Right_inst_s1_U5
xnor 64 93 # SB_SB_Right_inst_s2_U10
xnor 65 94 # SB_SB_Right_inst_s2_U5
xnor 56 95 # SB_SB_Right_inst_s3_U10
xnor 57 96 # SB_SB_Right_inst_s3_U5
out 72 7_0 # output1[7]
out 97 6_0 # output1[6]
out 51 5_0 # output1[5]
out 69 4_0 # output1[4]
out 71 3_0 # output1[3]
out 98 2_0 # output1[2]
out 70 1_0 # output1[1]
out 68 0_0 # output1[0]
out 66 7_1 # output2[7]
out 99 6_1 # output2[6]
out 67 5_1 # output2[5]
out 61 4_1 # output2[4]
out 63 3_1 # output2[3]
out 100 2_1 # output2[2]
out 62 1_1 # output2[1]
out 60 0_1 # output2[0]
out 58 7_2 # output3[7]
out 101 6_2 # output3[6]
out 59 5_2 # output3[5]
out 53 4_2 # output3[4]
out 55 3_2 # output3[3]
out 102 2_2 # output3[2]
out 54 1_2 # output3[1]
out 52 0_2 # output3[0]
