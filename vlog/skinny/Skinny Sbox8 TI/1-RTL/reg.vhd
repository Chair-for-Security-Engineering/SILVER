----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:28:03 11/05/2014 
-- Design Name: 
-- Module Name:    reg_FDE - behavioral 
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
--USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--LIBRARY UNISIM;
--USE UNISIM.VComponents.ALL;

ENTITY reg IS
	GENERIC ( size: POSITIVE);
	PORT ( clk : IN  STD_LOGIC;
			 D : IN  STD_LOGIC_VECTOR ((size-1) DOWNTO 0);
			 Q : OUT  STD_LOGIC_VECTOR ((size-1) DOWNTO 0));
END reg;

ARCHITECTURE behavioral OF reg IS
	
	SIGNAL s_current_state, s_next_state : STD_LOGIC_VECTOR ((size-1) DOWNTO 0);
	
BEGIN

	s_next_state <= D;

	reg_gen: PROCESS(clk, s_next_state)
	BEGIN
		IF RISING_EDGE(clk) THEN
			s_current_state <= s_next_state;
		END IF;
	END PROCESS;		

	Q <= s_current_state;
		
END;

