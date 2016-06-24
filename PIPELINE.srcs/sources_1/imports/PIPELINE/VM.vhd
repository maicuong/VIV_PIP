library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VM is
    port(
	    clk,rst : in std_logic;
        mem_d_in : in std_logic_vector(31 downto 0);
        mem_d_8_in : in std_logic_vector(7 downto 0);
        mem_d_stk_out, mem_d_fail_stk_out : in std_logic_vector(31 downto 0);
        mem_d_first_table_out, mem_d_first_record_out : in std_logic_vector(7 downto 0);
        mem_d_set_table_out : in std_logic;
        read, read_8, write, write_8, read_stk, write_stk, read_fail_stk, write_fail_stk, 
        read_first_table, write_first_table, read_first_record, write_first_record,
        read_set_table, write_set_table : out std_logic;
        S_fail, S_match : out std_logic;
        addr_8 : out std_logic_vector(31 downto 0);
        addr, addr_first_table : out std_logic_vector(31 downto 0);
        addr_in_stk, addr_out_stk, addr_in_fail_stk, addr_out_fail_stk : out std_logic_vector(15 downto 0);
        addr1_first_record, addr2_first_record : out std_logic_vector(7 downto 0);
        addr1_set_table, addr2_set_table : out std_logic_vector(7 downto 0);
        mem_d_stk_in, mem_d_fail_stk_in : out std_logic_vector(31 downto 0);
        parse_success, parse_fail : out std_logic);
end VM;

architecture Behavioral of VM is

	component reg_16 port(
	   clk, lat, rst : in std_logic;
	   a : in std_logic_vector(31 downto 0);
	   f : out std_logic_vector(31 downto 0));
	end component;
	
	component rw_counter_16 port(
	   lat, clk, rst, s_inc : in std_logic;
	   d : in std_logic_vector(31 downto 0);
	   f : out std_logic_vector(31 downto 0));
	end component;

	component sp_reg port(
 	   lat, clk, rst, s_dcr, s_inc : in std_logic;
 	   d : in std_logic_vector(15 downto 0);
 	   f_put, f_pop : out std_logic_vector(15 downto 0));
 	end component;
	
	---BUS_A
	signal S_BUS_A : std_logic_vector(31 downto 0);

	
	---BUS_C
	signal S_BUS_C : std_logic_vector(31 downto 0);
	
	signal S_IR_D : std_logic_vector(31 downto 0);
	
	---PR
	signal S_PRlat, S_s_inc : std_logic;
	signal S_PR_F : std_logic_vector(31 downto 0);
	
	signal put_stk, put_fail_stk : std_logic;
	
	component op_decoder port(
       Op : in std_logic_vector(7 downto 0);
       trg : in std_logic;
       Set_r : out std_logic);
    end component;
	
	---Byte
	signal S_Byte_r, S_Set_r, S_Set_or_r, S_Obyte_r, S_Nany_r, S_Rset_r, S_Call_r : std_logic;  
	
	component controller port(
	   clk, rst, parse_success, parse_fail, Set_r, set_table_data : in std_logic;
       instruction : in std_logic_vector(31 downto 0);
       text_in : in std_logic_vector(7 downto 0);
       text_out_VM : out std_logic_vector(7 downto 0);
	   IRlat, jump,   
	   s_inc, put_stk, put_fail_stk, next_text, SPlat, SPlat_fail, s_dcr, s_dcr_fail,
	   PRlat, TRlat,  read, write, read_8, write_8, read_stk, write_stk, read_fail_stk, write_fail_stk,
	   read_first_table, write_first_table, read_first_record, write_first_record, read_set_table, write_set_table,
	    S_fail, S_match: out std_logic);
	end component;
	
	--- controller
	signal S_read, S_write : std_logic;
	
	---IR
	signal S_IRlat : std_logic;
	signal S_IR_F : std_logic_vector(31 downto 0);
	
	---TR
	signal S_TRlat, S_s_t_inc : std_logic;
	signal S_TR_F : std_logic_vector(31 downto 0);
	
	signal S_text_in, S_text_out : std_logic_vector(7 downto 0);
	
	---SP
	signal S_SPlat,  S_s_dcr, S_s_inc_sp , S_get_sp : std_logic;
	signal S_SP_F_put, S_SP_F_pop, S_SP_D : std_logic_vector(15 downto 0);
    signal S_SPlat_fail,  S_s_dcr_fail, S_s_inc_sp_fail : std_logic;
    signal S_SP_F_fail_put, S_SP_F_fail_pop, S_SP_D_fail : std_logic_vector(15 downto 0);
	
	
	signal S_read_8, S_write_8, S_read_stk, S_s_read_stk, S_write_stk, S_read_fail_stk, S_s_read_fail_stk, S_write_fail_stk,
	       S_read_first_table, S_write_first_table, S_read_first_record, S_write_first_record,
	       S_read_set_table, S_write_set_table : std_logic;
	
	signal S_dec : std_logic;
	
	signal end_sig : std_logic;
	
	signal test_mem_stk : std_logic_vector(31 downto 0);
	
	signal jump : std_logic;
	
	signal parse_success_reg, parse_fail_reg : std_logic := '0';
	
begin

	IR : reg_16 port map (
	   clk => clk,
	   lat => S_read,
	   rst => '0',
	   a => mem_d_in,
	   f => S_IR_F);
	 
	PR : rw_counter_16 port map(
	   lat => S_PRlat,
	   clk => clk,
	   rst => rst,
	   s_inc => S_s_inc,
	   d => S_BUS_C,
	   f => S_PR_F);
	   
	--process(put_stk,S_read_stk)
	--begin
	   --if(put_stk = '1') then
	       --S_BUS_C <= "000000000000000000000000" & S_IR_F(7 downto 0);
	   --elsif(S_read_stk = '1') then
	       --S_BUS_C <= mem_d_stk_out;
	   --end if;
	--end process;          
	
	S_BUS_C <= "000000000000000000000000" & S_IR_F(7 downto 0) when (put_stk = '1') else
	           "000000000000000000000000" & S_IR_F(23 downto 16) when (jump = '1') else 
	           "000000000000000000000000" & mem_d_first_record_out when (S_read_first_record = '1') else 
	           mem_d_fail_stk_out when (S_read_fail_stk = '1') else
	           mem_d_stk_out when (S_read_stk = '1')    
	           else (others => '0');
		 
	TR : rw_counter_16 port map (
	   --lat => S_TRlat,
	   lat => S_s_t_inc,
	   clk => clk,
	   rst => rst,
	   s_inc => S_s_t_inc,
	   d => (others => '0'),
	   f => S_TR_F);
		 
	SP_RETURN : sp_reg port map (
          lat => S_SPlat,
          clk => clk,
          rst => rst,
          s_inc => put_stk,
          s_dcr => S_s_read_stk,
          d => S_SP_D,
          f_put => S_SP_F_put,
          f_pop => S_SP_F_pop);
          
	SP_FAIL : sp_reg port map (
          lat => S_SPlat_fail,
          clk => clk,
          rst => rst,
          s_inc => put_fail_stk,
          s_dcr =>  S_s_read_fail_stk,
          d => S_SP_D_fail,
          f_put => S_SP_F_fail_put,
          f_pop => S_SP_F_fail_pop);
    
    process(clk)
    begin
        if(clk'event and clk = '1') then    
            if(S_read_fail_stk = '1') then
                S_s_read_fail_stk <= '1';
            else 
                S_s_read_fail_stk <= '0';
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if(clk'event and clk = '1') then
            if((S_SP_F_fail_pop = "1111111111111111" and S_read_fail_stk = '1') 
                or (mem_d_fail_stk_out = "00000000000000000000000000000000" and S_s_read_fail_stk = '1')) then    
                parse_fail_reg <= '1';
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if(clk'event and clk = '1') then    
            if(S_read_stk = '1') then
                S_s_read_stk <= '1';
            else 
                S_s_read_stk <= '0';
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if(clk'event and clk = '1') then
            if((S_SP_F_pop = "1111111111111111" and S_read_stk = '1') 
                or (mem_d_stk_out = "00000000000000000000000000000000" and S_s_read_stk = '1')) then    
                parse_success_reg <= '1';
            end if;
        end if;
    end process;
    
    --end_sig <= '1' when (S_SP_F = "0000000000000000") else '0';
		 
	op_decoder1 : op_decoder port map(
          Op => mem_d_in(31 downto 24), ---
          trg => clk,
          Set_r => S_Set_r);
		 
	controller1 : controller port map(
	   clk => clk, 
	   rst => rst,
	   parse_success => parse_success_reg,
	   parse_fail => parse_fail_reg,
	   Set_r => S_Set_r,
	   set_table_data => mem_d_set_table_out,
	   instruction => mem_d_in,
	   text_in => mem_d_8_in,
	   text_out_VM => S_text_out,
	   IRlat => S_IRlat,
	   next_text => S_s_t_inc,
	   jump => jump,
	   s_inc => S_s_inc,
	   s_dcr => S_s_dcr,
	   s_dcr_fail => S_s_dcr_fail,
	   SPlat => S_SPlat,
	   SPlat_fail => S_SPlat_fail,
	   put_stk => put_stk,
	   put_fail_stk => put_fail_stk,
	   PRlat => S_PRlat,
	   TRlat => S_TRlat,
       S_fail => S_fail,------------
	   S_match => S_match,----------
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

--mem_d_stk_in <= ("000000000000000000000000" & mem_d_in(15 downto 8)) when (put_stk = '1') else (others => '0');

    --process(put_stk)
    --begin
        --if(put_stk = '1') then
            mem_d_stk_in <= "000000000000000000000000" & mem_d_in(15 downto 8);
            mem_d_fail_stk_in <= "000000000000000000000000" & mem_d_in(7 downto 0);
           -- mem_d_stk_in <= "000000000000000000000000" & S_IR_F(15 downto 8) when (put_stk = '1') else (others => '0');
            --mem_d_stk_in <= "00000000000000000000000000010000";
             
             
        --end if;
    --end process;            

    --Output	 
	S_text_in <= mem_d_8_in;
	
	S_IR_D <= mem_d_in;
	
	read <= S_read;
	write <= S_write;
	addr <= S_PR_F;
	read_8 <= S_s_t_inc;
	write_8 <= S_write_8;
	addr_8 <= S_TR_F;
	read_fail_stk <= S_read_fail_stk;
	read_stk <= S_read_stk;
    write_stk <= S_write_stk;
    write_fail_stk <= S_write_fail_stk;
    read_first_table <= S_read_first_table;
    write_first_table <= S_write_first_table;
    read_first_record <= S_read_first_record;
    write_first_record <= S_write_first_record;
    read_set_table <= S_read_set_table;
    write_set_table <= S_write_set_table;
    
    addr_in_stk <= S_SP_F_put; --when (S_write_stk = '1') else
    addr_out_stk <= S_SP_F_pop; -- when (S_read_stk = '1') else (others => '0');
                
    --process(S_write_fail_stk, S_read_fail_stk)
    --begin
        --if(S_write_fail_stk = '1') then
            addr_in_fail_stk <= S_SP_F_fail_put;
        --elsif(S_read_fail_stk = '1') then
            addr_out_fail_stk <= S_SP_F_fail_pop;
        --end if;
    --end process;
                
    --addr_fail_stk <= S_SP_F_fail_put when (S_write_fail_stk = '1') else
                     --S_SP_F_fail_pop when (S_read_fail_stk = '1') else (others => '0');
    
    addr_first_table <= S_PR_F;
    addr1_first_record <= S_text_out;
    addr2_first_record <= S_IR_F(7 downto 0);
    addr1_set_table <= S_text_out;
    addr2_set_table <= S_IR_F(7 downto 0);
    parse_success <= parse_success_reg;
    parse_fail <= parse_fail_reg;
     
end Behavioral;