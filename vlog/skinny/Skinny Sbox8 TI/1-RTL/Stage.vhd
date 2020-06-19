
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Stage IS
	PORT ( -- INPUT SHARES ---------------------------------
          X1 : IN	 STD_LOGIC_VECTOR (7 DOWNTO 0);
          X2 : IN	 STD_LOGIC_VECTOR (7 DOWNTO 0);
          X3 : IN	 STD_LOGIC_VECTOR (7 DOWNTO 0);
			 -- OUTPUT SHARES --------------------------------
          Y1 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
          Y2 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
          Y3 : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END Stage;


ARCHITECTURE behavioral OF Stage IS

BEGIN

	CF1 : ENTITY work.ComponentFG PORT MAP (X2, X3, Y1);
	CF2 : ENTITY work.ComponentFG PORT MAP (X3, X1, Y2);
	CF3 : ENTITY work.ComponentFG PORT MAP (X1, X2, Y3);

END behavioral;
