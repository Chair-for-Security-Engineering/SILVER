----------------------------------------------------------------------------------
-- COMPANY:		Ruhr University Bochum
-- AUTHOR:		Amir Moradi
-- TOPIC:               PRINCE Sbox inverse TI ( http://eprint.iacr.org/2016/481 )
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

ENTITY TISboxInv IS
		PORT ( input_s1   : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
				 input_s2   : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
				 input_s3   : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
				 
				 clk			: IN STD_LOGIC;
				 
				 output_s1 : OUT  STD_LOGIC_VECTOR (3 DOWNTO 0);
				 output_s2 : OUT  STD_LOGIC_VECTOR (3 DOWNTO 0);
				 output_s3 : OUT  STD_LOGIC_VECTOR (3 DOWNTO 0));
END TISboxInv;

ARCHITECTURE behavioral OF TISBoxInv IS

	
	signal Q294N1in_s1,
			 Q294N1in_s2,
			 Q294N1in_s3,
			 
			 Reg1in_s1,
			 Reg1in_s2,
			 Reg1in_s3,
			 
			 M1Affin_s1,
			 M1Affin_s2,
			 M1Affin_s3,
			 
			 Q294N2in_s1,
			 Q294N2in_s2,
			 Q294N2in_s3,
			 
			 M2Affin_s1,
			 M2Affin_s2,
			 M2Affin_s3,
			 
			 Reg2in_s1,
			 Reg2in_s2,
			 Reg2in_s3,

			 Q294N3in_s1,
			 Q294N3in_s2,
			 Q294N3in_s3,
			 
			 OutAffin_s1,
			 OutAffin_s2,
			 OutAffin_s3 	: STD_LOGIC_VECTOR (3 DOWNTO 0);
	
BEGIN

	InAff_inst_s1: ENTITY work.InAff
	Port Map (
		input		=> input_s1,
		output	=> Q294N1in_s1);
	
	InAff_inst_s2: ENTITY work.InAff
	Port Map (
		input		=> input_s2,
		output	=> Q294N1in_s2);

	InAff_inst_s3: ENTITY work.InAffC
	Port Map (
		input		=> input_s3,
		output	=> Q294N1in_s3);

	--------------------------------------------------
	
	Q_294N_1_inst_s1: ENTITY work.Q_294N
	Port Map (
		input1	=> Q294N1in_s2(3 downto 1),
		input2	=> Q294N1in_s3,
		output	=> Reg1in_s1);
		
	Q_294N_1_inst_s2: ENTITY work.Q_294N
	Port Map (
		input1	=> Q294N1in_s3(3 downto 1),
		input2	=> Q294N1in_s1,
		output	=> Reg1in_s2);

	Q_294N_1_inst_s3: ENTITY work.Q_294N
	Port Map (
		input1	=> Q294N1in_s1(3 downto 1),
		input2	=> Q294N1in_s2,
		output	=> Reg1in_s3);
		
	--------------------------------------------------
		
	reg1_s1: ENTITY work.reg
	GENERIC map ( size => 4)
	PORT map ( 
		clk 	=> clk,
		D 		=> Reg1in_s1,
		Q 		=> M1Affin_s1);

	reg1_s2: ENTITY work.reg
	GENERIC map ( size => 4)
	PORT map ( 
		clk 	=> clk,
		D 		=> Reg1in_s2,
		Q 		=> M1Affin_s2);

	reg1_s3: ENTITY work.reg
	GENERIC map ( size => 4)
	PORT map ( 
		clk 	=> clk,
		D 		=> Reg1in_s3,
		Q 		=> M1Affin_s3);

	--------------------------------------------------

	M1Aff_inst_s1: ENTITY work.M1AffC
	Port Map (
		input		=> M1Affin_s1,
		output	=> Q294N2in_s1);
	
	M1Aff_inst_s2: ENTITY work.M1Aff
	Port Map (
		input		=> M1Affin_s2,
		output	=> Q294N2in_s2);

	M1Aff_inst_s3: ENTITY work.M1Aff
	Port Map (
		input		=> M1Affin_s3,
		output	=> Q294N2in_s3);

	--------------------------------------------------

	Q_294N_2_inst_s1: ENTITY work.Q_294N
	Port Map (
		input1	=> Q294N2in_s2(3 downto 1),
		input2	=> Q294N2in_s3,
		output	=> M2Affin_s1);
		
	Q_294N_2_inst_s2: ENTITY work.Q_294N
	Port Map (
		input1	=> Q294N2in_s3(3 downto 1),
		input2	=> Q294N2in_s1,
		output	=> M2Affin_s2);

	Q_294N_2_inst_s3: ENTITY work.Q_294N
	Port Map (
		input1	=> Q294N2in_s1(3 downto 1),
		input2	=> Q294N2in_s2,
		output	=> M2Affin_s3);
		
	--------------------------------------------------

	M2Aff_inst_s1: ENTITY work.M2Aff
	Port Map (
		input		=> M2Affin_s1,
		output	=> Reg2in_s1);
	
	M2Aff_inst_s2: ENTITY work.M2AffC
	Port Map (
		input		=> M2Affin_s2,
		output	=> Reg2in_s2);

	M2Aff_inst_s3: ENTITY work.M2Aff
	Port Map (
		input		=> M2Affin_s3,
		output	=> Reg2in_s3);

	--------------------------------------------------

	reg2_s1: ENTITY work.reg
	GENERIC map ( size => 4)
	PORT map ( 
		clk 	=> clk,
		D 		=> Reg2in_s1,
		Q 		=> Q294N3in_s1);

	reg2_s2: ENTITY work.reg
	GENERIC map ( size => 4)
	PORT map ( 
		clk 	=> clk,
		D 		=> Reg2in_s2,
		Q 		=> Q294N3in_s2);

	reg2_s3: ENTITY work.reg
	GENERIC map ( size => 4)
	PORT map ( 
		clk 	=> clk,
		D 		=> Reg2in_s3,
		Q 		=> Q294N3in_s3);

	--------------------------------------------------

	Q_294N_3_inst_s1: ENTITY work.Q_294N
	Port Map (
		input1	=> Q294N3in_s2(3 downto 1),
		input2	=> Q294N3in_s3,
		output	=> OutAffin_s1);
		
	Q_294N_3_inst_s2: ENTITY work.Q_294N
	Port Map (
		input1	=> Q294N3in_s3(3 downto 1),
		input2	=> Q294N3in_s1,
		output	=> OutAffin_s2);

	Q_294N_3_inst_s3: ENTITY work.Q_294N
	Port Map (
		input1	=> Q294N3in_s1(3 downto 1),
		input2	=> Q294N3in_s2,
		output	=> OutAffin_s3);
		
	--------------------------------------------------

	OutAff_inst_s1: ENTITY work.OutAff
	Port Map (
		input		=> OutAffin_s1,
		output	=> output_s1);
	
	OutAff_inst_s2: ENTITY work.OutAffC
	Port Map (
		input		=> OutAffin_s2,
		output	=> output_s2);

	OutAff_inst_s3: ENTITY work.OutAff
	Port Map (
		input		=> OutAffin_s3,
		output	=> output_s3);

END behavioral;

