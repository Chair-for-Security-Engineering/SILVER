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

----------------------------------------------------------------------------
--
-- Initial Version: Date: 23. November 2015 by Hannes Gross IAIK
--
------------------------------------------------------------------------------

library ieee;  use ieee.std_logic_1164.all; 
               
package masked_aes_pkg is
  -- Subtypes

  -- Types
  type t_shared_gf2   is array(natural range <>) of std_logic_vector(1 downto 0);
  type t_shared_gf4   is array(natural range <>) of std_logic_vector(3 downto 0);
  type t_shared_gf8   is array(natural range <>) of std_logic_vector(7 downto 0);
  type t_shared_gf128 is array(natural range <>) of std_logic_vector(127 downto 0);
  type t_shared_gf18  is array(natural range <>) of std_logic_vector(17 downto 0);

  -- Functions
  
  
  --begin changes CMS   ***********************************************
  -- Types 
  type gf18  is array(natural range <>) of std_logic_vector(17 downto 0);
  type gf12  is array(natural range <>) of std_logic_vector(11 downto 0);
  type gf14  is array(natural range <>) of std_logic_vector(13 downto 0);
  
  -- stage 2
  type randomStage2 is array(natural range <>) of std_logic_vector(3 downto 0);
  -- stage 3
  type randomStage3 is array(natural range <>) of std_logic_vector(1 downto 0);
  type stage3OutType is array(natural range <>) of std_logic_vector(13 downto 0);
  -- stage 4
  type randomStage4 is array(natural range <>) of std_logic_vector(3 downto 0);
  type stage4OutType is array(natural range <>) of std_logic_vector(11 downto 0);
  -- stage 5
  type randomStage5 is array(natural range <>) of std_logic_vector(7 downto 0);
  type stage5OutType is array(natural range <>) of std_logic_vector(7 downto 0);
  
  -- end changes CMS     ***********************************************  
  
end masked_aes_pkg;


package body masked_aes_pkg is
  
end masked_aes_pkg;
