----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:28:54 01/28/2016 
-- Design Name: 
-- Module Name:    CompFGHI2 - Behavioral 
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

entity CompFGHI2 is -- x XNOR (w NAND u)
    Port ( x : in  STD_LOGIC;
			  w : in  STD_LOGIC;
			  u : in  STD_LOGIC;
           z : out STD_LOGIC);
end CompFGHI2;

architecture Behavioral of CompFGHI2 is

begin

	z <= x XNOR (w NAND u);
	
end Behavioral;

