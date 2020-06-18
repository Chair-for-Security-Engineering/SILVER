
module CMSSbox ( x1, x2, clk, y1, y2 );
(* SILVER="[7:0]_0" *)  input [7:0] x1;
(* SILVER="[7:0]_1" *)  input [7:0] x2;
(* SILVER="[7:0]_0" *)  output [7:0] y1;
(* SILVER="[7:0]_1" *)  output [7:0] y2;
(* SILVER="clock" *)  input clk;
  wire   fo1_3_, fo1_2_, fo2_3_, fo2_2_, F_TI2_c_f1_n2, F_TI2_c_fp1_n2,
         F_TI2_c_f3_n2, F_TI2_c_fp3_n2, F_TI2_c_f2_n3, F_TI2_c_fp2_n2,
         F_TI2_c_f4_n3, F_TI2_c_fp34_n2, G_TI2_c_f1_n2, G_TI2_c_fp1_n2,
         G_TI2_c_f3_n2, G_TI2_c_fp3_n2, G_TI2_c_f2_n3, G_TI2_c_fp2_n2,
         G_TI2_c_f4_n3, G_TI2_c_fp34_n2, H_TI2_c_f1_n2, H_TI2_c_fp1_n2,
         H_TI2_c_f3_n2, H_TI2_c_fp3_n2, H_TI2_c_f2_n3, H_TI2_c_fp2_n2,
         H_TI2_c_f4_n3, H_TI2_c_fp34_n2, I_TI2_c_f1_n2, I_TI2_c_fp1_n2,
         I_TI2_c_f3_n2, I_TI2_c_fp3_n2, I_TI2_c_f2_n3, I_TI2_c_fp2_n2,
         I_TI2_c_f4_n3, I_TI2_c_fp34_n2;
  wire   [1:0] fpo1;
  wire   [1:0] fpo2;
  wire   [3:2] fo1R;
  wire   [3:2] fo2R;
  wire   [1:0] fpo1R;
  wire   [1:0] fpo2R;
  wire   [4:0] gi1;
  wire   [4:0] gi2;
  wire   [7:0] go1;
  wire   [7:0] go2;
  wire   [1:0] gpo1;
  wire   [1:0] gpo2;
  wire   [3:2] go1R;
  wire   [3:2] go2R;
  wire   [1:0] gpo1R;
  wire   [1:0] gpo2R;
  wire   [4:0] hi1;
  wire   [4:0] hi2;
  wire   [7:0] ho1;
  wire   [7:0] ho2;
  wire   [1:0] hpo1;
  wire   [1:0] hpo2;
  wire   [3:2] ho1R;
  wire   [3:2] ho2R;
  wire   [1:0] hpo1R;
  wire   [1:0] hpo2R;
  wire   [4:0] ii1;
  wire   [4:0] ii2;
  wire   [7:0] io1;
  wire   [7:0] io2;
  wire   [1:0] ipo1;
  wire   [1:0] ipo2;
  wire   [3:2] io1R;
  wire   [3:2] io2R;
  wire   [1:0] ipo1R;
  wire   [1:0] ipo2R;

  XOR2_X1 F_TI2_c_f1_U2 ( .A(x1[0]), .B(F_TI2_c_f1_n2), .Z(fo1_2_) );
  NOR2_X1 F_TI2_c_f1_U1 ( .A1(x1[2]), .A2(x1[3]), .ZN(F_TI2_c_f1_n2) );
  NOR2_X1 F_TI2_c_fp1_U2 ( .A1(x1[2]), .A2(F_TI2_c_fp1_n2), .ZN(fpo1[0]) );
  INV_X1 F_TI2_c_fp1_U1 ( .A(x2[3]), .ZN(F_TI2_c_fp1_n2) );
  XOR2_X1 F_TI2_c_f3_U2 ( .A(x1[4]), .B(F_TI2_c_f3_n2), .Z(fo1_3_) );
  NOR2_X1 F_TI2_c_f3_U1 ( .A1(x1[6]), .A2(x1[7]), .ZN(F_TI2_c_f3_n2) );
  NOR2_X1 F_TI2_c_fp3_U2 ( .A1(x1[6]), .A2(F_TI2_c_fp3_n2), .ZN(fpo1[1]) );
  INV_X1 F_TI2_c_fp3_U1 ( .A(x2[7]), .ZN(F_TI2_c_fp3_n2) );
  XNOR2_X1 F_TI2_c_f2_U2 ( .A(F_TI2_c_f2_n3), .B(x2[0]), .ZN(fo2_2_) );
  NAND2_X1 F_TI2_c_f2_U1 ( .A1(x2[3]), .A2(x2[2]), .ZN(F_TI2_c_f2_n3) );
  NOR2_X1 F_TI2_c_fp2_U2 ( .A1(x1[3]), .A2(F_TI2_c_fp2_n2), .ZN(fpo2[0]) );
  INV_X1 F_TI2_c_fp2_U1 ( .A(x2[2]), .ZN(F_TI2_c_fp2_n2) );
  XNOR2_X1 F_TI2_c_f4_U2 ( .A(F_TI2_c_f4_n3), .B(x2[4]), .ZN(fo2_3_) );
  NAND2_X1 F_TI2_c_f4_U1 ( .A1(x2[7]), .A2(x2[6]), .ZN(F_TI2_c_f4_n3) );
  NOR2_X1 F_TI2_c_fp34_U2 ( .A1(x1[7]), .A2(F_TI2_c_fp34_n2), .ZN(fpo2[1]) );
  INV_X1 F_TI2_c_fp34_U1 ( .A(x2[6]), .ZN(F_TI2_c_fp34_n2) );
  DFF_X1 Rf_s_current_state_reg_0_ ( .D(x1[5]), .CK(clk), .Q(gi1[0]), .QN() );
  DFF_X1 Rf_s_current_state_reg_1_ ( .D(x1[3]), .CK(clk), .Q(go1[6]), .QN() );
  DFF_X1 Rf_s_current_state_reg_2_ ( .D(fo1_2_), .CK(clk), .Q(fo1R[2]), .QN()
         );
  DFF_X1 Rf_s_current_state_reg_3_ ( .D(fo1_3_), .CK(clk), .Q(fo1R[3]), .QN()
         );
  DFF_X1 Rf_s_current_state_reg_4_ ( .D(x1[6]), .CK(clk), .Q(gi1[4]), .QN() );
  DFF_X1 Rf_s_current_state_reg_5_ ( .D(x1[7]), .CK(clk), .Q(go1[0]), .QN() );
  DFF_X1 Rf_s_current_state_reg_6_ ( .D(x1[1]), .CK(clk), .Q(go1[4]), .QN() );
  DFF_X1 Rf_s_current_state_reg_7_ ( .D(x1[2]), .CK(clk), .Q(go1[5]), .QN() );
  DFF_X1 Rf_s_current_state_reg_8_ ( .D(x2[5]), .CK(clk), .Q(gi2[0]), .QN() );
  DFF_X1 Rf_s_current_state_reg_9_ ( .D(x2[3]), .CK(clk), .Q(go2[6]), .QN() );
  DFF_X1 Rf_s_current_state_reg_10_ ( .D(fo2_2_), .CK(clk), .Q(fo2R[2]), .QN()
         );
  DFF_X1 Rf_s_current_state_reg_11_ ( .D(fo2_3_), .CK(clk), .Q(fo2R[3]), .QN()
         );
  DFF_X1 Rf_s_current_state_reg_12_ ( .D(x2[6]), .CK(clk), .Q(gi2[4]), .QN()
         );
  DFF_X1 Rf_s_current_state_reg_13_ ( .D(x2[7]), .CK(clk), .Q(go2[0]), .QN()
         );
  DFF_X1 Rf_s_current_state_reg_14_ ( .D(x2[1]), .CK(clk), .Q(go2[4]), .QN()
         );
  DFF_X1 Rf_s_current_state_reg_15_ ( .D(x2[2]), .CK(clk), .Q(go2[5]), .QN()
         );
  DFF_X1 Rf_s_current_state_reg_16_ ( .D(fpo1[0]), .CK(clk), .Q(fpo1R[0]), 
        .QN() );
  DFF_X1 Rf_s_current_state_reg_17_ ( .D(fpo1[1]), .CK(clk), .Q(fpo1R[1]), 
        .QN() );
  DFF_X1 Rf_s_current_state_reg_18_ ( .D(fpo2[0]), .CK(clk), .Q(fpo2R[0]), 
        .QN() );
  DFF_X1 Rf_s_current_state_reg_19_ ( .D(fpo2[1]), .CK(clk), .Q(fpo2R[1]), 
        .QN() );
  XOR2_X1 F_Com_Combine1_U2 ( .A(fo1R[3]), .B(fpo1R[1]), .Z(go1[1]) );
  XOR2_X1 F_Com_Combine1_U1 ( .A(fo1R[2]), .B(fpo1R[0]), .Z(go1[7]) );
  XOR2_X1 F_Com_Combine2_U2 ( .A(fo2R[3]), .B(fpo2R[1]), .Z(go2[1]) );
  XOR2_X1 F_Com_Combine2_U1 ( .A(fo2R[2]), .B(fpo2R[0]), .Z(go2[7]) );
  XOR2_X1 G_TI2_c_f1_U2 ( .A(gi1[0]), .B(G_TI2_c_f1_n2), .Z(go1[2]) );
  NOR2_X1 G_TI2_c_f1_U1 ( .A1(go1[7]), .A2(go1[1]), .ZN(G_TI2_c_f1_n2) );
  NOR2_X1 G_TI2_c_fp1_U2 ( .A1(go1[7]), .A2(G_TI2_c_fp1_n2), .ZN(gpo1[0]) );
  INV_X1 G_TI2_c_fp1_U1 ( .A(go2[1]), .ZN(G_TI2_c_fp1_n2) );
  XOR2_X1 G_TI2_c_f3_U2 ( .A(gi1[4]), .B(G_TI2_c_f3_n2), .Z(go1[3]) );
  NOR2_X1 G_TI2_c_f3_U1 ( .A1(go1[4]), .A2(go1[5]), .ZN(G_TI2_c_f3_n2) );
  NOR2_X1 G_TI2_c_fp3_U2 ( .A1(go1[4]), .A2(G_TI2_c_fp3_n2), .ZN(gpo1[1]) );
  INV_X1 G_TI2_c_fp3_U1 ( .A(go2[5]), .ZN(G_TI2_c_fp3_n2) );
  XNOR2_X1 G_TI2_c_f2_U2 ( .A(G_TI2_c_f2_n3), .B(gi2[0]), .ZN(go2[2]) );
  NAND2_X1 G_TI2_c_f2_U1 ( .A1(go2[1]), .A2(go2[7]), .ZN(G_TI2_c_f2_n3) );
  NOR2_X1 G_TI2_c_fp2_U2 ( .A1(go1[1]), .A2(G_TI2_c_fp2_n2), .ZN(gpo2[0]) );
  INV_X1 G_TI2_c_fp2_U1 ( .A(go2[7]), .ZN(G_TI2_c_fp2_n2) );
  XNOR2_X1 G_TI2_c_f4_U2 ( .A(G_TI2_c_f4_n3), .B(gi2[4]), .ZN(go2[3]) );
  NAND2_X1 G_TI2_c_f4_U1 ( .A1(go2[5]), .A2(go2[4]), .ZN(G_TI2_c_f4_n3) );
  NOR2_X1 G_TI2_c_fp34_U2 ( .A1(go1[5]), .A2(G_TI2_c_fp34_n2), .ZN(gpo2[1]) );
  INV_X1 G_TI2_c_fp34_U1 ( .A(go2[4]), .ZN(G_TI2_c_fp34_n2) );
  DFF_X1 Rg_s_current_state_reg_0_ ( .D(go1[0]), .CK(clk), .Q(hi1[0]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_1_ ( .D(go1[1]), .CK(clk), .Q(ho1[6]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_2_ ( .D(go1[2]), .CK(clk), .Q(go1R[2]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_3_ ( .D(go1[3]), .CK(clk), .Q(go1R[3]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_4_ ( .D(go1[4]), .CK(clk), .Q(hi1[4]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_5_ ( .D(go1[5]), .CK(clk), .Q(ho1[0]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_6_ ( .D(go1[6]), .CK(clk), .Q(ho1[4]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_7_ ( .D(go1[7]), .CK(clk), .Q(ho1[5]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_8_ ( .D(go2[0]), .CK(clk), .Q(hi2[0]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_9_ ( .D(go2[1]), .CK(clk), .Q(ho2[6]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_10_ ( .D(go2[2]), .CK(clk), .Q(go2R[2]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_11_ ( .D(go2[3]), .CK(clk), .Q(go2R[3]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_12_ ( .D(go2[4]), .CK(clk), .Q(hi2[4]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_13_ ( .D(go2[5]), .CK(clk), .Q(ho2[0]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_14_ ( .D(go2[6]), .CK(clk), .Q(ho2[4]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_15_ ( .D(go2[7]), .CK(clk), .Q(ho2[5]), .QN()
         );
  DFF_X1 Rg_s_current_state_reg_16_ ( .D(gpo1[0]), .CK(clk), .Q(gpo1R[0]), 
        .QN() );
  DFF_X1 Rg_s_current_state_reg_17_ ( .D(gpo1[1]), .CK(clk), .Q(gpo1R[1]), 
        .QN() );
  DFF_X1 Rg_s_current_state_reg_18_ ( .D(gpo2[0]), .CK(clk), .Q(gpo2R[0]), 
        .QN() );
  DFF_X1 Rg_s_current_state_reg_19_ ( .D(gpo2[1]), .CK(clk), .Q(gpo2R[1]), 
        .QN() );
  XOR2_X1 G_Com_Combine1_U2 ( .A(go1R[3]), .B(gpo1R[1]), .Z(ho1[1]) );
  XOR2_X1 G_Com_Combine1_U1 ( .A(go1R[2]), .B(gpo1R[0]), .Z(ho1[7]) );
  XOR2_X1 G_Com_Combine2_U2 ( .A(go2R[3]), .B(gpo2R[1]), .Z(ho2[1]) );
  XOR2_X1 G_Com_Combine2_U1 ( .A(go2R[2]), .B(gpo2R[0]), .Z(ho2[7]) );
  XOR2_X1 H_TI2_c_f1_U2 ( .A(hi1[0]), .B(H_TI2_c_f1_n2), .Z(ho1[2]) );
  NOR2_X1 H_TI2_c_f1_U1 ( .A1(ho1[7]), .A2(ho1[1]), .ZN(H_TI2_c_f1_n2) );
  NOR2_X1 H_TI2_c_fp1_U2 ( .A1(ho1[7]), .A2(H_TI2_c_fp1_n2), .ZN(hpo1[0]) );
  INV_X1 H_TI2_c_fp1_U1 ( .A(ho2[1]), .ZN(H_TI2_c_fp1_n2) );
  XOR2_X1 H_TI2_c_f3_U2 ( .A(hi1[4]), .B(H_TI2_c_f3_n2), .Z(ho1[3]) );
  NOR2_X1 H_TI2_c_f3_U1 ( .A1(ho1[4]), .A2(ho1[5]), .ZN(H_TI2_c_f3_n2) );
  NOR2_X1 H_TI2_c_fp3_U2 ( .A1(ho1[4]), .A2(H_TI2_c_fp3_n2), .ZN(hpo1[1]) );
  INV_X1 H_TI2_c_fp3_U1 ( .A(ho2[5]), .ZN(H_TI2_c_fp3_n2) );
  XNOR2_X1 H_TI2_c_f2_U2 ( .A(H_TI2_c_f2_n3), .B(hi2[0]), .ZN(ho2[2]) );
  NAND2_X1 H_TI2_c_f2_U1 ( .A1(ho2[1]), .A2(ho2[7]), .ZN(H_TI2_c_f2_n3) );
  NOR2_X1 H_TI2_c_fp2_U2 ( .A1(ho1[1]), .A2(H_TI2_c_fp2_n2), .ZN(hpo2[0]) );
  INV_X1 H_TI2_c_fp2_U1 ( .A(ho2[7]), .ZN(H_TI2_c_fp2_n2) );
  XNOR2_X1 H_TI2_c_f4_U2 ( .A(H_TI2_c_f4_n3), .B(hi2[4]), .ZN(ho2[3]) );
  NAND2_X1 H_TI2_c_f4_U1 ( .A1(ho2[5]), .A2(ho2[4]), .ZN(H_TI2_c_f4_n3) );
  NOR2_X1 H_TI2_c_fp34_U2 ( .A1(ho1[5]), .A2(H_TI2_c_fp34_n2), .ZN(hpo2[1]) );
  INV_X1 H_TI2_c_fp34_U1 ( .A(ho2[4]), .ZN(H_TI2_c_fp34_n2) );
  DFF_X1 Rh_s_current_state_reg_0_ ( .D(ho1[0]), .CK(clk), .Q(ii1[0]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_1_ ( .D(ho1[1]), .CK(clk), .Q(io1[6]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_2_ ( .D(ho1[2]), .CK(clk), .Q(ho1R[2]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_3_ ( .D(ho1[3]), .CK(clk), .Q(ho1R[3]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_4_ ( .D(ho1[4]), .CK(clk), .Q(ii1[4]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_5_ ( .D(ho1[5]), .CK(clk), .Q(io1[0]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_6_ ( .D(ho1[6]), .CK(clk), .Q(io1[4]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_7_ ( .D(ho1[7]), .CK(clk), .Q(io1[5]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_8_ ( .D(ho2[0]), .CK(clk), .Q(ii2[0]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_9_ ( .D(ho2[1]), .CK(clk), .Q(io2[6]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_10_ ( .D(ho2[2]), .CK(clk), .Q(ho2R[2]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_11_ ( .D(ho2[3]), .CK(clk), .Q(ho2R[3]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_12_ ( .D(ho2[4]), .CK(clk), .Q(ii2[4]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_13_ ( .D(ho2[5]), .CK(clk), .Q(io2[0]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_14_ ( .D(ho2[6]), .CK(clk), .Q(io2[4]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_15_ ( .D(ho2[7]), .CK(clk), .Q(io2[5]), .QN()
         );
  DFF_X1 Rh_s_current_state_reg_16_ ( .D(hpo1[0]), .CK(clk), .Q(hpo1R[0]), 
        .QN() );
  DFF_X1 Rh_s_current_state_reg_17_ ( .D(hpo1[1]), .CK(clk), .Q(hpo1R[1]), 
        .QN() );
  DFF_X1 Rh_s_current_state_reg_18_ ( .D(hpo2[0]), .CK(clk), .Q(hpo2R[0]), 
        .QN() );
  DFF_X1 Rh_s_current_state_reg_19_ ( .D(hpo2[1]), .CK(clk), .Q(hpo2R[1]), 
        .QN() );
  XOR2_X1 H_Com_Combine1_U2 ( .A(ho1R[3]), .B(hpo1R[1]), .Z(io1[1]) );
  XOR2_X1 H_Com_Combine1_U1 ( .A(ho1R[2]), .B(hpo1R[0]), .Z(io1[7]) );
  XOR2_X1 H_Com_Combine2_U2 ( .A(ho2R[3]), .B(hpo2R[1]), .Z(io2[1]) );
  XOR2_X1 H_Com_Combine2_U1 ( .A(ho2R[2]), .B(hpo2R[0]), .Z(io2[7]) );
  XOR2_X1 I_TI2_c_f1_U2 ( .A(ii1[0]), .B(I_TI2_c_f1_n2), .Z(io1[2]) );
  NOR2_X1 I_TI2_c_f1_U1 ( .A1(io1[7]), .A2(io1[1]), .ZN(I_TI2_c_f1_n2) );
  NOR2_X1 I_TI2_c_fp1_U2 ( .A1(io1[7]), .A2(I_TI2_c_fp1_n2), .ZN(ipo1[0]) );
  INV_X1 I_TI2_c_fp1_U1 ( .A(io2[1]), .ZN(I_TI2_c_fp1_n2) );
  XOR2_X1 I_TI2_c_f3_U2 ( .A(ii1[4]), .B(I_TI2_c_f3_n2), .Z(io1[3]) );
  NOR2_X1 I_TI2_c_f3_U1 ( .A1(io1[4]), .A2(io1[5]), .ZN(I_TI2_c_f3_n2) );
  NOR2_X1 I_TI2_c_fp3_U2 ( .A1(io1[4]), .A2(I_TI2_c_fp3_n2), .ZN(ipo1[1]) );
  INV_X1 I_TI2_c_fp3_U1 ( .A(io2[5]), .ZN(I_TI2_c_fp3_n2) );
  XNOR2_X1 I_TI2_c_f2_U2 ( .A(I_TI2_c_f2_n3), .B(ii2[0]), .ZN(io2[2]) );
  NAND2_X1 I_TI2_c_f2_U1 ( .A1(io2[1]), .A2(io2[7]), .ZN(I_TI2_c_f2_n3) );
  NOR2_X1 I_TI2_c_fp2_U2 ( .A1(io1[1]), .A2(I_TI2_c_fp2_n2), .ZN(ipo2[0]) );
  INV_X1 I_TI2_c_fp2_U1 ( .A(io2[7]), .ZN(I_TI2_c_fp2_n2) );
  XNOR2_X1 I_TI2_c_f4_U2 ( .A(I_TI2_c_f4_n3), .B(ii2[4]), .ZN(io2[3]) );
  NAND2_X1 I_TI2_c_f4_U1 ( .A1(io2[5]), .A2(io2[4]), .ZN(I_TI2_c_f4_n3) );
  NOR2_X1 I_TI2_c_fp34_U2 ( .A1(io1[5]), .A2(I_TI2_c_fp34_n2), .ZN(ipo2[1]) );
  INV_X1 I_TI2_c_fp34_U1 ( .A(io2[4]), .ZN(I_TI2_c_fp34_n2) );
  DFF_X1 Ri_s_current_state_reg_0_ ( .D(io1[0]), .CK(clk), .Q(y1[5]), .QN() );
  DFF_X1 Ri_s_current_state_reg_1_ ( .D(io1[1]), .CK(clk), .Q(y1[3]), .QN() );
  DFF_X1 Ri_s_current_state_reg_2_ ( .D(io1[2]), .CK(clk), .Q(io1R[2]), .QN()
         );
  DFF_X1 Ri_s_current_state_reg_3_ ( .D(io1[3]), .CK(clk), .Q(io1R[3]), .QN()
         );
  DFF_X1 Ri_s_current_state_reg_4_ ( .D(io1[4]), .CK(clk), .Q(y1[6]), .QN() );
  DFF_X1 Ri_s_current_state_reg_5_ ( .D(io1[5]), .CK(clk), .Q(y1[7]), .QN() );
  DFF_X1 Ri_s_current_state_reg_6_ ( .D(io1[6]), .CK(clk), .Q(y1[2]), .QN() );
  DFF_X1 Ri_s_current_state_reg_7_ ( .D(io1[7]), .CK(clk), .Q(y1[1]), .QN() );
  DFF_X1 Ri_s_current_state_reg_8_ ( .D(io2[0]), .CK(clk), .Q(y2[5]), .QN() );
  DFF_X1 Ri_s_current_state_reg_9_ ( .D(io2[1]), .CK(clk), .Q(y2[3]), .QN() );
  DFF_X1 Ri_s_current_state_reg_10_ ( .D(io2[2]), .CK(clk), .Q(io2R[2]), .QN()
         );
  DFF_X1 Ri_s_current_state_reg_11_ ( .D(io2[3]), .CK(clk), .Q(io2R[3]), .QN()
         );
  DFF_X1 Ri_s_current_state_reg_12_ ( .D(io2[4]), .CK(clk), .Q(y2[6]), .QN()
         );
  DFF_X1 Ri_s_current_state_reg_13_ ( .D(io2[5]), .CK(clk), .Q(y2[7]), .QN()
         );
  DFF_X1 Ri_s_current_state_reg_14_ ( .D(io2[6]), .CK(clk), .Q(y2[2]), .QN()
         );
  DFF_X1 Ri_s_current_state_reg_15_ ( .D(io2[7]), .CK(clk), .Q(y2[1]), .QN()
         );
  DFF_X1 Ri_s_current_state_reg_16_ ( .D(ipo1[0]), .CK(clk), .Q(ipo1R[0]), 
        .QN() );
  DFF_X1 Ri_s_current_state_reg_17_ ( .D(ipo1[1]), .CK(clk), .Q(ipo1R[1]), 
        .QN() );
  DFF_X1 Ri_s_current_state_reg_18_ ( .D(ipo2[0]), .CK(clk), .Q(ipo2R[0]), 
        .QN() );
  DFF_X1 Ri_s_current_state_reg_19_ ( .D(ipo2[1]), .CK(clk), .Q(ipo2R[1]), 
        .QN() );
  XOR2_X1 I_Com_Combine1_U2 ( .A(io1R[3]), .B(ipo1R[1]), .Z(y1[4]) );
  XOR2_X1 I_Com_Combine1_U1 ( .A(io1R[2]), .B(ipo1R[0]), .Z(y1[0]) );
  XOR2_X1 I_Com_Combine2_U2 ( .A(io2R[3]), .B(ipo2R[1]), .Z(y2[4]) );
  XOR2_X1 I_Com_Combine2_U1 ( .A(io2R[2]), .B(ipo2R[0]), .Z(y2[0]) );
endmodule

