// ----------------------------------------------------------------------------
// Provided by the authors of https://eprint.iacr.org/2018/922
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
// Copyright Message
// ----------------------------------------------------------------------------
//
// 
// COPYRIGHT (c) NXP B.V. 2018
//
// All rights are reserved.
//
// Author Dušan Boilov
// ----------------------------------------------------------------------------

module CMSSbox(
    in_1,
    in_2,
    i_clk,
    i_r,
    out_1,
    out_2
);

input[3:0]  in_1;
input[3:0]  in_2;
input       i_clk;
input[11:0] i_r;
output[3:0] out_1;
output[3:0] out_2;

//Sbox output register and next value

wire  sbox_out1_b1;
wire  sbox_out2_b1;
wire  sbox_out3_b1;
wire  sbox_out4_b1;
wire  sbox_out5_b1;
wire  sbox_out6_b1;
wire  sbox_out7_b1;
wire  sbox_out8_b1;
                       
wire  sbox_out1_b2;
wire  sbox_out2_b2;
wire  sbox_out3_b2;
wire  sbox_out4_b2;
wire  sbox_out5_b2;
wire  sbox_out6_b2;
wire  sbox_out7_b2;
wire  sbox_out8_b2;
                       
wire  sbox_out1_b3;
wire  sbox_out2_b3;
wire  sbox_out3_b3;
wire  sbox_out4_b3;
wire  sbox_out5_b3;
wire  sbox_out6_b3;
wire  sbox_out7_b3;
wire  sbox_out8_b3;
                       
wire  sbox_out1_b4;
wire  sbox_out2_b4;
wire  sbox_out3_b4;
wire  sbox_out4_b4;
wire  sbox_out5_b4;
wire  sbox_out6_b4;
wire  sbox_out7_b4;
wire  sbox_out8_b4;

//Remasked values
wire  out_b1_reg_next1;
wire  out_b1_reg_next2;
wire  out_b1_reg_next3;
wire  out_b1_reg_next4;
wire  out_b1_reg_next5;
wire  out_b1_reg_next6;
wire  out_b1_reg_next7;
wire  out_b1_reg_next8;

wire  out_b2_reg_next1;
wire  out_b2_reg_next2;
wire  out_b2_reg_next3;
wire  out_b2_reg_next4;
wire  out_b2_reg_next5;
wire  out_b2_reg_next6;
wire  out_b2_reg_next7;
wire  out_b2_reg_next8;

wire  out_b3_reg_next1;
wire  out_b3_reg_next2;
wire  out_b3_reg_next3;
wire  out_b3_reg_next4;
wire  out_b3_reg_next5;
wire  out_b3_reg_next6;
wire  out_b3_reg_next7;
wire  out_b3_reg_next8;

wire  out_b4_reg_next1;
wire  out_b4_reg_next2;
wire  out_b4_reg_next3;
wire  out_b4_reg_next4;
wire  out_b4_reg_next5;
wire  out_b4_reg_next6;
wire  out_b4_reg_next7;
wire  out_b4_reg_next8;


wire  out_b1_reg_out1;
wire  out_b1_reg_out2;
wire  out_b1_reg_out3;
wire  out_b1_reg_out4;
wire  out_b1_reg_out5;
wire  out_b1_reg_out6;
wire  out_b1_reg_out7;
wire  out_b1_reg_out8;

wire  out_b2_reg_out1;
wire  out_b2_reg_out2;
wire  out_b2_reg_out3;
wire  out_b2_reg_out4;
wire  out_b2_reg_out5;
wire  out_b2_reg_out6;
wire  out_b2_reg_out7;
wire  out_b2_reg_out8;

wire  out_b3_reg_out1;
wire  out_b3_reg_out2;
wire  out_b3_reg_out3;
wire  out_b3_reg_out4;
wire  out_b3_reg_out5;
wire  out_b3_reg_out6;
wire  out_b3_reg_out7;
wire  out_b3_reg_out8;

wire  out_b4_reg_out1;
wire  out_b4_reg_out2;
wire  out_b4_reg_out3;
wire  out_b4_reg_out4;
wire  out_b4_reg_out5;
wire  out_b4_reg_out6;
wire  out_b4_reg_out7;
wire  out_b4_reg_out8;

wire [3 : 0] comp_sh1;
wire [3 : 0] comp_sh2;

    s SBOX_ITK(
        .in1 (in_1),
        .in2 (in_2),
        .out1({sbox_out8_b1,sbox_out7_b1,sbox_out6_b1,sbox_out5_b1,sbox_out4_b1,sbox_out3_b1,sbox_out2_b1,sbox_out1_b1}),
        .out2({sbox_out8_b2,sbox_out7_b2,sbox_out6_b2,sbox_out5_b2,sbox_out4_b2,sbox_out3_b2,sbox_out2_b2,sbox_out1_b2}),
        .out3({sbox_out8_b3,sbox_out7_b3,sbox_out6_b3,sbox_out5_b3,sbox_out4_b3,sbox_out3_b3,sbox_out2_b3,sbox_out1_b3}),
        .out4({sbox_out8_b4,sbox_out7_b4,sbox_out6_b4,sbox_out5_b4,sbox_out4_b4,sbox_out3_b4,sbox_out2_b4,sbox_out1_b4})
    );

    sbox_rmsk srmsk(
        .in1({sbox_out8_b1,sbox_out7_b1,sbox_out6_b1,sbox_out5_b1,sbox_out4_b1,sbox_out3_b1,sbox_out2_b1,sbox_out1_b1}),
        .in2({sbox_out8_b2,sbox_out7_b2,sbox_out6_b2,sbox_out5_b2,sbox_out4_b2,sbox_out3_b2,sbox_out2_b2,sbox_out1_b2}),
        .in3({sbox_out8_b3,sbox_out7_b3,sbox_out6_b3,sbox_out5_b3,sbox_out4_b3,sbox_out3_b3,sbox_out2_b3,sbox_out1_b3}),
        .in4({sbox_out8_b4,sbox_out7_b4,sbox_out6_b4,sbox_out5_b4,sbox_out4_b4,sbox_out3_b4,sbox_out2_b4,sbox_out1_b4}),
        .in_rand (i_r),
        .out1({out_b1_reg_next8,out_b1_reg_next7,out_b1_reg_next6,out_b1_reg_next5,out_b1_reg_next4,out_b1_reg_next3,out_b1_reg_next2,out_b1_reg_next1}),
        .out2({out_b2_reg_next8,out_b2_reg_next7,out_b2_reg_next6,out_b2_reg_next5,out_b2_reg_next4,out_b2_reg_next3,out_b2_reg_next2,out_b2_reg_next1}),
        .out3({out_b3_reg_next8,out_b3_reg_next7,out_b3_reg_next6,out_b3_reg_next5,out_b3_reg_next4,out_b3_reg_next3,out_b3_reg_next2,out_b3_reg_next1}),
        .out4({out_b4_reg_next8,out_b4_reg_next7,out_b4_reg_next6,out_b4_reg_next5,out_b4_reg_next4,out_b4_reg_next3,out_b4_reg_next2,out_b4_reg_next1})
    );

    //-----------------------

    share_reg out_reg_b1_s1(
        .i_clk (i_clk),
        .i_d   (out_b1_reg_next1),
        .o_q   (out_b1_reg_out1)
    );

    share_reg out_reg_b1_s2(
        .i_clk (i_clk),
        .i_d   (out_b1_reg_next2),
        .o_q   (out_b1_reg_out2)
    );

    share_reg out_reg_b1_s3(
        .i_clk (i_clk),
        .i_d   (out_b1_reg_next3),
        .o_q   (out_b1_reg_out3)
    );

    share_reg out_reg_b1_s4(
        .i_clk (i_clk),
        .i_d   (out_b1_reg_next4),
        .o_q   (out_b1_reg_out4)
    );

    share_reg out_reg_b1_s5(
        .i_clk (i_clk),
        .i_d   (out_b1_reg_next5),
        .o_q   (out_b1_reg_out5)
    );

    share_reg out_reg_b1_s6(
        .i_clk (i_clk),
        .i_d   (out_b1_reg_next6),
        .o_q   (out_b1_reg_out6)
    );

    share_reg out_reg_b1_s7(
        .i_clk (i_clk),
        .i_d   (out_b1_reg_next7),
        .o_q   (out_b1_reg_out7)
    );

    share_reg out_reg_b1_s8(
        .i_clk (i_clk),
        .i_d   (out_b1_reg_next8),
        .o_q   (out_b1_reg_out8)
    );

    share_reg out_reg_b2_s1(
        .i_clk (i_clk),
        .i_d   (out_b2_reg_next1),
        .o_q   (out_b2_reg_out1)
    );

    share_reg out_reg_b2_s2(
        .i_clk (i_clk),
        .i_d   (out_b2_reg_next2),
        .o_q   (out_b2_reg_out2)
    );

    share_reg out_reg_b2_s3(
        .i_clk (i_clk),
        .i_d   (out_b2_reg_next3),
        .o_q   (out_b2_reg_out3)
    );

    share_reg out_reg_b2_s4(
        .i_clk (i_clk),
        .i_d   (out_b2_reg_next4),
        .o_q   (out_b2_reg_out4)
    );

    share_reg out_reg_b2_s5(
        .i_clk (i_clk),
        .i_d   (out_b2_reg_next5),
        .o_q   (out_b2_reg_out5)
    );

    share_reg out_reg_b2_s6(
        .i_clk (i_clk),
        .i_d   (out_b2_reg_next6),
        .o_q   (out_b2_reg_out6)
    );

    share_reg out_reg_b2_s7(
        .i_clk (i_clk),
        .i_d   (out_b2_reg_next7),
        .o_q   (out_b2_reg_out7)
    );

    share_reg out_reg_b2_s8(
        .i_clk (i_clk),
        .i_d   (out_b2_reg_next8),
        .o_q   (out_b2_reg_out8)
    );

    share_reg out_reg_b3_s1(
        .i_clk (i_clk),
        .i_d   (out_b3_reg_next1),
        .o_q   (out_b3_reg_out1)
    );

    share_reg out_reg_b3_s2(
        .i_clk (i_clk),
        .i_d   (out_b3_reg_next2),
        .o_q   (out_b3_reg_out2)
    );

    share_reg out_reg_b3_s3(
        .i_clk (i_clk),
        .i_d   (out_b3_reg_next3),
        .o_q   (out_b3_reg_out3)
    );

    share_reg out_reg_b3_s4(
        .i_clk (i_clk),
        .i_d   (out_b3_reg_next4),
        .o_q   (out_b3_reg_out4)
    );

    share_reg out_reg_b3_s5(
        .i_clk (i_clk),
        .i_d   (out_b3_reg_next5),
        .o_q   (out_b3_reg_out5)
    );

    share_reg out_reg_b3_s6(
        .i_clk (i_clk),
        .i_d   (out_b3_reg_next6),
        .o_q   (out_b3_reg_out6)
    );

    share_reg out_reg_b3_s7(
        .i_clk (i_clk),
        .i_d   (out_b3_reg_next7),
        .o_q   (out_b3_reg_out7)
    );

    share_reg out_reg_b3_s8(
        .i_clk (i_clk),
        .i_d   (out_b3_reg_next8),
        .o_q   (out_b3_reg_out8)
    );

    share_reg out_reg_b4_s1(
        .i_clk (i_clk),
        .i_d   (out_b4_reg_next1),
        .o_q   (out_b4_reg_out1)
    );

    share_reg out_reg_b4_s2(
        .i_clk (i_clk),
        .i_d   (out_b4_reg_next2),
        .o_q   (out_b4_reg_out2)
    );

    share_reg out_reg_b4_s3(
        .i_clk (i_clk),
        .i_d   (out_b4_reg_next3),
        .o_q   (out_b4_reg_out3)
    );

    share_reg out_reg_b4_s4(
        .i_clk (i_clk),
        .i_d   (out_b4_reg_next4),
        .o_q   (out_b4_reg_out4)
    );

    share_reg out_reg_b4_s5(
        .i_clk (i_clk),
        .i_d   (out_b4_reg_next5),
        .o_q   (out_b4_reg_out5)
    );

    share_reg out_reg_b4_s6(
        .i_clk (i_clk),
        .i_d   (out_b4_reg_next6),
        .o_q   (out_b4_reg_out6)
    );

    share_reg out_reg_b4_s7(
        .i_clk (i_clk),
        .i_d   (out_b4_reg_next7),
        .o_q   (out_b4_reg_out7)
    );

    share_reg out_reg_b4_s8(
        .i_clk (i_clk),
        .i_d   (out_b4_reg_next8),
        .o_q   (out_b4_reg_out8)
    );

    //-----------------------

    xor_cir4 comp_b1_s1(
        .in1 (out_b1_reg_out1),
        .in2 (out_b1_reg_out2),
        .in3 (out_b1_reg_out3),
        .in4 (out_b1_reg_out4),
        .out (comp_sh1[0])
    );

    xor_cir4 comp_b1_s2(
        .in1 (out_b1_reg_out5),
        .in2 (out_b1_reg_out6),
        .in3 (out_b1_reg_out7),
        .in4 (out_b1_reg_out8),
        .out (comp_sh2[0])
    );

    xor_cir4 comp_b2_s1(
        .in1 (out_b2_reg_out1),
        .in2 (out_b2_reg_out2),
        .in3 (out_b2_reg_out3),
        .in4 (out_b2_reg_out4),
        .out (comp_sh1[1])
    );

    xor_cir4 comp_b2_s2(
        .in1 (out_b2_reg_out5),
        .in2 (out_b2_reg_out6),
        .in3 (out_b2_reg_out7),
        .in4 (out_b2_reg_out8),
        .out (comp_sh2[1])
    );

    xor_cir4 comp_b3_s1(
        .in1 (out_b3_reg_out1),
        .in2 (out_b3_reg_out2),
        .in3 (out_b3_reg_out3),
        .in4 (out_b3_reg_out4),
        .out (comp_sh1[2])
    );

    xor_cir4 comp_b3_s2(
        .in1 (out_b3_reg_out5),
        .in2 (out_b3_reg_out6),
        .in3 (out_b3_reg_out7),
        .in4 (out_b3_reg_out8),
        .out (comp_sh2[2])
    );

    xor_cir4 comp_b4_s1(
        .in1 (out_b4_reg_out1),
        .in2 (out_b4_reg_out2),
        .in3 (out_b4_reg_out3),
        .in4 (out_b4_reg_out4),
        .out (comp_sh1[3])
    );
    xor_cir4 comp_b4_s2(
        .in1 (out_b4_reg_out5),
        .in2 (out_b4_reg_out6),
        .in3 (out_b4_reg_out7),
        .in4 (out_b4_reg_out8),
        .out (comp_sh2[3])
    );

    affine_2sh outaff(
        .in1  (comp_sh1),
        .in2  (comp_sh2),
        .out1 (out_1),
        .out2 (out_2)
    );


endmodule




