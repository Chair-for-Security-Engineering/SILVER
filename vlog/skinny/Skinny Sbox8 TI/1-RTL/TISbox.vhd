
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TISbox IS
		PORT ( input_s1   : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
				 input_s2   : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
				 input_s3   : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
				 
				 clk			: IN STD_LOGIC;
				 
				 output_s1 : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0);
				 output_s2 : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0);
				 output_s3 : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0));
END TISbox;

ARCHITECTURE behavioral OF TISBox IS
	
	signal Stage1_out1,
			 Stage1_out2,
			 Stage1_out3,
			 
			 Stage2_in1,
			 Stage2_in2,
			 Stage2_in3,
			 
			 Stage2_out1,
			 Stage2_out2,
			 Stage2_out3,
			 
			 Stage3_in1,
			 Stage3_in2,
			 Stage3_in3,
			 
			 Stage3_out1,
			 Stage3_out2,
			 Stage3_out3,

			 Stage4_in1,
			 Stage4_in2,
			 Stage4_in3,

			 Stage4_out1,
			 Stage4_out2,
			 Stage4_out3	 : STD_LOGIC_VECTOR (7 DOWNTO 0);
	
BEGIN

	Stage1: ENTITY work.Stage
	Port Map (
		X1	=> input_s1,
		X2	=> input_s2,
		X3	=> input_s3,
		Y1	=> Stage1_out1,
		Y2	=> Stage1_out2,
		Y3	=> Stage1_out3);
		
	--------------------------------------------------

	reg1_s1: ENTITY work.reg
	GENERIC map ( size => 8)
	PORT map ( 
		clk 	=> clk,
		D 		=> Stage1_out1,
		Q 		=> Stage2_in1);

	reg1_s2: ENTITY work.reg
	GENERIC map ( size => 8)
	PORT map ( 
		clk 	=> clk,
		D 		=> Stage1_out2,
		Q 		=> Stage2_in2);

	reg1_s3: ENTITY work.reg
	GENERIC map ( size => 8)
	PORT map ( 
		clk 	=> clk,
		D 		=> Stage1_out3,
		Q 		=> Stage2_in3);

	--------------------------------------------------
	
	Stage2: ENTITY work.Stage
	Port Map (
		X1	=> Stage2_in1,
		X2	=> Stage2_in2,
		X3	=> Stage2_in3,
		Y1	=> Stage2_out1,
		Y2	=> Stage2_out2,
		Y3	=> Stage2_out3);
		
	--------------------------------------------------

	reg2_s1: ENTITY work.reg
	GENERIC map ( size => 8)
	PORT map ( 
		clk 	=> clk,
		D 		=> Stage2_out1,
		Q 		=> Stage3_in1);

	reg2_s2: ENTITY work.reg
	GENERIC map ( size => 8)
	PORT map ( 
		clk 	=> clk,
		D 		=> Stage2_out2,
		Q 		=> Stage3_in2);

	reg2_s3: ENTITY work.reg
	GENERIC map ( size => 8)
	PORT map ( 
		clk 	=> clk,
		D 		=> Stage2_out3,
		Q 		=> Stage3_in3);

	--------------------------------------------------	
	
	Stage3: ENTITY work.Stage
	Port Map (
		X1	=> Stage3_in1,
		X2	=> Stage3_in2,
		X3	=> Stage3_in3,
		Y1	=> Stage3_out1,
		Y2	=> Stage3_out2,
		Y3	=> Stage3_out3);
		
	--------------------------------------------------

	reg3_s1: ENTITY work.reg
	GENERIC map ( size => 8)
	PORT map ( 
		clk 	=> clk,
		D 		=> Stage3_out1,
		Q 		=> Stage4_in1);

	reg3_s2: ENTITY work.reg
	GENERIC map ( size => 8)
	PORT map ( 
		clk 	=> clk,
		D 		=> Stage3_out2,
		Q 		=> Stage4_in2);

	reg3_s3: ENTITY work.reg
	GENERIC map ( size => 8)
	PORT map ( 
		clk 	=> clk,
		D 		=> Stage3_out3,
		Q 		=> Stage4_in3);

	--------------------------------------------------	

	Stage4: ENTITY work.Stage
	Port Map (
		X1	=> Stage4_in1,
		X2	=> Stage4_in2,
		X3	=> Stage4_in3,
		Y1	=> Stage4_out1,
		Y2	=> Stage4_out2,
		Y3	=> Stage4_out3);
		
	--------------------------------------------------

	P1: ENTITY work.Permute
	Port Map (
		X	=>	Stage4_out1,
		Y	=> output_s1);
		
	P2: ENTITY work.Permute
	Port Map (
		X	=>	Stage4_out2,
		Y	=> output_s2);
		
	P3: ENTITY work.Permute
	Port Map (
		X	=>	Stage4_out3,
		Y	=> output_s3);

END behavioral;


		
		
		