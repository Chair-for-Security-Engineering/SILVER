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

module xor_cir4(
    in1,
    in2,
    in3,
    in4,
    out
);

parameter N = 1;

input wire [N - 1 : 0] in1;
input wire [N - 1 : 0] in2;
input wire [N - 1 : 0] in3;
input wire [N - 1 : 0] in4;

output wire [N - 1 : 0] out;

  assign out = in1 ^ in2 ^ in3 ^ in4;

endmodule

