----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:28:03 11/05/2014 
-- Design Name: 
-- Module Name:    sBox - behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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

