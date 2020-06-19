
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Permute IS
	PORT ( X : IN	 STD_LOGIC_VECTOR (7 DOWNTO 0);
          Y  : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END Permute;


ARCHITECTURE behavioral OF Permute IS
BEGIN

	Y(0) <= X(2);
	Y(2) <= X(6);
	Y(1) <= X(7);
	Y(3) <= X(1);
	Y(4) <= X(3);
	Y(5) <= X(0);
	Y(6) <= X(4);
	Y(7) <= X(5);
				
END behavioral;
