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
// Author Du�an Bo�ilov
// ----------------------------------------------------------------------------

module s_bit3_sh6 (
  x2,
  w1,
  z2,
  y1,
  out6
);

    input wire x2;
    input wire w1;
    input wire z2;
    input wire y1;

    output wire out6;

    assign out6 = x2 & w1 ^ x2 & z2 ^ x2 & z2 & w1 ^ x2 & y1 & z2 ;

endmodule
