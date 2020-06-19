----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:28:54 01/28/2016 
-- Design Name: 
-- Module Name:    SboxFGHI_dp1 - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SboxFGHI_dp1 is
    Port ( x1 : in  STD_LOGIC_VECTOR (7 downto 0);
			  x2 : in  STD_LOGIC_VECTOR (7 downto 0);
           y1 : out STD_LOGIC_VECTOR (7 downto 0);
           y2 : out STD_LOGIC_VECTOR (7 downto 0);
           y3 : out STD_LOGIC_VECTOR (1 downto 0);
           y4 : out STD_LOGIC_VECTOR (1 downto 0));
end SboxFGHI_dp1;

architecture Behavioral of SboxFGHI_dp1 is

	component CompFGHI1 is -- x XOR (w NOR u)
    Port ( x : in  STD_LOGIC;
			  w : in  STD_LOGIC;
			  u : in  STD_LOGIC;
           z : out STD_LOGIC);
	end component;	

	component CompFGHI2 is -- x XNOR (w NAND u)
    Port ( x : in  STD_LOGIC;
			  w : in  STD_LOGIC;
			  u : in  STD_LOGIC;
           z : out STD_LOGIC);
	end component;	

	component CompFGHIp1 is -- (x NOR (NOT w))
    Port ( x : in  STD_LOGIC;
			  w : in  STD_LOGIC;
           z : out STD_LOGIC);
	end component;	

	signal yy1 : STD_LOGIC_VECTOR(7 downto 0);
	signal yy2 : STD_LOGIC_VECTOR(7 downto 0);

begin

	c_f1: CompFGHI1
	port map(x1(0), x1(2), x1(3), yy1(0)); -- x1(0) XOR  (x1(2)  NOR x1(3)) 
	
	c_fp1: CompFGHIp1
	port map(x1(2), x2(3), y3(0)); -- (x1(2) NOR (not x2(3))
		
	yy1(1) <= x1(1);
	yy1(2) <= x1(2);
	yy1(3) <= x1(3);

	c_f3: CompFGHI1
	port map(x1(4), x1(6), x1(7), yy1(4)); --	x1(4) XOR  (x1(6)  NOR x1(7))
	
	c_fp3: CompFGHIp1
	port map(x1(6), x2(7), y3(1)); -- (x1(6) NOR (not x2(7))

	yy1(5) <= x1(5);
	yy1(6) <= x1(6);
	yy1(7) <= x1(7);

	------------------------------------

	c_f2: CompFGHI2
	port map(x2(0), x2(2), x2(3), yy2(0)); -- x2(0) XNOR (x2(2) NAND x2(3)) 
	
	c_fp2: CompFGHIp1
	port map(x1(3), x2(2), y4(0)); -- (x1(3) NOR (not x2(2))
	
	yy2(1) <= x2(1);
	yy2(2) <= x2(2);
	yy2(3) <= x2(3);

	c_f4: CompFGHI2
	port map(x2(4), x2(6), x2(7), yy2(4)); -- x2(4) XNOR (x2(6) NAND x2(7))

	c_fp34: CompFGHIp1
	port map(x1(7), x2(6), y4(1)); -- (x1(7) NOR (not x2(6))
	
	yy2(5) <= x2(5);
	yy2(6) <= x2(6);
	yy2(7) <= x2(7);
	
	------------------------------------

	y1(2) <= yy1(0);
	y1(6) <= yy1(1);
	y1(7) <= yy1(2);
	y1(1) <= yy1(3);
	y1(3) <= yy1(4);
	y1(0) <= yy1(5);
	y1(4) <= yy1(6);
	y1(5) <= yy1(7);

	y2(2) <= yy2(0);
	y2(6) <= yy2(1);
	y2(7) <= yy2(2);
	y2(1) <= yy2(3);
	y2(3) <= yy2(4);
	y2(0) <= yy2(5);
	y2(4) <= yy2(6);
	y2(5) <= yy2(7);
	
end Behavioral;


