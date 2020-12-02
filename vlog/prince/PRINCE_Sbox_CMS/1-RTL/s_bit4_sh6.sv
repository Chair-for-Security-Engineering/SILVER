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

module s_bit4_sh6 (
  x2,
  w1,
  y1,
  z2,
  out6
);

    input wire x2;
    input wire w1;
    input wire y1;
    input wire z2;

    output wire out6;

    assign out6 = y1 & z2 & w1 ^ x2 & z2 & w1 ^ x2 & y1 & w1 ;

endmodule
