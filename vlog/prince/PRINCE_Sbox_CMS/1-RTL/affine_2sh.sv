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
// Author Dušan Božilov
// ----------------------------------------------------------------------------

module affine_2sh(
    in1,
    in2,
    out1,
    out2
);

input wire [3 : 0] in1;
input wire [3 : 0] in2;

output wire [3 : 0] out1;
output wire [3 : 0] out2;

    affine_share1 sh1(
        .i_in1 (in1),
        .o_out1 (out1)
    );

    affine_share2 sh2(
        .i_in2 (in2),
        .o_out2 (out2)
    );

endmodule


