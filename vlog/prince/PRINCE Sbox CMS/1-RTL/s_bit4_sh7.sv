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

module s_bit4_sh7 (
  x2,
  y2,
  w1,
  z1,
  out7
);

    input wire x2;
    input wire y2;
    input wire w1;
    input wire z1;

    output wire out7;

    assign out7 = x2 & y2 ^ y2 & z1 & w1 ^ x2 & z1 & w1 ^ x2 & y2 & w1 ;

endmodule
