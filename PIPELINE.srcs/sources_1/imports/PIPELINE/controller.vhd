library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controller is
	port(
	   clk, rst, end_sig, Set_r, set_table_data  : in std_logic;
       instruction : in std_logic_vector(31 downto 0);
       text_in : in std_logic_vector(7 downto 0);
       text_out_VM : out std_logic_vector(7 downto 0);
	   jump, s_inc, put_stk, put_fail_stk, next_text, s_dcr, s_dcr_fail, SPlat, SPlat_fail, PRlat, TRlat, IRlat, read, write , 
	      read_8, write_8, read_stk, write_stk, read_fail_stk, write_fail_stk, read_first_table, write_first_table, 
	      read_first_record, write_first_record, read_set_table, write_set_table, S_fail, S_match: out std_logic);
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
	signal S_Fail_D, S_fail_cond1, S_fail_cond2, S_fail_cond : std_logic;
	signal S_wait_text_D, S_wait_text, S_s_wait_text : std_logic;
	signal S_next_text_D, S_next_text : std_logic;
	signal Call_cond, Alt_cond : std_logic;
	signal S_Return_cond1, S_Return_cond2 : std_logic;
	signal S_str_goto_next_text_cond : std_logic;
	signal S_jump_D, S_jump, S_jump_ok, S_s_jump_ok : std_logic;
	signal S_first_step1, S_first_step2, S_first_step3, S_first_step4 : std_logic;
	signal S_Succ_cond1, S_Succ_cond2 : std_logic;
	
	component ctl_sig  port(
	   f1, Call_r, Call_cond, Alt_r, Alt_cond, fail_step1, fail_step2, 
	   Return_step1, Return_step2, Succ_step1, Succ_step2, Jump, First_step1, First_step2, 
	   First_step3, First_step4, Set_r : in std_logic;
	   s_inc, put_stk, put_fail_stk, s_dcr, s_dcr_fail, SPlat, SPlat_fail, PRlat, TRlat, IRlat, read, write, read_8, 
	   write_8, read_stk, write_stk, read_fail_stk, write_fail_stk, read_first_table, write_first_table,
	   read_first_record, write_first_record, read_set_table, write_set_table : out std_logic);
	end component;
	
	component Ex 
      Port (clk, end_sig, Set_r, Byte_r, Set_or_r, Obyte_r, Rset_r, Call_r, Alt_r, Return_r, Succ_r, Oset_r,
            Oset_or_r, Str_first, Str_second, First_r, set_table_data : in  std_logic;
            instruction : in std_logic_vector(15 downto 0);
            text_in : in std_logic_vector(7 downto 0);
            Wait_text, Str_goto_next_text, Next_text, Next_ist, Fail : out std_logic);
    end component;
    
    component d_ff
        Port (clk, trg : in std_logic;
            next_trg : out std_logic);
    end component;
    
    signal S_Byte, S_Set, S_Set_or, S_Obyte, S_Nany, S_Rset, S_Call, 
            S_Return, S_Alt, S_Oset, S_Oset_or, S_str_first, S_str_second, S_First, S_Fail_inst, S_Succ : std_logic;
    signal S_s_match, S_s_fail : std_logic;
    signal S_next_ist, S_s_next_text, S_str_goto_next_text : std_logic;
	
	---ctl_sig
	signal S_s_inc, S_put_stk, S_put_fail_stk, S_PRlat, S_s_dcr, S_s_dcr_fail, S_SPlat, S_SPlat_fail,
	  S_TRlat, S_IRlat, S_read, S_write , S_read_8, S_write_8, S_read_stk,
	  S_write_stk, S_read_fail_stk, S_write_fail_stk, S_read_first_table, S_write_first_table,
	  S_read_first_record, S_write_first_record, S_read_set_table, S_write_set_table :  std_logic;
	
	signal test : std_logic;
	
	signal text_out, text_out_f, nez_in : std_logic_vector(7 downto 0);
	signal nez_in_f : std_logic_vector(15 downto 0);

    component Dec port(
        clk : in std_logic;
        trg, str_goto_next_text : in std_logic;
        instruction : in std_logic_vector(31 downto 0);
        Set_r, Set_or_r, Obyte_r, Rset_r, Call_r, Return_r, ALt_r : out std_logic;
        Byte_r, Oset_r, Oset_or_r, Str_first_r, Str_second_r, First_r, Fail_r, Succ_r : out std_logic);
    end component;
    
    signal S_START1 : std_logic;
    
    component f port(
        clk, next_ist, next_text : in std_logic;
        instruction : in std_logic_vector(31 downto 0);
        text_in : in std_logic_vector(7 downto 0);
        nez_in: out std_logic_vector(15 downto 0);
        text_out : out std_logic_vector(7 downto 0);
        jump_ok : out std_logic;
        f_out : out std_logic);
     end component; 

begin
	   
    START : d_ff port map(
        clk => clk,
        trg => rst,
        next_trg => S_START1);
        
    START1 : d_ff port map(
        clk => clk,
        trg => S_START1,
        next_trg => S_START);
             
    Next_text1 : d_ff port map(
        clk => clk,
        trg => S_next_text_D,
        next_trg => S_next_text); 
        
	Fail1 : d_ff port map(
           clk => clk,
           trg => S_Fail_D,
           next_trg => S_fail_cond1); 

	Fail2 : d_ff port map(
           clk => clk,
           trg => S_fail_cond1,
           next_trg => S_fail_cond);
           
	Return1 : d_ff port map(
          clk => clk,
          trg => S_Return,
          next_trg => S_return_cond1); 
          
	Return2 : d_ff port map(
          clk => clk,
          trg => S_Return_cond1,
          next_trg => S_Return_cond2);
   
   	Succ1 : d_ff port map(
         clk => clk,
         trg => S_Succ,
         next_trg => S_Succ_cond1);
         
	Succ2 : d_ff port map(
         clk => clk,
         trg => S_Succ_cond1,
         next_trg => S_Succ_cond2);            
                  
    Call : d_ff port map(
        clk => clk,
        trg => S_Call,
        next_trg => Call_cond);
        
    Alt : d_ff port map(
        clk => clk,
        trg => S_Alt,
        next_trg => Alt_cond);
        
    Str_goto_next_text : d_ff port map(
        clk => clk,
        trg => S_str_goto_next_text,
        next_trg => S_str_goto_next_text_cond);
        
    Jump1 : d_ff port map(
        clk => clk,
        trg => S_jump_D,
        next_trg => S_jump);

    First_step1 : d_ff port map(
        clk => clk,
        trg => S_first_step1,
        next_trg => S_first_step2);
        
    S_first_step1 <= S_first;

    First_step2 : d_ff port map(
        clk => clk,
        trg => S_first_step2,
        next_trg => S_first_step3);        
            		 
    --First_step3 : d_ff port map(
        --clk => clk,
        --trg => S_first_step3,
        --next_trg => S_first_step4);

	ctl_sig1 : ctl_sig port map(
	   f1 => S_f1,
	   Call_r => S_Call,
	   Call_cond => Call_cond,
	   Alt_r => S_Alt,
	   Alt_cond => Alt_cond,
	   fail_step1 => S_fail_D,
	   fail_step2 => S_fail_cond1,
	   Return_step1 => S_Return,
	   Return_step2 => S_Return_cond1,
	   Succ_step1 => S_succ,
	   Succ_step2 => S_Succ_cond1,
	   Jump => S_jump_ok,
	   First_step1 => S_first_step1,
	   First_step2 => S_first_step2,
	   First_step3 => S_first_step3,
	   First_step4 => S_first_step4,
	   Set_r => S_Set,
	   s_inc => S_s_inc,
	   put_stk => S_put_stk,
	   put_fail_stk => S_put_fail_stk,
	   s_dcr => S_s_dcr,
	   s_dcr_fail => S_s_dcr_fail,
	   SPlat => S_SPlat,
	   SPlat_fail => S_SPlat_fail,
	   PRlat => S_PRlat,
	   TRlat => S_TRlat,
	   IRlat => S_IRlat,
	   read => S_read,
	   write => S_write,
	   read_stk => S_read_stk,
	   write_stk => S_write_stk,
	   read_fail_stk => S_read_fail_stk,
	   write_fail_stk => S_write_fail_stk,
	   read_first_table => S_read_first_table,
	   write_first_table => S_write_first_table,
	   read_first_record => S_read_first_record,
	   write_first_record => S_write_first_record,
	   read_set_table => S_read_set_table,
	   write_set_table => S_write_set_table,
	   read_8 => S_read_8,
	   write_8 => S_write_8);
				
	------------START CIRCUIT
	S_START_rst <= not rst;
	------------F1
	S_F1_next_ist_D <= S_START or (S_next_ist and not S_s_jump_ok) or (S_jump) or S_fail_cond;
	S_F1_next_text_D <= S_START or S_s_next_text;
	
	--S_F2_D <= S_f1;
	
	S_jump_D <= S_next_ist and S_s_jump_ok;
	
	
	------------Dec-
	S_Dec_D <= S_f1 or S_wait_text;
	
	S_Exe_D <= S_dec;
	
	-----------Next_text
	S_next_text_D <= S_START or (S_s_next_text);
    S_Fail_D <= S_s_fail or S_Fail_inst;

	--S_Set <= Set_r and S_Dec;
	
	F1 : f port map(
	   clk => clk,
	   next_ist => S_F1_next_ist_D,
	   next_text => S_F1_next_text_D,
	   instruction => instruction,
	   text_in => text_in,
	   nez_in => nez_in_f,
	   text_out => text_out_f,
	   jump_ok => S_s_jump_ok,
	   f_out => S_f1);
	
	S_jump_ok <= S_s_jump_ok and S_next_ist;
	
	Dec1 : Dec port map(
	   clk => clk,
	   trg => S_Dec_D,
	   str_goto_next_text => S_str_goto_next_text_cond,
	   instruction => instruction,
	   Set_r => S_Set,
	   Byte_r => S_Byte,
	   Set_or_r => S_Set_or,
	   Obyte_r => S_Obyte,
	   Rset_r => S_rset,
	   Call_r => S_Call,
	   Return_r => S_Return,
	   Alt_r => S_Alt,
	   Oset_r => S_Oset,
	   Oset_or_r => S_Oset_or,
	   Str_first_r => S_Str_first,
	   Str_second_r => S_Str_second,
	   First_r => S_First,
	   Fail_r => S_Fail_inst,
	   Succ_r => S_Succ);

	Ex1 : Ex port map(
	  clk => clk,
	  end_sig => end_sig,
      Set_r => S_Set,
      Byte_r => S_Byte,
      Set_or_r => S_Set_or,
      Obyte_r => S_Obyte,
      Rset_r => S_rset,
      Call_r => Call_cond,
      Alt_r => Alt_cond,
      Oset_r => S_Oset,
      Oset_or_r => S_Oset_or,
      Return_r => S_Return_cond1,
      Succ_r => S_Succ_cond1,
      Str_first => S_str_first,
      Str_second => S_str_second,
      First_r => S_first_step2,
      set_table_data => set_table_data,
      instruction => nez_in_f,
      text_in => text_out_f,
      Wait_text => S_wait_text_D,
      Str_goto_next_text => S_str_goto_next_text,
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
	put_stk <= S_put_stk;
	put_fail_stk <= S_put_fail_stk;
	s_dcr <= S_s_dcr;
	s_dcr_fail <= S_s_dcr_fail;
	SPlat <= S_SPlat;
	SPlat_fail <= S_SPlat_fail;
	PRlat <= S_PRlat;
	TRlat <= S_TRlat;
	IRlat <= S_IRlat;
	read <= S_START or (S_next_ist and not S_s_jump_ok) or (S_jump) or S_fail_cond;
	write <= S_write;
	read_8 <= S_read_8;
	write_8 <= S_write_8;
	read_stk <= S_read_stk;
    write_stk <= S_write_stk;
    read_fail_stk <= S_read_fail_stk;
    write_fail_stk <= S_write_fail_stk;
    read_first_table <= S_read_first_table;
    write_first_table <= S_write_first_table;
    read_first_record <= S_read_first_record;
    write_first_record <= S_write_first_record;
    read_set_table <= S_read_set_table;
    write_set_table <= S_write_set_table;
	next_text <= S_next_text_D; ----------
	S_match <= S_next_ist;
	S_fail <= S_s_fail;
	jump <= S_jump_ok;
	text_out_VM <= text_out_f;
	
end Behavioral;