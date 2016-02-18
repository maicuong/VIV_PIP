library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity VM is
		port(clk,rst : in std_logic;
            mem_d_in : in std_logic_vector(31 downto 0);
            mem_d_8_in : in std_logic_vector(7 downto 0);
            mem_d_stk_in : in std_logic_vector(31 downto 0);
            read, read_8, read_stk,  write, write_8, write_stk : out std_logic;
            S_fail, S_match : out std_logic;
            addr_8 : out std_logic_vector(31 downto 0);
            addr_16 : out std_logic_vector(15 downto 0);
            addr,mem_d_out : out std_logic_vector(31 downto 0));
end VM;

architecture Behavioral of VM is

	component reg_16
	port(clk,lat,rst : in std_logic;
			a : in std_logic_vector(31 downto 0);
			f : out std_logic_vector(31 downto 0));
	end component;
	
	component rw_counter_16
	port(lat,clk,rst,s_inc : in std_logic;
			d : in std_logic_vector(31 downto 0);
			f : out std_logic_vector(31 downto 0));
	end component;
	
	component sp_reg
	port(lat,clk,rst,s_dcr,s_inc : in std_logic;
	d : in std_logic_vector(15 downto 0);
	f : out std_logic_vector(15 downto 0));
	end component;
	
	
	---BUS_A
	signal S_BUS_A : std_logic_vector(31 downto 0);

	
	---BUS_C
	signal S_BUS_C : std_logic_vector(31 downto 0);
	
	signal S_IR_D : std_logic_vector(31 downto 0);
	
	---PR
	signal S_PRlat, S_s_inc : std_logic;
	signal S_PR_F : std_logic_vector(31 downto 0);
	
	component op_decoder
	port(Op : in std_logic_vector(7 downto 0);
		  Byte_r: out std_logic);
	end component;
	
	
	---Byte
	signal S_Byte_r : std_logic; 
	
	
	component controller
	port(clk, rst, Byte_r: in std_logic;
	       nez_in, text_in : in std_logic_vector(7 downto 0);
			IRlat, SPlat, s_inc_sp, get_sp,   
			s_inc,
			PRlat,  read, write, read_stk, write_stk,
			S_fail, S_match: out std_logic);
	end component;
	
	--- controller
	signal 
				   S_read, S_write : std_logic;
	
	---IR
	signal S_IRlat : std_logic;
	signal S_IR_F : std_logic_vector(31 downto 0);
	
	---TR
	signal S_TRlat, S_s_t_inc : std_logic;
	signal S_TR_F : std_logic_vector(31 downto 0);
	
	signal S_text_in : std_logic_vector(7 downto 0);
	
	---SP
	signal S_SPlat, S_s_dcr, S_s_inc_sp , S_get_sp : std_logic;
	signal S_SP_F, S_SP_D : std_logic_vector(15 downto 0);
	
	signal S_read_stk, S_write_stk : std_logic;
	
begin

	IR : reg_16 port map 
		(clk => clk,
		lat => S_IRlat,
		rst => '0',
		a => S_IR_D,
		f => S_IR_F);
	 
	PR : rw_counter_16 port map
		(lat => S_PRlat,
		 clk => clk,
		 rst => rst,
		 s_inc => S_s_inc,
		 d => S_BUS_C,
		 f => S_PR_F);
		 
	TR : rw_counter_16 port map
		(lat => S_PRlat,
		 clk => clk,
		 rst => rst,
		 s_inc => S_s_inc,
		 d => (others => '0'),
		 f => S_TR_F);
		 
	SP : sp_reg port map 
		(lat => S_SPlat,
		 clk => clk,
		 rst => rst,
		 s_inc => S_s_inc_sp,
		 s_dcr => S_s_dcr,
		 d => S_SP_D,
		 f => S_SP_F);
		 
	addr_16 <= S_SP_F;
		 
	S_text_in <= mem_d_8_in;
		 
	op_decoder1 : op_decoder port map
		(Op => S_IR_F(15 downto 8), ---
		 Byte_r => S_Byte_r);
		 
	controller1 : controller port map
		(clk => clk, 
		 rst => rst,
		 Byte_r => S_Byte_r,
		 nez_in => S_IR_F(7 downto 0), ----
		 text_in => S_text_in,
		 IRlat => S_IRlat,
		 SPlat => S_SPlat,
		 s_inc_sp => S_s_inc_sp,
		 get_sp => S_get_sp,
		 s_inc => S_s_inc,
		 PRlat => S_PRlat,
		 S_fail => S_fail,------------
		 S_match => S_match,----------
		 read => S_read,
		 write => S_write,
		 read_stk => S_read_stk,
		 write_stk => S_write_stk);

	S_IR_D <= mem_d_in;
	
	read <= S_read;
	write <= S_write;
	addr <= S_PR_F;
	addr_8 <= S_TR_F;
	mem_d_out <= S_IR_F;
	
	read_stk <= S_read_stk;
	write_stk <= S_write_stk;
	
	--process(S_get_sp)
	--begin
	   --if(S_get_sp = '1') then
	       S_BUS_C <= mem_d_stk_in;
	   --else
	       --S_BUS_C <= (others => '0');
	   --end if;
	--end process; 

end Behavioral;
