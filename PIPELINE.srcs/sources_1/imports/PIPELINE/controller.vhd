library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controller is
	port(
	   clk, rst, Byte_r : in std_logic;
	   nez_in, text_in : in std_logic_vector(7 downto 0); 
	   s_inc, SPlat, s_inc_sp, get_sp, PRlat, IRlat, read, write , read_stk, write_stk, S_fail, S_match: out std_logic);
end controller;

architecture Behavioral of controller is
	
	component reg_pos_et_d_ff port(
	   clk, D, lat, rst : in std_logic;
	   Q : out std_logic);
	end component;
	
	---START
	signal S_START_rst, S_START : std_logic;
	
	---F1,F2,F3,Dec 
	signal S_F1_D, S_f1 : std_logic;
	signal S_Dec_D, S_dec : std_logic;
	signal S_Fail_D, S_fail_cond : std_logic;
	signal S_Imp_D, S_Imp : std_logic;
	
	component ctl_sig  port(
	   f1 , fail : in std_logic;
	   s_inc, s_inc_sp, SPlat, get_sp, PRlat, IRlat, read, write, read_stk, write_stk : out std_logic);
	end component;
	
	---ctl_sig
	signal S_s_inc_sp, S_SPlat, S_get_sp, S_s_inc, S_PRlat, S_IRlat, S_read, S_write , S_read_stk, S_write_stk:  std_logic;
	
	
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
	
	signal S_s_match, S_s_fail, match_sig, fail_sig : std_logic;

begin

	START : reg_pos_et_d_ff port map(
	   clk => clk,
	   D => '1',
	   lat => '1',
	   rst => S_START_rst,
	   Q => S_START);
		 
	F1 : reg_pos_et_d_ff port map(
	   clk => clk,
	   D => S_F1_D,
	   lat => '1',
	   rst =>rst,
	   Q => S_f1);
		 
	Dec : reg_pos_et_d_ff port map(
	   clk => clk,
	   D => S_Dec_D,
	   lat => '1',
	   rst =>rst,
	   Q => S_dec);
		 
	Fail : reg_pos_et_d_ff port map(
	   clk => clk,
	   D => S_Fail_D,
       lat => '1',
       rst =>rst,
       Q => S_fail_cond); 
		 
	ctl_sig1 : ctl_sig port map(
	   f1 => S_f1,
	   fail => S_fail_cond,
	   s_inc => S_s_inc,
	   s_inc_sp => S_s_inc_sp,
	   SPlat => S_SPlat,
	   get_sp => S_get_sp,
	   PRlat => S_PRlat,
	   IRlat => S_IRlat,
	   read => S_read,
	   write => S_write,
	   read_stk => S_read_stk,
	   write_stk => S_write_stk);
			
	Byte1 : Byte port map (
		TRG => Byte_r,
		TEXT_IN => text_in,
		NEZ_IN => nez_in,
		FAIL => S_s_fail,
		MATCH => S_s_match);
	
	------------START CIRCUIT
	S_START_rst <= not rst;
	------------F1
	S_F1_D <= S_START;
	------------Dec-
	S_Dec_D <= S_f1;
	--match_sig <= S_s_match and S_dec;
	fail_sig <= S_s_fail and S_dec;
	------------Fail
	S_Fail_D <= fail_sig;
	
	
	S_Byte <=  Byte_r;
	--S_Byte <= ((S_dec and S_s_match) or S_fail_cond) and  Byte_r;


	s_inc <= S_s_inc;
	PRlat <= S_PRlat;
	IRlat <= S_IRlat;
	read <= S_read;
	write <= S_write;
	SPlat <= S_SPlat;
	s_inc_sp <= S_s_inc_sp;
	get_sp <= S_get_sp;
	S_match <= S_s_match;
	--S_match <= '1';
	S_fail <= fail_sig;
	read_stk <= S_read_stk;
	write_stk <= S_write_stk;


end Behavioral;

