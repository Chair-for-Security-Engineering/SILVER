
module CMSSbox ( in_1, in_2, i_clk, i_r, out_1, out_2 );
(* SILVER="[3:0]_0" *)  input [3:0] in_1;
(* SILVER="[3:0]_1" *)  input [3:0] in_2;
(* SILVER="refresh" *)  input [11:0] i_r;
(* SILVER="[3:0]_0" *)  output [3:0] out_1;
(* SILVER="[3:0]_1" *)  output [3:0] out_2;
(* SILVER="clock" *)  input i_clk;
  wire   sbox_out7_b4, sbox_out6_b4, sbox_out5_b4, sbox_out4_b4, sbox_out3_b4,
         sbox_out2_b4, sbox_out7_b3, sbox_out6_b3, sbox_out5_b3, sbox_out4_b3,
         sbox_out3_b3, sbox_out2_b3, sbox_out7_b2, sbox_out6_b2, sbox_out5_b2,
         sbox_out4_b2, sbox_out3_b2, sbox_out2_b2, sbox_out7_b1, sbox_out6_b1,
         sbox_out5_b1, sbox_out4_b1, sbox_out3_b1, sbox_out2_b1,
         out_b4_reg_next8, out_b4_reg_next7, out_b4_reg_next6,
         out_b4_reg_next5, out_b4_reg_next4, out_b4_reg_next3,
         out_b4_reg_next2, out_b4_reg_next1, out_b3_reg_next8,
         out_b3_reg_next7, out_b3_reg_next6, out_b3_reg_next5,
         out_b3_reg_next4, out_b3_reg_next3, out_b3_reg_next2,
         out_b3_reg_next1, out_b2_reg_next8, out_b2_reg_next7,
         out_b2_reg_next6, out_b2_reg_next5, out_b2_reg_next4,
         out_b2_reg_next3, out_b2_reg_next2, out_b2_reg_next1,
         out_b1_reg_next8, out_b1_reg_next7, out_b1_reg_next6,
         out_b1_reg_next5, out_b1_reg_next4, out_b1_reg_next3,
         out_b1_reg_next2, out_b1_reg_next1, out_b1_reg_out1, out_b1_reg_out2,
         out_b1_reg_out3, out_b1_reg_out4, out_b1_reg_out5, out_b1_reg_out6,
         out_b1_reg_out7, out_b1_reg_out8, out_b2_reg_out1, out_b2_reg_out2,
         out_b2_reg_out3, out_b2_reg_out4, out_b2_reg_out5, out_b2_reg_out6,
         out_b2_reg_out7, out_b2_reg_out8, out_b3_reg_out1, out_b3_reg_out2,
         out_b3_reg_out3, out_b3_reg_out4, out_b3_reg_out5, out_b3_reg_out6,
         out_b3_reg_out7, out_b3_reg_out8, out_b4_reg_out1, out_b4_reg_out2,
         out_b4_reg_out3, out_b4_reg_out4, out_b4_reg_out5, out_b4_reg_out6,
         out_b4_reg_out7, out_b4_reg_out8, comp_sh2_0_,
         SBOX_ITK_sb1_inst_s_bit11_inst_n15,
         SBOX_ITK_sb1_inst_s_bit11_inst_n14,
         SBOX_ITK_sb1_inst_s_bit11_inst_n13,
         SBOX_ITK_sb1_inst_s_bit11_inst_n12,
         SBOX_ITK_sb1_inst_s_bit11_inst_n11,
         SBOX_ITK_sb1_inst_s_bit11_inst_n10,
         SBOX_ITK_sb1_inst_s_bit12_inst_n11,
         SBOX_ITK_sb1_inst_s_bit12_inst_n10, SBOX_ITK_sb1_inst_s_bit12_inst_n9,
         SBOX_ITK_sb1_inst_s_bit12_inst_n8, SBOX_ITK_sb1_inst_s_bit12_inst_n7,
         SBOX_ITK_sb1_inst_s_bit13_inst_n9, SBOX_ITK_sb1_inst_s_bit13_inst_n8,
         SBOX_ITK_sb1_inst_s_bit13_inst_n7, SBOX_ITK_sb1_inst_s_bit13_inst_n6,
         SBOX_ITK_sb1_inst_s_bit14_inst_n2, SBOX_ITK_sb1_inst_s_bit15_inst_n6,
         SBOX_ITK_sb1_inst_s_bit15_inst_n5, SBOX_ITK_sb1_inst_s_bit15_inst_n4,
         SBOX_ITK_sb1_inst_s_bit16_inst_n5, SBOX_ITK_sb1_inst_s_bit16_inst_n4,
         SBOX_ITK_sb1_inst_s_bit17_inst_n5, SBOX_ITK_sb1_inst_s_bit17_inst_n4,
         SBOX_ITK_sb1_inst_s_bit18_inst_n2, SBOX_ITK_sb2_inst_s_bit21_inst_n6,
         SBOX_ITK_sb2_inst_s_bit21_inst_n5, SBOX_ITK_sb2_inst_s_bit21_inst_n4,
         SBOX_ITK_sb2_inst_s_bit22_inst_n6, SBOX_ITK_sb2_inst_s_bit22_inst_n5,
         SBOX_ITK_sb2_inst_s_bit22_inst_n4, SBOX_ITK_sb2_inst_s_bit23_inst_n8,
         SBOX_ITK_sb2_inst_s_bit23_inst_n7, SBOX_ITK_sb2_inst_s_bit23_inst_n6,
         SBOX_ITK_sb2_inst_s_bit24_inst_n8, SBOX_ITK_sb2_inst_s_bit24_inst_n7,
         SBOX_ITK_sb2_inst_s_bit24_inst_n6, SBOX_ITK_sb2_inst_s_bit25_inst_n10,
         SBOX_ITK_sb2_inst_s_bit25_inst_n9, SBOX_ITK_sb2_inst_s_bit25_inst_n8,
         SBOX_ITK_sb2_inst_s_bit25_inst_n7, SBOX_ITK_sb2_inst_s_bit26_inst_n10,
         SBOX_ITK_sb2_inst_s_bit26_inst_n9, SBOX_ITK_sb2_inst_s_bit26_inst_n8,
         SBOX_ITK_sb2_inst_s_bit26_inst_n7, SBOX_ITK_sb2_inst_s_bit27_inst_n4,
         SBOX_ITK_sb2_inst_s_bit27_inst_n3, SBOX_ITK_sb2_inst_s_bit28_inst_n4,
         SBOX_ITK_sb2_inst_s_bit28_inst_n3, SBOX_ITK_sb3_inst_s_bit31_inst_n11,
         SBOX_ITK_sb3_inst_s_bit31_inst_n10, SBOX_ITK_sb3_inst_s_bit31_inst_n9,
         SBOX_ITK_sb3_inst_s_bit32_inst_n8, SBOX_ITK_sb3_inst_s_bit32_inst_n7,
         SBOX_ITK_sb3_inst_s_bit32_inst_n6, SBOX_ITK_sb3_inst_s_bit32_inst_n5,
         SBOX_ITK_sb3_inst_s_bit33_inst_n8, SBOX_ITK_sb3_inst_s_bit33_inst_n7,
         SBOX_ITK_sb3_inst_s_bit33_inst_n6, SBOX_ITK_sb3_inst_s_bit33_inst_n5,
         SBOX_ITK_sb3_inst_s_bit34_inst_n8, SBOX_ITK_sb3_inst_s_bit34_inst_n7,
         SBOX_ITK_sb3_inst_s_bit34_inst_n6, SBOX_ITK_sb3_inst_s_bit34_inst_n5,
         SBOX_ITK_sb3_inst_s_bit35_inst_n10, SBOX_ITK_sb3_inst_s_bit35_inst_n9,
         SBOX_ITK_sb3_inst_s_bit35_inst_n8, SBOX_ITK_sb3_inst_s_bit35_inst_n7,
         SBOX_ITK_sb3_inst_s_bit36_inst_n8, SBOX_ITK_sb3_inst_s_bit36_inst_n7,
         SBOX_ITK_sb3_inst_s_bit36_inst_n6, SBOX_ITK_sb3_inst_s_bit37_inst_n5,
         SBOX_ITK_sb3_inst_s_bit37_inst_n4, SBOX_ITK_sb3_inst_s_bit38_inst_n5,
         SBOX_ITK_sb3_inst_s_bit38_inst_n4, SBOX_ITK_sb4_inst_s_bit41_inst_n8,
         SBOX_ITK_sb4_inst_s_bit41_inst_n7, SBOX_ITK_sb4_inst_s_bit41_inst_n6,
         SBOX_ITK_sb4_inst_s_bit41_inst_n5, SBOX_ITK_sb4_inst_s_bit42_inst_n17,
         SBOX_ITK_sb4_inst_s_bit42_inst_n16,
         SBOX_ITK_sb4_inst_s_bit42_inst_n15,
         SBOX_ITK_sb4_inst_s_bit42_inst_n14,
         SBOX_ITK_sb4_inst_s_bit42_inst_n13,
         SBOX_ITK_sb4_inst_s_bit42_inst_n12,
         SBOX_ITK_sb4_inst_s_bit42_inst_n11,
         SBOX_ITK_sb4_inst_s_bit43_inst_n11,
         SBOX_ITK_sb4_inst_s_bit43_inst_n10, SBOX_ITK_sb4_inst_s_bit43_inst_n9,
         SBOX_ITK_sb4_inst_s_bit43_inst_n8, SBOX_ITK_sb4_inst_s_bit43_inst_n7,
         SBOX_ITK_sb4_inst_s_bit44_inst_n11,
         SBOX_ITK_sb4_inst_s_bit44_inst_n10, SBOX_ITK_sb4_inst_s_bit44_inst_n9,
         SBOX_ITK_sb4_inst_s_bit44_inst_n8, SBOX_ITK_sb4_inst_s_bit44_inst_n7,
         SBOX_ITK_sb4_inst_s_bit45_inst_n16,
         SBOX_ITK_sb4_inst_s_bit45_inst_n15,
         SBOX_ITK_sb4_inst_s_bit45_inst_n14,
         SBOX_ITK_sb4_inst_s_bit45_inst_n13,
         SBOX_ITK_sb4_inst_s_bit45_inst_n12,
         SBOX_ITK_sb4_inst_s_bit45_inst_n11, SBOX_ITK_sb4_inst_s_bit46_inst_n8,
         SBOX_ITK_sb4_inst_s_bit46_inst_n7, SBOX_ITK_sb4_inst_s_bit46_inst_n6,
         SBOX_ITK_sb4_inst_s_bit46_inst_n5, SBOX_ITK_sb4_inst_s_bit47_inst_n11,
         SBOX_ITK_sb4_inst_s_bit47_inst_n10, SBOX_ITK_sb4_inst_s_bit47_inst_n9,
         SBOX_ITK_sb4_inst_s_bit47_inst_n8, SBOX_ITK_sb4_inst_s_bit47_inst_n7,
         SBOX_ITK_sb4_inst_s_bit48_inst_n8, SBOX_ITK_sb4_inst_s_bit48_inst_n7,
         SBOX_ITK_sb4_inst_s_bit48_inst_n6, SBOX_ITK_sb4_inst_s_bit48_inst_n5,
         comp_b1_s1_n4, comp_b1_s1_n3, comp_b1_s2_n4, comp_b1_s2_n3,
         comp_b2_s1_n4, comp_b2_s1_n3, comp_b2_s2_n4, comp_b2_s2_n3,
         comp_b3_s1_n4, comp_b3_s1_n3, comp_b3_s2_n4, comp_b3_s2_n3,
         comp_b4_s1_n4, comp_b4_s1_n3, comp_b4_s2_n4, comp_b4_s2_n3,
         outaff_sh1_n2, outaff_sh2_n2;
  wire   [3:0] comp_sh1;

  XNOR2_X1 SBOX_ITK_sb1_inst_s_bit11_inst_U7 ( .A(
        SBOX_ITK_sb1_inst_s_bit11_inst_n15), .B(
        SBOX_ITK_sb1_inst_s_bit11_inst_n14), .ZN(out_b1_reg_next1) );
  XOR2_X1 SBOX_ITK_sb1_inst_s_bit11_inst_U6 ( .A(in_1[2]), .B(in_1[3]), .Z(
        SBOX_ITK_sb1_inst_s_bit11_inst_n14) );
  NOR2_X1 SBOX_ITK_sb1_inst_s_bit11_inst_U5 ( .A1(
        SBOX_ITK_sb1_inst_s_bit11_inst_n13), .A2(
        SBOX_ITK_sb1_inst_s_bit11_inst_n12), .ZN(
        SBOX_ITK_sb1_inst_s_bit11_inst_n15) );
  NOR2_X1 SBOX_ITK_sb1_inst_s_bit11_inst_U4 ( .A1(in_1[2]), .A2(in_1[0]), .ZN(
        SBOX_ITK_sb1_inst_s_bit11_inst_n12) );
  XOR2_X1 SBOX_ITK_sb1_inst_s_bit11_inst_U3 ( .A(in_1[1]), .B(
        SBOX_ITK_sb1_inst_s_bit11_inst_n11), .Z(
        SBOX_ITK_sb1_inst_s_bit11_inst_n13) );
  NAND2_X1 SBOX_ITK_sb1_inst_s_bit11_inst_U2 ( .A1(in_1[3]), .A2(
        SBOX_ITK_sb1_inst_s_bit11_inst_n10), .ZN(
        SBOX_ITK_sb1_inst_s_bit11_inst_n11) );
  NAND2_X1 SBOX_ITK_sb1_inst_s_bit11_inst_U1 ( .A1(in_1[2]), .A2(in_1[0]), 
        .ZN(SBOX_ITK_sb1_inst_s_bit11_inst_n10) );
  NAND2_X1 SBOX_ITK_sb1_inst_s_bit12_inst_U6 ( .A1(
        SBOX_ITK_sb1_inst_s_bit12_inst_n11), .A2(
        SBOX_ITK_sb1_inst_s_bit12_inst_n10), .ZN(sbox_out2_b1) );
  NAND2_X1 SBOX_ITK_sb1_inst_s_bit12_inst_U5 ( .A1(
        SBOX_ITK_sb1_inst_s_bit12_inst_n9), .A2(in_2[0]), .ZN(
        SBOX_ITK_sb1_inst_s_bit12_inst_n10) );
  XOR2_X1 SBOX_ITK_sb1_inst_s_bit12_inst_U4 ( .A(in_2[1]), .B(in_1[3]), .Z(
        SBOX_ITK_sb1_inst_s_bit12_inst_n9) );
  NAND2_X1 SBOX_ITK_sb1_inst_s_bit12_inst_U3 ( .A1(
        SBOX_ITK_sb1_inst_s_bit12_inst_n8), .A2(in_1[2]), .ZN(
        SBOX_ITK_sb1_inst_s_bit12_inst_n11) );
  NOR2_X1 SBOX_ITK_sb1_inst_s_bit12_inst_U2 ( .A1(in_2[0]), .A2(
        SBOX_ITK_sb1_inst_s_bit12_inst_n7), .ZN(
        SBOX_ITK_sb1_inst_s_bit12_inst_n8) );
  INV_X1 SBOX_ITK_sb1_inst_s_bit12_inst_U1 ( .A(in_2[1]), .ZN(
        SBOX_ITK_sb1_inst_s_bit12_inst_n7) );
  NOR2_X1 SBOX_ITK_sb1_inst_s_bit13_inst_U5 ( .A1(
        SBOX_ITK_sb1_inst_s_bit13_inst_n6), .A2(
        SBOX_ITK_sb1_inst_s_bit13_inst_n9), .ZN(sbox_out3_b1) );
  XNOR2_X1 SBOX_ITK_sb1_inst_s_bit13_inst_U4 ( .A(in_1[1]), .B(
        SBOX_ITK_sb1_inst_s_bit13_inst_n8), .ZN(
        SBOX_ITK_sb1_inst_s_bit13_inst_n9) );
  NOR2_X1 SBOX_ITK_sb1_inst_s_bit13_inst_U3 ( .A1(in_1[3]), .A2(
        SBOX_ITK_sb1_inst_s_bit13_inst_n7), .ZN(
        SBOX_ITK_sb1_inst_s_bit13_inst_n8) );
  INV_X1 SBOX_ITK_sb1_inst_s_bit13_inst_U2 ( .A(in_2[2]), .ZN(
        SBOX_ITK_sb1_inst_s_bit13_inst_n7) );
  NOR2_X1 SBOX_ITK_sb1_inst_s_bit13_inst_U1 ( .A1(in_2[2]), .A2(in_2[0]), .ZN(
        SBOX_ITK_sb1_inst_s_bit13_inst_n6) );
  AND2_X1 SBOX_ITK_sb1_inst_s_bit14_inst_U2 ( .A1(in_2[1]), .A2(
        SBOX_ITK_sb1_inst_s_bit14_inst_n2), .ZN(sbox_out4_b1) );
  OR2_X1 SBOX_ITK_sb1_inst_s_bit14_inst_U1 ( .A1(in_2[2]), .A2(in_1[0]), .ZN(
        SBOX_ITK_sb1_inst_s_bit14_inst_n2) );
  NOR2_X1 SBOX_ITK_sb1_inst_s_bit15_inst_U4 ( .A1(
        SBOX_ITK_sb1_inst_s_bit15_inst_n6), .A2(
        SBOX_ITK_sb1_inst_s_bit15_inst_n5), .ZN(sbox_out5_b1) );
  XOR2_X1 SBOX_ITK_sb1_inst_s_bit15_inst_U3 ( .A(in_2[0]), .B(in_1[2]), .Z(
        SBOX_ITK_sb1_inst_s_bit15_inst_n5) );
  XOR2_X1 SBOX_ITK_sb1_inst_s_bit15_inst_U2 ( .A(in_2[3]), .B(
        SBOX_ITK_sb1_inst_s_bit15_inst_n4), .Z(
        SBOX_ITK_sb1_inst_s_bit15_inst_n6) );
  NAND2_X1 SBOX_ITK_sb1_inst_s_bit15_inst_U1 ( .A1(in_2[0]), .A2(in_1[1]), 
        .ZN(SBOX_ITK_sb1_inst_s_bit15_inst_n4) );
  AND2_X1 SBOX_ITK_sb1_inst_s_bit16_inst_U3 ( .A1(
        SBOX_ITK_sb1_inst_s_bit16_inst_n5), .A2(in_1[0]), .ZN(sbox_out6_b1) );
  XNOR2_X1 SBOX_ITK_sb1_inst_s_bit16_inst_U2 ( .A(in_2[3]), .B(
        SBOX_ITK_sb1_inst_s_bit16_inst_n4), .ZN(
        SBOX_ITK_sb1_inst_s_bit16_inst_n5) );
  NAND2_X1 SBOX_ITK_sb1_inst_s_bit16_inst_U1 ( .A1(in_2[1]), .A2(in_1[2]), 
        .ZN(SBOX_ITK_sb1_inst_s_bit16_inst_n4) );
  AND2_X1 SBOX_ITK_sb1_inst_s_bit17_inst_U3 ( .A1(
        SBOX_ITK_sb1_inst_s_bit17_inst_n5), .A2(in_2[2]), .ZN(sbox_out7_b1) );
  XNOR2_X1 SBOX_ITK_sb1_inst_s_bit17_inst_U2 ( .A(in_2[3]), .B(
        SBOX_ITK_sb1_inst_s_bit17_inst_n4), .ZN(
        SBOX_ITK_sb1_inst_s_bit17_inst_n5) );
  NAND2_X1 SBOX_ITK_sb1_inst_s_bit17_inst_U1 ( .A1(in_1[0]), .A2(in_1[1]), 
        .ZN(SBOX_ITK_sb1_inst_s_bit17_inst_n4) );
  AND2_X1 SBOX_ITK_sb1_inst_s_bit18_inst_U2 ( .A1(
        SBOX_ITK_sb1_inst_s_bit18_inst_n2), .A2(in_2[0]), .ZN(out_b1_reg_next8) );
  AND2_X1 SBOX_ITK_sb1_inst_s_bit18_inst_U1 ( .A1(in_2[1]), .A2(in_2[2]), .ZN(
        SBOX_ITK_sb1_inst_s_bit18_inst_n2) );
  OR2_X1 SBOX_ITK_sb2_inst_s_bit21_inst_U4 ( .A1(
        SBOX_ITK_sb2_inst_s_bit21_inst_n6), .A2(
        SBOX_ITK_sb2_inst_s_bit21_inst_n5), .ZN(out_b2_reg_next1) );
  NOR2_X1 SBOX_ITK_sb2_inst_s_bit21_inst_U3 ( .A1(in_1[2]), .A2(in_1[3]), .ZN(
        SBOX_ITK_sb2_inst_s_bit21_inst_n5) );
  NOR2_X1 SBOX_ITK_sb2_inst_s_bit21_inst_U2 ( .A1(in_1[1]), .A2(
        SBOX_ITK_sb2_inst_s_bit21_inst_n4), .ZN(
        SBOX_ITK_sb2_inst_s_bit21_inst_n6) );
  AND2_X1 SBOX_ITK_sb2_inst_s_bit21_inst_U1 ( .A1(in_1[2]), .A2(in_1[0]), .ZN(
        SBOX_ITK_sb2_inst_s_bit21_inst_n4) );
  NAND2_X1 SBOX_ITK_sb2_inst_s_bit22_inst_U4 ( .A1(
        SBOX_ITK_sb2_inst_s_bit22_inst_n6), .A2(
        SBOX_ITK_sb2_inst_s_bit22_inst_n5), .ZN(sbox_out2_b2) );
  NAND2_X1 SBOX_ITK_sb2_inst_s_bit22_inst_U3 ( .A1(in_2[1]), .A2(in_1[3]), 
        .ZN(SBOX_ITK_sb2_inst_s_bit22_inst_n5) );
  NAND2_X1 SBOX_ITK_sb2_inst_s_bit22_inst_U2 ( .A1(in_1[2]), .A2(
        SBOX_ITK_sb2_inst_s_bit22_inst_n4), .ZN(
        SBOX_ITK_sb2_inst_s_bit22_inst_n6) );
  OR2_X1 SBOX_ITK_sb2_inst_s_bit22_inst_U1 ( .A1(in_2[0]), .A2(in_2[1]), .ZN(
        SBOX_ITK_sb2_inst_s_bit22_inst_n4) );
  NOR2_X1 SBOX_ITK_sb2_inst_s_bit23_inst_U4 ( .A1(
        SBOX_ITK_sb2_inst_s_bit23_inst_n8), .A2(
        SBOX_ITK_sb2_inst_s_bit23_inst_n7), .ZN(sbox_out3_b2) );
  NOR2_X1 SBOX_ITK_sb2_inst_s_bit23_inst_U3 ( .A1(in_1[1]), .A2(in_2[0]), .ZN(
        SBOX_ITK_sb2_inst_s_bit23_inst_n7) );
  NAND2_X1 SBOX_ITK_sb2_inst_s_bit23_inst_U2 ( .A1(
        SBOX_ITK_sb2_inst_s_bit23_inst_n6), .A2(in_2[2]), .ZN(
        SBOX_ITK_sb2_inst_s_bit23_inst_n8) );
  NAND2_X1 SBOX_ITK_sb2_inst_s_bit23_inst_U1 ( .A1(in_1[3]), .A2(in_1[1]), 
        .ZN(SBOX_ITK_sb2_inst_s_bit23_inst_n6) );
  NOR2_X1 SBOX_ITK_sb2_inst_s_bit24_inst_U4 ( .A1(
        SBOX_ITK_sb2_inst_s_bit24_inst_n8), .A2(
        SBOX_ITK_sb2_inst_s_bit24_inst_n7), .ZN(sbox_out4_b2) );
  NOR2_X1 SBOX_ITK_sb2_inst_s_bit24_inst_U3 ( .A1(in_2[1]), .A2(in_1[0]), .ZN(
        SBOX_ITK_sb2_inst_s_bit24_inst_n7) );
  NAND2_X1 SBOX_ITK_sb2_inst_s_bit24_inst_U2 ( .A1(
        SBOX_ITK_sb2_inst_s_bit24_inst_n6), .A2(in_2[2]), .ZN(
        SBOX_ITK_sb2_inst_s_bit24_inst_n8) );
  NAND2_X1 SBOX_ITK_sb2_inst_s_bit24_inst_U1 ( .A1(in_1[3]), .A2(in_2[1]), 
        .ZN(SBOX_ITK_sb2_inst_s_bit24_inst_n6) );
  NOR2_X1 SBOX_ITK_sb2_inst_s_bit25_inst_U5 ( .A1(
        SBOX_ITK_sb2_inst_s_bit25_inst_n10), .A2(
        SBOX_ITK_sb2_inst_s_bit25_inst_n9), .ZN(sbox_out5_b2) );
  NOR2_X1 SBOX_ITK_sb2_inst_s_bit25_inst_U4 ( .A1(in_1[2]), .A2(in_2[3]), .ZN(
        SBOX_ITK_sb2_inst_s_bit25_inst_n9) );
  NAND2_X1 SBOX_ITK_sb2_inst_s_bit25_inst_U3 ( .A1(
        SBOX_ITK_sb2_inst_s_bit25_inst_n8), .A2(in_1[1]), .ZN(
        SBOX_ITK_sb2_inst_s_bit25_inst_n10) );
  NAND2_X1 SBOX_ITK_sb2_inst_s_bit25_inst_U2 ( .A1(in_1[2]), .A2(
        SBOX_ITK_sb2_inst_s_bit25_inst_n7), .ZN(
        SBOX_ITK_sb2_inst_s_bit25_inst_n8) );
  INV_X1 SBOX_ITK_sb2_inst_s_bit25_inst_U1 ( .A(in_2[0]), .ZN(
        SBOX_ITK_sb2_inst_s_bit25_inst_n7) );
  NOR2_X1 SBOX_ITK_sb2_inst_s_bit26_inst_U5 ( .A1(
        SBOX_ITK_sb2_inst_s_bit26_inst_n10), .A2(
        SBOX_ITK_sb2_inst_s_bit26_inst_n9), .ZN(sbox_out6_b2) );
  NOR2_X1 SBOX_ITK_sb2_inst_s_bit26_inst_U4 ( .A1(in_1[2]), .A2(in_2[3]), .ZN(
        SBOX_ITK_sb2_inst_s_bit26_inst_n9) );
  NAND2_X1 SBOX_ITK_sb2_inst_s_bit26_inst_U3 ( .A1(
        SBOX_ITK_sb2_inst_s_bit26_inst_n8), .A2(in_2[1]), .ZN(
        SBOX_ITK_sb2_inst_s_bit26_inst_n10) );
  NAND2_X1 SBOX_ITK_sb2_inst_s_bit26_inst_U2 ( .A1(in_1[2]), .A2(
        SBOX_ITK_sb2_inst_s_bit26_inst_n7), .ZN(
        SBOX_ITK_sb2_inst_s_bit26_inst_n8) );
  INV_X1 SBOX_ITK_sb2_inst_s_bit26_inst_U1 ( .A(in_1[0]), .ZN(
        SBOX_ITK_sb2_inst_s_bit26_inst_n7) );
  NOR2_X1 SBOX_ITK_sb2_inst_s_bit27_inst_U3 ( .A1(
        SBOX_ITK_sb2_inst_s_bit27_inst_n4), .A2(
        SBOX_ITK_sb2_inst_s_bit27_inst_n3), .ZN(sbox_out7_b2) );
  NAND2_X1 SBOX_ITK_sb2_inst_s_bit27_inst_U2 ( .A1(in_2[2]), .A2(in_1[1]), 
        .ZN(SBOX_ITK_sb2_inst_s_bit27_inst_n3) );
  XNOR2_X1 SBOX_ITK_sb2_inst_s_bit27_inst_U1 ( .A(in_1[0]), .B(in_2[3]), .ZN(
        SBOX_ITK_sb2_inst_s_bit27_inst_n4) );
  NOR2_X1 SBOX_ITK_sb2_inst_s_bit28_inst_U3 ( .A1(
        SBOX_ITK_sb2_inst_s_bit28_inst_n4), .A2(
        SBOX_ITK_sb2_inst_s_bit28_inst_n3), .ZN(out_b2_reg_next8) );
  NAND2_X1 SBOX_ITK_sb2_inst_s_bit28_inst_U2 ( .A1(in_2[2]), .A2(in_2[1]), 
        .ZN(SBOX_ITK_sb2_inst_s_bit28_inst_n3) );
  XNOR2_X1 SBOX_ITK_sb2_inst_s_bit28_inst_U1 ( .A(in_2[0]), .B(in_2[3]), .ZN(
        SBOX_ITK_sb2_inst_s_bit28_inst_n4) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit31_inst_U4 ( .A1(
        SBOX_ITK_sb3_inst_s_bit31_inst_n11), .A2(
        SBOX_ITK_sb3_inst_s_bit31_inst_n10), .ZN(out_b3_reg_next1) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit31_inst_U3 ( .A1(in_1[3]), .A2(in_1[2]), 
        .ZN(SBOX_ITK_sb3_inst_s_bit31_inst_n10) );
  OR2_X1 SBOX_ITK_sb3_inst_s_bit31_inst_U2 ( .A1(in_1[1]), .A2(
        SBOX_ITK_sb3_inst_s_bit31_inst_n9), .ZN(
        SBOX_ITK_sb3_inst_s_bit31_inst_n11) );
  NOR2_X1 SBOX_ITK_sb3_inst_s_bit31_inst_U1 ( .A1(in_1[0]), .A2(in_1[3]), .ZN(
        SBOX_ITK_sb3_inst_s_bit31_inst_n9) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit32_inst_U5 ( .A1(
        SBOX_ITK_sb3_inst_s_bit32_inst_n8), .A2(
        SBOX_ITK_sb3_inst_s_bit32_inst_n7), .ZN(sbox_out2_b3) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit32_inst_U4 ( .A1(in_2[0]), .A2(
        SBOX_ITK_sb3_inst_s_bit32_inst_n6), .ZN(
        SBOX_ITK_sb3_inst_s_bit32_inst_n7) );
  NOR2_X1 SBOX_ITK_sb3_inst_s_bit32_inst_U3 ( .A1(in_1[3]), .A2(in_2[1]), .ZN(
        SBOX_ITK_sb3_inst_s_bit32_inst_n6) );
  OR2_X1 SBOX_ITK_sb3_inst_s_bit32_inst_U2 ( .A1(in_1[2]), .A2(
        SBOX_ITK_sb3_inst_s_bit32_inst_n5), .ZN(
        SBOX_ITK_sb3_inst_s_bit32_inst_n8) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit32_inst_U1 ( .A1(in_1[3]), .A2(in_2[1]), 
        .ZN(SBOX_ITK_sb3_inst_s_bit32_inst_n5) );
  NOR2_X1 SBOX_ITK_sb3_inst_s_bit33_inst_U5 ( .A1(
        SBOX_ITK_sb3_inst_s_bit33_inst_n8), .A2(
        SBOX_ITK_sb3_inst_s_bit33_inst_n7), .ZN(sbox_out3_b3) );
  NOR2_X1 SBOX_ITK_sb3_inst_s_bit33_inst_U4 ( .A1(in_1[3]), .A2(in_2[0]), .ZN(
        SBOX_ITK_sb3_inst_s_bit33_inst_n7) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit33_inst_U3 ( .A1(
        SBOX_ITK_sb3_inst_s_bit33_inst_n6), .A2(in_1[1]), .ZN(
        SBOX_ITK_sb3_inst_s_bit33_inst_n8) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit33_inst_U2 ( .A1(in_1[3]), .A2(
        SBOX_ITK_sb3_inst_s_bit33_inst_n5), .ZN(
        SBOX_ITK_sb3_inst_s_bit33_inst_n6) );
  INV_X1 SBOX_ITK_sb3_inst_s_bit33_inst_U1 ( .A(in_2[2]), .ZN(
        SBOX_ITK_sb3_inst_s_bit33_inst_n5) );
  NOR2_X1 SBOX_ITK_sb3_inst_s_bit34_inst_U5 ( .A1(
        SBOX_ITK_sb3_inst_s_bit34_inst_n8), .A2(
        SBOX_ITK_sb3_inst_s_bit34_inst_n7), .ZN(sbox_out4_b3) );
  NOR2_X1 SBOX_ITK_sb3_inst_s_bit34_inst_U4 ( .A1(in_1[3]), .A2(in_1[0]), .ZN(
        SBOX_ITK_sb3_inst_s_bit34_inst_n7) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit34_inst_U3 ( .A1(
        SBOX_ITK_sb3_inst_s_bit34_inst_n6), .A2(in_2[1]), .ZN(
        SBOX_ITK_sb3_inst_s_bit34_inst_n8) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit34_inst_U2 ( .A1(in_1[3]), .A2(
        SBOX_ITK_sb3_inst_s_bit34_inst_n5), .ZN(
        SBOX_ITK_sb3_inst_s_bit34_inst_n6) );
  INV_X1 SBOX_ITK_sb3_inst_s_bit34_inst_U1 ( .A(in_2[2]), .ZN(
        SBOX_ITK_sb3_inst_s_bit34_inst_n5) );
  NOR2_X1 SBOX_ITK_sb3_inst_s_bit35_inst_U5 ( .A1(
        SBOX_ITK_sb3_inst_s_bit35_inst_n10), .A2(
        SBOX_ITK_sb3_inst_s_bit35_inst_n9), .ZN(sbox_out5_b3) );
  NOR2_X1 SBOX_ITK_sb3_inst_s_bit35_inst_U4 ( .A1(
        SBOX_ITK_sb3_inst_s_bit35_inst_n8), .A2(in_1[2]), .ZN(
        SBOX_ITK_sb3_inst_s_bit35_inst_n9) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit35_inst_U3 ( .A1(
        SBOX_ITK_sb3_inst_s_bit35_inst_n7), .A2(in_2[3]), .ZN(
        SBOX_ITK_sb3_inst_s_bit35_inst_n10) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit35_inst_U2 ( .A1(in_2[0]), .A2(
        SBOX_ITK_sb3_inst_s_bit35_inst_n8), .ZN(
        SBOX_ITK_sb3_inst_s_bit35_inst_n7) );
  INV_X1 SBOX_ITK_sb3_inst_s_bit35_inst_U1 ( .A(in_1[1]), .ZN(
        SBOX_ITK_sb3_inst_s_bit35_inst_n8) );
  NOR2_X1 SBOX_ITK_sb3_inst_s_bit36_inst_U4 ( .A1(
        SBOX_ITK_sb3_inst_s_bit36_inst_n8), .A2(
        SBOX_ITK_sb3_inst_s_bit36_inst_n7), .ZN(sbox_out6_b3) );
  NOR2_X1 SBOX_ITK_sb3_inst_s_bit36_inst_U3 ( .A1(in_2[1]), .A2(in_1[0]), .ZN(
        SBOX_ITK_sb3_inst_s_bit36_inst_n7) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit36_inst_U2 ( .A1(
        SBOX_ITK_sb3_inst_s_bit36_inst_n6), .A2(in_2[3]), .ZN(
        SBOX_ITK_sb3_inst_s_bit36_inst_n8) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit36_inst_U1 ( .A1(in_1[2]), .A2(in_2[1]), 
        .ZN(SBOX_ITK_sb3_inst_s_bit36_inst_n6) );
  NOR2_X1 SBOX_ITK_sb3_inst_s_bit37_inst_U3 ( .A1(
        SBOX_ITK_sb3_inst_s_bit37_inst_n5), .A2(
        SBOX_ITK_sb3_inst_s_bit37_inst_n4), .ZN(sbox_out7_b3) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit37_inst_U2 ( .A1(in_1[1]), .A2(in_2[3]), 
        .ZN(SBOX_ITK_sb3_inst_s_bit37_inst_n4) );
  XNOR2_X1 SBOX_ITK_sb3_inst_s_bit37_inst_U1 ( .A(in_1[0]), .B(in_2[2]), .ZN(
        SBOX_ITK_sb3_inst_s_bit37_inst_n5) );
  NOR2_X1 SBOX_ITK_sb3_inst_s_bit38_inst_U3 ( .A1(
        SBOX_ITK_sb3_inst_s_bit38_inst_n5), .A2(
        SBOX_ITK_sb3_inst_s_bit38_inst_n4), .ZN(out_b3_reg_next8) );
  NAND2_X1 SBOX_ITK_sb3_inst_s_bit38_inst_U2 ( .A1(in_2[1]), .A2(in_2[3]), 
        .ZN(SBOX_ITK_sb3_inst_s_bit38_inst_n4) );
  XNOR2_X1 SBOX_ITK_sb3_inst_s_bit38_inst_U1 ( .A(in_2[0]), .B(in_2[2]), .ZN(
        SBOX_ITK_sb3_inst_s_bit38_inst_n5) );
  OR2_X1 SBOX_ITK_sb4_inst_s_bit41_inst_U5 ( .A1(
        SBOX_ITK_sb4_inst_s_bit41_inst_n8), .A2(
        SBOX_ITK_sb4_inst_s_bit41_inst_n7), .ZN(out_b4_reg_next1) );
  NOR2_X1 SBOX_ITK_sb4_inst_s_bit41_inst_U4 ( .A1(in_1[1]), .A2(in_1[3]), .ZN(
        SBOX_ITK_sb4_inst_s_bit41_inst_n7) );
  NOR2_X1 SBOX_ITK_sb4_inst_s_bit41_inst_U3 ( .A1(in_1[0]), .A2(
        SBOX_ITK_sb4_inst_s_bit41_inst_n6), .ZN(
        SBOX_ITK_sb4_inst_s_bit41_inst_n8) );
  NOR2_X1 SBOX_ITK_sb4_inst_s_bit41_inst_U2 ( .A1(in_1[2]), .A2(
        SBOX_ITK_sb4_inst_s_bit41_inst_n5), .ZN(
        SBOX_ITK_sb4_inst_s_bit41_inst_n6) );
  AND2_X1 SBOX_ITK_sb4_inst_s_bit41_inst_U1 ( .A1(in_1[1]), .A2(in_1[3]), .ZN(
        SBOX_ITK_sb4_inst_s_bit41_inst_n5) );
  NOR2_X1 SBOX_ITK_sb4_inst_s_bit42_inst_U8 ( .A1(
        SBOX_ITK_sb4_inst_s_bit42_inst_n17), .A2(
        SBOX_ITK_sb4_inst_s_bit42_inst_n16), .ZN(sbox_out2_b4) );
  NOR2_X1 SBOX_ITK_sb4_inst_s_bit42_inst_U7 ( .A1(in_1[2]), .A2(
        SBOX_ITK_sb4_inst_s_bit42_inst_n15), .ZN(
        SBOX_ITK_sb4_inst_s_bit42_inst_n16) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit42_inst_U6 ( .A1(
        SBOX_ITK_sb4_inst_s_bit42_inst_n14), .A2(
        SBOX_ITK_sb4_inst_s_bit42_inst_n13), .ZN(
        SBOX_ITK_sb4_inst_s_bit42_inst_n17) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit42_inst_U5 ( .A1(
        SBOX_ITK_sb4_inst_s_bit42_inst_n15), .A2(
        SBOX_ITK_sb4_inst_s_bit42_inst_n12), .ZN(
        SBOX_ITK_sb4_inst_s_bit42_inst_n13) );
  INV_X1 SBOX_ITK_sb4_inst_s_bit42_inst_U4 ( .A(in_2[1]), .ZN(
        SBOX_ITK_sb4_inst_s_bit42_inst_n12) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit42_inst_U3 ( .A1(in_2[0]), .A2(in_1[3]), 
        .ZN(SBOX_ITK_sb4_inst_s_bit42_inst_n15) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit42_inst_U2 ( .A1(
        SBOX_ITK_sb4_inst_s_bit42_inst_n11), .A2(in_1[2]), .ZN(
        SBOX_ITK_sb4_inst_s_bit42_inst_n14) );
  INV_X1 SBOX_ITK_sb4_inst_s_bit42_inst_U1 ( .A(in_2[0]), .ZN(
        SBOX_ITK_sb4_inst_s_bit42_inst_n11) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit43_inst_U6 ( .A1(
        SBOX_ITK_sb4_inst_s_bit43_inst_n11), .A2(
        SBOX_ITK_sb4_inst_s_bit43_inst_n10), .ZN(sbox_out3_b4) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit43_inst_U5 ( .A1(in_2[2]), .A2(
        SBOX_ITK_sb4_inst_s_bit43_inst_n9), .ZN(
        SBOX_ITK_sb4_inst_s_bit43_inst_n10) );
  NOR2_X1 SBOX_ITK_sb4_inst_s_bit43_inst_U4 ( .A1(in_2[0]), .A2(
        SBOX_ITK_sb4_inst_s_bit43_inst_n8), .ZN(
        SBOX_ITK_sb4_inst_s_bit43_inst_n9) );
  XNOR2_X1 SBOX_ITK_sb4_inst_s_bit43_inst_U3 ( .A(in_1[1]), .B(in_1[3]), .ZN(
        SBOX_ITK_sb4_inst_s_bit43_inst_n8) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit43_inst_U2 ( .A1(in_2[0]), .A2(
        SBOX_ITK_sb4_inst_s_bit43_inst_n7), .ZN(
        SBOX_ITK_sb4_inst_s_bit43_inst_n11) );
  AND2_X1 SBOX_ITK_sb4_inst_s_bit43_inst_U1 ( .A1(in_1[1]), .A2(in_1[3]), .ZN(
        SBOX_ITK_sb4_inst_s_bit43_inst_n7) );
  OR2_X1 SBOX_ITK_sb4_inst_s_bit44_inst_U6 ( .A1(
        SBOX_ITK_sb4_inst_s_bit44_inst_n11), .A2(
        SBOX_ITK_sb4_inst_s_bit44_inst_n10), .ZN(sbox_out4_b4) );
  NOR2_X1 SBOX_ITK_sb4_inst_s_bit44_inst_U5 ( .A1(in_1[0]), .A2(
        SBOX_ITK_sb4_inst_s_bit44_inst_n9), .ZN(
        SBOX_ITK_sb4_inst_s_bit44_inst_n10) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit44_inst_U4 ( .A1(in_2[2]), .A2(in_2[1]), 
        .ZN(SBOX_ITK_sb4_inst_s_bit44_inst_n9) );
  NOR2_X1 SBOX_ITK_sb4_inst_s_bit44_inst_U3 ( .A1(
        SBOX_ITK_sb4_inst_s_bit44_inst_n8), .A2(
        SBOX_ITK_sb4_inst_s_bit44_inst_n7), .ZN(
        SBOX_ITK_sb4_inst_s_bit44_inst_n11) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit44_inst_U2 ( .A1(in_1[3]), .A2(in_1[0]), 
        .ZN(SBOX_ITK_sb4_inst_s_bit44_inst_n7) );
  XNOR2_X1 SBOX_ITK_sb4_inst_s_bit44_inst_U1 ( .A(in_2[2]), .B(in_2[1]), .ZN(
        SBOX_ITK_sb4_inst_s_bit44_inst_n8) );
  AND2_X1 SBOX_ITK_sb4_inst_s_bit45_inst_U7 ( .A1(
        SBOX_ITK_sb4_inst_s_bit45_inst_n16), .A2(
        SBOX_ITK_sb4_inst_s_bit45_inst_n15), .ZN(sbox_out5_b4) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit45_inst_U6 ( .A1(
        SBOX_ITK_sb4_inst_s_bit45_inst_n14), .A2(in_1[2]), .ZN(
        SBOX_ITK_sb4_inst_s_bit45_inst_n15) );
  INV_X1 SBOX_ITK_sb4_inst_s_bit45_inst_U5 ( .A(in_2[0]), .ZN(
        SBOX_ITK_sb4_inst_s_bit45_inst_n14) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit45_inst_U4 ( .A1(
        SBOX_ITK_sb4_inst_s_bit45_inst_n13), .A2(
        SBOX_ITK_sb4_inst_s_bit45_inst_n12), .ZN(
        SBOX_ITK_sb4_inst_s_bit45_inst_n16) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit45_inst_U3 ( .A1(in_2[3]), .A2(
        SBOX_ITK_sb4_inst_s_bit45_inst_n11), .ZN(
        SBOX_ITK_sb4_inst_s_bit45_inst_n12) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit45_inst_U2 ( .A1(in_2[0]), .A2(in_1[1]), 
        .ZN(SBOX_ITK_sb4_inst_s_bit45_inst_n11) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit45_inst_U1 ( .A1(in_1[1]), .A2(in_1[2]), 
        .ZN(SBOX_ITK_sb4_inst_s_bit45_inst_n13) );
  AND2_X1 SBOX_ITK_sb4_inst_s_bit46_inst_U5 ( .A1(
        SBOX_ITK_sb4_inst_s_bit46_inst_n8), .A2(in_1[0]), .ZN(sbox_out6_b4) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit46_inst_U4 ( .A1(
        SBOX_ITK_sb4_inst_s_bit46_inst_n7), .A2(
        SBOX_ITK_sb4_inst_s_bit46_inst_n6), .ZN(
        SBOX_ITK_sb4_inst_s_bit46_inst_n8) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit46_inst_U3 ( .A1(in_2[1]), .A2(
        SBOX_ITK_sb4_inst_s_bit46_inst_n5), .ZN(
        SBOX_ITK_sb4_inst_s_bit46_inst_n6) );
  OR2_X1 SBOX_ITK_sb4_inst_s_bit46_inst_U2 ( .A1(in_1[2]), .A2(in_2[3]), .ZN(
        SBOX_ITK_sb4_inst_s_bit46_inst_n5) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit46_inst_U1 ( .A1(in_1[2]), .A2(in_2[3]), 
        .ZN(SBOX_ITK_sb4_inst_s_bit46_inst_n7) );
  OR2_X1 SBOX_ITK_sb4_inst_s_bit47_inst_U6 ( .A1(
        SBOX_ITK_sb4_inst_s_bit47_inst_n11), .A2(
        SBOX_ITK_sb4_inst_s_bit47_inst_n10), .ZN(sbox_out7_b4) );
  NOR2_X1 SBOX_ITK_sb4_inst_s_bit47_inst_U5 ( .A1(in_1[0]), .A2(
        SBOX_ITK_sb4_inst_s_bit47_inst_n9), .ZN(
        SBOX_ITK_sb4_inst_s_bit47_inst_n10) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit47_inst_U4 ( .A1(in_2[3]), .A2(in_2[2]), 
        .ZN(SBOX_ITK_sb4_inst_s_bit47_inst_n9) );
  NOR2_X1 SBOX_ITK_sb4_inst_s_bit47_inst_U3 ( .A1(
        SBOX_ITK_sb4_inst_s_bit47_inst_n8), .A2(
        SBOX_ITK_sb4_inst_s_bit47_inst_n7), .ZN(
        SBOX_ITK_sb4_inst_s_bit47_inst_n11) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit47_inst_U2 ( .A1(in_1[1]), .A2(in_1[0]), 
        .ZN(SBOX_ITK_sb4_inst_s_bit47_inst_n7) );
  XNOR2_X1 SBOX_ITK_sb4_inst_s_bit47_inst_U1 ( .A(in_2[3]), .B(in_2[2]), .ZN(
        SBOX_ITK_sb4_inst_s_bit47_inst_n8) );
  AND2_X1 SBOX_ITK_sb4_inst_s_bit48_inst_U5 ( .A1(
        SBOX_ITK_sb4_inst_s_bit48_inst_n8), .A2(in_2[0]), .ZN(out_b4_reg_next8) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit48_inst_U4 ( .A1(
        SBOX_ITK_sb4_inst_s_bit48_inst_n7), .A2(
        SBOX_ITK_sb4_inst_s_bit48_inst_n6), .ZN(
        SBOX_ITK_sb4_inst_s_bit48_inst_n8) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit48_inst_U3 ( .A1(in_2[1]), .A2(
        SBOX_ITK_sb4_inst_s_bit48_inst_n5), .ZN(
        SBOX_ITK_sb4_inst_s_bit48_inst_n6) );
  OR2_X1 SBOX_ITK_sb4_inst_s_bit48_inst_U2 ( .A1(in_2[2]), .A2(in_2[3]), .ZN(
        SBOX_ITK_sb4_inst_s_bit48_inst_n5) );
  NAND2_X1 SBOX_ITK_sb4_inst_s_bit48_inst_U1 ( .A1(in_2[2]), .A2(in_2[3]), 
        .ZN(SBOX_ITK_sb4_inst_s_bit48_inst_n7) );
  XOR2_X1 srmsk_U24 ( .A(i_r[11]), .B(sbox_out7_b4), .Z(out_b4_reg_next7) );
  XOR2_X1 srmsk_U23 ( .A(i_r[10]), .B(sbox_out6_b4), .Z(out_b4_reg_next6) );
  XOR2_X1 srmsk_U22 ( .A(i_r[9]), .B(sbox_out5_b4), .Z(out_b4_reg_next5) );
  XOR2_X1 srmsk_U21 ( .A(i_r[9]), .B(sbox_out4_b4), .Z(out_b4_reg_next4) );
  XOR2_X1 srmsk_U20 ( .A(i_r[10]), .B(sbox_out3_b4), .Z(out_b4_reg_next3) );
  XOR2_X1 srmsk_U19 ( .A(i_r[11]), .B(sbox_out2_b4), .Z(out_b4_reg_next2) );
  XOR2_X1 srmsk_U18 ( .A(i_r[8]), .B(sbox_out7_b3), .Z(out_b3_reg_next7) );
  XOR2_X1 srmsk_U17 ( .A(i_r[7]), .B(sbox_out6_b3), .Z(out_b3_reg_next6) );
  XOR2_X1 srmsk_U16 ( .A(i_r[6]), .B(sbox_out5_b3), .Z(out_b3_reg_next5) );
  XOR2_X1 srmsk_U15 ( .A(i_r[6]), .B(sbox_out4_b3), .Z(out_b3_reg_next4) );
  XOR2_X1 srmsk_U14 ( .A(i_r[7]), .B(sbox_out3_b3), .Z(out_b3_reg_next3) );
  XOR2_X1 srmsk_U13 ( .A(i_r[8]), .B(sbox_out2_b3), .Z(out_b3_reg_next2) );
  XOR2_X1 srmsk_U12 ( .A(i_r[5]), .B(sbox_out7_b2), .Z(out_b2_reg_next7) );
  XOR2_X1 srmsk_U11 ( .A(i_r[4]), .B(sbox_out6_b2), .Z(out_b2_reg_next6) );
  XOR2_X1 srmsk_U10 ( .A(i_r[3]), .B(sbox_out5_b2), .Z(out_b2_reg_next5) );
  XOR2_X1 srmsk_U9 ( .A(i_r[3]), .B(sbox_out4_b2), .Z(out_b2_reg_next4) );
  XOR2_X1 srmsk_U8 ( .A(i_r[4]), .B(sbox_out3_b2), .Z(out_b2_reg_next3) );
  XOR2_X1 srmsk_U7 ( .A(i_r[5]), .B(sbox_out2_b2), .Z(out_b2_reg_next2) );
  XOR2_X1 srmsk_U6 ( .A(i_r[2]), .B(sbox_out7_b1), .Z(out_b1_reg_next7) );
  XOR2_X1 srmsk_U5 ( .A(i_r[1]), .B(sbox_out6_b1), .Z(out_b1_reg_next6) );
  XOR2_X1 srmsk_U4 ( .A(i_r[0]), .B(sbox_out5_b1), .Z(out_b1_reg_next5) );
  XOR2_X1 srmsk_U3 ( .A(i_r[0]), .B(sbox_out4_b1), .Z(out_b1_reg_next4) );
  XOR2_X1 srmsk_U2 ( .A(i_r[2]), .B(sbox_out2_b1), .Z(out_b1_reg_next2) );
  XOR2_X1 srmsk_U1 ( .A(i_r[1]), .B(sbox_out3_b1), .Z(out_b1_reg_next3) );
  DFF_X1 out_reg_b1_s1_state_reg ( .D(out_b1_reg_next1), .CK(i_clk), .Q(
        out_b1_reg_out1), .QN() );
  DFF_X1 out_reg_b1_s2_state_reg ( .D(out_b1_reg_next2), .CK(i_clk), .Q(
        out_b1_reg_out2), .QN() );
  DFF_X1 out_reg_b1_s3_state_reg ( .D(out_b1_reg_next3), .CK(i_clk), .Q(
        out_b1_reg_out3), .QN() );
  DFF_X1 out_reg_b1_s4_state_reg ( .D(out_b1_reg_next4), .CK(i_clk), .Q(
        out_b1_reg_out4), .QN() );
  DFF_X1 out_reg_b1_s5_state_reg ( .D(out_b1_reg_next5), .CK(i_clk), .Q(
        out_b1_reg_out5), .QN() );
  DFF_X1 out_reg_b1_s6_state_reg ( .D(out_b1_reg_next6), .CK(i_clk), .Q(
        out_b1_reg_out6), .QN() );
  DFF_X1 out_reg_b1_s7_state_reg ( .D(out_b1_reg_next7), .CK(i_clk), .Q(
        out_b1_reg_out7), .QN() );
  DFF_X1 out_reg_b1_s8_state_reg ( .D(out_b1_reg_next8), .CK(i_clk), .Q(
        out_b1_reg_out8), .QN() );
  DFF_X1 out_reg_b2_s1_state_reg ( .D(out_b2_reg_next1), .CK(i_clk), .Q(
        out_b2_reg_out1), .QN() );
  DFF_X1 out_reg_b2_s2_state_reg ( .D(out_b2_reg_next2), .CK(i_clk), .Q(
        out_b2_reg_out2), .QN() );
  DFF_X1 out_reg_b2_s3_state_reg ( .D(out_b2_reg_next3), .CK(i_clk), .Q(
        out_b2_reg_out3), .QN() );
  DFF_X1 out_reg_b2_s4_state_reg ( .D(out_b2_reg_next4), .CK(i_clk), .Q(
        out_b2_reg_out4), .QN() );
  DFF_X1 out_reg_b2_s5_state_reg ( .D(out_b2_reg_next5), .CK(i_clk), .Q(
        out_b2_reg_out5), .QN() );
  DFF_X1 out_reg_b2_s6_state_reg ( .D(out_b2_reg_next6), .CK(i_clk), .Q(
        out_b2_reg_out6), .QN() );
  DFF_X1 out_reg_b2_s7_state_reg ( .D(out_b2_reg_next7), .CK(i_clk), .Q(
        out_b2_reg_out7), .QN() );
  DFF_X1 out_reg_b2_s8_state_reg ( .D(out_b2_reg_next8), .CK(i_clk), .Q(
        out_b2_reg_out8), .QN() );
  DFF_X1 out_reg_b3_s1_state_reg ( .D(out_b3_reg_next1), .CK(i_clk), .Q(
        out_b3_reg_out1), .QN() );
  DFF_X1 out_reg_b3_s2_state_reg ( .D(out_b3_reg_next2), .CK(i_clk), .Q(
        out_b3_reg_out2), .QN() );
  DFF_X1 out_reg_b3_s3_state_reg ( .D(out_b3_reg_next3), .CK(i_clk), .Q(
        out_b3_reg_out3), .QN() );
  DFF_X1 out_reg_b3_s4_state_reg ( .D(out_b3_reg_next4), .CK(i_clk), .Q(
        out_b3_reg_out4), .QN() );
  DFF_X1 out_reg_b3_s5_state_reg ( .D(out_b3_reg_next5), .CK(i_clk), .Q(
        out_b3_reg_out5), .QN() );
  DFF_X1 out_reg_b3_s6_state_reg ( .D(out_b3_reg_next6), .CK(i_clk), .Q(
        out_b3_reg_out6), .QN() );
  DFF_X1 out_reg_b3_s7_state_reg ( .D(out_b3_reg_next7), .CK(i_clk), .Q(
        out_b3_reg_out7), .QN() );
  DFF_X1 out_reg_b3_s8_state_reg ( .D(out_b3_reg_next8), .CK(i_clk), .Q(
        out_b3_reg_out8), .QN() );
  DFF_X1 out_reg_b4_s1_state_reg ( .D(out_b4_reg_next1), .CK(i_clk), .Q(
        out_b4_reg_out1), .QN() );
  DFF_X1 out_reg_b4_s2_state_reg ( .D(out_b4_reg_next2), .CK(i_clk), .Q(
        out_b4_reg_out2), .QN() );
  DFF_X1 out_reg_b4_s3_state_reg ( .D(out_b4_reg_next3), .CK(i_clk), .Q(
        out_b4_reg_out3), .QN() );
  DFF_X1 out_reg_b4_s4_state_reg ( .D(out_b4_reg_next4), .CK(i_clk), .Q(
        out_b4_reg_out4), .QN() );
  DFF_X1 out_reg_b4_s5_state_reg ( .D(out_b4_reg_next5), .CK(i_clk), .Q(
        out_b4_reg_out5), .QN() );
  DFF_X1 out_reg_b4_s6_state_reg ( .D(out_b4_reg_next6), .CK(i_clk), .Q(
        out_b4_reg_out6), .QN() );
  DFF_X1 out_reg_b4_s7_state_reg ( .D(out_b4_reg_next7), .CK(i_clk), .Q(
        out_b4_reg_out7), .QN() );
  DFF_X1 out_reg_b4_s8_state_reg ( .D(out_b4_reg_next8), .CK(i_clk), .Q(
        out_b4_reg_out8), .QN() );
  XNOR2_X1 comp_b1_s1_U3 ( .A(comp_b1_s1_n4), .B(comp_b1_s1_n3), .ZN(
        comp_sh1[0]) );
  XNOR2_X1 comp_b1_s1_U2 ( .A(out_b1_reg_out3), .B(out_b1_reg_out4), .ZN(
        comp_b1_s1_n3) );
  XOR2_X1 comp_b1_s1_U1 ( .A(out_b1_reg_out1), .B(out_b1_reg_out2), .Z(
        comp_b1_s1_n4) );
  XNOR2_X1 comp_b1_s2_U3 ( .A(comp_b1_s2_n4), .B(comp_b1_s2_n3), .ZN(
        comp_sh2_0_) );
  XNOR2_X1 comp_b1_s2_U2 ( .A(out_b1_reg_out7), .B(out_b1_reg_out8), .ZN(
        comp_b1_s2_n3) );
  XOR2_X1 comp_b1_s2_U1 ( .A(out_b1_reg_out5), .B(out_b1_reg_out6), .Z(
        comp_b1_s2_n4) );
  XNOR2_X1 comp_b2_s1_U3 ( .A(comp_b2_s1_n4), .B(comp_b2_s1_n3), .ZN(
        comp_sh1[1]) );
  XNOR2_X1 comp_b2_s1_U2 ( .A(out_b2_reg_out3), .B(out_b2_reg_out4), .ZN(
        comp_b2_s1_n3) );
  XOR2_X1 comp_b2_s1_U1 ( .A(out_b2_reg_out1), .B(out_b2_reg_out2), .Z(
        comp_b2_s1_n4) );
  XNOR2_X1 comp_b2_s2_U3 ( .A(comp_b2_s2_n4), .B(comp_b2_s2_n3), .ZN(out_2[0])
         );
  XNOR2_X1 comp_b2_s2_U2 ( .A(out_b2_reg_out7), .B(out_b2_reg_out8), .ZN(
        comp_b2_s2_n3) );
  XOR2_X1 comp_b2_s2_U1 ( .A(out_b2_reg_out5), .B(out_b2_reg_out6), .Z(
        comp_b2_s2_n4) );
  XNOR2_X1 comp_b3_s1_U3 ( .A(comp_b3_s1_n4), .B(comp_b3_s1_n3), .ZN(out_1[3])
         );
  XNOR2_X1 comp_b3_s1_U2 ( .A(out_b3_reg_out3), .B(out_b3_reg_out4), .ZN(
        comp_b3_s1_n3) );
  XOR2_X1 comp_b3_s1_U1 ( .A(out_b3_reg_out1), .B(out_b3_reg_out2), .Z(
        comp_b3_s1_n4) );
  XNOR2_X1 comp_b3_s2_U3 ( .A(comp_b3_s2_n4), .B(comp_b3_s2_n3), .ZN(out_2[3])
         );
  XNOR2_X1 comp_b3_s2_U2 ( .A(out_b3_reg_out7), .B(out_b3_reg_out8), .ZN(
        comp_b3_s2_n3) );
  XOR2_X1 comp_b3_s2_U1 ( .A(out_b3_reg_out5), .B(out_b3_reg_out6), .Z(
        comp_b3_s2_n4) );
  XNOR2_X1 comp_b4_s1_U3 ( .A(comp_b4_s1_n4), .B(comp_b4_s1_n3), .ZN(
        comp_sh1[3]) );
  XNOR2_X1 comp_b4_s1_U2 ( .A(out_b4_reg_out3), .B(out_b4_reg_out4), .ZN(
        comp_b4_s1_n3) );
  XOR2_X1 comp_b4_s1_U1 ( .A(out_b4_reg_out1), .B(out_b4_reg_out2), .Z(
        comp_b4_s1_n4) );
  XNOR2_X1 comp_b4_s2_U3 ( .A(comp_b4_s2_n4), .B(comp_b4_s2_n3), .ZN(out_2[2])
         );
  XNOR2_X1 comp_b4_s2_U2 ( .A(out_b4_reg_out7), .B(out_b4_reg_out8), .ZN(
        comp_b4_s2_n3) );
  XOR2_X1 comp_b4_s2_U1 ( .A(out_b4_reg_out5), .B(out_b4_reg_out6), .Z(
        comp_b4_s2_n4) );
  INV_X1 outaff_sh1_U4 ( .A(comp_sh1[3]), .ZN(out_1[2]) );
  INV_X1 outaff_sh1_U3 ( .A(comp_sh1[1]), .ZN(out_1[0]) );
  XNOR2_X1 outaff_sh1_U2 ( .A(outaff_sh1_n2), .B(comp_sh1[0]), .ZN(out_1[1])
         );
  XNOR2_X1 outaff_sh1_U1 ( .A(comp_sh1[1]), .B(out_1[3]), .ZN(outaff_sh1_n2)
         );
  XNOR2_X1 outaff_sh2_U2 ( .A(outaff_sh2_n2), .B(comp_sh2_0_), .ZN(out_2[1])
         );
  XNOR2_X1 outaff_sh2_U1 ( .A(out_2[3]), .B(out_2[0]), .ZN(outaff_sh2_n2) );
endmodule

