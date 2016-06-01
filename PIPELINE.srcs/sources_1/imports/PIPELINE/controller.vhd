library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controller is
	port(
	   clk, rst, Byte_r, Set_r, Set_or_r, Obyte_r, Nany_r  : in std_logic;
       instruction : in std_logic_vector(31 downto 0);
       text_in : in std_logic_vector(7 downto 0);
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
	signal S_Ex_D, S_ex : std_logic;
	
	component ctl_sig  port(
	   f1 , dec, fail : in std_logic;
	   s_inc, s_inc_sp, SPlat, get_sp, PRlat, IRlat, read, write, read_stk, write_stk : out std_logic);
	end component;
	
	component Ex 
      Port (Byte_r, Set_r, Set_or_r, Obyte_r, Nany_r : in  std_logic;
            instruction : in std_logic_vector(31 downto 0);
            text_in : in std_logic_vector(7 downto 0);
            Match, Fail : out std_logic);
    end component;
    
    signal S_Byte, S_Set, S_Set_or, S_Obyte, S_Nany : std_logic;
    signal S_s_match, S_s_fail : std_logic;
	
	---ctl_sig
	signal S_s_inc_sp, S_SPlat, S_get_sp, S_s_inc, S_PRlat, S_IRlat, S_read, S_write , S_read_stk, S_write_stk:  std_logic;
	

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
	   dec => S_dec,
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
			

	
	------------START CIRCUIT
	S_START_rst <= not rst;
	------------F1
	S_F1_D <= S_START or (S_dec and S_s_match);
	------------Dec-
	S_Dec_D <= S_f1;
	------------Ex
	S_Ex_D <= S_dec;
	
	
	--match_sig <= S_s_match and S_dec;
	--fail_sig <= S_s_fail and S_dec;
	------------Fail
	--S_Fail_D <= fail_sig;
	
	
	S_Byte <=  Byte_r and S_dec;
	S_Set <= Set_r and S_dec;
	S_Set_or <= Set_or_r and S_dec;
	S_Obyte <= Obyte_r and S_dec;
	S_Nany <= Nany_r and S_dec;
	
	Ex1 : Ex port map(
      Byte_r => S_Byte, 
      Set_r => S_Set,
      Set_or_r => S_Set_or,
      Obyte_r => S_Obyte,
      Nany_r => S_Nany,
      instruction => instruction,
      text_in => text_in,
      Match => S_s_match,
      Fail => S_s_fail);
	
	
	
	--S_Byte <= ((S_dec and S_s_match) or S_fail_cond) and  Byte_r;


	s_inc <= S_s_inc;
	PRlat <= S_PRlat;
	IRlat <= S_IRlat;
	read <= S_read;
	write <= S_write;
	SPlat <= S_SPlat;
	s_inc_sp <= S_s_inc_sp;
	get_sp <= S_get_sp;
	S_match <= S_s_match and S_dec;
	--S_match <= S_dec;
	S_fail <= S_s_fail;
	read_stk <= S_read_stk;
	write_stk <= S_write_stk;
	--S_s_dec <= S_dec;


end Behavioral;

