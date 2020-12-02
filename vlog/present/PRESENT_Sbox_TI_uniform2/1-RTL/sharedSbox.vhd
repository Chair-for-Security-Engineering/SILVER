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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sharedSbox is
    Port ( clk : in  STD_LOGIC;
           sboxIn1 : in  STD_LOGIC_VECTOR (3 downto 0);
           sboxIn2 : in  STD_LOGIC_VECTOR (3 downto 0);
           sboxIn3 : in  STD_LOGIC_VECTOR (3 downto 0);
           share1 : out  STD_LOGIC_VECTOR (3 downto 0);
           share2 : out  STD_LOGIC_VECTOR (3 downto 0);
           share3 : out  STD_LOGIC_VECTOR (3 downto 0));
end sharedSbox;

architecture dfl of sharedSbox is


----------------------------------------------------------
-- component declaration
----------------------------------------------------------

component dflipfloplw1in is
	generic (NBITS: integer);
	port(
		clk	: in std_logic;
		D	: in std_logic_vector(NBITS-1 downto 0);
		Q	: out std_logic_vector(NBITS-1 downto 0)
		);
end component dflipfloplw1in;

component f1BOOM is
	Port ( x : in  STD_LOGIC_VECTOR (7 downto 0);
			 y: out  STD_LOGIC_VECTOR (3 downto 0));
end component f1BOOM;

component f2BOOM is
	Port ( x : in  STD_LOGIC_VECTOR (7 downto 0);
			   y : out  STD_LOGIC_VECTOR (3 downto 0));
end component f2BOOM;

component f3BOOM is
	Port ( x : in  STD_LOGIC_VECTOR (7 downto 0);
			 y: out STD_LOGIC_VECTOR (3 downto 0));
end component f3BOOM;

component g1BOOM is
	Port ( x : in  STD_LOGIC_VECTOR (7 downto 0);
			 y: out  STD_LOGIC_VECTOR (3 downto 0));
end component g1BOOM;

component g2BOOM is
	Port ( x : in  STD_LOGIC_VECTOR (7 downto 0);
			 y: out  STD_LOGIC_VECTOR (3 downto 0));
end component g2BOOM;

component g3BOOM is
	Port ( x : in  STD_LOGIC_VECTOR (7 downto 0);
			 y: out  STD_LOGIC_VECTOR (3 downto 0));
end component g3BOOM;

----------------------------------------------------------
-- data signals
----------------------------------------------------------
signal f1In, f2In, f3In : STD_LOGIC_VECTOR (7 downto 0);
signal f1Out, f2Out, f3Out : STD_LOGIC_VECTOR (3 downto 0);
signal g1In, g2In, g3In : STD_LOGIC_VECTOR (7 downto 0);
signal g1Out, g2Out, g3Out : STD_LOGIC_VECTOR (3 downto 0);
signal g1Reg, g2Reg, g3Reg : STD_LOGIC_VECTOR (3 downto 0);


begin

----------------------------------------------------------
-- component instantiations
----------------------------------------------------------

f1: f1BOOM
	Port map (x => f1In,
				 y => f1Out);

f2: f2BOOM
	Port map (x => f2In,
				 y => f2Out);
				 
f3: f3BOOM
	Port map (x => f3In,
				 y => f3Out);

g1: g1BOOM
	Port map (x => g1In,
				 y => g1Out);
				 
g2: g2BOOM
	Port map (x => g2In,
				 y => g2Out);
				 
g3: g3BOOM
	Port map (x => g3In,
				 y => g3Out);
				 
				 
y3: dflipfloplw1in
	generic map(NBITS=>4)
	Port map(
		clk => clk,
		D => g3Out,
		Q => g3Reg
		);


y2: dflipfloplw1in
	generic map(NBITS=>4)
	Port map(
		clk => clk,
		D => g2Out,
		Q => g2Reg
		);


y1: dflipfloplw1in
	generic map(NBITS=>4)
	Port map(
		clk => clk,
		D => g1Out,
		Q => g1Reg
		);

f1In <= g3Reg&g2Reg;
f2In <= g3Reg&g1Reg;
f3In <= g2Reg&g1Reg;
g1In <= sboxIn2&sboxIn3;
g2In <= sboxIn1&sboxIn3;
g3In <= sboxIn1&sboxIn2;

share1 <= f1Out;
share2 <= f2Out;
share3 <= f3Out;

end dfl;

