
module TISbox ( input_s1, input_s2, input_s3, clk, output_s1, output_s2, 
        output_s3 );
(* SILVER="[7:0]_0" *)  input [7:0] input_s1;
(* SILVER="[7:0]_1" *)  input [7:0] input_s2;
(* SILVER="[7:0]_2" *)  input [7:0] input_s3;
(* SILVER="[7:0]_0" *)  output [7:0] output_s1;
(* SILVER="[7:0]_1" *)  output [7:0] output_s2;
(* SILVER="[7:0]_2" *)  output [7:0] output_s3;
(* SILVER="clock" *)      input clk;
  wire   Stage1_out1_3_, Stage1_out1_2_, Stage1_out2_3_, Stage1_out2_2_,
         Stage1_out3_3_, Stage1_out3_2_, Stage1_CF1_n18, Stage1_CF1_n17,
         Stage1_CF1_n16, Stage1_CF1_n15, Stage1_CF1_n14, Stage1_CF1_n13,
         Stage1_CF1_n12, Stage1_CF1_n11, Stage1_CF2_n18, Stage1_CF2_n17,
         Stage1_CF2_n16, Stage1_CF2_n15, Stage1_CF2_n14, Stage1_CF2_n13,
         Stage1_CF2_n12, Stage1_CF2_n11, Stage1_CF3_n18, Stage1_CF3_n17,
         Stage1_CF3_n16, Stage1_CF3_n15, Stage1_CF3_n14, Stage1_CF3_n13,
         Stage1_CF3_n12, Stage1_CF3_n11, Stage2_CF1_n18, Stage2_CF1_n17,
         Stage2_CF1_n16, Stage2_CF1_n15, Stage2_CF1_n14, Stage2_CF1_n13,
         Stage2_CF1_n12, Stage2_CF1_n11, Stage2_CF2_n18, Stage2_CF2_n17,
         Stage2_CF2_n16, Stage2_CF2_n15, Stage2_CF2_n14, Stage2_CF2_n13,
         Stage2_CF2_n12, Stage2_CF2_n11, Stage2_CF3_n18, Stage2_CF3_n17,
         Stage2_CF3_n16, Stage2_CF3_n15, Stage2_CF3_n14, Stage2_CF3_n13,
         Stage2_CF3_n12, Stage2_CF3_n11, Stage3_CF1_n18, Stage3_CF1_n17,
         Stage3_CF1_n16, Stage3_CF1_n15, Stage3_CF1_n14, Stage3_CF1_n13,
         Stage3_CF1_n12, Stage3_CF1_n11, Stage3_CF2_n18, Stage3_CF2_n17,
         Stage3_CF2_n16, Stage3_CF2_n15, Stage3_CF2_n14, Stage3_CF2_n13,
         Stage3_CF2_n12, Stage3_CF2_n11, Stage3_CF3_n18, Stage3_CF3_n17,
         Stage3_CF3_n16, Stage3_CF3_n15, Stage3_CF3_n14, Stage3_CF3_n13,
         Stage3_CF3_n12, Stage3_CF3_n11, Stage4_CF1_n18, Stage4_CF1_n17,
         Stage4_CF1_n16, Stage4_CF1_n15, Stage4_CF1_n14, Stage4_CF1_n13,
         Stage4_CF1_n12, Stage4_CF1_n11, Stage4_CF2_n18, Stage4_CF2_n17,
         Stage4_CF2_n16, Stage4_CF2_n15, Stage4_CF2_n14, Stage4_CF2_n13,
         Stage4_CF2_n12, Stage4_CF2_n11, Stage4_CF3_n18, Stage4_CF3_n17,
         Stage4_CF3_n16, Stage4_CF3_n15, Stage4_CF3_n14, Stage4_CF3_n13,
         Stage4_CF3_n12, Stage4_CF3_n11;
  wire   [4:0] Stage2_in1;
  wire   [4:0] Stage2_in2;
  wire   [4:0] Stage2_in3;
  wire   [7:0] Stage2_out1;
  wire   [7:0] Stage2_out2;
  wire   [7:0] Stage2_out3;
  wire   [4:0] Stage3_in1;
  wire   [4:0] Stage3_in2;
  wire   [4:0] Stage3_in3;
  wire   [7:0] Stage3_out1;
  wire   [7:0] Stage3_out2;
  wire   [7:0] Stage3_out3;
  wire   [4:0] Stage4_in1;
  wire   [4:0] Stage4_in2;
  wire   [4:0] Stage4_in3;

  XNOR2_X1 Stage1_CF1_U10 ( .A(Stage1_CF1_n18), .B(Stage1_CF1_n17), .ZN(
        Stage1_out1_3_) );
  XNOR2_X1 Stage1_CF1_U9 ( .A(Stage1_CF1_n16), .B(input_s3[4]), .ZN(
        Stage1_CF1_n17) );
  NOR2_X1 Stage1_CF1_U8 ( .A1(input_s3[7]), .A2(input_s2[6]), .ZN(
        Stage1_CF1_n16) );
  NOR2_X1 Stage1_CF1_U7 ( .A1(Stage1_CF1_n15), .A2(input_s2[7]), .ZN(
        Stage1_CF1_n18) );
  XNOR2_X1 Stage1_CF1_U6 ( .A(input_s2[6]), .B(input_s3[6]), .ZN(
        Stage1_CF1_n15) );
  XNOR2_X1 Stage1_CF1_U5 ( .A(Stage1_CF1_n14), .B(Stage1_CF1_n13), .ZN(
        Stage1_out1_2_) );
  XNOR2_X1 Stage1_CF1_U4 ( .A(Stage1_CF1_n12), .B(input_s3[0]), .ZN(
        Stage1_CF1_n13) );
  NOR2_X1 Stage1_CF1_U3 ( .A1(input_s3[3]), .A2(input_s2[2]), .ZN(
        Stage1_CF1_n12) );
  NOR2_X1 Stage1_CF1_U2 ( .A1(Stage1_CF1_n11), .A2(input_s2[3]), .ZN(
        Stage1_CF1_n14) );
  XNOR2_X1 Stage1_CF1_U1 ( .A(input_s2[2]), .B(input_s3[2]), .ZN(
        Stage1_CF1_n11) );
  XNOR2_X1 Stage1_CF2_U10 ( .A(Stage1_CF2_n18), .B(Stage1_CF2_n17), .ZN(
        Stage1_out2_3_) );
  XNOR2_X1 Stage1_CF2_U9 ( .A(Stage1_CF2_n16), .B(input_s1[4]), .ZN(
        Stage1_CF2_n17) );
  NOR2_X1 Stage1_CF2_U8 ( .A1(input_s1[7]), .A2(input_s3[6]), .ZN(
        Stage1_CF2_n16) );
  NOR2_X1 Stage1_CF2_U7 ( .A1(Stage1_CF2_n15), .A2(input_s3[7]), .ZN(
        Stage1_CF2_n18) );
  XNOR2_X1 Stage1_CF2_U6 ( .A(input_s3[6]), .B(input_s1[6]), .ZN(
        Stage1_CF2_n15) );
  XNOR2_X1 Stage1_CF2_U5 ( .A(Stage1_CF2_n14), .B(Stage1_CF2_n13), .ZN(
        Stage1_out2_2_) );
  XNOR2_X1 Stage1_CF2_U4 ( .A(Stage1_CF2_n12), .B(input_s1[0]), .ZN(
        Stage1_CF2_n13) );
  NOR2_X1 Stage1_CF2_U3 ( .A1(input_s1[3]), .A2(input_s3[2]), .ZN(
        Stage1_CF2_n12) );
  NOR2_X1 Stage1_CF2_U2 ( .A1(Stage1_CF2_n11), .A2(input_s3[3]), .ZN(
        Stage1_CF2_n14) );
  XNOR2_X1 Stage1_CF2_U1 ( .A(input_s3[2]), .B(input_s1[2]), .ZN(
        Stage1_CF2_n11) );
  XNOR2_X1 Stage1_CF3_U10 ( .A(Stage1_CF3_n18), .B(Stage1_CF3_n17), .ZN(
        Stage1_out3_3_) );
  XNOR2_X1 Stage1_CF3_U9 ( .A(Stage1_CF3_n16), .B(input_s2[4]), .ZN(
        Stage1_CF3_n17) );
  NOR2_X1 Stage1_CF3_U8 ( .A1(input_s2[7]), .A2(input_s1[6]), .ZN(
        Stage1_CF3_n16) );
  NOR2_X1 Stage1_CF3_U7 ( .A1(Stage1_CF3_n15), .A2(input_s1[7]), .ZN(
        Stage1_CF3_n18) );
  XNOR2_X1 Stage1_CF3_U6 ( .A(input_s1[6]), .B(input_s2[6]), .ZN(
        Stage1_CF3_n15) );
  XNOR2_X1 Stage1_CF3_U5 ( .A(Stage1_CF3_n14), .B(Stage1_CF3_n13), .ZN(
        Stage1_out3_2_) );
  XNOR2_X1 Stage1_CF3_U4 ( .A(Stage1_CF3_n12), .B(input_s2[0]), .ZN(
        Stage1_CF3_n13) );
  NOR2_X1 Stage1_CF3_U3 ( .A1(input_s2[3]), .A2(input_s1[2]), .ZN(
        Stage1_CF3_n12) );
  NOR2_X1 Stage1_CF3_U2 ( .A1(Stage1_CF3_n11), .A2(input_s1[3]), .ZN(
        Stage1_CF3_n14) );
  XNOR2_X1 Stage1_CF3_U1 ( .A(input_s1[2]), .B(input_s2[2]), .ZN(
        Stage1_CF3_n11) );
  DFF_X1 reg1_s1_s_current_state_reg_0_ ( .D(input_s3[5]), .CK(clk), .Q(
        Stage2_in1[0]), .QN() );
  DFF_X1 reg1_s1_s_current_state_reg_1_ ( .D(input_s3[3]), .CK(clk), .Q(
        Stage2_out2[6]), .QN() );
  DFF_X1 reg1_s1_s_current_state_reg_2_ ( .D(Stage1_out1_2_), .CK(clk), .Q(
        Stage2_out2[7]), .QN() );
  DFF_X1 reg1_s1_s_current_state_reg_3_ ( .D(Stage1_out1_3_), .CK(clk), .Q(
        Stage2_out2[1]), .QN() );
  DFF_X1 reg1_s1_s_current_state_reg_4_ ( .D(input_s3[6]), .CK(clk), .Q(
        Stage2_in1[4]), .QN() );
  DFF_X1 reg1_s1_s_current_state_reg_5_ ( .D(input_s3[7]), .CK(clk), .Q(
        Stage2_out2[0]), .QN() );
  DFF_X1 reg1_s1_s_current_state_reg_6_ ( .D(input_s3[1]), .CK(clk), .Q(
        Stage2_out2[4]), .QN() );
  DFF_X1 reg1_s1_s_current_state_reg_7_ ( .D(input_s3[2]), .CK(clk), .Q(
        Stage2_out2[5]), .QN() );
  DFF_X1 reg1_s2_s_current_state_reg_0_ ( .D(input_s1[5]), .CK(clk), .Q(
        Stage2_in2[0]), .QN() );
  DFF_X1 reg1_s2_s_current_state_reg_1_ ( .D(input_s1[3]), .CK(clk), .Q(
        Stage2_out3[6]), .QN() );
  DFF_X1 reg1_s2_s_current_state_reg_2_ ( .D(Stage1_out2_2_), .CK(clk), .Q(
        Stage2_out3[7]), .QN() );
  DFF_X1 reg1_s2_s_current_state_reg_3_ ( .D(Stage1_out2_3_), .CK(clk), .Q(
        Stage2_out3[1]), .QN() );
  DFF_X1 reg1_s2_s_current_state_reg_4_ ( .D(input_s1[6]), .CK(clk), .Q(
        Stage2_in2[4]), .QN() );
  DFF_X1 reg1_s2_s_current_state_reg_5_ ( .D(input_s1[7]), .CK(clk), .Q(
        Stage2_out3[0]), .QN() );
  DFF_X1 reg1_s2_s_current_state_reg_6_ ( .D(input_s1[1]), .CK(clk), .Q(
        Stage2_out3[4]), .QN() );
  DFF_X1 reg1_s2_s_current_state_reg_7_ ( .D(input_s1[2]), .CK(clk), .Q(
        Stage2_out3[5]), .QN() );
  DFF_X1 reg1_s3_s_current_state_reg_0_ ( .D(input_s2[5]), .CK(clk), .Q(
        Stage2_in3[0]), .QN() );
  DFF_X1 reg1_s3_s_current_state_reg_1_ ( .D(input_s2[3]), .CK(clk), .Q(
        Stage2_out1[6]), .QN() );
  DFF_X1 reg1_s3_s_current_state_reg_2_ ( .D(Stage1_out3_2_), .CK(clk), .Q(
        Stage2_out1[7]), .QN() );
  DFF_X1 reg1_s3_s_current_state_reg_3_ ( .D(Stage1_out3_3_), .CK(clk), .Q(
        Stage2_out1[1]), .QN() );
  DFF_X1 reg1_s3_s_current_state_reg_4_ ( .D(input_s2[6]), .CK(clk), .Q(
        Stage2_in3[4]), .QN() );
  DFF_X1 reg1_s3_s_current_state_reg_5_ ( .D(input_s2[7]), .CK(clk), .Q(
        Stage2_out1[0]), .QN() );
  DFF_X1 reg1_s3_s_current_state_reg_6_ ( .D(input_s2[1]), .CK(clk), .Q(
        Stage2_out1[4]), .QN() );
  DFF_X1 reg1_s3_s_current_state_reg_7_ ( .D(input_s2[2]), .CK(clk), .Q(
        Stage2_out1[5]), .QN() );
  XNOR2_X1 Stage2_CF1_U10 ( .A(Stage2_CF1_n18), .B(Stage2_CF1_n17), .ZN(
        Stage2_out1[3]) );
  XNOR2_X1 Stage2_CF1_U9 ( .A(Stage2_CF1_n16), .B(Stage2_in3[4]), .ZN(
        Stage2_CF1_n17) );
  NOR2_X1 Stage2_CF1_U8 ( .A1(Stage2_out1[5]), .A2(Stage2_out3[4]), .ZN(
        Stage2_CF1_n16) );
  NOR2_X1 Stage2_CF1_U7 ( .A1(Stage2_CF1_n15), .A2(Stage2_out3[5]), .ZN(
        Stage2_CF1_n18) );
  XNOR2_X1 Stage2_CF1_U6 ( .A(Stage2_out3[4]), .B(Stage2_out1[4]), .ZN(
        Stage2_CF1_n15) );
  XNOR2_X1 Stage2_CF1_U5 ( .A(Stage2_CF1_n14), .B(Stage2_CF1_n13), .ZN(
        Stage2_out1[2]) );
  XNOR2_X1 Stage2_CF1_U4 ( .A(Stage2_CF1_n12), .B(Stage2_in3[0]), .ZN(
        Stage2_CF1_n13) );
  NOR2_X1 Stage2_CF1_U3 ( .A1(Stage2_out1[1]), .A2(Stage2_out3[7]), .ZN(
        Stage2_CF1_n12) );
  NOR2_X1 Stage2_CF1_U2 ( .A1(Stage2_CF1_n11), .A2(Stage2_out3[1]), .ZN(
        Stage2_CF1_n14) );
  XNOR2_X1 Stage2_CF1_U1 ( .A(Stage2_out3[7]), .B(Stage2_out1[7]), .ZN(
        Stage2_CF1_n11) );
  XNOR2_X1 Stage2_CF2_U10 ( .A(Stage2_CF2_n18), .B(Stage2_CF2_n17), .ZN(
        Stage2_out2[3]) );
  XNOR2_X1 Stage2_CF2_U9 ( .A(Stage2_CF2_n16), .B(Stage2_in1[4]), .ZN(
        Stage2_CF2_n17) );
  NOR2_X1 Stage2_CF2_U8 ( .A1(Stage2_out2[5]), .A2(Stage2_out1[4]), .ZN(
        Stage2_CF2_n16) );
  NOR2_X1 Stage2_CF2_U7 ( .A1(Stage2_CF2_n15), .A2(Stage2_out1[5]), .ZN(
        Stage2_CF2_n18) );
  XNOR2_X1 Stage2_CF2_U6 ( .A(Stage2_out1[4]), .B(Stage2_out2[4]), .ZN(
        Stage2_CF2_n15) );
  XNOR2_X1 Stage2_CF2_U5 ( .A(Stage2_CF2_n14), .B(Stage2_CF2_n13), .ZN(
        Stage2_out2[2]) );
  XNOR2_X1 Stage2_CF2_U4 ( .A(Stage2_CF2_n12), .B(Stage2_in1[0]), .ZN(
        Stage2_CF2_n13) );
  NOR2_X1 Stage2_CF2_U3 ( .A1(Stage2_out2[1]), .A2(Stage2_out1[7]), .ZN(
        Stage2_CF2_n12) );
  NOR2_X1 Stage2_CF2_U2 ( .A1(Stage2_CF2_n11), .A2(Stage2_out1[1]), .ZN(
        Stage2_CF2_n14) );
  XNOR2_X1 Stage2_CF2_U1 ( .A(Stage2_out1[7]), .B(Stage2_out2[7]), .ZN(
        Stage2_CF2_n11) );
  XNOR2_X1 Stage2_CF3_U10 ( .A(Stage2_CF3_n18), .B(Stage2_CF3_n17), .ZN(
        Stage2_out3[3]) );
  XNOR2_X1 Stage2_CF3_U9 ( .A(Stage2_CF3_n16), .B(Stage2_in2[4]), .ZN(
        Stage2_CF3_n17) );
  NOR2_X1 Stage2_CF3_U8 ( .A1(Stage2_out3[5]), .A2(Stage2_out2[4]), .ZN(
        Stage2_CF3_n16) );
  NOR2_X1 Stage2_CF3_U7 ( .A1(Stage2_CF3_n15), .A2(Stage2_out2[5]), .ZN(
        Stage2_CF3_n18) );
  XNOR2_X1 Stage2_CF3_U6 ( .A(Stage2_out2[4]), .B(Stage2_out3[4]), .ZN(
        Stage2_CF3_n15) );
  XNOR2_X1 Stage2_CF3_U5 ( .A(Stage2_CF3_n14), .B(Stage2_CF3_n13), .ZN(
        Stage2_out3[2]) );
  XNOR2_X1 Stage2_CF3_U4 ( .A(Stage2_CF3_n12), .B(Stage2_in2[0]), .ZN(
        Stage2_CF3_n13) );
  NOR2_X1 Stage2_CF3_U3 ( .A1(Stage2_out3[1]), .A2(Stage2_out2[7]), .ZN(
        Stage2_CF3_n12) );
  NOR2_X1 Stage2_CF3_U2 ( .A1(Stage2_CF3_n11), .A2(Stage2_out2[1]), .ZN(
        Stage2_CF3_n14) );
  XNOR2_X1 Stage2_CF3_U1 ( .A(Stage2_out2[7]), .B(Stage2_out3[7]), .ZN(
        Stage2_CF3_n11) );
  DFF_X1 reg2_s1_s_current_state_reg_0_ ( .D(Stage2_out1[0]), .CK(clk), .Q(
        Stage3_in1[0]), .QN() );
  DFF_X1 reg2_s1_s_current_state_reg_1_ ( .D(Stage2_out1[1]), .CK(clk), .Q(
        Stage3_out2[6]), .QN() );
  DFF_X1 reg2_s1_s_current_state_reg_2_ ( .D(Stage2_out1[2]), .CK(clk), .Q(
        Stage3_out2[7]), .QN() );
  DFF_X1 reg2_s1_s_current_state_reg_3_ ( .D(Stage2_out1[3]), .CK(clk), .Q(
        Stage3_out2[1]), .QN() );
  DFF_X1 reg2_s1_s_current_state_reg_4_ ( .D(Stage2_out1[4]), .CK(clk), .Q(
        Stage3_in1[4]), .QN() );
  DFF_X1 reg2_s1_s_current_state_reg_5_ ( .D(Stage2_out1[5]), .CK(clk), .Q(
        Stage3_out2[0]), .QN() );
  DFF_X1 reg2_s1_s_current_state_reg_6_ ( .D(Stage2_out1[6]), .CK(clk), .Q(
        Stage3_out2[4]), .QN() );
  DFF_X1 reg2_s1_s_current_state_reg_7_ ( .D(Stage2_out1[7]), .CK(clk), .Q(
        Stage3_out2[5]), .QN() );
  DFF_X1 reg2_s2_s_current_state_reg_0_ ( .D(Stage2_out2[0]), .CK(clk), .Q(
        Stage3_in2[0]), .QN() );
  DFF_X1 reg2_s2_s_current_state_reg_1_ ( .D(Stage2_out2[1]), .CK(clk), .Q(
        Stage3_out3[6]), .QN() );
  DFF_X1 reg2_s2_s_current_state_reg_2_ ( .D(Stage2_out2[2]), .CK(clk), .Q(
        Stage3_out3[7]), .QN() );
  DFF_X1 reg2_s2_s_current_state_reg_3_ ( .D(Stage2_out2[3]), .CK(clk), .Q(
        Stage3_out3[1]), .QN() );
  DFF_X1 reg2_s2_s_current_state_reg_4_ ( .D(Stage2_out2[4]), .CK(clk), .Q(
        Stage3_in2[4]), .QN() );
  DFF_X1 reg2_s2_s_current_state_reg_5_ ( .D(Stage2_out2[5]), .CK(clk), .Q(
        Stage3_out3[0]), .QN() );
  DFF_X1 reg2_s2_s_current_state_reg_6_ ( .D(Stage2_out2[6]), .CK(clk), .Q(
        Stage3_out3[4]), .QN() );
  DFF_X1 reg2_s2_s_current_state_reg_7_ ( .D(Stage2_out2[7]), .CK(clk), .Q(
        Stage3_out3[5]), .QN() );
  DFF_X1 reg2_s3_s_current_state_reg_0_ ( .D(Stage2_out3[0]), .CK(clk), .Q(
        Stage3_in3[0]), .QN() );
  DFF_X1 reg2_s3_s_current_state_reg_1_ ( .D(Stage2_out3[1]), .CK(clk), .Q(
        Stage3_out1[6]), .QN() );
  DFF_X1 reg2_s3_s_current_state_reg_2_ ( .D(Stage2_out3[2]), .CK(clk), .Q(
        Stage3_out1[7]), .QN() );
  DFF_X1 reg2_s3_s_current_state_reg_3_ ( .D(Stage2_out3[3]), .CK(clk), .Q(
        Stage3_out1[1]), .QN() );
  DFF_X1 reg2_s3_s_current_state_reg_4_ ( .D(Stage2_out3[4]), .CK(clk), .Q(
        Stage3_in3[4]), .QN() );
  DFF_X1 reg2_s3_s_current_state_reg_5_ ( .D(Stage2_out3[5]), .CK(clk), .Q(
        Stage3_out1[0]), .QN() );
  DFF_X1 reg2_s3_s_current_state_reg_6_ ( .D(Stage2_out3[6]), .CK(clk), .Q(
        Stage3_out1[4]), .QN() );
  DFF_X1 reg2_s3_s_current_state_reg_7_ ( .D(Stage2_out3[7]), .CK(clk), .Q(
        Stage3_out1[5]), .QN() );
  XNOR2_X1 Stage3_CF1_U10 ( .A(Stage3_CF1_n18), .B(Stage3_CF1_n17), .ZN(
        Stage3_out1[3]) );
  XNOR2_X1 Stage3_CF1_U9 ( .A(Stage3_CF1_n16), .B(Stage3_in3[4]), .ZN(
        Stage3_CF1_n17) );
  NOR2_X1 Stage3_CF1_U8 ( .A1(Stage3_out1[5]), .A2(Stage3_out3[4]), .ZN(
        Stage3_CF1_n16) );
  NOR2_X1 Stage3_CF1_U7 ( .A1(Stage3_CF1_n15), .A2(Stage3_out3[5]), .ZN(
        Stage3_CF1_n18) );
  XNOR2_X1 Stage3_CF1_U6 ( .A(Stage3_out3[4]), .B(Stage3_out1[4]), .ZN(
        Stage3_CF1_n15) );
  XNOR2_X1 Stage3_CF1_U5 ( .A(Stage3_CF1_n14), .B(Stage3_CF1_n13), .ZN(
        Stage3_out1[2]) );
  XNOR2_X1 Stage3_CF1_U4 ( .A(Stage3_CF1_n12), .B(Stage3_in3[0]), .ZN(
        Stage3_CF1_n13) );
  NOR2_X1 Stage3_CF1_U3 ( .A1(Stage3_out1[1]), .A2(Stage3_out3[7]), .ZN(
        Stage3_CF1_n12) );
  NOR2_X1 Stage3_CF1_U2 ( .A1(Stage3_CF1_n11), .A2(Stage3_out3[1]), .ZN(
        Stage3_CF1_n14) );
  XNOR2_X1 Stage3_CF1_U1 ( .A(Stage3_out3[7]), .B(Stage3_out1[7]), .ZN(
        Stage3_CF1_n11) );
  XNOR2_X1 Stage3_CF2_U10 ( .A(Stage3_CF2_n18), .B(Stage3_CF2_n17), .ZN(
        Stage3_out2[3]) );
  XNOR2_X1 Stage3_CF2_U9 ( .A(Stage3_CF2_n16), .B(Stage3_in1[4]), .ZN(
        Stage3_CF2_n17) );
  NOR2_X1 Stage3_CF2_U8 ( .A1(Stage3_out2[5]), .A2(Stage3_out1[4]), .ZN(
        Stage3_CF2_n16) );
  NOR2_X1 Stage3_CF2_U7 ( .A1(Stage3_CF2_n15), .A2(Stage3_out1[5]), .ZN(
        Stage3_CF2_n18) );
  XNOR2_X1 Stage3_CF2_U6 ( .A(Stage3_out1[4]), .B(Stage3_out2[4]), .ZN(
        Stage3_CF2_n15) );
  XNOR2_X1 Stage3_CF2_U5 ( .A(Stage3_CF2_n14), .B(Stage3_CF2_n13), .ZN(
        Stage3_out2[2]) );
  XNOR2_X1 Stage3_CF2_U4 ( .A(Stage3_CF2_n12), .B(Stage3_in1[0]), .ZN(
        Stage3_CF2_n13) );
  NOR2_X1 Stage3_CF2_U3 ( .A1(Stage3_out2[1]), .A2(Stage3_out1[7]), .ZN(
        Stage3_CF2_n12) );
  NOR2_X1 Stage3_CF2_U2 ( .A1(Stage3_CF2_n11), .A2(Stage3_out1[1]), .ZN(
        Stage3_CF2_n14) );
  XNOR2_X1 Stage3_CF2_U1 ( .A(Stage3_out1[7]), .B(Stage3_out2[7]), .ZN(
        Stage3_CF2_n11) );
  XNOR2_X1 Stage3_CF3_U10 ( .A(Stage3_CF3_n18), .B(Stage3_CF3_n17), .ZN(
        Stage3_out3[3]) );
  XNOR2_X1 Stage3_CF3_U9 ( .A(Stage3_CF3_n16), .B(Stage3_in2[4]), .ZN(
        Stage3_CF3_n17) );
  NOR2_X1 Stage3_CF3_U8 ( .A1(Stage3_out3[5]), .A2(Stage3_out2[4]), .ZN(
        Stage3_CF3_n16) );
  NOR2_X1 Stage3_CF3_U7 ( .A1(Stage3_CF3_n15), .A2(Stage3_out2[5]), .ZN(
        Stage3_CF3_n18) );
  XNOR2_X1 Stage3_CF3_U6 ( .A(Stage3_out2[4]), .B(Stage3_out3[4]), .ZN(
        Stage3_CF3_n15) );
  XNOR2_X1 Stage3_CF3_U5 ( .A(Stage3_CF3_n14), .B(Stage3_CF3_n13), .ZN(
        Stage3_out3[2]) );
  XNOR2_X1 Stage3_CF3_U4 ( .A(Stage3_CF3_n12), .B(Stage3_in2[0]), .ZN(
        Stage3_CF3_n13) );
  NOR2_X1 Stage3_CF3_U3 ( .A1(Stage3_out3[1]), .A2(Stage3_out2[7]), .ZN(
        Stage3_CF3_n12) );
  NOR2_X1 Stage3_CF3_U2 ( .A1(Stage3_CF3_n11), .A2(Stage3_out2[1]), .ZN(
        Stage3_CF3_n14) );
  XNOR2_X1 Stage3_CF3_U1 ( .A(Stage3_out2[7]), .B(Stage3_out3[7]), .ZN(
        Stage3_CF3_n11) );
  DFF_X1 reg3_s1_s_current_state_reg_0_ ( .D(Stage3_out1[0]), .CK(clk), .Q(
        Stage4_in1[0]), .QN() );
  DFF_X1 reg3_s1_s_current_state_reg_1_ ( .D(Stage3_out1[1]), .CK(clk), .Q(
        output_s2[2]), .QN() );
  DFF_X1 reg3_s1_s_current_state_reg_2_ ( .D(Stage3_out1[2]), .CK(clk), .Q(
        output_s2[1]), .QN() );
  DFF_X1 reg3_s1_s_current_state_reg_3_ ( .D(Stage3_out1[3]), .CK(clk), .Q(
        output_s2[3]), .QN() );
  DFF_X1 reg3_s1_s_current_state_reg_4_ ( .D(Stage3_out1[4]), .CK(clk), .Q(
        Stage4_in1[4]), .QN() );
  DFF_X1 reg3_s1_s_current_state_reg_5_ ( .D(Stage3_out1[5]), .CK(clk), .Q(
        output_s2[5]), .QN() );
  DFF_X1 reg3_s1_s_current_state_reg_6_ ( .D(Stage3_out1[6]), .CK(clk), .Q(
        output_s2[6]), .QN() );
  DFF_X1 reg3_s1_s_current_state_reg_7_ ( .D(Stage3_out1[7]), .CK(clk), .Q(
        output_s2[7]), .QN() );
  DFF_X1 reg3_s2_s_current_state_reg_0_ ( .D(Stage3_out2[0]), .CK(clk), .Q(
        Stage4_in2[0]), .QN() );
  DFF_X1 reg3_s2_s_current_state_reg_1_ ( .D(Stage3_out2[1]), .CK(clk), .Q(
        output_s3[2]), .QN() );
  DFF_X1 reg3_s2_s_current_state_reg_2_ ( .D(Stage3_out2[2]), .CK(clk), .Q(
        output_s3[1]), .QN() );
  DFF_X1 reg3_s2_s_current_state_reg_3_ ( .D(Stage3_out2[3]), .CK(clk), .Q(
        output_s3[3]), .QN() );
  DFF_X1 reg3_s2_s_current_state_reg_4_ ( .D(Stage3_out2[4]), .CK(clk), .Q(
        Stage4_in2[4]), .QN() );
  DFF_X1 reg3_s2_s_current_state_reg_5_ ( .D(Stage3_out2[5]), .CK(clk), .Q(
        output_s3[5]), .QN() );
  DFF_X1 reg3_s2_s_current_state_reg_6_ ( .D(Stage3_out2[6]), .CK(clk), .Q(
        output_s3[6]), .QN() );
  DFF_X1 reg3_s2_s_current_state_reg_7_ ( .D(Stage3_out2[7]), .CK(clk), .Q(
        output_s3[7]), .QN() );
  DFF_X1 reg3_s3_s_current_state_reg_0_ ( .D(Stage3_out3[0]), .CK(clk), .Q(
        Stage4_in3[0]), .QN() );
  DFF_X1 reg3_s3_s_current_state_reg_1_ ( .D(Stage3_out3[1]), .CK(clk), .Q(
        output_s1[2]), .QN() );
  DFF_X1 reg3_s3_s_current_state_reg_2_ ( .D(Stage3_out3[2]), .CK(clk), .Q(
        output_s1[1]), .QN() );
  DFF_X1 reg3_s3_s_current_state_reg_3_ ( .D(Stage3_out3[3]), .CK(clk), .Q(
        output_s1[3]), .QN() );
  DFF_X1 reg3_s3_s_current_state_reg_4_ ( .D(Stage3_out3[4]), .CK(clk), .Q(
        Stage4_in3[4]), .QN() );
  DFF_X1 reg3_s3_s_current_state_reg_5_ ( .D(Stage3_out3[5]), .CK(clk), .Q(
        output_s1[5]), .QN() );
  DFF_X1 reg3_s3_s_current_state_reg_6_ ( .D(Stage3_out3[6]), .CK(clk), .Q(
        output_s1[6]), .QN() );
  DFF_X1 reg3_s3_s_current_state_reg_7_ ( .D(Stage3_out3[7]), .CK(clk), .Q(
        output_s1[7]), .QN() );
  XNOR2_X1 Stage4_CF1_U10 ( .A(Stage4_CF1_n18), .B(Stage4_CF1_n17), .ZN(
        output_s1[4]) );
  XNOR2_X1 Stage4_CF1_U9 ( .A(Stage4_CF1_n16), .B(Stage4_in3[4]), .ZN(
        Stage4_CF1_n17) );
  NOR2_X1 Stage4_CF1_U8 ( .A1(output_s1[7]), .A2(output_s3[6]), .ZN(
        Stage4_CF1_n16) );
  NOR2_X1 Stage4_CF1_U7 ( .A1(Stage4_CF1_n15), .A2(output_s3[7]), .ZN(
        Stage4_CF1_n18) );
  XNOR2_X1 Stage4_CF1_U6 ( .A(output_s3[6]), .B(output_s1[6]), .ZN(
        Stage4_CF1_n15) );
  XNOR2_X1 Stage4_CF1_U5 ( .A(Stage4_CF1_n14), .B(Stage4_CF1_n13), .ZN(
        output_s1[0]) );
  XNOR2_X1 Stage4_CF1_U4 ( .A(Stage4_CF1_n12), .B(Stage4_in3[0]), .ZN(
        Stage4_CF1_n13) );
  NOR2_X1 Stage4_CF1_U3 ( .A1(output_s1[3]), .A2(output_s3[1]), .ZN(
        Stage4_CF1_n12) );
  NOR2_X1 Stage4_CF1_U2 ( .A1(Stage4_CF1_n11), .A2(output_s3[3]), .ZN(
        Stage4_CF1_n14) );
  XNOR2_X1 Stage4_CF1_U1 ( .A(output_s3[1]), .B(output_s1[1]), .ZN(
        Stage4_CF1_n11) );
  XNOR2_X1 Stage4_CF2_U10 ( .A(Stage4_CF2_n18), .B(Stage4_CF2_n17), .ZN(
        output_s2[4]) );
  XNOR2_X1 Stage4_CF2_U9 ( .A(Stage4_CF2_n16), .B(Stage4_in1[4]), .ZN(
        Stage4_CF2_n17) );
  NOR2_X1 Stage4_CF2_U8 ( .A1(output_s2[7]), .A2(output_s1[6]), .ZN(
        Stage4_CF2_n16) );
  NOR2_X1 Stage4_CF2_U7 ( .A1(Stage4_CF2_n15), .A2(output_s1[7]), .ZN(
        Stage4_CF2_n18) );
  XNOR2_X1 Stage4_CF2_U6 ( .A(output_s1[6]), .B(output_s2[6]), .ZN(
        Stage4_CF2_n15) );
  XNOR2_X1 Stage4_CF2_U5 ( .A(Stage4_CF2_n14), .B(Stage4_CF2_n13), .ZN(
        output_s2[0]) );
  XNOR2_X1 Stage4_CF2_U4 ( .A(Stage4_CF2_n12), .B(Stage4_in1[0]), .ZN(
        Stage4_CF2_n13) );
  NOR2_X1 Stage4_CF2_U3 ( .A1(output_s2[3]), .A2(output_s1[1]), .ZN(
        Stage4_CF2_n12) );
  NOR2_X1 Stage4_CF2_U2 ( .A1(Stage4_CF2_n11), .A2(output_s1[3]), .ZN(
        Stage4_CF2_n14) );
  XNOR2_X1 Stage4_CF2_U1 ( .A(output_s1[1]), .B(output_s2[1]), .ZN(
        Stage4_CF2_n11) );
  XNOR2_X1 Stage4_CF3_U10 ( .A(Stage4_CF3_n18), .B(Stage4_CF3_n17), .ZN(
        output_s3[4]) );
  XNOR2_X1 Stage4_CF3_U9 ( .A(Stage4_CF3_n16), .B(Stage4_in2[4]), .ZN(
        Stage4_CF3_n17) );
  NOR2_X1 Stage4_CF3_U8 ( .A1(output_s3[7]), .A2(output_s2[6]), .ZN(
        Stage4_CF3_n16) );
  NOR2_X1 Stage4_CF3_U7 ( .A1(Stage4_CF3_n15), .A2(output_s2[7]), .ZN(
        Stage4_CF3_n18) );
  XNOR2_X1 Stage4_CF3_U6 ( .A(output_s2[6]), .B(output_s3[6]), .ZN(
        Stage4_CF3_n15) );
  XNOR2_X1 Stage4_CF3_U5 ( .A(Stage4_CF3_n14), .B(Stage4_CF3_n13), .ZN(
        output_s3[0]) );
  XNOR2_X1 Stage4_CF3_U4 ( .A(Stage4_CF3_n12), .B(Stage4_in2[0]), .ZN(
        Stage4_CF3_n13) );
  NOR2_X1 Stage4_CF3_U3 ( .A1(output_s3[3]), .A2(output_s2[1]), .ZN(
        Stage4_CF3_n12) );
  NOR2_X1 Stage4_CF3_U2 ( .A1(Stage4_CF3_n11), .A2(output_s2[3]), .ZN(
        Stage4_CF3_n14) );
  XNOR2_X1 Stage4_CF3_U1 ( .A(output_s2[1]), .B(output_s3[1]), .ZN(
        Stage4_CF3_n11) );
endmodule

