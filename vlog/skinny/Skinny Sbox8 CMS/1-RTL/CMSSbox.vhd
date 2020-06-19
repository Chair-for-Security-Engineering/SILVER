
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CMSSbox is
    Port ( x1 : in  STD_LOGIC_VECTOR (7 downto 0);
			  x2 : in  STD_LOGIC_VECTOR (7 downto 0);
			  
			  clk : in STD_LOGIC;
           
			  y1 : out STD_LOGIC_VECTOR (7 downto 0);
           y2 : out STD_LOGIC_VECTOR (7 downto 0));
end CMSSbox;

architecture Behavioral of CMSSbox is

	component SboxFGHI_dp1 is
    Port ( x1 : in  STD_LOGIC_VECTOR (7 downto 0);
			  x2 : in  STD_LOGIC_VECTOR (7 downto 0);
           y1 : out STD_LOGIC_VECTOR (7 downto 0);
           y2 : out STD_LOGIC_VECTOR (7 downto 0);
           y3 : out STD_LOGIC_VECTOR (1 downto 0);
           y4 : out STD_LOGIC_VECTOR (1 downto 0));
	end component;

	component FGHI_Combine is
    Port ( x1 : in  STD_LOGIC_VECTOR (7 downto 0);
			  x2 : in  STD_LOGIC_VECTOR (7 downto 0);
			  x3 : in  STD_LOGIC_VECTOR (1 downto 0);
           x4 : in  STD_LOGIC_VECTOR (1 downto 0);
           y1 : out STD_LOGIC_VECTOR (7 downto 0);
			  y2 : out STD_LOGIC_VECTOR (7 downto 0));
	end component;

	signal fo1	: STD_LOGIC_VECTOR(7 downto 0);
	signal fo2	: STD_LOGIC_VECTOR(7 downto 0);
	signal fpo1	: STD_LOGIC_VECTOR(1 downto 0);
	signal fpo2	: STD_LOGIC_VECTOR(1 downto 0);

	signal fo1R	: STD_LOGIC_VECTOR(7 downto 0);
	signal fo2R	: STD_LOGIC_VECTOR(7 downto 0);
	signal fpo1R: STD_LOGIC_VECTOR(1 downto 0);
	signal fpo2R: STD_LOGIC_VECTOR(1 downto 0);

	signal gi1	: STD_LOGIC_VECTOR(7 downto 0);
	signal gi2	: STD_LOGIC_VECTOR(7 downto 0);

	signal go1	: STD_LOGIC_VECTOR(7 downto 0);
	signal go2	: STD_LOGIC_VECTOR(7 downto 0);
	signal gpo1	: STD_LOGIC_VECTOR(1 downto 0);
	signal gpo2	: STD_LOGIC_VECTOR(1 downto 0);

	signal go1R	: STD_LOGIC_VECTOR(7 downto 0);
	signal go2R	: STD_LOGIC_VECTOR(7 downto 0);
	signal gpo1R: STD_LOGIC_VECTOR(1 downto 0);
	signal gpo2R: STD_LOGIC_VECTOR(1 downto 0);

	signal hi1	: STD_LOGIC_VECTOR(7 downto 0);
	signal hi2	: STD_LOGIC_VECTOR(7 downto 0);

	signal ho1	: STD_LOGIC_VECTOR(7 downto 0);
	signal ho2	: STD_LOGIC_VECTOR(7 downto 0);
	signal hpo1	: STD_LOGIC_VECTOR(1 downto 0);
	signal hpo2	: STD_LOGIC_VECTOR(1 downto 0);

	signal ho1R	: STD_LOGIC_VECTOR(7 downto 0);
	signal ho2R	: STD_LOGIC_VECTOR(7 downto 0);
	signal hpo1R: STD_LOGIC_VECTOR(1 downto 0);
	signal hpo2R: STD_LOGIC_VECTOR(1 downto 0);

	signal ii1	: STD_LOGIC_VECTOR(7 downto 0);
	signal ii2	: STD_LOGIC_VECTOR(7 downto 0);

	signal io1	: STD_LOGIC_VECTOR(7 downto 0);
	signal io2	: STD_LOGIC_VECTOR(7 downto 0);
	signal ipo1	: STD_LOGIC_VECTOR(1 downto 0);
	signal ipo2	: STD_LOGIC_VECTOR(1 downto 0);

	signal io1R	: STD_LOGIC_VECTOR(7 downto 0);
	signal io2R	: STD_LOGIC_VECTOR(7 downto 0);
	signal ipo1R: STD_LOGIC_VECTOR(1 downto 0);
	signal ipo2R: STD_LOGIC_VECTOR(1 downto 0);

	signal pi1	: STD_LOGIC_VECTOR(7 downto 0);
	signal pi2	: STD_LOGIC_VECTOR(7 downto 0);

begin

	F_TI2: SboxFGHI_dp1
	port map(x1, x2, fo1, fo2, fpo1, fpo2);

	--------------------------------------- 
	
	Rf: ENTITY work.reg 
	generic map (2*10)
	port map (
		clk 				=> clk,
		D( 7 downto  0)=> fo1,
		D(15 downto  8)=> fo2,
		D(17 downto 16)=> fpo1,
		D(19 downto 18)=> fpo2,
		
		Q( 7 downto  0)=> fo1R,
		Q(15 downto  8)=> fo2R,
		Q(17 downto 16)=> fpo1R,
		Q(19 downto 18)=> fpo2R);
	
	---------------------------------------	

	F_Com: FGHI_Combine
	port map(fo1R, fo2R, fpo1R, fpo2R, gi1, gi2);

	G_TI2: SboxFGHI_dp1
	port map(gi1, gi2, go1, go2, gpo1, gpo2);

	--------------------------------------- 
	
	Rg: ENTITY work.reg 
	generic map (2*10)
	port map (
		clk 				=> clk,
		D( 7 downto  0)=> go1,
		D(15 downto  8)=> go2,
		D(17 downto 16)=> gpo1,
		D(19 downto 18)=> gpo2,
		
		Q( 7 downto  0)=> go1R,
		Q(15 downto  8)=> go2R,
		Q(17 downto 16)=> gpo1R,
		Q(19 downto 18)=> gpo2R);
	
	---------------------------------------	
	
	G_Com: FGHI_Combine
	port map(go1R, go2R, gpo1R, gpo2R, hi1, hi2);

	H_TI2: SboxFGHI_dp1
	port map(hi1, hi2, ho1, ho2, hpo1, hpo2);

	--------------------------------------- 
	
	Rh: ENTITY work.reg 
	generic map (2*10)
	port map (
		clk 				=> clk,
		D( 7 downto  0)=> ho1,
		D(15 downto  8)=> ho2,
		D(17 downto 16)=> hpo1,
		D(19 downto 18)=> hpo2,
		
		Q( 7 downto  0)=> ho1R,
		Q(15 downto  8)=> ho2R,
		Q(17 downto 16)=> hpo1R,
		Q(19 downto 18)=> hpo2R);
	
	---------------------------------------	
	
	H_Com: FGHI_Combine
	port map(ho1R, ho2R, hpo1R, hpo2R, ii1, ii2);

	I_TI2: SboxFGHI_dp1
	port map(ii1, ii2, io1, io2, ipo1, ipo2);
	--------------------------------------- 
	
	Ri: ENTITY work.reg 
	generic map (2*10)
	port map (
		clk 				=> clk,
		D( 7 downto  0)=> io1,
		D(15 downto  8)=> io2,
		D(17 downto 16)=> ipo1,
		D(19 downto 18)=> ipo2,
		
		Q( 7 downto  0)=> io1R,
		Q(15 downto  8)=> io2R,
		Q(17 downto 16)=> ipo1R,
		Q(19 downto 18)=> ipo2R);
	
	---------------------------------------	
	
	I_Com: FGHI_Combine
	port map(io1R, io2R, ipo1R, ipo2R, pi1, pi2);

	P1: ENTITY work.Permute
	Port map (pi1, y1);

	P2: ENTITY work.Permute
	Port map (pi2, y2);


end Behavioral;

