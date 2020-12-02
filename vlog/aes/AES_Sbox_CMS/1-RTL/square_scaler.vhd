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

entity square_scaler is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           q : out STD_LOGIC_VECTOR (3 downto 0));
end square_scaler;

architecture Behavioral of square_scaler is
signal square_in1 : STD_LOGIC_VECTOR(1 downto 0);
signal square_out1 : STD_LOGIC_VECTOR(1 downto 0);
signal square_out2 : STD_LOGIC_VECTOR(1 downto 0);

signal scale_out : STD_LOGIC_VECTOR(1 downto 0);
begin
-- square & scale by nu in GF(2^4)/GF(2^2), normal basis (alpha^8,alpha^2) 
-- nu = beta^8 = N^2*alpha^2, N = w^2 

--    -- square1 (GF2 squaring is the same as inverting)
--    square_in1 <= a(3 downto 2) xor a(1 downto 0);
--    square1: entity work.inverter port map (
--        a => square_in1,
--        q => square_out1
--    );
    
--    -- square2 (GF2 squaring is the same as inverting)
--    square2: entity work.inverter port map (
--        a => a(1 downto 0),
--        q => square_out2
--    );
    
--    -- scale by w^2 = Omega^2 in GF(2^2), using normal basis [Omega^2,Omega]  
--    square_scale_gf2: entity work.square_scaler_gf2 port map (
--        a => square_out2,
--        q => scale_out
--    );    
--    q   <=  square_out1 & scale_out;
    
    -- todo: is this the same, but better?
    q(3) <= a(0) xor a(2);
    q(2) <= a(1) xor a(3);    
    q(1) <= a(1) xor a(0);
    q(0) <= a(0);

end Behavioral;
