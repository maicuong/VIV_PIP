library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controller is
	port(clk, rst, Byte_r: in std_logic;
			nez_in, text_in : in std_logic_vector(7 downto 0);
			  PRout, MARout, 
			s_inc, s_mdi,
			PRlat, MARlat, IRlat, read, write , S_fail, S_match: out std_logic);
end controller;

architecture Behavioral of controller is
	
	component reg_pos_et_d_ff
	port(clk, D, lat, rst : in std_logic;
			Q : out std_logic);
	end component;
	
	---START
	signal S_START_rst, S_START : std_logic;
	
	---F1,F2,F3,Dec 
	signal S_F1_D, S_f1 : std_logic;
	signal S_F2_D, S_f2 : std_logic;
	signal S_Dec_D, S_dec : std_logic;
	
	component ctl_sig
	port(f1, f2 : in std_logic;
			 PRout, MARout,
			s_inc, s_mdi,
			PRlat, MARlat,  IRlat, read, write : out std_logic);
	end component;
	
	
	---ctl_sig
	signal S_PRout, S_MARout,
			S_s_inc, S_s_mdi, S_PRlat, S_MARlat, S_IRlat, S_read, S_write :  std_logic;
	
	
	
	---Byte
	signal S_Byte : std_logic;
	component Byte
		port(
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(7 downto 0) ;
		FAIL : out std_logic;
		MATCH : out std_logic);
	end component;

begin

	START : reg_pos_et_d_ff port map
		(clk => clk,
		 D => '1',
		 lat => '1',
		 rst => S_START_rst,
		 Q => S_START);
		 
	F1 : reg_pos_et_d_ff port map
		(clk => clk,
		 D => S_F1_D,
		 lat => '1',
		 rst =>rst,
		 Q => S_f1);
		 
	F2 : reg_pos_et_d_ff port map
		(clk => clk,
		 D => S_F2_D,
		 lat => '1',
		 rst =>rst,
		 Q => S_f2);
		 
	Dec : reg_pos_et_d_ff port map
		(clk => clk,
		 D => S_Dec_D,
		 lat => '1',
		 rst =>rst,
		 Q => S_dec);
		 
	ctl_sig1 : ctl_sig port map
		 (f1 => S_f1,
		  f2 => S_f2,
		  PRout => S_PRout,
		  MARout => S_MARout,
		  s_inc => S_s_inc,
		  s_mdi => S_s_mdi,
			PRlat => S_PRlat,
			MARlat => S_MARlat,
			IRlat => S_IRlat,
			read => S_read,
			write => S_write);
			
	Byte1 : Byte port map (
		TRG => Byte_r,
		TEXT_IN => text_in,
		NEZ_IN => nez_in,
		FAIL => S_fail,
		MATCH => S_match);
	
	------------START CIRCUIT
	S_START_rst <= not rst;
	------------F1
	S_F1_D <= S_START or S_Byte;
	------------F2
	S_F2_D <= S_f1;
	------------Dec-
	S_Dec_D <= S_f2;
	S_Byte <= S_dec and Byte_r;
	
	PRout <= S_PRout;
	MARout <= S_MARout;


	s_inc <= S_s_inc;
	s_mdi <= S_s_mdi;
	PRlat <= S_PRlat;
	MARlat <= S_MARlat;
	IRlat <= S_IRlat;
	read <= S_read;
	write <= S_write;


end Behavioral;

