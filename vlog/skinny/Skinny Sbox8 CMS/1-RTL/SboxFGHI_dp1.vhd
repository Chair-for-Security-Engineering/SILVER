----------------------------------------------------------------------------------
-- COMPANY:		Ruhr University Bochum
-- AUTHOR:		Amir Moradi
-- TOPIC:               Skinny 8-bit Sbox CMS ( http://eprint.iacr.org/2016/660 )
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
use IEEE.STD_LOGIC_1164.ALL;

entity SboxFGHI_dp1 is
    Port ( x1 : in  STD_LOGIC_VECTOR (7 downto 0);
			  x2 : in  STD_LOGIC_VECTOR (7 downto 0);
           y1 : out STD_LOGIC_VECTOR (7 downto 0);
           y2 : out STD_LOGIC_VECTOR (7 downto 0);
           y3 : out STD_LOGIC_VECTOR (1 downto 0);
           y4 : out STD_LOGIC_VECTOR (1 downto 0));
end SboxFGHI_dp1;

architecture Behavioral of SboxFGHI_dp1 is

	component CompFGHI1 is -- x XOR (w NOR u)
    Port ( x : in  STD_LOGIC;
			  w : in  STD_LOGIC;
			  u : in  STD_LOGIC;
           z : out STD_LOGIC);
	end component;	

	component CompFGHI2 is -- x XNOR (w NAND u)
    Port ( x : in  STD_LOGIC;
			  w : in  STD_LOGIC;
			  u : in  STD_LOGIC;
           z : out STD_LOGIC);
	end component;	

	component CompFGHIp1 is -- (x NOR (NOT w))
    Port ( x : in  STD_LOGIC;
			  w : in  STD_LOGIC;
           z : out STD_LOGIC);
	end component;	

	signal yy1 : STD_LOGIC_VECTOR(7 downto 0);
	signal yy2 : STD_LOGIC_VECTOR(7 downto 0);

begin

	c_f1: CompFGHI1
	port map(x1(0), x1(2), x1(3), yy1(0)); -- x1(0) XOR  (x1(2)  NOR x1(3)) 
	
	c_fp1: CompFGHIp1
	port map(x1(2), x2(3), y3(0)); -- (x1(2) NOR (not x2(3))
		
	yy1(1) <= x1(1);
	yy1(2) <= x1(2);
	yy1(3) <= x1(3);

	c_f3: CompFGHI1
	port map(x1(4), x1(6), x1(7), yy1(4)); --	x1(4) XOR  (x1(6)  NOR x1(7))
	
	c_fp3: CompFGHIp1
	port map(x1(6), x2(7), y3(1)); -- (x1(6) NOR (not x2(7))

	yy1(5) <= x1(5);
	yy1(6) <= x1(6);
	yy1(7) <= x1(7);

	------------------------------------

	c_f2: CompFGHI2
	port map(x2(0), x2(2), x2(3), yy2(0)); -- x2(0) XNOR (x2(2) NAND x2(3)) 
	
	c_fp2: CompFGHIp1
	port map(x1(3), x2(2), y4(0)); -- (x1(3) NOR (not x2(2))
	
	yy2(1) <= x2(1);
	yy2(2) <= x2(2);
	yy2(3) <= x2(3);

	c_f4: CompFGHI2
	port map(x2(4), x2(6), x2(7), yy2(4)); -- x2(4) XNOR (x2(6) NAND x2(7))

	c_fp34: CompFGHIp1
	port map(x1(7), x2(6), y4(1)); -- (x1(7) NOR (not x2(6))
	
	yy2(5) <= x2(5);
	yy2(6) <= x2(6);
	yy2(7) <= x2(7);
	
	------------------------------------

	y1(2) <= yy1(0);
	y1(6) <= yy1(1);
	y1(7) <= yy1(2);
	y1(1) <= yy1(3);
	y1(3) <= yy1(4);
	y1(0) <= yy1(5);
	y1(4) <= yy1(6);
	y1(5) <= yy1(7);

	y2(2) <= yy2(0);
	y2(6) <= yy2(1);
	y2(7) <= yy2(2);
	y2(1) <= yy2(3);
	y2(3) <= yy2(4);
	y2(0) <= yy2(5);
	y2(4) <= yy2(6);
	y2(5) <= yy2(7);
	
end Behavioral;


