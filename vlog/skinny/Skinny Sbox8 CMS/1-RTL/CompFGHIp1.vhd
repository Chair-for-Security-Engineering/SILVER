----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:28:54 01/28/2016 
-- Design Name: 
-- Module Name:    CompFGHIp1 - Behavioral 
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

entity CompFGHIp1 is -- (x NOR (NOT w))
    Port ( x : in  STD_LOGIC;
			  w : in  STD_LOGIC;
           z : out STD_LOGIC);
end CompFGHIp1;

architecture Behavioral of CompFGHIp1 is

begin

	z <= (x NOR (NOT w));
	
end Behavioral;

