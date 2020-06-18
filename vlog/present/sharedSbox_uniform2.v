
module sharedSbox ( clk, sboxIn1, sboxIn2, sboxIn3, share1, share2, share3 );
(* SILVER="[3:0]_0" *)  input [3:0] sboxIn1;
(* SILVER="[3:0]_1" *)  input [3:0] sboxIn2;
(* SILVER="[3:0]_2" *)  input [3:0] sboxIn3;
(* SILVER="[3:0]_0" *)  output [3:0] share1;
(* SILVER="[3:0]_1" *)  output [3:0] share2;
(* SILVER="[3:0]_2" *)  output [3:0] share3;
(* SILVER="clock" *)  input clk;
  wire   f1_n116, f1_n115, f1_n114, f1_n113, f1_n112, f1_n111, f1_n110,
         f1_n109, f1_n108, f1_n107, f1_n106, f1_n105, f1_n104, f1_n103,
         f1_n102, f1_n101, f1_n100, f1_n99, f1_n98, f1_n97, f1_n96, f1_n95,
         f1_n94, f1_n93, f1_n92, f1_n91, f1_n90, f1_n89, f1_n88, f1_n87,
         f1_n86, f1_n85, f1_n84, f1_n83, f1_n82, f1_n81, f1_n80, f1_n79,
         f1_n78, f1_n77, f1_n76, f1_n75, f1_n74, f1_n73, f1_n72, f1_n71,
         f1_n70, f1_n69, f1_n68, f1_n67, f2_n113, f2_n112, f2_n111, f2_n110,
         f2_n109, f2_n108, f2_n107, f2_n106, f2_n105, f2_n104, f2_n103,
         f2_n102, f2_n101, f2_n100, f2_n99, f2_n98, f2_n97, f2_n96, f2_n95,
         f2_n94, f2_n93, f2_n92, f2_n91, f2_n90, f2_n89, f2_n88, f2_n87,
         f2_n86, f2_n85, f2_n84, f2_n83, f2_n82, f2_n81, f2_n80, f2_n79,
         f2_n78, f2_n77, f2_n76, f2_n75, f2_n74, f2_n73, f2_n72, f2_n71,
         f2_n70, f2_n69, f2_n68, f2_n67, f2_n66, f2_n65, f3_n116, f3_n115,
         f3_n114, f3_n113, f3_n112, f3_n111, f3_n110, f3_n109, f3_n108,
         f3_n107, f3_n106, f3_n105, f3_n104, f3_n103, f3_n102, f3_n101,
         f3_n100, f3_n99, f3_n98, f3_n97, f3_n96, f3_n95, f3_n94, f3_n93,
         f3_n92, f3_n91, f3_n90, f3_n89, f3_n88, f3_n87, f3_n86, f3_n85,
         f3_n84, f3_n83, f3_n82, f3_n81, f3_n80, f3_n79, f3_n78, f3_n77,
         f3_n76, f3_n75, f3_n74, f3_n73, f3_n72, f3_n71, f3_n70, f3_n69,
         f3_n68, f3_n67, g1_n50, g1_n49, g1_n48, g1_n47, g1_n46, g1_n45,
         g1_n44, g1_n43, g1_n42, g1_n41, g1_n40, g1_n39, g1_n38, g1_n37,
         g1_n36, g1_n35, g1_n34, g1_n33, g1_n32, g1_n31, g1_n30, g1_n29,
         g1_n28, g1_n27, g1_n26, g1_n25, g1_n24, g1_n23, g1_n22, g1_n21,
         g1_n20, g1_n19, g1_n18, g1_n17, g1_n16, g1_n15, g1_n14, g1_n13,
         g1_n12, g1_n11, g1_n10, g1_n9, g1_n8, g1_n7, g1_n6, g1_n5, g1_n4,
         g1_n3, g1_n2, g1_n1, g2_n67, g2_n66, g2_n65, g2_n64, g2_n63, g2_n62,
         g2_n61, g2_n60, g2_n59, g2_n58, g2_n57, g2_n56, g2_n55, g2_n54,
         g2_n53, g2_n52, g2_n51, g2_n50, g2_n49, g2_n48, g2_n47, g2_n46,
         g2_n45, g2_n44, g2_n43, g2_n42, g2_n41, g2_n40, g2_n39, g2_n38,
         g2_n37, g2_n36, g2_n35, g2_n34, g2_n33, g2_n32, g2_n31, g2_n30,
         g2_n29, g2_n28, g2_n27, g2_n26, g2_n25, g2_n24, g2_n23, g2_n22,
         g2_n21, g2_n20, g2_n19, g2_n18, g2_n17, g2_n16, g2_n15, g2_n14,
         g2_n13, g2_n12, g2_n11, g2_n10, g2_n9, g2_n8, g2_n7, g2_n6, g2_n5,
         g2_n4, g2_n3, g2_n2, g2_n1, g3_n51, g3_n50, g3_n49, g3_n48, g3_n47,
         g3_n46, g3_n45, g3_n44, g3_n43, g3_n42, g3_n41, g3_n40, g3_n39,
         g3_n38, g3_n37, g3_n36, g3_n35, g3_n34, g3_n33, g3_n32, g3_n31,
         g3_n30, g3_n29, g3_n28, g3_n27, g3_n26, g3_n25, g3_n24, g3_n23,
         g3_n22, g3_n21, g3_n20, g3_n19, g3_n18, g3_n17, g3_n16, g3_n15,
         g3_n14, g3_n13, g3_n12, g3_n11, g3_n10, g3_n9, g3_n8, g3_n7, g3_n6,
         g3_n5, g3_n4, g3_n3, g3_n2, g3_n1;
  wire   [3:0] g1Out;
  wire   [3:0] g2Out;
  wire   [3:0] g3Out;
  wire   [3:0] g3Reg;
  wire   [3:0] g2Reg;
  wire   [3:0] g1Reg;

  NAND2_X1 f1_U54 ( .A1(f1_n116), .A2(f1_n115), .ZN(share1[3]) );
  NOR2_X1 f1_U53 ( .A1(f1_n114), .A2(f1_n113), .ZN(f1_n116) );
  NOR2_X1 f1_U52 ( .A1(g2Reg[3]), .A2(f1_n112), .ZN(f1_n113) );
  NOR2_X1 f1_U51 ( .A1(f1_n111), .A2(f1_n110), .ZN(f1_n114) );
  NAND2_X1 f1_U50 ( .A1(f1_n109), .A2(f1_n108), .ZN(share1[2]) );
  NAND2_X1 f1_U49 ( .A1(g3Reg[3]), .A2(f1_n107), .ZN(f1_n108) );
  NAND2_X1 f1_U48 ( .A1(f1_n106), .A2(f1_n105), .ZN(f1_n107) );
  NAND2_X1 f1_U47 ( .A1(f1_n104), .A2(f1_n103), .ZN(f1_n105) );
  NAND2_X1 f1_U46 ( .A1(g2Reg[0]), .A2(g3Reg[1]), .ZN(f1_n103) );
  NAND2_X1 f1_U45 ( .A1(f1_n102), .A2(g3Reg[0]), .ZN(f1_n106) );
  XOR2_X1 f1_U44 ( .A(f1_n101), .B(g2Reg[1]), .Z(f1_n102) );
  NAND2_X1 f1_U43 ( .A1(f1_n100), .A2(g3Reg[1]), .ZN(f1_n101) );
  NAND2_X1 f1_U42 ( .A1(f1_n99), .A2(f1_n98), .ZN(f1_n109) );
  NAND2_X1 f1_U41 ( .A1(f1_n97), .A2(f1_n96), .ZN(f1_n98) );
  NAND2_X1 f1_U40 ( .A1(f1_n95), .A2(g3Reg[1]), .ZN(f1_n96) );
  XNOR2_X1 f1_U39 ( .A(f1_n94), .B(f1_n100), .ZN(f1_n95) );
  NOR2_X1 f1_U38 ( .A1(g2Reg[1]), .A2(f1_n104), .ZN(f1_n94) );
  NAND2_X1 f1_U37 ( .A1(g2Reg[1]), .A2(f1_n93), .ZN(f1_n97) );
  NOR2_X1 f1_U36 ( .A1(g3Reg[1]), .A2(f1_n104), .ZN(f1_n93) );
  NAND2_X1 f1_U35 ( .A1(f1_n92), .A2(f1_n115), .ZN(share1[1]) );
  NAND2_X1 f1_U34 ( .A1(f1_n104), .A2(f1_n91), .ZN(f1_n115) );
  XNOR2_X1 f1_U33 ( .A(f1_n90), .B(f1_n89), .ZN(f1_n91) );
  NAND2_X1 f1_U32 ( .A1(g2Reg[0]), .A2(g3Reg[3]), .ZN(f1_n89) );
  NOR2_X1 f1_U31 ( .A1(f1_n88), .A2(f1_n87), .ZN(f1_n92) );
  NOR2_X1 f1_U30 ( .A1(f1_n112), .A2(f1_n111), .ZN(f1_n87) );
  INV_X1 f1_U29 ( .A(g2Reg[3]), .ZN(f1_n111) );
  NAND2_X1 f1_U28 ( .A1(f1_n86), .A2(f1_n85), .ZN(f1_n112) );
  NAND2_X1 f1_U27 ( .A1(f1_n99), .A2(f1_n104), .ZN(f1_n85) );
  XNOR2_X1 f1_U26 ( .A(f1_n84), .B(f1_n90), .ZN(f1_n86) );
  NOR2_X1 f1_U25 ( .A1(f1_n99), .A2(g2Reg[0]), .ZN(f1_n84) );
  INV_X1 f1_U24 ( .A(g3Reg[3]), .ZN(f1_n99) );
  NOR2_X1 f1_U23 ( .A1(g2Reg[3]), .A2(f1_n110), .ZN(f1_n88) );
  NAND2_X1 f1_U22 ( .A1(f1_n83), .A2(f1_n82), .ZN(f1_n110) );
  NAND2_X1 f1_U21 ( .A1(g3Reg[3]), .A2(f1_n104), .ZN(f1_n82) );
  XNOR2_X1 f1_U20 ( .A(f1_n81), .B(f1_n90), .ZN(f1_n83) );
  XOR2_X1 f1_U19 ( .A(g3Reg[1]), .B(g3Reg[2]), .Z(f1_n90) );
  NAND2_X1 f1_U18 ( .A1(f1_n100), .A2(g3Reg[3]), .ZN(f1_n81) );
  INV_X1 f1_U17 ( .A(g2Reg[0]), .ZN(f1_n100) );
  INV_X1 f1_U16 ( .A(g3Reg[0]), .ZN(f1_n104) );
  NAND2_X1 f1_U15 ( .A1(f1_n74), .A2(f1_n80), .ZN(share1[0]) );
  NAND2_X1 f1_U14 ( .A1(g3Reg[1]), .A2(f1_n79), .ZN(f1_n80) );
  NAND2_X1 f1_U13 ( .A1(f1_n76), .A2(f1_n78), .ZN(f1_n79) );
  NAND2_X1 f1_U12 ( .A1(g3Reg[0]), .A2(f1_n77), .ZN(f1_n78) );
  INV_X1 f1_U11 ( .A(f1_n71), .ZN(f1_n77) );
  NAND2_X1 f1_U10 ( .A1(f1_n75), .A2(f1_n104), .ZN(f1_n76) );
  NAND2_X1 f1_U9 ( .A1(g2Reg[0]), .A2(g3Reg[2]), .ZN(f1_n75) );
  NAND2_X1 f1_U8 ( .A1(f1_n67), .A2(f1_n73), .ZN(f1_n74) );
  NAND2_X1 f1_U7 ( .A1(f1_n69), .A2(f1_n72), .ZN(f1_n73) );
  NAND2_X1 f1_U6 ( .A1(g3Reg[0]), .A2(f1_n71), .ZN(f1_n72) );
  XNOR2_X1 f1_U5 ( .A(f1_n70), .B(g2Reg[2]), .ZN(f1_n71) );
  NAND2_X1 f1_U4 ( .A1(g3Reg[2]), .A2(f1_n100), .ZN(f1_n70) );
  NAND2_X1 f1_U3 ( .A1(g3Reg[2]), .A2(f1_n68), .ZN(f1_n69) );
  NOR2_X1 f1_U2 ( .A1(g3Reg[0]), .A2(f1_n100), .ZN(f1_n68) );
  INV_X1 f1_U1 ( .A(g3Reg[1]), .ZN(f1_n67) );
  NAND2_X1 f2_U53 ( .A1(f2_n113), .A2(f2_n112), .ZN(share2[3]) );
  NAND2_X1 f2_U52 ( .A1(f2_n111), .A2(f2_n110), .ZN(f2_n112) );
  NOR2_X1 f2_U51 ( .A1(f2_n109), .A2(f2_n108), .ZN(f2_n113) );
  NOR2_X1 f2_U50 ( .A1(f2_n111), .A2(f2_n107), .ZN(f2_n108) );
  INV_X1 f2_U49 ( .A(g3Reg[3]), .ZN(f2_n111) );
  NAND2_X1 f2_U48 ( .A1(f2_n106), .A2(f2_n105), .ZN(share2[2]) );
  NAND2_X1 f2_U47 ( .A1(g1Reg[3]), .A2(f2_n104), .ZN(f2_n105) );
  NAND2_X1 f2_U46 ( .A1(f2_n103), .A2(f2_n102), .ZN(f2_n104) );
  NAND2_X1 f2_U45 ( .A1(f2_n101), .A2(f2_n100), .ZN(f2_n102) );
  NAND2_X1 f2_U44 ( .A1(g3Reg[0]), .A2(g1Reg[1]), .ZN(f2_n100) );
  NAND2_X1 f2_U43 ( .A1(f2_n99), .A2(g1Reg[0]), .ZN(f2_n103) );
  XOR2_X1 f2_U42 ( .A(f2_n98), .B(g3Reg[1]), .Z(f2_n99) );
  NAND2_X1 f2_U41 ( .A1(f2_n97), .A2(g1Reg[1]), .ZN(f2_n98) );
  NAND2_X1 f2_U40 ( .A1(f2_n96), .A2(f2_n95), .ZN(f2_n106) );
  NAND2_X1 f2_U39 ( .A1(f2_n94), .A2(f2_n93), .ZN(f2_n95) );
  NAND2_X1 f2_U38 ( .A1(f2_n92), .A2(g1Reg[1]), .ZN(f2_n93) );
  XNOR2_X1 f2_U37 ( .A(f2_n91), .B(f2_n97), .ZN(f2_n92) );
  NOR2_X1 f2_U36 ( .A1(g3Reg[1]), .A2(f2_n101), .ZN(f2_n91) );
  NAND2_X1 f2_U35 ( .A1(g3Reg[1]), .A2(f2_n90), .ZN(f2_n94) );
  NOR2_X1 f2_U34 ( .A1(g1Reg[1]), .A2(f2_n101), .ZN(f2_n90) );
  NAND2_X1 f2_U33 ( .A1(f2_n89), .A2(f2_n88), .ZN(share2[1]) );
  NAND2_X1 f2_U32 ( .A1(g3Reg[3]), .A2(f2_n110), .ZN(f2_n88) );
  NAND2_X1 f2_U31 ( .A1(f2_n87), .A2(f2_n86), .ZN(f2_n110) );
  NAND2_X1 f2_U30 ( .A1(g1Reg[0]), .A2(f2_n85), .ZN(f2_n86) );
  NOR2_X1 f2_U29 ( .A1(f2_n84), .A2(f2_n83), .ZN(f2_n85) );
  NAND2_X1 f2_U28 ( .A1(f2_n84), .A2(f2_n83), .ZN(f2_n87) );
  NOR2_X1 f2_U27 ( .A1(f2_n109), .A2(f2_n82), .ZN(f2_n89) );
  NOR2_X1 f2_U26 ( .A1(g3Reg[3]), .A2(f2_n107), .ZN(f2_n82) );
  NAND2_X1 f2_U25 ( .A1(f2_n81), .A2(g1Reg[0]), .ZN(f2_n107) );
  XOR2_X1 f2_U24 ( .A(f2_n84), .B(f2_n83), .Z(f2_n81) );
  NOR2_X1 f2_U23 ( .A1(f2_n96), .A2(g3Reg[0]), .ZN(f2_n83) );
  INV_X1 f2_U22 ( .A(g1Reg[3]), .ZN(f2_n96) );
  NOR2_X1 f2_U21 ( .A1(g1Reg[0]), .A2(f2_n80), .ZN(f2_n109) );
  XOR2_X1 f2_U20 ( .A(f2_n84), .B(f2_n79), .Z(f2_n80) );
  NAND2_X1 f2_U19 ( .A1(g3Reg[0]), .A2(g1Reg[3]), .ZN(f2_n79) );
  XOR2_X1 f2_U18 ( .A(g1Reg[1]), .B(g1Reg[2]), .Z(f2_n84) );
  INV_X1 f2_U17 ( .A(g1Reg[0]), .ZN(f2_n101) );
  INV_X1 f2_U16 ( .A(g3Reg[0]), .ZN(f2_n97) );
  NAND2_X1 f2_U15 ( .A1(f2_n72), .A2(f2_n78), .ZN(share2[0]) );
  NAND2_X1 f2_U14 ( .A1(g1Reg[1]), .A2(f2_n77), .ZN(f2_n78) );
  NAND2_X1 f2_U13 ( .A1(f2_n74), .A2(f2_n76), .ZN(f2_n77) );
  NAND2_X1 f2_U12 ( .A1(g1Reg[0]), .A2(f2_n75), .ZN(f2_n76) );
  INV_X1 f2_U11 ( .A(f2_n69), .ZN(f2_n75) );
  NAND2_X1 f2_U10 ( .A1(f2_n73), .A2(f2_n101), .ZN(f2_n74) );
  NAND2_X1 f2_U9 ( .A1(g3Reg[0]), .A2(g1Reg[2]), .ZN(f2_n73) );
  NAND2_X1 f2_U8 ( .A1(f2_n65), .A2(f2_n71), .ZN(f2_n72) );
  NAND2_X1 f2_U7 ( .A1(f2_n67), .A2(f2_n70), .ZN(f2_n71) );
  NAND2_X1 f2_U6 ( .A1(g1Reg[0]), .A2(f2_n69), .ZN(f2_n70) );
  XNOR2_X1 f2_U5 ( .A(f2_n68), .B(g3Reg[2]), .ZN(f2_n69) );
  NAND2_X1 f2_U4 ( .A1(g1Reg[2]), .A2(f2_n97), .ZN(f2_n68) );
  NAND2_X1 f2_U3 ( .A1(g1Reg[2]), .A2(f2_n66), .ZN(f2_n67) );
  NOR2_X1 f2_U2 ( .A1(g1Reg[0]), .A2(f2_n97), .ZN(f2_n66) );
  INV_X1 f2_U1 ( .A(g1Reg[1]), .ZN(f2_n65) );
  NAND2_X1 f3_U54 ( .A1(f3_n116), .A2(f3_n115), .ZN(share3[3]) );
  NOR2_X1 f3_U53 ( .A1(f3_n114), .A2(f3_n113), .ZN(f3_n116) );
  NOR2_X1 f3_U52 ( .A1(g1Reg[3]), .A2(f3_n112), .ZN(f3_n113) );
  NOR2_X1 f3_U51 ( .A1(f3_n111), .A2(f3_n110), .ZN(f3_n114) );
  NAND2_X1 f3_U50 ( .A1(f3_n109), .A2(f3_n108), .ZN(share3[2]) );
  NAND2_X1 f3_U49 ( .A1(g2Reg[3]), .A2(f3_n107), .ZN(f3_n108) );
  NAND2_X1 f3_U48 ( .A1(f3_n106), .A2(f3_n105), .ZN(f3_n107) );
  NAND2_X1 f3_U47 ( .A1(f3_n104), .A2(f3_n103), .ZN(f3_n105) );
  NAND2_X1 f3_U46 ( .A1(g1Reg[0]), .A2(g2Reg[1]), .ZN(f3_n103) );
  NAND2_X1 f3_U45 ( .A1(f3_n102), .A2(g2Reg[0]), .ZN(f3_n106) );
  XOR2_X1 f3_U44 ( .A(f3_n101), .B(g1Reg[1]), .Z(f3_n102) );
  NAND2_X1 f3_U43 ( .A1(f3_n100), .A2(g2Reg[1]), .ZN(f3_n101) );
  NAND2_X1 f3_U42 ( .A1(f3_n99), .A2(f3_n98), .ZN(f3_n109) );
  NAND2_X1 f3_U41 ( .A1(f3_n97), .A2(f3_n96), .ZN(f3_n98) );
  NAND2_X1 f3_U40 ( .A1(f3_n95), .A2(g2Reg[1]), .ZN(f3_n96) );
  XNOR2_X1 f3_U39 ( .A(f3_n94), .B(f3_n100), .ZN(f3_n95) );
  NOR2_X1 f3_U38 ( .A1(g1Reg[1]), .A2(f3_n104), .ZN(f3_n94) );
  NAND2_X1 f3_U37 ( .A1(g1Reg[1]), .A2(f3_n93), .ZN(f3_n97) );
  NOR2_X1 f3_U36 ( .A1(g2Reg[1]), .A2(f3_n104), .ZN(f3_n93) );
  NAND2_X1 f3_U35 ( .A1(f3_n92), .A2(f3_n115), .ZN(share3[1]) );
  NAND2_X1 f3_U34 ( .A1(f3_n104), .A2(f3_n91), .ZN(f3_n115) );
  XNOR2_X1 f3_U33 ( .A(f3_n90), .B(f3_n89), .ZN(f3_n91) );
  NAND2_X1 f3_U32 ( .A1(g1Reg[0]), .A2(g2Reg[3]), .ZN(f3_n89) );
  NOR2_X1 f3_U31 ( .A1(f3_n88), .A2(f3_n87), .ZN(f3_n92) );
  NOR2_X1 f3_U30 ( .A1(f3_n112), .A2(f3_n111), .ZN(f3_n87) );
  INV_X1 f3_U29 ( .A(g1Reg[3]), .ZN(f3_n111) );
  NAND2_X1 f3_U28 ( .A1(f3_n86), .A2(f3_n85), .ZN(f3_n112) );
  NAND2_X1 f3_U27 ( .A1(f3_n99), .A2(f3_n104), .ZN(f3_n85) );
  XNOR2_X1 f3_U26 ( .A(f3_n84), .B(f3_n90), .ZN(f3_n86) );
  NOR2_X1 f3_U25 ( .A1(f3_n99), .A2(g1Reg[0]), .ZN(f3_n84) );
  INV_X1 f3_U24 ( .A(g2Reg[3]), .ZN(f3_n99) );
  NOR2_X1 f3_U23 ( .A1(g1Reg[3]), .A2(f3_n110), .ZN(f3_n88) );
  NAND2_X1 f3_U22 ( .A1(f3_n83), .A2(f3_n82), .ZN(f3_n110) );
  NAND2_X1 f3_U21 ( .A1(g2Reg[3]), .A2(f3_n104), .ZN(f3_n82) );
  XNOR2_X1 f3_U20 ( .A(f3_n81), .B(f3_n90), .ZN(f3_n83) );
  XOR2_X1 f3_U19 ( .A(g2Reg[1]), .B(g2Reg[2]), .Z(f3_n90) );
  NAND2_X1 f3_U18 ( .A1(f3_n100), .A2(g2Reg[3]), .ZN(f3_n81) );
  INV_X1 f3_U17 ( .A(g1Reg[0]), .ZN(f3_n100) );
  INV_X1 f3_U16 ( .A(g2Reg[0]), .ZN(f3_n104) );
  NAND2_X1 f3_U15 ( .A1(f3_n79), .A2(f3_n80), .ZN(share3[0]) );
  NAND2_X1 f3_U14 ( .A1(g2Reg[1]), .A2(f3_n76), .ZN(f3_n80) );
  NAND2_X1 f3_U13 ( .A1(f3_n77), .A2(f3_n78), .ZN(f3_n79) );
  NAND2_X1 f3_U12 ( .A1(f3_n71), .A2(f3_n69), .ZN(f3_n78) );
  INV_X1 f3_U11 ( .A(g2Reg[1]), .ZN(f3_n77) );
  NAND2_X1 f3_U10 ( .A1(f3_n75), .A2(f3_n73), .ZN(f3_n76) );
  NAND2_X1 f3_U9 ( .A1(f3_n74), .A2(f3_n104), .ZN(f3_n75) );
  NAND2_X1 f3_U8 ( .A1(g1Reg[0]), .A2(g2Reg[2]), .ZN(f3_n74) );
  NAND2_X1 f3_U7 ( .A1(g2Reg[0]), .A2(f3_n72), .ZN(f3_n73) );
  INV_X1 f3_U6 ( .A(f3_n68), .ZN(f3_n72) );
  NAND2_X1 f3_U5 ( .A1(g2Reg[2]), .A2(f3_n70), .ZN(f3_n71) );
  NOR2_X1 f3_U4 ( .A1(g2Reg[0]), .A2(f3_n100), .ZN(f3_n70) );
  NAND2_X1 f3_U3 ( .A1(g2Reg[0]), .A2(f3_n68), .ZN(f3_n69) );
  XNOR2_X1 f3_U2 ( .A(f3_n67), .B(g1Reg[2]), .ZN(f3_n68) );
  NAND2_X1 f3_U1 ( .A1(g2Reg[2]), .A2(f3_n100), .ZN(f3_n67) );
  XNOR2_X1 g1_U54 ( .A(sboxIn2[0]), .B(g1Out[2]), .ZN(g1Out[3]) );
  XOR2_X1 g1_U53 ( .A(sboxIn2[3]), .B(g1_n50), .Z(g1Out[1]) );
  NAND2_X1 g1_U52 ( .A1(g1_n49), .A2(g1_n48), .ZN(g1_n50) );
  NAND2_X1 g1_U51 ( .A1(g1_n47), .A2(g1_n46), .ZN(g1_n48) );
  NAND2_X1 g1_U50 ( .A1(g1_n45), .A2(g1_n44), .ZN(g1_n47) );
  NAND2_X1 g1_U49 ( .A1(sboxIn3[0]), .A2(g1_n43), .ZN(g1_n44) );
  NAND2_X1 g1_U48 ( .A1(g1_n42), .A2(g1_n41), .ZN(g1_n45) );
  NAND2_X1 g1_U47 ( .A1(g1_n40), .A2(sboxIn2[0]), .ZN(g1_n49) );
  XNOR2_X1 g1_U46 ( .A(g1_n39), .B(g1_n38), .ZN(g1_n40) );
  NOR2_X1 g1_U45 ( .A1(g1_n37), .A2(g1_n36), .ZN(g1_n38) );
  NOR2_X1 g1_U44 ( .A1(g1_n42), .A2(g1_n41), .ZN(g1_n36) );
  INV_X1 g1_U43 ( .A(sboxIn3[0]), .ZN(g1_n42) );
  NOR2_X1 g1_U42 ( .A1(sboxIn3[0]), .A2(g1_n43), .ZN(g1_n37) );
  NAND2_X1 g1_U41 ( .A1(g1_n35), .A2(g1_n34), .ZN(g1Out[0]) );
  NAND2_X1 g1_U40 ( .A1(g1_n33), .A2(g1_n46), .ZN(g1_n34) );
  INV_X1 g1_U39 ( .A(sboxIn2[0]), .ZN(g1_n46) );
  NAND2_X1 g1_U38 ( .A1(g1_n32), .A2(g1_n31), .ZN(g1_n33) );
  NOR2_X1 g1_U37 ( .A1(g1_n30), .A2(g1_n29), .ZN(g1_n31) );
  NOR2_X1 g1_U36 ( .A1(g1_n28), .A2(g1_n27), .ZN(g1_n29) );
  NOR2_X1 g1_U35 ( .A1(sboxIn2[3]), .A2(g1_n26), .ZN(g1_n30) );
  NOR2_X1 g1_U34 ( .A1(g1_n25), .A2(g1_n24), .ZN(g1_n26) );
  NOR2_X1 g1_U33 ( .A1(sboxIn2[1]), .A2(g1_n23), .ZN(g1_n24) );
  NAND2_X1 g1_U32 ( .A1(g1_n22), .A2(g1_n21), .ZN(g1_n25) );
  OR2_X1 g1_U31 ( .A1(g1_n20), .A2(sboxIn2[2]), .ZN(g1_n21) );
  NAND2_X1 g1_U30 ( .A1(g1_n19), .A2(g1_n28), .ZN(g1_n22) );
  NAND2_X1 g1_U29 ( .A1(g1_n18), .A2(sboxIn2[3]), .ZN(g1_n32) );
  NAND2_X1 g1_U28 ( .A1(g1_n17), .A2(g1_n16), .ZN(g1_n18) );
  NAND2_X1 g1_U27 ( .A1(g1_n15), .A2(g1_n23), .ZN(g1_n16) );
  NAND2_X1 g1_U26 ( .A1(g1_n14), .A2(g1_n20), .ZN(g1_n17) );
  NAND2_X1 g1_U25 ( .A1(g1_n13), .A2(sboxIn2[0]), .ZN(g1_n35) );
  NAND2_X1 g1_U24 ( .A1(g1_n12), .A2(g1_n11), .ZN(g1_n13) );
  NOR2_X1 g1_U23 ( .A1(g1_n10), .A2(g1_n9), .ZN(g1_n11) );
  AND2_X1 g1_U22 ( .A1(g1_n19), .A2(g1_n39), .ZN(g1_n9) );
  NOR2_X1 g1_U21 ( .A1(g1_n41), .A2(g1_n43), .ZN(g1_n19) );
  NOR2_X1 g1_U20 ( .A1(sboxIn2[3]), .A2(g1_n8), .ZN(g1_n10) );
  NOR2_X1 g1_U19 ( .A1(g1_n7), .A2(g1_n6), .ZN(g1_n8) );
  AND2_X1 g1_U18 ( .A1(g1_n23), .A2(g1_n14), .ZN(g1_n6) );
  AND2_X1 g1_U17 ( .A1(g1_n20), .A2(g1_n15), .ZN(g1_n7) );
  NAND2_X1 g1_U16 ( .A1(g1_n5), .A2(sboxIn2[3]), .ZN(g1_n12) );
  NAND2_X1 g1_U15 ( .A1(g1_n4), .A2(g1_n3), .ZN(g1_n5) );
  NOR2_X1 g1_U14 ( .A1(g1_n2), .A2(g1_n1), .ZN(g1_n3) );
  NOR2_X1 g1_U13 ( .A1(g1_n39), .A2(g1_n27), .ZN(g1_n1) );
  NAND2_X1 g1_U12 ( .A1(g1_n41), .A2(g1_n43), .ZN(g1_n27) );
  INV_X1 g1_U11 ( .A(g1_n28), .ZN(g1_n39) );
  XOR2_X1 g1_U10 ( .A(sboxIn3[1]), .B(sboxIn3[2]), .Z(g1_n28) );
  NOR2_X1 g1_U9 ( .A1(g1_n43), .A2(g1_n20), .ZN(g1_n2) );
  XOR2_X1 g1_U8 ( .A(sboxIn3[3]), .B(sboxIn3[2]), .Z(g1_n20) );
  OR2_X1 g1_U7 ( .A1(g1_n23), .A2(g1_n41), .ZN(g1_n4) );
  XOR2_X1 g1_U6 ( .A(sboxIn3[1]), .B(sboxIn3[3]), .Z(g1_n23) );
  NOR2_X1 g1_U5 ( .A1(g1_n15), .A2(g1_n14), .ZN(g1Out[2]) );
  NOR2_X1 g1_U4 ( .A1(g1_n43), .A2(sboxIn2[1]), .ZN(g1_n14) );
  NOR2_X1 g1_U3 ( .A1(g1_n41), .A2(sboxIn2[2]), .ZN(g1_n15) );
  INV_X1 g1_U2 ( .A(sboxIn2[1]), .ZN(g1_n41) );
  INV_X1 g1_U1 ( .A(sboxIn2[2]), .ZN(g1_n43) );
  XOR2_X1 g2_U71 ( .A(sboxIn3[0]), .B(g2Out[2]), .Z(g2Out[3]) );
  NAND2_X1 g2_U70 ( .A1(g2_n67), .A2(g2_n66), .ZN(g2Out[2]) );
  NAND2_X1 g2_U69 ( .A1(g2_n65), .A2(g2_n64), .ZN(g2Out[1]) );
  NAND2_X1 g2_U68 ( .A1(g2_n63), .A2(g2_n62), .ZN(g2_n64) );
  INV_X1 g2_U67 ( .A(sboxIn1[0]), .ZN(g2_n62) );
  NAND2_X1 g2_U66 ( .A1(g2_n61), .A2(g2_n60), .ZN(g2_n63) );
  NAND2_X1 g2_U65 ( .A1(g2_n59), .A2(g2_n58), .ZN(g2_n60) );
  XNOR2_X1 g2_U64 ( .A(g2_n57), .B(sboxIn3[1]), .ZN(g2_n59) );
  NAND2_X1 g2_U63 ( .A1(sboxIn3[0]), .A2(g2_n56), .ZN(g2_n61) );
  XOR2_X1 g2_U62 ( .A(g2_n55), .B(g2_n54), .Z(g2_n56) );
  NAND2_X1 g2_U61 ( .A1(g2_n53), .A2(sboxIn1[0]), .ZN(g2_n65) );
  NAND2_X1 g2_U60 ( .A1(g2_n52), .A2(g2_n51), .ZN(g2_n53) );
  NAND2_X1 g2_U59 ( .A1(g2_n50), .A2(g2_n58), .ZN(g2_n51) );
  XNOR2_X1 g2_U58 ( .A(g2_n55), .B(sboxIn3[3]), .ZN(g2_n50) );
  NAND2_X1 g2_U57 ( .A1(g2_n49), .A2(sboxIn3[0]), .ZN(g2_n52) );
  XOR2_X1 g2_U56 ( .A(g2_n48), .B(g2_n54), .Z(g2_n49) );
  XOR2_X1 g2_U55 ( .A(g2_n57), .B(g2_n47), .Z(g2_n54) );
  NAND2_X1 g2_U54 ( .A1(g2_n46), .A2(g2_n45), .ZN(g2Out[0]) );
  NAND2_X1 g2_U53 ( .A1(g2_n44), .A2(sboxIn1[3]), .ZN(g2_n45) );
  NAND2_X1 g2_U52 ( .A1(g2_n43), .A2(g2_n42), .ZN(g2_n44) );
  NOR2_X1 g2_U51 ( .A1(g2_n41), .A2(g2_n40), .ZN(g2_n42) );
  NOR2_X1 g2_U50 ( .A1(sboxIn1[1]), .A2(g2_n39), .ZN(g2_n40) );
  NAND2_X1 g2_U49 ( .A1(g2_n38), .A2(g2_n37), .ZN(g2_n41) );
  OR2_X1 g2_U48 ( .A1(g2_n36), .A2(g2_n35), .ZN(g2_n37) );
  NAND2_X1 g2_U47 ( .A1(g2_n36), .A2(g2_n34), .ZN(g2_n38) );
  OR2_X1 g2_U46 ( .A1(g2_n33), .A2(g2_n32), .ZN(g2_n43) );
  NOR2_X1 g2_U45 ( .A1(g2_n31), .A2(g2_n30), .ZN(g2_n46) );
  NOR2_X1 g2_U44 ( .A1(sboxIn1[3]), .A2(g2_n29), .ZN(g2_n30) );
  NOR2_X1 g2_U43 ( .A1(g2_n28), .A2(g2_n27), .ZN(g2_n29) );
  NOR2_X1 g2_U42 ( .A1(g2_n32), .A2(g2_n39), .ZN(g2_n27) );
  NOR2_X1 g2_U41 ( .A1(g2_n26), .A2(g2_n25), .ZN(g2_n39) );
  NOR2_X1 g2_U40 ( .A1(g2_n24), .A2(g2_n67), .ZN(g2_n25) );
  NOR2_X1 g2_U39 ( .A1(g2_n23), .A2(g2_n66), .ZN(g2_n26) );
  NAND2_X1 g2_U38 ( .A1(g2_n22), .A2(g2_n21), .ZN(g2_n28) );
  NOR2_X1 g2_U37 ( .A1(g2_n20), .A2(g2_n19), .ZN(g2_n21) );
  NOR2_X1 g2_U36 ( .A1(sboxIn1[1]), .A2(g2_n33), .ZN(g2_n19) );
  NOR2_X1 g2_U35 ( .A1(g2_n18), .A2(g2_n17), .ZN(g2_n33) );
  NOR2_X1 g2_U34 ( .A1(g2_n48), .A2(g2_n16), .ZN(g2_n17) );
  NOR2_X1 g2_U33 ( .A1(sboxIn3[1]), .A2(g2_n15), .ZN(g2_n18) );
  NOR2_X1 g2_U32 ( .A1(sboxIn1[2]), .A2(g2_n35), .ZN(g2_n20) );
  NOR2_X1 g2_U31 ( .A1(g2_n14), .A2(g2_n13), .ZN(g2_n35) );
  NOR2_X1 g2_U30 ( .A1(g2_n16), .A2(g2_n55), .ZN(g2_n13) );
  NOR2_X1 g2_U29 ( .A1(sboxIn3[2]), .A2(g2_n15), .ZN(g2_n14) );
  NAND2_X1 g2_U28 ( .A1(sboxIn1[2]), .A2(g2_n34), .ZN(g2_n22) );
  NAND2_X1 g2_U27 ( .A1(g2_n58), .A2(g2_n57), .ZN(g2_n24) );
  NAND2_X1 g2_U26 ( .A1(g2_n55), .A2(sboxIn3[1]), .ZN(g2_n66) );
  NAND2_X1 g2_U25 ( .A1(g2_n48), .A2(sboxIn3[2]), .ZN(g2_n67) );
  NAND2_X1 g2_U24 ( .A1(sboxIn3[0]), .A2(sboxIn3[3]), .ZN(g2_n23) );
  NAND2_X1 g2_U23 ( .A1(g2_n12), .A2(g2_n11), .ZN(g2_n31) );
  NAND2_X1 g2_U22 ( .A1(g2_n10), .A2(g2_n9), .ZN(g2_n11) );
  NOR2_X1 g2_U21 ( .A1(sboxIn3[2]), .A2(g2_n8), .ZN(g2_n10) );
  NAND2_X1 g2_U20 ( .A1(g2_n48), .A2(g2_n7), .ZN(g2_n8) );
  NAND2_X1 g2_U19 ( .A1(g2_n47), .A2(g2_n16), .ZN(g2_n7) );
  NAND2_X1 g2_U18 ( .A1(sboxIn3[3]), .A2(g2_n58), .ZN(g2_n16) );
  INV_X1 g2_U17 ( .A(g2_n6), .ZN(g2_n47) );
  NAND2_X1 g2_U16 ( .A1(g2_n5), .A2(g2_n4), .ZN(g2_n12) );
  NOR2_X1 g2_U15 ( .A1(g2_n55), .A2(g2_n48), .ZN(g2_n4) );
  NAND2_X1 g2_U14 ( .A1(g2_n3), .A2(g2_n9), .ZN(g2_n5) );
  NAND2_X1 g2_U13 ( .A1(g2_n58), .A2(g2_n6), .ZN(g2_n9) );
  INV_X1 g2_U12 ( .A(sboxIn3[0]), .ZN(g2_n58) );
  OR2_X1 g2_U11 ( .A1(g2_n6), .A2(g2_n15), .ZN(g2_n3) );
  NAND2_X1 g2_U10 ( .A1(g2_n57), .A2(sboxIn3[0]), .ZN(g2_n15) );
  INV_X1 g2_U9 ( .A(sboxIn3[3]), .ZN(g2_n57) );
  XNOR2_X1 g2_U8 ( .A(g2_n32), .B(g2_n36), .ZN(g2_n6) );
  INV_X1 g2_U7 ( .A(sboxIn1[2]), .ZN(g2_n36) );
  INV_X1 g2_U6 ( .A(sboxIn1[1]), .ZN(g2_n32) );
  INV_X1 g2_U5 ( .A(sboxIn3[1]), .ZN(g2_n48) );
  INV_X1 g2_U4 ( .A(sboxIn3[2]), .ZN(g2_n55) );
  OR2_X1 g2_U3 ( .A1(g2_n1), .A2(g2_n2), .ZN(g2_n34) );
  NOR2_X1 g2_U2 ( .A1(g2_n67), .A2(g2_n23), .ZN(g2_n2) );
  NOR2_X1 g2_U1 ( .A1(g2_n66), .A2(g2_n24), .ZN(g2_n1) );
  XOR2_X1 g3_U55 ( .A(sboxIn1[0]), .B(g3Out[2]), .Z(g3Out[3]) );
  NAND2_X1 g3_U54 ( .A1(g3_n51), .A2(g3_n50), .ZN(g3Out[2]) );
  NAND2_X1 g3_U53 ( .A1(g3_n49), .A2(g3_n48), .ZN(g3Out[1]) );
  NAND2_X1 g3_U52 ( .A1(g3_n47), .A2(g3_n46), .ZN(g3_n48) );
  NAND2_X1 g3_U51 ( .A1(g3_n45), .A2(g3_n44), .ZN(g3_n47) );
  NAND2_X1 g3_U50 ( .A1(sboxIn2[0]), .A2(g3_n43), .ZN(g3_n44) );
  NAND2_X1 g3_U49 ( .A1(g3_n42), .A2(g3_n41), .ZN(g3_n45) );
  NAND2_X1 g3_U48 ( .A1(g3_n40), .A2(sboxIn1[0]), .ZN(g3_n49) );
  XOR2_X1 g3_U47 ( .A(g3_n39), .B(g3_n38), .Z(g3_n40) );
  NOR2_X1 g3_U46 ( .A1(g3_n37), .A2(g3_n36), .ZN(g3_n38) );
  NOR2_X1 g3_U45 ( .A1(g3_n41), .A2(g3_n42), .ZN(g3_n36) );
  INV_X1 g3_U44 ( .A(sboxIn2[0]), .ZN(g3_n42) );
  XOR2_X1 g3_U43 ( .A(sboxIn1[3]), .B(sboxIn1[1]), .Z(g3_n41) );
  NOR2_X1 g3_U42 ( .A1(sboxIn2[0]), .A2(g3_n43), .ZN(g3_n37) );
  XOR2_X1 g3_U41 ( .A(sboxIn1[3]), .B(sboxIn1[2]), .Z(g3_n43) );
  AND2_X1 g3_U40 ( .A1(g3_n32), .A2(g3_n31), .ZN(g3_n33) );
  NAND2_X1 g3_U39 ( .A1(g3_n30), .A2(g3_n29), .ZN(g3_n34) );
  NAND2_X1 g3_U38 ( .A1(g3_n28), .A2(g3_n27), .ZN(g3_n29) );
  NAND2_X1 g3_U37 ( .A1(g3_n26), .A2(g3_n39), .ZN(g3_n30) );
  INV_X1 g3_U36 ( .A(g3_n25), .ZN(g3_n39) );
  INV_X1 g3_U35 ( .A(sboxIn1[0]), .ZN(g3_n46) );
  NOR2_X1 g3_U34 ( .A1(g3_n32), .A2(g3_n27), .ZN(g3_n26) );
  NOR2_X1 g3_U33 ( .A1(g3_n23), .A2(g3_n22), .ZN(g3_n24) );
  NOR2_X1 g3_U32 ( .A1(g3_n51), .A2(g3_n31), .ZN(g3_n22) );
  NAND2_X1 g3_U31 ( .A1(sboxIn1[1]), .A2(g3_n32), .ZN(g3_n51) );
  NOR2_X1 g3_U30 ( .A1(g3_n28), .A2(g3_n50), .ZN(g3_n23) );
  NAND2_X1 g3_U29 ( .A1(sboxIn1[2]), .A2(g3_n27), .ZN(g3_n50) );
  NOR2_X1 g3_U28 ( .A1(g3_n25), .A2(g3_n35), .ZN(g3_n20) );
  NAND2_X1 g3_U27 ( .A1(g3_n32), .A2(g3_n27), .ZN(g3_n35) );
  INV_X1 g3_U26 ( .A(sboxIn1[1]), .ZN(g3_n27) );
  INV_X1 g3_U25 ( .A(sboxIn1[2]), .ZN(g3_n32) );
  XNOR2_X1 g3_U24 ( .A(sboxIn2[1]), .B(sboxIn2[2]), .ZN(g3_n25) );
  AND2_X1 g3_U23 ( .A1(sboxIn1[1]), .A2(g3_n28), .ZN(g3_n21) );
  XNOR2_X1 g3_U22 ( .A(sboxIn2[1]), .B(sboxIn2[3]), .ZN(g3_n28) );
  XNOR2_X1 g3_U21 ( .A(sboxIn2[3]), .B(sboxIn2[2]), .ZN(g3_n31) );
  NAND2_X1 g3_U20 ( .A1(g3_n18), .A2(g3_n19), .ZN(g3Out[0]) );
  NAND2_X1 g3_U19 ( .A1(g3_n46), .A2(g3_n8), .ZN(g3_n19) );
  NAND2_X1 g3_U18 ( .A1(sboxIn1[0]), .A2(g3_n17), .ZN(g3_n18) );
  NAND2_X1 g3_U17 ( .A1(g3_n12), .A2(g3_n16), .ZN(g3_n17) );
  NAND2_X1 g3_U16 ( .A1(sboxIn1[3]), .A2(g3_n15), .ZN(g3_n16) );
  OR2_X1 g3_U15 ( .A1(g3_n13), .A2(g3_n14), .ZN(g3_n15) );
  NOR2_X1 g3_U14 ( .A1(g3_n31), .A2(g3_n50), .ZN(g3_n14) );
  NOR2_X1 g3_U13 ( .A1(g3_n28), .A2(g3_n51), .ZN(g3_n13) );
  NOR2_X1 g3_U12 ( .A1(g3_n10), .A2(g3_n11), .ZN(g3_n12) );
  NOR2_X1 g3_U11 ( .A1(g3_n35), .A2(g3_n39), .ZN(g3_n11) );
  NOR2_X1 g3_U10 ( .A1(sboxIn1[3]), .A2(g3_n9), .ZN(g3_n10) );
  NOR2_X1 g3_U9 ( .A1(g3_n34), .A2(g3_n33), .ZN(g3_n9) );
  NAND2_X1 g3_U8 ( .A1(g3_n3), .A2(g3_n7), .ZN(g3_n8) );
  NAND2_X1 g3_U7 ( .A1(g3_n6), .A2(sboxIn1[3]), .ZN(g3_n7) );
  NAND2_X1 g3_U6 ( .A1(g3_n5), .A2(g3_n4), .ZN(g3_n6) );
  NAND2_X1 g3_U5 ( .A1(g3_n31), .A2(sboxIn1[2]), .ZN(g3_n5) );
  NOR2_X1 g3_U4 ( .A1(g3_n21), .A2(g3_n20), .ZN(g3_n4) );
  NOR2_X1 g3_U3 ( .A1(g3_n1), .A2(g3_n2), .ZN(g3_n3) );
  NOR2_X1 g3_U2 ( .A1(sboxIn1[3]), .A2(g3_n24), .ZN(g3_n2) );
  AND2_X1 g3_U1 ( .A1(g3_n25), .A2(g3_n26), .ZN(g3_n1) );
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

