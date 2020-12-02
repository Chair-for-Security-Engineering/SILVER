----------------------------------------------------------------------------------
-- COMPANY:		Ruhr University Bochum
-- AUTHOR:		Amir Moradi
-- TOPIC:               Skinny 8-bit Sbox TI ( http://eprint.iacr.org/2016/660 )
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

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ComponentFG IS
	PORT ( -- INPUT SHARES ---------------------------------
          X1 : IN	 STD_LOGIC_VECTOR (7 DOWNTO 0);
          X2 : IN	 STD_LOGIC_VECTOR (7 DOWNTO 0);
			 -- OUTPUT SHARES --------------------------------
          Y  : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END ComponentFG;


ARCHITECTURE behavioral OF ComponentFG IS

	-- SIGNAL ---------------------------------------------------------------------
	SIGNAL T : STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN

	T(0) <= X2(0) XOR (X1(2) NOR X1(3)) XOR (X2(2) NOR X1(3)) XOR (X1(2) NOR X2(3));
	T(1) <= X2(1);
	T(2) <= X2(2);
	T(3) <= X2(3);
	T(4) <= X2(4) XOR (X1(6) NOR X1(7)) XOR (X2(6) NOR X1(7)) XOR (X1(6) NOR X2(7));
	T(5) <= X2(5);
	T(6) <= X2(6);
	T(7) <= X2(7);

	Y(2) <= T(0);
	Y(6) <= T(1);
	Y(7) <= T(2);
	Y(1) <= T(3);
	Y(3) <= T(4);
	Y(0) <= T(5);
	Y(4) <= T(6);
	Y(5) <= T(7);

END behavioral;
