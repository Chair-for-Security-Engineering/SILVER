----------------------------------------------------------------------------------
-- COMPANY:		Ruhr University Bochum
-- AUTHOR:		Amir Moradi
-- TOPIC:               PRESENT Sbox TI uniform ( https://doi.org/10.1007/s00145-010-9086-6 )
----------------------------------------------------------------------------------
-- Copyright (c) Amir Moradi
-- All rights reserved.

-- BSD-3-Clause License
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:
--     * Redistributions of source code must retain the above copyright
--       notice, this list of conditions and the following disclaimer.
--     * Redistributions in binary form must reproduce the above copyright
--       notice, this list of conditions and the following disclaimer in the
--       documentation and/or other materials provided with the distribution.
--     * Neither the name of the copyright holder, their organization nor the
--       names of its contributors may be used to endorse or promote products
--       derived from this software without specific prior written permission.
-- 
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
-- ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTERS BE LIABLE FOR ANY
-- DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
-- ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

library IEEE;
use IEEE.std_logic_1164.all;

entity f2BOOM is
	Port ( x : in  STD_LOGIC_VECTOR (7 downto 0);
	       y : out  STD_LOGIC_VECTOR (3 downto 0));
end entity f2BOOM;

architecture circ_arch of f2BOOM is
   signal t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16, t17, t18, t19, t20, t21, t22, t23, t24, t25, t26, t27, t28, t29, t30, t31, t32, t33, t34, t35, t36, t37, t38, t39, t40, t41, t42, t43, t44, t45, t46 : std_logic;
   signal n_x0, n_x1, n_x2, n_x3, n_x4, n_x5, n_x6, n_x7 : std_logic;
  	signal x0,x1,x2,x3,x4,x5,x6,x7 : std_logic;
	 signal y0,y1,y2,y3 : std_logic;

begin
  
  
x0 <= x(7);
x1 <= x(6);
x2 <= x(5);
x3 <= x(4);
x4 <= x(3);
x5 <= x(2);
x6 <= x(1);
x7 <= x(0);

y <= y0&y1&y2&y3;

   n_x0 <= not x0;
   n_x1 <= not x1;
   n_x2 <= not x2;
   n_x3 <= not x3;
   n_x4 <= not x4;
   n_x5 <= not x5;
   n_x6 <= not x6;
   n_x7 <= not x7;

   t0 <= x3 and n_x4 and x6 and n_x7;
   t1 <= x0 and x3 and x5 and x6 and x7;
   t2 <= n_x3 and x6 and n_x7;
   t3 <= x0 and n_x4 and x5 and n_x6;
   t4 <= x0 and x3 and n_x5 and n_x6 and x7;
   t5 <= n_x0 and x3 and x5 and x6 and x7;
   t6 <= x0 and n_x4 and n_x5 and x6;
   t7 <= n_x5 and x6 and n_x7;
   t8 <= n_x0 and x3 and n_x5 and n_x6 and x7;
   t9 <= n_x0 and n_x4 and n_x5 and x6;
   t10 <= n_x0 and x3 and x5 and n_x6 and x7;
   t11 <= x3 and x4 and x5 and n_x6 and n_x7;
   t12 <= x3 and n_x4 and x5 and n_x6 and n_x7;
   t13 <= n_x4 and n_x5 and x6 and n_x7;
   t14 <= n_x3 and x4 and n_x7;
   t15 <= n_x1 and x3 and x6 and x7;
   t16 <= x0 and n_x3 and x4 and n_x5 and x6;
   t17 <= n_x0 and n_x3 and x4 and n_x5 and x6;
   t18 <= n_x0 and n_x3 and x4 and x5 and n_x6;
   t19 <= n_x0 and n_x3 and x4 and x5 and x6 and x7;
   t20 <= x0 and n_x3 and x4 and x5 and n_x6;
   t21 <= x0 and n_x3 and x4 and x5 and x6 and x7;
   t22 <= x0 and n_x3 and x4 and n_x5 and n_x6 and x7;
   t23 <= n_x0 and n_x3 and x4 and n_x5 and n_x6 and x7;
   t24 <= n_x0 and n_x4 and x5 and x6 and x7;
   t25 <= x1 and x3 and x5 and n_x6;
   t26 <= x0 and x3 and x5 and n_x6 and x7;
   t27 <= n_x0 and x3 and n_x5 and x6 and x7;
   t28 <= n_x0 and n_x4 and n_x5 and n_x6 and x7;
   t29 <= x3 and x4 and x5 and x6 and n_x7;
   t30 <= x0 and n_x4 and n_x5 and n_x6 and x7;
   t31 <= x2 and x3 and n_x4 and x6;
   t32 <= x0 and x3 and n_x5 and x6 and x7;
   t33 <= x1 and n_x3 and x5 and x6;
   t34 <= x0 and n_x4 and x5 and x6 and x7;
   t35 <= n_x0 and n_x4 and x5 and n_x6;
   t36 <= n_x2 and x3 and x4 and x7;
   t37 <= n_x2 and n_x3 and n_x4 and x6 and x7;
   t38 <= n_x1 and n_x3 and x5 and n_x6 and x7;
   t39 <= x3 and x4 and n_x5 and n_x6 and n_x7;
   t40 <= x2 and n_x3 and x4 and x6;
   t41 <= x2 and n_x4 and n_x6 and x7;
   t42 <= n_x3 and n_x5 and x6 and n_x7;
   t43 <= n_x3 and x5 and n_x6 and n_x7;
   t44 <= x1 and n_x5 and n_x6 and x7;
   t45 <= n_x2 and x4 and n_x6;
   t46 <= n_x1 and n_x5 and x6;

   y0 <= t3 or t5 or t6 or t8 or t12 or t13 or t17 or t18 or t21 or t22 or t24 or t26 or t28 or t29 or t32 or t39 or t42 or t43;
   y1 <= t0 or t11 or t14 or t31 or t36 or t37 or t39 or t40 or t41 or t45;
   y2 <= t1 or t4 or t9 or t10 or t12 or t13 or t16 or t19 or t20 or t23 or t27 or t29 or t30 or t34 or t35 or t39 or t42 or t43;
   y3 <= t2 or t7 or t11 or t12 or t15 or t25 or t33 or t38 or t44 or t46;
end circ_arch;
