----------------------------------------------------------------------------------
-- COMPANY:		Ruhr University Bochum
-- AUTHOR:		Amir Moradi
-- TOPIC:               AES Sbox CMS ( http://eprint.iacr.org/2016/631 )
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

entity mul_gf2 is
    generic (
        N    : integer := 1
    );
    Port ( a : in STD_LOGIC_VECTOR (N-1 downto 0);
           b : in STD_LOGIC_VECTOR (N-1  downto 0);
           q : out STD_LOGIC_VECTOR (N-1 downto 0));
end mul_gf2;

architecture Behavioral of mul_gf2 is

begin
    -- 1 Bit
    gf2_1: if N = 1 generate
        q(0) <= a(0) and b(0);
    end generate gf2_1;

    -- 2 Bit
    gf2_2: if N = 2 generate
        q(0) <= ((a(1) xor a(0)) and (b(1) xor b(0))) xor (a(0) and b(0));
        q(1) <= ((a(1) xor a(0)) and (b(1) xor b(0))) xor (a(1) and b(1));
    end generate gf2_2;
    
    -- 4 Bit
  gf2_3: if N = 4 generate
      gf2_3_mul: process (a, b) is
        variable PH     : std_logic_vector(1 downto 0); --  PH
        variable PL     : std_logic_vector(1 downto 0); --  PL
        variable P      : std_logic_vector(1 downto 0); --  P
        variable AA     : std_logic_vector(1 downto 0); --  AA
        variable BB     : std_logic_vector(1 downto 0); --  BB
      begin  -- process gf2_1_mul
        -- Canright:
        -- HI MUL GF2^4 multiplier
        PH(0) := ((A(3) xor A(2)) and (B(3) xor B(2))) xor (A(2) and B(2));
        PH(1) := ((A(3) xor A(2)) and (B(3) xor B(2))) xor (A(3) and B(3));
        
        -- LO MUL GF2^4 multiplier
        PL(0) := ((A(1) xor A(0)) and (B(1) xor B(0))) xor (A(0) and B(0));
        PL(1) := ((A(1) xor A(0)) and (B(1) xor B(0))) xor (A(1) and B(1));
  
        -- MUL and SQUARE SCALE
        AA := (A(3) & A(2)) xor (A(1) & A(0));
        BB := (B(3) & B(2)) xor (B(1) & B(0));
        
        P(1) := ((AA(1) xor AA(0)) and (BB(1) xor BB(0))) xor (AA(0) and BB(0));
        P(0) := ((AA(1) xor AA(0)) and (BB(1) xor BB(0))) xor (AA(1) and BB(1)) xor P(1);
  
       -- Output assignment
        q <= (PH xor P) & (PL xor P);
                
      end process gf2_3_mul;
    end generate gf2_3;


end Behavioral;
