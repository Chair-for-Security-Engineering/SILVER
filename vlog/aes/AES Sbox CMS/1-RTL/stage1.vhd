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
library common;
use common.masked_aes_pkg.all;

entity stage1 is
    generic (
       order    : integer
    );
    Port ( stage1In : in t_shared_gf8(order downto 0);
           clk : in STD_LOGIC;
           stage1Out : out t_shared_gf8(order downto 0)
    );
end stage1;

architecture Behavioral of stage1 is
    signal linMapOut : t_shared_gf8(order downto 0);
    
    attribute keep_hierarchy : string;
    attribute keep_hierarchy of Behavioral : architecture is "yes";    
begin

    unprotected_variant : if order = 0 generate
        -- Linear mapping at input from DOM source code
        input_mapping : entity work.linear_map2
        generic map (
            MATRIX_SEL => "X^-1")
        port map (
            DataInxDI  => stage1In(0),
            DataOutxDO => linMapOut(0)
        );
          
    --       -- Linear mapping at input from paper
    --       input_mapping : entity work.linear_map
    --         port map (
    --           a  => stage1In,
    --           q  => linMapOut
    --       );
    
        stage1Proc : process(clk) is begin
            if (rising_edge(clk)) then
                stage1Out <= linMapOut;
            end if;
        end process stage1Proc;
        
    end generate;
    
    protected_variant : if order > 0 generate
         generate_instances_g: for i in order downto 0 generate
            -- Linear mapping at input from DOM source code
            input_mapping : entity work.linear_map2
            generic map (
                MATRIX_SEL => "X^-1")
            port map (
                DataInxDI  => stage1In(i),
                DataOutxDO => linMapOut(i)
            );
            
            stage1Proc : process(clk) is begin
                if (rising_edge(clk)) then
                    stage1Out(i) <= linMapOut(i);
                end if;
            end process stage1Proc;       
         end generate;     
    end generate;

end Behavioral;
