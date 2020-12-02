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

module s_bit4_sh2 (
  w2,
  z2,
  y1,
  x1,
  out2
);

    input wire w2;
    input wire z2;
    input wire y1;
    input wire x1;

    output wire out2;

    assign out2 = z2 ^ y1 & z2 ^ y1 & z2 & w2 ^ x1 & z2 & w2 ^ x1 & y1 & w2 ;

endmodule
