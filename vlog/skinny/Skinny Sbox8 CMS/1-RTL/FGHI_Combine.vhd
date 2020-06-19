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

entity FGHI_Combine is
    Port ( x1 : in  STD_LOGIC_VECTOR (7 downto 0);
			  x2 : in  STD_LOGIC_VECTOR (7 downto 0);
			  x3 : in  STD_LOGIC_VECTOR (1 downto 0);
           x4 : in  STD_LOGIC_VECTOR (1 downto 0);
           y1 : out STD_LOGIC_VECTOR (7 downto 0);
			  y2 : out STD_LOGIC_VECTOR (7 downto 0));
end FGHI_Combine;

architecture Behavioral of FGHI_Combine is

	component CompFGHICombine is -- (x(7 downto 4) & (x(3) xor y(1))  & (x(2) xor y(0)))  & x(1 downto 0)
    Port ( x : in  STD_LOGIC_VECTOR(7 downto 0);
			  y : in  STD_LOGIC_VECTOR(1 downto 0);
			  z : out STD_LOGIC_VECTOR(7 downto 0));
	end component;	
	
begin
	
	Combine1: CompFGHICombine -- (x1(7 downto 4) & (x1(3) xor x3(1))  & (x1(2) xor x3(0)))  & x1(1 downto 0)
	port map(x1, x3, y1);
	
	Combine2: CompFGHICombine -- (x2(7 downto 4) & (x2(3) xor x4(1))  & (x2(2) xor x4(0)))  & x2(1 downto 0)
	port map(x2, x4, y2);

end Behavioral;

