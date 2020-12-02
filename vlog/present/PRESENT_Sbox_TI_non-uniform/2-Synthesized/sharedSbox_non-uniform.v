
module sharedSbox ( clk, sboxIn1, sboxIn2, sboxIn3, share1, share2, share3 );
(* SILVER="[3:0]_0" *)  input [3:0] sboxIn1;
(* SILVER="[3:0]_1" *)  input [3:0] sboxIn2;
(* SILVER="[3:0]_2" *)  input [3:0] sboxIn3;
(* SILVER="[3:0]_0" *)  output [3:0] share1;
(* SILVER="[3:0]_1" *)  output [3:0] share2;
(* SILVER="[3:0]_2" *)  output [3:0] share3;
(* SILVER="clock" *)  input clk;
  wire   f1_n14, f1_n13, f1_n12, f1_n11, f1_n10, f1_n9, f1_n8, f1_n7, f1_n6,
         f1_n5, f1_n4, f1_n3, f1_n2, f1_n1, f2_n15, f2_n14, f2_n13, f2_n12,
         f2_n11, f2_n10, f2_n9, f2_n8, f2_n7, f2_n6, f2_n5, f2_n4, f2_n3,
         f2_n2, f2_n1, f3_n14, f3_n13, f3_n12, f3_n11, f3_n10, f3_n9, f3_n8,
         f3_n7, f3_n6, f3_n5, f3_n4, f3_n3, f3_n2, f3_n1, g1_n31, g1_n30,
         g1_n29, g1_n28, g1_n27, g1_n26, g1_n25, g1_n24, g1_n23, g1_n22,
         g1_n21, g1_n20, g1_n19, g1_n18, g1_n17, g1_n16, g1_n15, g1_n14,
         g2_n20, g2_n19, g2_n18, g2_n17, g2_n16, g2_n15, g2_n14, g2_n13,
         g2_n12, g2_n11, g2_n10, g2_n9, g2_n8, g2_n7, g2_n6, g2_n5, g2_n4,
         g2_n3, g2_n2, g2_n1, g3_n20, g3_n19, g3_n18, g3_n17, g3_n16, g3_n15,
         g3_n14, g3_n13, g3_n12, g3_n11, g3_n10, g3_n9, g3_n8, g3_n7, g3_n6,
         g3_n5, g3_n4, g3_n3, g3_n2, g3_n1;
  wire   [3:0] g1Out;
  wire   [3:0] g2Out;
  wire   [3:0] g3Out;
  wire   [3:0] g3Reg;
  wire   [3:0] g2Reg;
  wire   [3:0] g1Reg;

  XOR2_X1 f1_U18 ( .A(f1_n14), .B(f1_n13), .Z(share1[3]) );
  NOR2_X1 f1_U17 ( .A1(g3Reg[3]), .A2(f1_n12), .ZN(f1_n13) );
  XNOR2_X1 f1_U16 ( .A(g2Reg[3]), .B(f1_n11), .ZN(share1[2]) );
  XNOR2_X1 f1_U15 ( .A(f1_n10), .B(f1_n9), .ZN(f1_n11) );
  NAND2_X1 f1_U14 ( .A1(g3Reg[1]), .A2(g2Reg[0]), .ZN(f1_n9) );
  NAND2_X1 f1_U13 ( .A1(f1_n8), .A2(g2Reg[1]), .ZN(f1_n10) );
  XNOR2_X1 f1_U12 ( .A(f1_n7), .B(f1_n14), .ZN(share1[1]) );
  XNOR2_X1 f1_U11 ( .A(f1_n6), .B(f1_n5), .ZN(f1_n14) );
  NAND2_X1 f1_U10 ( .A1(g2Reg[3]), .A2(f1_n8), .ZN(f1_n5) );
  XOR2_X1 f1_U9 ( .A(g2Reg[0]), .B(g3Reg[0]), .Z(f1_n8) );
  XOR2_X1 f1_U8 ( .A(g2Reg[1]), .B(g2Reg[2]), .Z(f1_n6) );
  NAND2_X1 f1_U7 ( .A1(g3Reg[3]), .A2(g2Reg[0]), .ZN(f1_n7) );
  XNOR2_X1 f1_U6 ( .A(f1_n4), .B(f1_n3), .ZN(share1[0]) );
  NAND2_X1 f1_U5 ( .A1(g2Reg[2]), .A2(g3Reg[0]), .ZN(f1_n3) );
  XOR2_X1 f1_U4 ( .A(g2Reg[1]), .B(f1_n2), .Z(f1_n4) );
  NOR2_X1 f1_U3 ( .A1(f1_n1), .A2(f1_n12), .ZN(f1_n2) );
  INV_X1 f1_U2 ( .A(g2Reg[0]), .ZN(f1_n12) );
  XNOR2_X1 f1_U1 ( .A(g2Reg[2]), .B(g3Reg[2]), .ZN(f1_n1) );
  XNOR2_X1 f2_U19 ( .A(f2_n15), .B(f2_n14), .ZN(share2[2]) );
  NAND2_X1 f2_U18 ( .A1(g1Reg[0]), .A2(g3Reg[1]), .ZN(f2_n14) );
  XOR2_X1 f2_U17 ( .A(g3Reg[3]), .B(f2_n13), .Z(f2_n15) );
  NOR2_X1 f2_U16 ( .A1(f2_n12), .A2(f2_n11), .ZN(f2_n13) );
  XNOR2_X1 f2_U15 ( .A(g3Reg[1]), .B(g1Reg[1]), .ZN(f2_n12) );
  XOR2_X1 f2_U14 ( .A(f2_n10), .B(f2_n9), .Z(share2[1]) );
  NOR2_X1 f2_U13 ( .A1(f2_n11), .A2(f2_n8), .ZN(f2_n9) );
  XNOR2_X1 f2_U12 ( .A(f2_n7), .B(f2_n6), .ZN(share2[0]) );
  NAND2_X1 f2_U11 ( .A1(g3Reg[2]), .A2(g1Reg[0]), .ZN(f2_n6) );
  XOR2_X1 f2_U10 ( .A(g3Reg[1]), .B(f2_n5), .Z(f2_n7) );
  NOR2_X1 f2_U9 ( .A1(f2_n4), .A2(f2_n11), .ZN(f2_n5) );
  INV_X1 f2_U8 ( .A(g3Reg[0]), .ZN(f2_n11) );
  XNOR2_X1 f2_U7 ( .A(g3Reg[2]), .B(g1Reg[2]), .ZN(f2_n4) );
  XNOR2_X1 f2_U6 ( .A(f2_n3), .B(f2_n10), .ZN(share2[3]) );
  XNOR2_X1 f2_U5 ( .A(f2_n2), .B(f2_n1), .ZN(f2_n10) );
  NAND2_X1 f2_U4 ( .A1(g1Reg[0]), .A2(g3Reg[3]), .ZN(f2_n1) );
  XOR2_X1 f2_U3 ( .A(g3Reg[1]), .B(g3Reg[2]), .Z(f2_n2) );
  NAND2_X1 f2_U2 ( .A1(f2_n8), .A2(g3Reg[0]), .ZN(f2_n3) );
  XNOR2_X1 f2_U1 ( .A(g3Reg[3]), .B(g1Reg[3]), .ZN(f2_n8) );
  XOR2_X1 f3_U18 ( .A(f3_n14), .B(f3_n13), .Z(share3[3]) );
  NOR2_X1 f3_U17 ( .A1(g2Reg[3]), .A2(f3_n12), .ZN(f3_n13) );
  XNOR2_X1 f3_U16 ( .A(g1Reg[3]), .B(f3_n11), .ZN(share3[2]) );
  XNOR2_X1 f3_U15 ( .A(f3_n10), .B(f3_n9), .ZN(f3_n11) );
  NAND2_X1 f3_U14 ( .A1(g2Reg[1]), .A2(g1Reg[0]), .ZN(f3_n9) );
  NAND2_X1 f3_U13 ( .A1(f3_n8), .A2(g1Reg[1]), .ZN(f3_n10) );
  XNOR2_X1 f3_U12 ( .A(f3_n7), .B(f3_n14), .ZN(share3[1]) );
  XNOR2_X1 f3_U11 ( .A(f3_n6), .B(f3_n5), .ZN(f3_n14) );
  NAND2_X1 f3_U10 ( .A1(g1Reg[3]), .A2(f3_n8), .ZN(f3_n5) );
  XOR2_X1 f3_U9 ( .A(g1Reg[0]), .B(g2Reg[0]), .Z(f3_n8) );
  XOR2_X1 f3_U8 ( .A(g1Reg[1]), .B(g1Reg[2]), .Z(f3_n6) );
  NAND2_X1 f3_U7 ( .A1(g2Reg[3]), .A2(g1Reg[0]), .ZN(f3_n7) );
  XNOR2_X1 f3_U6 ( .A(f3_n4), .B(f3_n3), .ZN(share3[0]) );
  NAND2_X1 f3_U5 ( .A1(g1Reg[2]), .A2(g2Reg[0]), .ZN(f3_n3) );
  XOR2_X1 f3_U4 ( .A(g1Reg[1]), .B(f3_n2), .Z(f3_n4) );
  NOR2_X1 f3_U3 ( .A1(f3_n1), .A2(f3_n12), .ZN(f3_n2) );
  INV_X1 f3_U2 ( .A(g1Reg[0]), .ZN(f3_n12) );
  XNOR2_X1 f3_U1 ( .A(g1Reg[2]), .B(g2Reg[2]), .ZN(f3_n1) );
  XNOR2_X1 g1_U22 ( .A(sboxIn2[0]), .B(g1Out[2]), .ZN(g1Out[3]) );
  XNOR2_X1 g1_U21 ( .A(g1_n31), .B(g1_n30), .ZN(g1Out[1]) );
  XNOR2_X1 g1_U20 ( .A(g1_n29), .B(sboxIn3[3]), .ZN(g1_n30) );
  NAND2_X1 g1_U19 ( .A1(g1_n28), .A2(g1_n27), .ZN(g1_n29) );
  NAND2_X1 g1_U18 ( .A1(sboxIn2[2]), .A2(sboxIn3[0]), .ZN(g1_n27) );
  NAND2_X1 g1_U17 ( .A1(g1_n26), .A2(sboxIn2[1]), .ZN(g1_n28) );
  INV_X1 g1_U16 ( .A(sboxIn3[0]), .ZN(g1_n26) );
  NAND2_X1 g1_U15 ( .A1(g1_n25), .A2(sboxIn2[0]), .ZN(g1_n31) );
  XNOR2_X1 g1_U14 ( .A(g1_n24), .B(g1_n23), .ZN(g1Out[0]) );
  XNOR2_X1 g1_U13 ( .A(g1_n22), .B(g1_n21), .ZN(g1_n23) );
  NAND2_X1 g1_U12 ( .A1(sboxIn3[2]), .A2(sboxIn2[1]), .ZN(g1_n21) );
  XOR2_X1 g1_U11 ( .A(sboxIn2[0]), .B(g1_n20), .Z(g1_n22) );
  XOR2_X1 g1_U10 ( .A(g1_n19), .B(g1_n18), .Z(g1_n20) );
  NAND2_X1 g1_U9 ( .A1(sboxIn2[3]), .A2(g1_n25), .ZN(g1_n18) );
  XNOR2_X1 g1_U8 ( .A(g1Out[2]), .B(g1_n17), .ZN(g1_n25) );
  XOR2_X1 g1_U7 ( .A(sboxIn3[2]), .B(sboxIn3[1]), .Z(g1_n17) );
  NAND2_X1 g1_U6 ( .A1(sboxIn2[2]), .A2(sboxIn3[1]), .ZN(g1_n19) );
  NAND2_X1 g1_U5 ( .A1(g1_n16), .A2(g1_n15), .ZN(g1_n24) );
  NAND2_X1 g1_U4 ( .A1(sboxIn2[2]), .A2(sboxIn2[1]), .ZN(g1_n15) );
  NAND2_X1 g1_U3 ( .A1(g1_n14), .A2(sboxIn3[3]), .ZN(g1_n16) );
  OR2_X1 g1_U2 ( .A1(sboxIn2[2]), .A2(sboxIn2[1]), .ZN(g1_n14) );
  XNOR2_X1 g1_U1 ( .A(sboxIn2[2]), .B(sboxIn2[1]), .ZN(g1Out[2]) );
  XOR2_X1 g2_U24 ( .A(sboxIn3[0]), .B(g2Out[2]), .Z(g2Out[3]) );
  XNOR2_X1 g2_U23 ( .A(g2_n20), .B(g2_n19), .ZN(g2Out[1]) );
  NOR2_X1 g2_U22 ( .A1(g2_n18), .A2(g2_n17), .ZN(g2_n19) );
  NOR2_X1 g2_U21 ( .A1(g2_n16), .A2(sboxIn1[0]), .ZN(g2_n17) );
  AND2_X1 g2_U20 ( .A1(sboxIn1[0]), .A2(g2_n15), .ZN(g2_n18) );
  XNOR2_X1 g2_U19 ( .A(sboxIn1[3]), .B(sboxIn3[2]), .ZN(g2_n15) );
  NAND2_X1 g2_U18 ( .A1(g2_n14), .A2(sboxIn3[0]), .ZN(g2_n20) );
  XNOR2_X1 g2_U17 ( .A(g2_n13), .B(g2Out[2]), .ZN(g2_n14) );
  XNOR2_X1 g2_U16 ( .A(sboxIn1[1]), .B(sboxIn1[2]), .ZN(g2_n13) );
  XOR2_X1 g2_U15 ( .A(sboxIn3[1]), .B(sboxIn3[2]), .Z(g2Out[2]) );
  XNOR2_X1 g2_U14 ( .A(g2_n12), .B(g2_n11), .ZN(g2Out[0]) );
  NAND2_X1 g2_U13 ( .A1(g2_n10), .A2(sboxIn3[1]), .ZN(g2_n11) );
  XNOR2_X1 g2_U12 ( .A(sboxIn1[3]), .B(g2_n9), .ZN(g2_n10) );
  XNOR2_X1 g2_U11 ( .A(sboxIn3[3]), .B(sboxIn1[2]), .ZN(g2_n9) );
  XNOR2_X1 g2_U10 ( .A(g2_n8), .B(g2_n7), .ZN(g2_n12) );
  NAND2_X1 g2_U9 ( .A1(sboxIn3[2]), .A2(g2_n16), .ZN(g2_n7) );
  XOR2_X1 g2_U8 ( .A(sboxIn3[1]), .B(sboxIn1[3]), .Z(g2_n16) );
  XNOR2_X1 g2_U7 ( .A(g2_n6), .B(g2_n5), .ZN(g2_n8) );
  XOR2_X1 g2_U6 ( .A(sboxIn3[0]), .B(g2_n4), .Z(g2_n5) );
  NAND2_X1 g2_U5 ( .A1(g2_n3), .A2(g2_n2), .ZN(g2_n4) );
  NAND2_X1 g2_U4 ( .A1(sboxIn3[2]), .A2(sboxIn3[3]), .ZN(g2_n2) );
  NAND2_X1 g2_U3 ( .A1(sboxIn1[1]), .A2(g2_n1), .ZN(g2_n3) );
  OR2_X1 g2_U2 ( .A1(sboxIn3[2]), .A2(sboxIn3[3]), .ZN(g2_n1) );
  NAND2_X1 g2_U1 ( .A1(sboxIn3[3]), .A2(sboxIn1[2]), .ZN(g2_n6) );
  XOR2_X1 g3_U24 ( .A(g3Out[2]), .B(sboxIn1[0]), .Z(g3Out[3]) );
  XNOR2_X1 g3_U23 ( .A(g3_n20), .B(g3_n19), .ZN(g3Out[1]) );
  XOR2_X1 g3_U22 ( .A(g3_n18), .B(g3_n17), .Z(g3_n19) );
  NOR2_X1 g3_U21 ( .A1(sboxIn2[0]), .A2(g3_n16), .ZN(g3_n17) );
  XOR2_X1 g3_U20 ( .A(sboxIn2[3]), .B(g3_n15), .Z(g3_n18) );
  NOR2_X1 g3_U19 ( .A1(g3_n14), .A2(g3_n13), .ZN(g3_n15) );
  XOR2_X1 g3_U18 ( .A(g3_n12), .B(sboxIn2[2]), .Z(g3_n13) );
  NAND2_X1 g3_U17 ( .A1(sboxIn2[0]), .A2(sboxIn1[2]), .ZN(g3_n20) );
  XNOR2_X1 g3_U16 ( .A(g3_n11), .B(g3_n10), .ZN(g3Out[0]) );
  NAND2_X1 g3_U15 ( .A1(g3_n9), .A2(g3_n8), .ZN(g3_n10) );
  NAND2_X1 g3_U14 ( .A1(g3_n7), .A2(g3_n16), .ZN(g3_n8) );
  NAND2_X1 g3_U13 ( .A1(sboxIn2[3]), .A2(sboxIn1[2]), .ZN(g3_n7) );
  NAND2_X1 g3_U12 ( .A1(g3_n6), .A2(sboxIn1[1]), .ZN(g3_n9) );
  XOR2_X1 g3_U11 ( .A(g3_n5), .B(sboxIn2[2]), .Z(g3_n6) );
  NOR2_X1 g3_U10 ( .A1(sboxIn2[3]), .A2(sboxIn1[2]), .ZN(g3_n5) );
  XNOR2_X1 g3_U9 ( .A(g3_n4), .B(g3_n3), .ZN(g3_n11) );
  NAND2_X1 g3_U8 ( .A1(sboxIn2[1]), .A2(sboxIn1[2]), .ZN(g3_n3) );
  XOR2_X1 g3_U7 ( .A(g3_n2), .B(g3_n14), .Z(g3_n4) );
  INV_X1 g3_U6 ( .A(sboxIn1[0]), .ZN(g3_n14) );
  NAND2_X1 g3_U5 ( .A1(g3_n1), .A2(sboxIn1[3]), .ZN(g3_n2) );
  XNOR2_X1 g3_U4 ( .A(sboxIn2[2]), .B(g3_n12), .ZN(g3_n1) );
  XNOR2_X1 g3_U3 ( .A(g3Out[2]), .B(sboxIn2[1]), .ZN(g3_n12) );
  XNOR2_X1 g3_U2 ( .A(g3_n16), .B(sboxIn1[2]), .ZN(g3Out[2]) );
  INV_X1 g3_U1 ( .A(sboxIn1[1]), .ZN(g3_n16) );
  DFF_X1 y3_s_current_state_reg_0_ ( .D(g3Out[0]), .CK(clk), .Q(g3Reg[0]), 
        .QN() );
  DFF_X1 y3_s_current_state_reg_1_ ( .D(g3Out[1]), .CK(clk), .Q(g3Reg[1]), 
        .QN() );
  DFF_X1 y3_s_current_state_reg_2_ ( .D(g3Out[2]), .CK(clk), .Q(g3Reg[2]), 
        .QN() );
  DFF_X1 y3_s_current_state_reg_3_ ( .D(g3Out[3]), .CK(clk), .Q(g3Reg[3]), 
        .QN() );
  DFF_X1 y2_s_current_state_reg_0_ ( .D(g2Out[0]), .CK(clk), .Q(g2Reg[0]), 
        .QN() );
  DFF_X1 y2_s_current_state_reg_1_ ( .D(g2Out[1]), .CK(clk), .Q(g2Reg[1]), 
        .QN() );
  DFF_X1 y2_s_current_state_reg_2_ ( .D(g2Out[2]), .CK(clk), .Q(g2Reg[2]), 
        .QN() );
  DFF_X1 y2_s_current_state_reg_3_ ( .D(g2Out[3]), .CK(clk), .Q(g2Reg[3]), 
        .QN() );
  DFF_X1 y1_s_current_state_reg_0_ ( .D(g1Out[0]), .CK(clk), .Q(g1Reg[0]), 
        .QN() );
  DFF_X1 y1_s_current_state_reg_1_ ( .D(g1Out[1]), .CK(clk), .Q(g1Reg[1]), 
        .QN() );
  DFF_X1 y1_s_current_state_reg_2_ ( .D(g1Out[2]), .CK(clk), .Q(g1Reg[2]), 
        .QN() );
  DFF_X1 y1_s_current_state_reg_3_ ( .D(g1Out[3]), .CK(clk), .Q(g1Reg[3]), 
        .QN() );
endmodule

