
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ComponentFG IS
	PORT ( -- INPUT SHARES ---------------------------------
          X1 : IN	 STD_LOGIC_VECTOR (7 DOWNTO 0);
          X2 : IN	 STD_LOGIC_VECTOR (7 DOWNTO 0);
			 -- OUTPUT SHARES --------------------------------
          Y  : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END ComponentFG;


ARCHITECTURE behavioral OF ComponentFG IS

	-- SIGNAL ---------------------------------------------------------------------
	SIGNAL T : STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN

	T(0) <= X2(0) XOR (X1(2) NOR X1(3)) XOR (X2(2) NOR X1(3)) XOR (X1(2) NOR X2(3));
	T(1) <= X2(1);
	T(2) <= X2(2);
	T(3) <= X2(3);
	T(4) <= X2(4) XOR (X1(6) NOR X1(7)) XOR (X2(6) NOR X1(7)) XOR (X1(6) NOR X2(7));
	T(5) <= X2(5);
	T(6) <= X2(6);
	T(7) <= X2(7);

	Y(2) <= T(0);
	Y(6) <= T(1);
	Y(7) <= T(2);
	Y(1) <= T(3);
	Y(3) <= T(4);
	Y(0) <= T(5);
	Y(4) <= T(6);
	Y(5) <= T(7);

END behavioral;
