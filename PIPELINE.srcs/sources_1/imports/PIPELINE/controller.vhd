library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controller is
	port(
	   clk, rst, Set_r  : in std_logic;
       instruction : in std_logic_vector(31 downto 0);
       text_in : in std_logic_vector(7 downto 0);
	   s_inc, next_text, PRlat, TRlat, IRlat, read, write , 
	      read_8, write_8, S_fail, S_match: out std_logic);
end controller;

architecture Behavioral of controller is
	
	component reg_pos_et_d_ff port(
	   clk, D, lat, rst : in std_logic;
	   Q : out std_logic);
	end component;
	
	---START
	signal S_START_rst, S_START : std_logic;
	
	---F1,Dec 
	signal S_F1_next_ist_D, S_F1_next_text_D, S_f1 : std_logic;
	signal S_F2_D, S_f2 : std_logic;
	signal S_Dec_D, S_dec : std_logic;
	signal S_Exe_D, S_Exe : std_logic;
	signal S_Fail_D, S_fail_cond : std_logic;
	signal S_wait_text_D, S_wait_text, S_s_wait_text : std_logic;
	signal S_next_text_D, S_next_text : std_logic;
	
	component ctl_sig  port(
	   f1 : in std_logic;
	   s_inc, PRlat, TRlat, IRlat, read, write, read_8, write_8 : out std_logic);
	end component;
	
	component Ex 
      Port (clk, Set_r, Byte_r, Set_or_r, Obyte_r, Rset_r : in  std_logic;
            instruction : in std_logic_vector(15 downto 0);
            text_in : in std_logic_vector(7 downto 0);
            Wait_text, Next_text, Next_ist, Fail : out std_logic);
    end component;
    
    component d_ff
        Port (clk, trg : in std_logic;
            next_trg : out std_logic);
    end component;
    
    signal S_Byte, S_Set, S_Set_or, S_Obyte, S_Nany, S_Rset, S_Call : std_logic;
    signal S_s_match, S_s_fail : std_logic;
    signal S_next_ist, S_s_next_text : std_logic;
	
	---ctl_sig
	signal S_s_inc, S_PRlat, 
	  S_TRlat, S_IRlat, S_read, S_write , S_read_8, S_write_8:  std_logic;
	
	signal test : std_logic;
	
	signal text_out, text_out_f, nez_in : std_logic_vector(7 downto 0);
	signal nez_in_f : std_logic_vector(15 downto 0);

    component Dec port(
        clk : in std_logic;
        trg : in std_logic;
        instruction : in std_logic_vector(31 downto 0);
        Set_r, Set_or_r, Obyte_r, Rset_r : out std_logic;
        Byte_r : out std_logic);
    end component;
    
    signal S_START1 : std_logic;
    
    component f port(
        clk, next_ist, next_text : in std_logic;
        instruction : in std_logic_vector(31 downto 0);
        text_in : in std_logic_vector(7 downto 0);
        nez_in: out std_logic_vector(15 downto 0);
        text_out : out std_logic_vector(7 downto 0);
        f_out : out std_logic);
     end component; 

begin

	--START : reg_pos_et_d_ff port map(
	   --clk => clk,
	   --D => '1',
	   --lat => '1',
	   --rst => S_START_rst,
	   --Q => S_START);
	   
    START : d_ff port map(
        clk => clk,
        trg => rst,
        next_trg => S_START1);
        
    START1 : d_ff port map(
        clk => clk,
        trg => S_START1,
        next_trg => S_START);
	   
	--F1 : d_ff port map(
	   --clk => clk,
	   --trg => S_F1_D,
	   --next_trg => S_f1);
	   
	--Dec : d_ff port map(
	   --clk => clk,
	   --trg => S_Dec_D,
	   --next_trg => S_dec);
		 
	--F1 : reg_pos_et_d_ff port map(
	   --clk => clk,
	   --D => S_F1_D,
	   --lat => '1',
	   --rst =>rst,
	   --Q => S_f1);
	
	--F2 : reg_pos_et_d_ff port map(
          --clk => clk,
          --D => S_F2_D,
          --lat => '1',
          --rst =>rst,
          --Q => S_f2);
	
	--Dec_Ex : reg_pos_et_d_ff port map(
	   --clk => clk,
	   --D => S_Dec_D,
	   --lat => '1',
	   --rst =>rst,
	   --Q => S_dec);
	   
	--Exe : reg_pos_et_d_ff port map(
          --clk => clk,
          --D => S_Exe_D,
          --lat => '1',
          --rst =>rst,
          --Q => S_Exe);
	   
	   
	--Next_text1 : reg_pos_et_d_ff port map(
             --clk => clk,
             --D => S_next_text_D,
             --lat => '1',
             --rst =>rst,
             --Q => S_next_text);
             
    Next_text1 : d_ff port map(
        clk => clk,
        trg => S_next_text_D,
        next_trg => S_next_text); 
		 
	ctl_sig1 : ctl_sig port map(
	   f1 => S_f1,
	   s_inc => S_s_inc,
	   PRlat => S_PRlat,
	   TRlat => S_TRlat,
	   IRlat => S_IRlat,
	   read => S_read,
	   write => S_write,
	   read_8 => S_read_8,
	   write_8 => S_write_8);
			

	
	------------START CIRCUIT
	S_START_rst <= not rst;
	------------F1
	S_F1_next_ist_D <= S_START or (S_next_ist);
	S_F1_next_text_D <= S_START or S_s_next_text;
	
	--S_F2_D <= S_f1;
	
	
	------------Dec-
	S_Dec_D <= S_f1 or S_wait_text;
	
	S_Exe_D <= S_dec;
	
	-----------Next_text
	S_next_text_D <= S_START or (S_s_next_text);

	--S_Set <= Set_r and S_Dec;
	
	F1 : f port map(
	   clk => clk,
	   next_ist => S_F1_next_ist_D,
	   next_text => S_F1_next_text_D,
	   instruction => instruction,
	   text_in => text_in,
	   nez_in => nez_in_f,
	   text_out => text_out_f,
	   f_out => S_f1);
	
	Dec1 : Dec port map(
	   clk => clk,
	   trg => S_Dec_D,
	   instruction => instruction,
	   Set_r => S_Set,
	   Byte_r => S_Byte,
	   Set_or_r => S_Set_or,
	   Obyte_r => S_Obyte,
	   Rset_r => S_rset);

	
	Ex1 : Ex port map(
	  clk => clk,
      Set_r => S_Set,
      Byte_r => S_Byte,
      Set_or_r => S_Set_or,
      Obyte_r => S_Obyte,
      Rset_r => S_rset,
      instruction => nez_in_f,
      text_in => text_out_f,
      Wait_text => S_wait_text_D,
      Next_ist => S_next_ist,
      Next_text => S_s_next_text,
      Fail => S_s_fail);
      
	Wait_text : reg_pos_et_d_ff port map(
       clk => clk,
       D => S_wait_text_D,
       lat => '1',
       rst =>rst,
       Q => S_wait_text);
      
	s_inc <= S_s_inc;
	PRlat <= S_PRlat;
	TRlat <= S_TRlat;
	IRlat <= S_IRlat;
	read <= S_START or S_next_ist;
	write <= S_write;
	read_8 <= S_read_8;
	write_8 <= S_write_8;
	next_text <= S_next_text_D; ----------
	S_match <= S_next_ist;
	S_fail <= S_s_fail;
	
end Behavioral;