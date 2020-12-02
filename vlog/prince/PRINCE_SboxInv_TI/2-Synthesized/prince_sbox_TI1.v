
module TISboxInv ( input_s1, input_s2, input_s3, clk, output_s1, output_s2, 
        output_s3 );
(* SILVER="[3:0]_0" *)  input [3:0] input_s1;
(* SILVER="[3:0]_1" *)  input [3:0] input_s2;
(* SILVER="[3:0]_2" *)  input [3:0] input_s3;
(* SILVER="[3:0]_0" *)  output [3:0] output_s1;
(* SILVER="[3:0]_1" *)  output [3:0] output_s2;
(* SILVER="[3:0]_2" *)  output [3:0] output_s3;
(* SILVER="clock" *)  input clk;
  wire   Q294N1in_s3_1_, Reg1in_s2_3_, Reg1in_s2_1_, Reg1in_s2_0_,
         Reg1in_s3_3_, Reg1in_s3_1_, Reg1in_s3_0_, M1Affin_s1_1_,
         Q_294N_1_inst_s1_n20, Q_294N_1_inst_s1_n19, Q_294N_1_inst_s1_n18,
         Q_294N_1_inst_s1_n17, Q_294N_1_inst_s1_n16, Q_294N_1_inst_s1_n15,
         Q_294N_1_inst_s1_n14, Q_294N_1_inst_s2_n20, Q_294N_1_inst_s2_n19,
         Q_294N_1_inst_s2_n18, Q_294N_1_inst_s2_n17, Q_294N_1_inst_s2_n16,
         Q_294N_1_inst_s2_n15, Q_294N_1_inst_s2_n14, Q_294N_1_inst_s3_n20,
         Q_294N_1_inst_s3_n19, Q_294N_1_inst_s3_n18, Q_294N_1_inst_s3_n17,
         Q_294N_1_inst_s3_n16, Q_294N_1_inst_s3_n15, Q_294N_1_inst_s3_n14,
         Q_294N_2_inst_s1_n20, Q_294N_2_inst_s1_n19, Q_294N_2_inst_s1_n18,
         Q_294N_2_inst_s1_n17, Q_294N_2_inst_s1_n16, Q_294N_2_inst_s1_n15,
         Q_294N_2_inst_s1_n14, Q_294N_2_inst_s2_n20, Q_294N_2_inst_s2_n19,
         Q_294N_2_inst_s2_n18, Q_294N_2_inst_s2_n17, Q_294N_2_inst_s2_n16,
         Q_294N_2_inst_s2_n15, Q_294N_2_inst_s2_n14, Q_294N_2_inst_s3_n20,
         Q_294N_2_inst_s3_n19, Q_294N_2_inst_s3_n18, Q_294N_2_inst_s3_n17,
         Q_294N_2_inst_s3_n16, Q_294N_2_inst_s3_n15, Q_294N_2_inst_s3_n14,
         Q_294N_3_inst_s1_n20, Q_294N_3_inst_s1_n19, Q_294N_3_inst_s1_n18,
         Q_294N_3_inst_s1_n17, Q_294N_3_inst_s1_n16, Q_294N_3_inst_s1_n15,
         Q_294N_3_inst_s1_n14, Q_294N_3_inst_s2_n20, Q_294N_3_inst_s2_n19,
         Q_294N_3_inst_s2_n18, Q_294N_3_inst_s2_n17, Q_294N_3_inst_s2_n16,
         Q_294N_3_inst_s2_n15, Q_294N_3_inst_s2_n14, Q_294N_3_inst_s3_n20,
         Q_294N_3_inst_s3_n19, Q_294N_3_inst_s3_n18, Q_294N_3_inst_s3_n17,
         Q_294N_3_inst_s3_n16, Q_294N_3_inst_s3_n15, Q_294N_3_inst_s3_n14;
  wire   [3:0] Reg1in_s1;
  wire   [1:0] Q294N2in_s1;
  wire   [1:0] Q294N2in_s2;
  wire   [1:0] Q294N2in_s3;
  wire   [3:1] M2Affin_s1;
  wire   [3:1] M2Affin_s2;
  wire   [3:1] M2Affin_s3;
  wire   [3:0] Reg2in_s1;
  wire   [3:0] Reg2in_s2;
  wire   [3:0] Reg2in_s3;
  wire   [1:0] Q294N3in_s1;
  wire   [1:0] Q294N3in_s2;
  wire   [1:0] Q294N3in_s3;
  wire   [3:0] OutAffin_s1;
  wire   [3:0] OutAffin_s2;
  wire   [3:0] OutAffin_s3;

  XOR2_X1 InAff_inst_s1_U1 ( .A(input_s1[0]), .B(input_s1[3]), .Z(Reg1in_s2_3_) );
  XOR2_X1 InAff_inst_s2_U1 ( .A(input_s2[0]), .B(input_s2[3]), .Z(Reg1in_s3_3_) );
  XNOR2_X1 InAff_inst_s3_U3 ( .A(input_s3[3]), .B(Q294N1in_s3_1_), .ZN(
        Reg1in_s1[3]) );
  INV_X1 InAff_inst_s3_U2 ( .A(input_s3[0]), .ZN(Q294N1in_s3_1_) );
  INV_X1 InAff_inst_s3_U1 ( .A(input_s3[2]), .ZN(Reg1in_s1[2]) );
  XNOR2_X1 Q_294N_1_inst_s1_U9 ( .A(Q294N1in_s3_1_), .B(Q_294N_1_inst_s1_n20), 
        .ZN(Reg1in_s1[1]) );
  XNOR2_X1 Q_294N_1_inst_s1_U8 ( .A(Q_294N_1_inst_s1_n19), .B(
        Q_294N_1_inst_s1_n18), .ZN(Q_294N_1_inst_s1_n20) );
  NOR2_X1 Q_294N_1_inst_s1_U7 ( .A1(input_s2[2]), .A2(Q_294N_1_inst_s1_n17), 
        .ZN(Q_294N_1_inst_s1_n18) );
  NOR2_X1 Q_294N_1_inst_s1_U6 ( .A1(Reg1in_s3_3_), .A2(Reg1in_s1[2]), .ZN(
        Q_294N_1_inst_s1_n19) );
  XNOR2_X1 Q_294N_1_inst_s1_U5 ( .A(input_s3[1]), .B(Q_294N_1_inst_s1_n16), 
        .ZN(Reg1in_s1[0]) );
  XNOR2_X1 Q_294N_1_inst_s1_U4 ( .A(Q_294N_1_inst_s1_n15), .B(
        Q_294N_1_inst_s1_n14), .ZN(Q_294N_1_inst_s1_n16) );
  NOR2_X1 Q_294N_1_inst_s1_U3 ( .A1(input_s2[0]), .A2(Q_294N_1_inst_s1_n17), 
        .ZN(Q_294N_1_inst_s1_n14) );
  XNOR2_X1 Q_294N_1_inst_s1_U2 ( .A(Reg1in_s1[3]), .B(Reg1in_s3_3_), .ZN(
        Q_294N_1_inst_s1_n17) );
  NOR2_X1 Q_294N_1_inst_s1_U1 ( .A1(Reg1in_s3_3_), .A2(Q294N1in_s3_1_), .ZN(
        Q_294N_1_inst_s1_n15) );
  XNOR2_X1 Q_294N_1_inst_s2_U9 ( .A(input_s1[0]), .B(Q_294N_1_inst_s2_n20), 
        .ZN(Reg1in_s2_1_) );
  XNOR2_X1 Q_294N_1_inst_s2_U8 ( .A(Q_294N_1_inst_s2_n19), .B(
        Q_294N_1_inst_s2_n18), .ZN(Q_294N_1_inst_s2_n20) );
  NOR2_X1 Q_294N_1_inst_s2_U7 ( .A1(Reg1in_s1[2]), .A2(Q_294N_1_inst_s2_n17), 
        .ZN(Q_294N_1_inst_s2_n18) );
  NOR2_X1 Q_294N_1_inst_s2_U6 ( .A1(Reg1in_s1[3]), .A2(input_s1[2]), .ZN(
        Q_294N_1_inst_s2_n19) );
  XNOR2_X1 Q_294N_1_inst_s2_U5 ( .A(input_s1[1]), .B(Q_294N_1_inst_s2_n16), 
        .ZN(Reg1in_s2_0_) );
  XNOR2_X1 Q_294N_1_inst_s2_U4 ( .A(Q_294N_1_inst_s2_n15), .B(
        Q_294N_1_inst_s2_n14), .ZN(Q_294N_1_inst_s2_n16) );
  NOR2_X1 Q_294N_1_inst_s2_U3 ( .A1(Q294N1in_s3_1_), .A2(Q_294N_1_inst_s2_n17), 
        .ZN(Q_294N_1_inst_s2_n14) );
  XNOR2_X1 Q_294N_1_inst_s2_U2 ( .A(Reg1in_s2_3_), .B(Reg1in_s1[3]), .ZN(
        Q_294N_1_inst_s2_n17) );
  NOR2_X1 Q_294N_1_inst_s2_U1 ( .A1(Reg1in_s1[3]), .A2(input_s1[0]), .ZN(
        Q_294N_1_inst_s2_n15) );
  XNOR2_X1 Q_294N_1_inst_s3_U9 ( .A(input_s2[0]), .B(Q_294N_1_inst_s3_n20), 
        .ZN(Reg1in_s3_1_) );
  XNOR2_X1 Q_294N_1_inst_s3_U8 ( .A(Q_294N_1_inst_s3_n19), .B(
        Q_294N_1_inst_s3_n18), .ZN(Q_294N_1_inst_s3_n20) );
  NOR2_X1 Q_294N_1_inst_s3_U7 ( .A1(input_s1[2]), .A2(Q_294N_1_inst_s3_n17), 
        .ZN(Q_294N_1_inst_s3_n18) );
  NOR2_X1 Q_294N_1_inst_s3_U6 ( .A1(Reg1in_s2_3_), .A2(input_s2[2]), .ZN(
        Q_294N_1_inst_s3_n19) );
  XNOR2_X1 Q_294N_1_inst_s3_U5 ( .A(input_s2[1]), .B(Q_294N_1_inst_s3_n16), 
        .ZN(Reg1in_s3_0_) );
  XNOR2_X1 Q_294N_1_inst_s3_U4 ( .A(Q_294N_1_inst_s3_n15), .B(
        Q_294N_1_inst_s3_n14), .ZN(Q_294N_1_inst_s3_n16) );
  NOR2_X1 Q_294N_1_inst_s3_U3 ( .A1(input_s1[0]), .A2(Q_294N_1_inst_s3_n17), 
        .ZN(Q_294N_1_inst_s3_n14) );
  XNOR2_X1 Q_294N_1_inst_s3_U2 ( .A(Reg1in_s3_3_), .B(Reg1in_s2_3_), .ZN(
        Q_294N_1_inst_s3_n17) );
  NOR2_X1 Q_294N_1_inst_s3_U1 ( .A1(Reg1in_s2_3_), .A2(input_s2[0]), .ZN(
        Q_294N_1_inst_s3_n15) );
  DFF_X1 reg1_s1_s_current_state_reg_0_ ( .D(Reg1in_s1[0]), .CK(clk), .Q(
        M2Affin_s2[3]), .QN() );
  DFF_X1 reg1_s1_s_current_state_reg_1_ ( .D(Reg1in_s1[1]), .CK(clk), .Q(
        M1Affin_s1_1_), .QN() );
  DFF_X1 reg1_s1_s_current_state_reg_2_ ( .D(Reg1in_s1[2]), .CK(clk), .Q(
        Q294N2in_s1[1]), .QN() );
  DFF_X1 reg1_s1_s_current_state_reg_3_ ( .D(Reg1in_s1[3]), .CK(clk), .Q(
        Q294N2in_s1[0]), .QN() );
  DFF_X1 reg1_s2_s_current_state_reg_0_ ( .D(Reg1in_s2_0_), .CK(clk), .Q(
        M2Affin_s3[3]), .QN() );
  DFF_X1 reg1_s2_s_current_state_reg_1_ ( .D(Reg1in_s2_1_), .CK(clk), .Q(
        Reg2in_s3[0]), .QN() );
  DFF_X1 reg1_s2_s_current_state_reg_2_ ( .D(input_s1[2]), .CK(clk), .Q(
        Q294N2in_s2[1]), .QN() );
  DFF_X1 reg1_s2_s_current_state_reg_3_ ( .D(Reg1in_s2_3_), .CK(clk), .Q(
        Q294N2in_s2[0]), .QN() );
  DFF_X1 reg1_s3_s_current_state_reg_0_ ( .D(Reg1in_s3_0_), .CK(clk), .Q(
        M2Affin_s1[3]), .QN() );
  DFF_X1 reg1_s3_s_current_state_reg_1_ ( .D(Reg1in_s3_1_), .CK(clk), .Q(
        Reg2in_s1[0]), .QN() );
  DFF_X1 reg1_s3_s_current_state_reg_2_ ( .D(input_s2[2]), .CK(clk), .Q(
        Q294N2in_s3[1]), .QN() );
  DFF_X1 reg1_s3_s_current_state_reg_3_ ( .D(Reg1in_s3_3_), .CK(clk), .Q(
        Q294N2in_s3[0]), .QN() );
  INV_X1 M1Aff_inst_s1_U1 ( .A(M1Affin_s1_1_), .ZN(Reg2in_s2[0]) );
  XNOR2_X1 Q_294N_2_inst_s1_U9 ( .A(Q294N2in_s3[1]), .B(Q_294N_2_inst_s1_n20), 
        .ZN(M2Affin_s1[1]) );
  XNOR2_X1 Q_294N_2_inst_s1_U8 ( .A(Q_294N_2_inst_s1_n19), .B(
        Q_294N_2_inst_s1_n18), .ZN(Q_294N_2_inst_s1_n20) );
  NOR2_X1 Q_294N_2_inst_s1_U7 ( .A1(Reg2in_s3[0]), .A2(Q_294N_2_inst_s1_n17), 
        .ZN(Q_294N_2_inst_s1_n18) );
  NOR2_X1 Q_294N_2_inst_s1_U6 ( .A1(M2Affin_s3[3]), .A2(Reg2in_s1[0]), .ZN(
        Q_294N_2_inst_s1_n19) );
  XNOR2_X1 Q_294N_2_inst_s1_U5 ( .A(Q294N2in_s3[0]), .B(Q_294N_2_inst_s1_n16), 
        .ZN(Reg2in_s1[2]) );
  XNOR2_X1 Q_294N_2_inst_s1_U4 ( .A(Q_294N_2_inst_s1_n15), .B(
        Q_294N_2_inst_s1_n14), .ZN(Q_294N_2_inst_s1_n16) );
  NOR2_X1 Q_294N_2_inst_s1_U3 ( .A1(Q294N2in_s2[1]), .A2(Q_294N_2_inst_s1_n17), 
        .ZN(Q_294N_2_inst_s1_n14) );
  XNOR2_X1 Q_294N_2_inst_s1_U2 ( .A(M2Affin_s1[3]), .B(M2Affin_s3[3]), .ZN(
        Q_294N_2_inst_s1_n17) );
  NOR2_X1 Q_294N_2_inst_s1_U1 ( .A1(M2Affin_s3[3]), .A2(Q294N2in_s3[1]), .ZN(
        Q_294N_2_inst_s1_n15) );
  XNOR2_X1 Q_294N_2_inst_s2_U9 ( .A(Q294N2in_s1[1]), .B(Q_294N_2_inst_s2_n20), 
        .ZN(M2Affin_s2[1]) );
  XNOR2_X1 Q_294N_2_inst_s2_U8 ( .A(Q_294N_2_inst_s2_n19), .B(
        Q_294N_2_inst_s2_n18), .ZN(Q_294N_2_inst_s2_n20) );
  NOR2_X1 Q_294N_2_inst_s2_U7 ( .A1(Reg2in_s1[0]), .A2(Q_294N_2_inst_s2_n17), 
        .ZN(Q_294N_2_inst_s2_n18) );
  NOR2_X1 Q_294N_2_inst_s2_U6 ( .A1(M2Affin_s1[3]), .A2(Reg2in_s2[0]), .ZN(
        Q_294N_2_inst_s2_n19) );
  XNOR2_X1 Q_294N_2_inst_s2_U5 ( .A(Q294N2in_s1[0]), .B(Q_294N_2_inst_s2_n16), 
        .ZN(Reg2in_s2[2]) );
  XNOR2_X1 Q_294N_2_inst_s2_U4 ( .A(Q_294N_2_inst_s2_n15), .B(
        Q_294N_2_inst_s2_n14), .ZN(Q_294N_2_inst_s2_n16) );
  NOR2_X1 Q_294N_2_inst_s2_U3 ( .A1(Q294N2in_s3[1]), .A2(Q_294N_2_inst_s2_n17), 
        .ZN(Q_294N_2_inst_s2_n14) );
  XNOR2_X1 Q_294N_2_inst_s2_U2 ( .A(M2Affin_s2[3]), .B(M2Affin_s1[3]), .ZN(
        Q_294N_2_inst_s2_n17) );
  NOR2_X1 Q_294N_2_inst_s2_U1 ( .A1(M2Affin_s1[3]), .A2(Q294N2in_s1[1]), .ZN(
        Q_294N_2_inst_s2_n15) );
  XNOR2_X1 Q_294N_2_inst_s3_U9 ( .A(Q294N2in_s2[1]), .B(Q_294N_2_inst_s3_n20), 
        .ZN(M2Affin_s3[1]) );
  XNOR2_X1 Q_294N_2_inst_s3_U8 ( .A(Q_294N_2_inst_s3_n19), .B(
        Q_294N_2_inst_s3_n18), .ZN(Q_294N_2_inst_s3_n20) );
  NOR2_X1 Q_294N_2_inst_s3_U7 ( .A1(Reg2in_s2[0]), .A2(Q_294N_2_inst_s3_n17), 
        .ZN(Q_294N_2_inst_s3_n18) );
  NOR2_X1 Q_294N_2_inst_s3_U6 ( .A1(M2Affin_s2[3]), .A2(Reg2in_s3[0]), .ZN(
        Q_294N_2_inst_s3_n19) );
  XNOR2_X1 Q_294N_2_inst_s3_U5 ( .A(Q294N2in_s2[0]), .B(Q_294N_2_inst_s3_n16), 
        .ZN(Reg2in_s3[2]) );
  XNOR2_X1 Q_294N_2_inst_s3_U4 ( .A(Q_294N_2_inst_s3_n15), .B(
        Q_294N_2_inst_s3_n14), .ZN(Q_294N_2_inst_s3_n16) );
  NOR2_X1 Q_294N_2_inst_s3_U3 ( .A1(Q294N2in_s1[1]), .A2(Q_294N_2_inst_s3_n17), 
        .ZN(Q_294N_2_inst_s3_n14) );
  XNOR2_X1 Q_294N_2_inst_s3_U2 ( .A(M2Affin_s3[3]), .B(M2Affin_s2[3]), .ZN(
        Q_294N_2_inst_s3_n17) );
  NOR2_X1 Q_294N_2_inst_s3_U1 ( .A1(M2Affin_s2[3]), .A2(Q294N2in_s2[1]), .ZN(
        Q_294N_2_inst_s3_n15) );
  XOR2_X1 M2Aff_inst_s1_U2 ( .A(Reg2in_s1[2]), .B(M2Affin_s1[1]), .Z(
        Reg2in_s1[3]) );
  XOR2_X1 M2Aff_inst_s1_U1 ( .A(Reg2in_s1[0]), .B(M2Affin_s1[3]), .Z(
        Reg2in_s1[1]) );
  XNOR2_X1 M2Aff_inst_s2_U2 ( .A(Reg2in_s2[2]), .B(M2Affin_s2[1]), .ZN(
        Reg2in_s2[3]) );
  XOR2_X1 M2Aff_inst_s2_U1 ( .A(Reg2in_s2[0]), .B(M2Affin_s2[3]), .Z(
        Reg2in_s2[1]) );
  XOR2_X1 M2Aff_inst_s3_U2 ( .A(Reg2in_s3[2]), .B(M2Affin_s3[1]), .Z(
        Reg2in_s3[3]) );
  XOR2_X1 M2Aff_inst_s3_U1 ( .A(Reg2in_s3[0]), .B(M2Affin_s3[3]), .Z(
        Reg2in_s3[1]) );
  DFF_X1 reg2_s1_s_current_state_reg_0_ ( .D(Reg2in_s1[0]), .CK(clk), .Q(
        Q294N3in_s1[0]), .QN() );
  DFF_X1 reg2_s1_s_current_state_reg_1_ ( .D(Reg2in_s1[1]), .CK(clk), .Q(
        Q294N3in_s1[1]), .QN() );
  DFF_X1 reg2_s1_s_current_state_reg_2_ ( .D(Reg2in_s1[2]), .CK(clk), .Q(
        OutAffin_s2[2]), .QN() );
  DFF_X1 reg2_s1_s_current_state_reg_3_ ( .D(Reg2in_s1[3]), .CK(clk), .Q(
        OutAffin_s2[3]), .QN() );
  DFF_X1 reg2_s2_s_current_state_reg_0_ ( .D(Reg2in_s2[0]), .CK(clk), .Q(
        Q294N3in_s2[0]), .QN() );
  DFF_X1 reg2_s2_s_current_state_reg_1_ ( .D(Reg2in_s2[1]), .CK(clk), .Q(
        Q294N3in_s2[1]), .QN() );
  DFF_X1 reg2_s2_s_current_state_reg_2_ ( .D(Reg2in_s2[2]), .CK(clk), .Q(
        OutAffin_s3[2]), .QN() );
  DFF_X1 reg2_s2_s_current_state_reg_3_ ( .D(Reg2in_s2[3]), .CK(clk), .Q(
        OutAffin_s3[3]), .QN() );
  DFF_X1 reg2_s3_s_current_state_reg_0_ ( .D(Reg2in_s3[0]), .CK(clk), .Q(
        Q294N3in_s3[0]), .QN() );
  DFF_X1 reg2_s3_s_current_state_reg_1_ ( .D(Reg2in_s3[1]), .CK(clk), .Q(
        Q294N3in_s3[1]), .QN() );
  DFF_X1 reg2_s3_s_current_state_reg_2_ ( .D(Reg2in_s3[2]), .CK(clk), .Q(
        OutAffin_s1[2]), .QN() );
  DFF_X1 reg2_s3_s_current_state_reg_3_ ( .D(Reg2in_s3[3]), .CK(clk), .Q(
        OutAffin_s1[3]), .QN() );
  XNOR2_X1 Q_294N_3_inst_s1_U9 ( .A(Q294N3in_s3[1]), .B(Q_294N_3_inst_s1_n20), 
        .ZN(output_s1[2]) );
  XNOR2_X1 Q_294N_3_inst_s1_U8 ( .A(Q_294N_3_inst_s1_n19), .B(
        Q_294N_3_inst_s1_n18), .ZN(Q_294N_3_inst_s1_n20) );
  NOR2_X1 Q_294N_3_inst_s1_U7 ( .A1(OutAffin_s3[2]), .A2(Q_294N_3_inst_s1_n17), 
        .ZN(Q_294N_3_inst_s1_n18) );
  NOR2_X1 Q_294N_3_inst_s1_U6 ( .A1(OutAffin_s3[3]), .A2(OutAffin_s1[2]), .ZN(
        Q_294N_3_inst_s1_n19) );
  XNOR2_X1 Q_294N_3_inst_s1_U5 ( .A(Q294N3in_s3[0]), .B(Q_294N_3_inst_s1_n16), 
        .ZN(OutAffin_s1[0]) );
  XNOR2_X1 Q_294N_3_inst_s1_U4 ( .A(Q_294N_3_inst_s1_n15), .B(
        Q_294N_3_inst_s1_n14), .ZN(Q_294N_3_inst_s1_n16) );
  NOR2_X1 Q_294N_3_inst_s1_U3 ( .A1(Q294N3in_s2[1]), .A2(Q_294N_3_inst_s1_n17), 
        .ZN(Q_294N_3_inst_s1_n14) );
  XNOR2_X1 Q_294N_3_inst_s1_U2 ( .A(OutAffin_s1[3]), .B(OutAffin_s3[3]), .ZN(
        Q_294N_3_inst_s1_n17) );
  NOR2_X1 Q_294N_3_inst_s1_U1 ( .A1(OutAffin_s3[3]), .A2(Q294N3in_s3[1]), .ZN(
        Q_294N_3_inst_s1_n15) );
  XNOR2_X1 Q_294N_3_inst_s2_U9 ( .A(Q294N3in_s1[1]), .B(Q_294N_3_inst_s2_n20), 
        .ZN(output_s2[2]) );
  XNOR2_X1 Q_294N_3_inst_s2_U8 ( .A(Q_294N_3_inst_s2_n19), .B(
        Q_294N_3_inst_s2_n18), .ZN(Q_294N_3_inst_s2_n20) );
  NOR2_X1 Q_294N_3_inst_s2_U7 ( .A1(OutAffin_s1[2]), .A2(Q_294N_3_inst_s2_n17), 
        .ZN(Q_294N_3_inst_s2_n18) );
  NOR2_X1 Q_294N_3_inst_s2_U6 ( .A1(OutAffin_s1[3]), .A2(OutAffin_s2[2]), .ZN(
        Q_294N_3_inst_s2_n19) );
  XNOR2_X1 Q_294N_3_inst_s2_U5 ( .A(Q294N3in_s1[0]), .B(Q_294N_3_inst_s2_n16), 
        .ZN(OutAffin_s2[0]) );
  XNOR2_X1 Q_294N_3_inst_s2_U4 ( .A(Q_294N_3_inst_s2_n15), .B(
        Q_294N_3_inst_s2_n14), .ZN(Q_294N_3_inst_s2_n16) );
  NOR2_X1 Q_294N_3_inst_s2_U3 ( .A1(Q294N3in_s3[1]), .A2(Q_294N_3_inst_s2_n17), 
        .ZN(Q_294N_3_inst_s2_n14) );
  XNOR2_X1 Q_294N_3_inst_s2_U2 ( .A(OutAffin_s2[3]), .B(OutAffin_s1[3]), .ZN(
        Q_294N_3_inst_s2_n17) );
  NOR2_X1 Q_294N_3_inst_s2_U1 ( .A1(OutAffin_s1[3]), .A2(Q294N3in_s1[1]), .ZN(
        Q_294N_3_inst_s2_n15) );
  XNOR2_X1 Q_294N_3_inst_s3_U9 ( .A(Q294N3in_s2[1]), .B(Q_294N_3_inst_s3_n20), 
        .ZN(output_s3[2]) );
  XNOR2_X1 Q_294N_3_inst_s3_U8 ( .A(Q_294N_3_inst_s3_n19), .B(
        Q_294N_3_inst_s3_n18), .ZN(Q_294N_3_inst_s3_n20) );
  NOR2_X1 Q_294N_3_inst_s3_U7 ( .A1(OutAffin_s2[2]), .A2(Q_294N_3_inst_s3_n17), 
        .ZN(Q_294N_3_inst_s3_n18) );
  NOR2_X1 Q_294N_3_inst_s3_U6 ( .A1(OutAffin_s2[3]), .A2(OutAffin_s3[2]), .ZN(
        Q_294N_3_inst_s3_n19) );
  XNOR2_X1 Q_294N_3_inst_s3_U5 ( .A(Q294N3in_s2[0]), .B(Q_294N_3_inst_s3_n16), 
        .ZN(OutAffin_s3[0]) );
  XNOR2_X1 Q_294N_3_inst_s3_U4 ( .A(Q_294N_3_inst_s3_n15), .B(
        Q_294N_3_inst_s3_n14), .ZN(Q_294N_3_inst_s3_n16) );
  NOR2_X1 Q_294N_3_inst_s3_U3 ( .A1(Q294N3in_s1[1]), .A2(Q_294N_3_inst_s3_n17), 
        .ZN(Q_294N_3_inst_s3_n14) );
  XNOR2_X1 Q_294N_3_inst_s3_U2 ( .A(OutAffin_s3[3]), .B(OutAffin_s2[3]), .ZN(
        Q_294N_3_inst_s3_n17) );
  NOR2_X1 Q_294N_3_inst_s3_U1 ( .A1(OutAffin_s2[3]), .A2(Q294N3in_s2[1]), .ZN(
        Q_294N_3_inst_s3_n15) );
  XOR2_X1 OutAff_inst_s1_U3 ( .A(OutAffin_s1[2]), .B(OutAffin_s1[3]), .Z(
        output_s1[3]) );
  XOR2_X1 OutAff_inst_s1_U2 ( .A(OutAffin_s1[0]), .B(OutAffin_s1[2]), .Z(
        output_s1[1]) );
  XOR2_X1 OutAff_inst_s1_U1 ( .A(OutAffin_s1[0]), .B(output_s1[2]), .Z(
        output_s1[0]) );
  XOR2_X1 OutAff_inst_s2_U3 ( .A(OutAffin_s2[2]), .B(OutAffin_s2[3]), .Z(
        output_s2[3]) );
  XNOR2_X1 OutAff_inst_s2_U2 ( .A(OutAffin_s2[0]), .B(OutAffin_s2[2]), .ZN(
        output_s2[1]) );
  XNOR2_X1 OutAff_inst_s2_U1 ( .A(OutAffin_s2[0]), .B(output_s2[2]), .ZN(
        output_s2[0]) );
  XOR2_X1 OutAff_inst_s3_U3 ( .A(OutAffin_s3[2]), .B(OutAffin_s3[3]), .Z(
        output_s3[3]) );
  XOR2_X1 OutAff_inst_s3_U2 ( .A(OutAffin_s3[0]), .B(OutAffin_s3[2]), .Z(
        output_s3[1]) );
  XOR2_X1 OutAff_inst_s3_U1 ( .A(OutAffin_s3[0]), .B(output_s3[2]), .Z(
        output_s3[0]) );
endmodule

