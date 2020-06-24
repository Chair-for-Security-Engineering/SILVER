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

module s_bit2_sh4 (
  y2,
  w1,
  z2,
  x1,
  out4
);

    input wire y2;
    input wire w1;
    input wire z2;
    input wire x1;

    output wire out4;

    assign out4 = y2 & w1 ^ y2 & z2 ^ y2 & z2 & w1 ^ x1 & y2 & z2 ;

endmodule
