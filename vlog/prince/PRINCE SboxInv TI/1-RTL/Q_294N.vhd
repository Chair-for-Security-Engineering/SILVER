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

ENTITY Q_294N IS
	PORT ( input1 : IN  STD_LOGIC_VECTOR (3 downto 1);
			 input2 : IN  STD_LOGIC_VECTOR (3 downto 0);
			 output : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END Q_294N;

ARCHITECTURE behavioral OF Q_294N IS

	signal x1, x2, x3, x4, x5, x6, x7 : std_logic;

BEGIN
	
	x1	<= input1(1);
	x2	<= input1(2);
	x3	<= input1(3);

	x4	<= input2(0);
	x5	<= input2(1);
	x6	<= input2(2);
	x7	<= input2(3);
	
	output(0) <= x4 xor (x1 nor x3) xor (x1 nor x7) xor (x3 nor x5);
	output(1) <= x5 xor (x2 nor x3) xor (x2 nor x7) xor (x3 nor x6);
	output(2) <= x6; 
	output(3) <= x7;
	
END behavioral;
