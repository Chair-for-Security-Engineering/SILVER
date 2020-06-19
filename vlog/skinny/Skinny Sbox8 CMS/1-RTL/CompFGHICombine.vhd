----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:28:54 01/28/2016 
-- Design Name: 
-- Module Name:    CompFGHICombine - Behavioral 
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

entity CompFGHICombine is -- (x(7 downto 4) & (x(3) xor y(1))  & (x(2) xor y(0)))  & x(1 downto 0)
    Port ( x : in  STD_LOGIC_VECTOR(7 downto 0);
			  y : in  STD_LOGIC_VECTOR(1 downto 0);
			  z : out STD_LOGIC_VECTOR(7 downto 0));
end CompFGHICombine;

architecture Behavioral of CompFGHICombine is

begin

	z <= (x(7 downto 4) & (x(3) xor y(1))  & (x(2) xor y(0)))  & x(1 downto 0);
	
end Behavioral;

