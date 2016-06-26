library IEEE;
library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use UNISIM.Vcomponents.ALL;

entity TEST is
    port(clk: in std_logic;
		 match : out std_logic;
		 parse_success, parse_fail : out std_logic);
end TEST;

architecture Behavioral of TEST is

	component VM port(
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
	   addr : out std_logic_vector(7 downto 0);
	   addr_first_table : out std_logic_vector(31 downto 0);
       addr_in_stk, addr_out_stk, addr_in_fail_stk, addr_out_fail_stk : out std_logic_vector(15 downto 0);
       addr1_first_record, addr2_first_record, addr1_set_table, addr2_set_table : out std_logic_vector(7 downto 0);
       mem_d_stk_in, mem_d_fail_stk_in : out std_logic_vector(31 downto 0);
       parse_success, parse_fail : out std_logic);
	end component;
	
	component MEMORY port(
	   clk, read, write, rst : in std_logic;
	   addr : in std_logic_vector(7 downto 0);
	   data_in : in std_logic_vector(31 downto 0);
	   data_out : out std_logic_vector(31 downto 0));
	end component;
	
	component MEMORY_8 port(
	   read, write, rst : in std_logic;
	   addr : in std_logic_vector(31 downto 0);
	   data : inout std_logic_vector(7 downto 0));
	end component;
	
	component MEMORY_STK port(
       read, write : in std_logic;
       addr_in, addr_out : in std_logic_vector(15 downto 0);
       data_in : in std_logic_vector(31 downto 0);
       data_out : out std_logic_vector(31 downto 0));
    end component;

    --component FIRST_TABLE 
    --Port ( CLK : in std_logic;
          -- DIN : in std_logic_vector(7 downto 0);
          -- DOUT : out std_logic_vector(7 downto 0);
          -- WR : in std_logic;
          -- ADDR_IN : in std_logic_vector(8 downto 0));
    --end component;
    
    component FIRST_RECORD 
            port (read, write : in std_logic;
                 addr1, addr2 : in std_logic_vector(7 downto 0);
                 data_in : in std_logic_vector(7 downto 0);
                 data_out : out std_logic_vector(7 downto 0));
    end component;
    
    component SET_TABLE
            port (read, write : in std_logic;
                 addr1, addr2 : in std_logic_vector(7 downto 0);
                 data_in : in std_logic;
                 data_out : out std_logic);
    end component;

    signal read_first_table, write_first_table, read_first_record, write_first_record : std_logic;
    signal read_set_table, write_set_table : std_logic;
    signal addr1_first_record, addr2_first_record, data_in_first_table,
           data_out_first_table, data_in_first_record, data_out_first_record : std_logic_vector(7 downto 0);
    signal addr1_set_table, addr2_set_table : std_logic_vector(7 downto 0); 
    signal data_in_set_table, data_out_set_table : std_logic;

	signal mem_d_in, mem_d_out : std_logic_vector(31 downto 0);
	signal read,write : std_logic;
	signal addr : std_logic_vector(7 downto 0);
	signal addr_8, addr_first_table: std_logic_vector(31 downto 0);
	
	signal mem_d_8_in : std_logic_vector(7 downto 0);
	signal read_8,write_8 : std_logic;
	
	--- MEMORY
	signal data : std_logic_vector(31 downto 0);
	
	signal rst, fail : std_logic := '0';

    signal match_reg : std_logic;

    signal bus_clk : std_logic;
    
    signal count : integer := 0;
    
    signal test : std_logic_vector(28 downto 0) := (others => '0');
    
    signal read_stk, write_stk : std_logic;
    signal addr_in_stk, addr_out_stk : std_logic_vector(15 downto 0);
    signal mem_d_stk_in, mem_d_stk_out : std_logic_vector(31 downto 0);
    
    signal check : std_logic;
    
    signal read_fail_stk, write_fail_stk : std_logic; 
    signal addr_in_fail_stk, addr_out_fail_stk : std_logic_vector(15 downto 0);  
    signal mem_d_fail_stk_in, mem_d_fail_stk_out : std_logic_vector(31 downto 0);
    
    signal S_parse_success, S_parse_fail : std_logic;
    
    signal addr_first_table_test, addr_first_table_test_1 : std_logic_vector(8 downto 0); 
    signal data_in_first_table_test, data_in_first_table_test_1, data_out_first_table_test, data_out_first_table_test_1  : std_logic_vector(7 downto 0);
    
    
    
      component RAMB4_S8
      port (DI     : in STD_LOGIC_VECTOR (7 downto 0);
            EN     : in STD_ULOGIC;
            WE     : in STD_ULOGIC;
            RST    : in STD_ULOGIC;
            CLK    : in STD_ULOGIC;
            ADDR   : in STD_LOGIC_VECTOR (8 downto 0);
            DO     : out STD_LOGIC_VECTOR (7 downto 0)
      ); 
    end component;
    
component blk_mem_gen_0 
  PORT (
  clka : IN STD_LOGIC;
  ena : IN STD_LOGIC;
  wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
  addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
  douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
  clkb : IN STD_LOGIC;
  enb : IN STD_LOGIC;
  web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
  addrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
  dinb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
  doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
);
    END component;

signal   wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
signal   addra :  STD_LOGIC_VECTOR(3 DOWNTO 0);
signal   dina, douta, doutb :  STD_LOGIC_VECTOR(15 DOWNTO 0);

 component BRAM_v
      port (din     : in STD_LOGIC_VECTOR (15 downto 0);
            we     : in STD_ULOGIC;
            CLK    : in STD_ULOGIC;
            ADDR   : in STD_LOGIC_VECTOR (4 downto 0);
            dout     : out STD_LOGIC_VECTOR (15 downto 0)
      ); 
 end component;

signal addr_bram_v : std_logic_vector(4 downto 0);
signal wr : std_logic;

component FIRST_TABLE is
    port(
        clk, reset : in std_logic;
        wr : in std_logic;
        dad : in std_logic_vector(8 downto 0);
        ini : in std_logic_vector(31 downto 0);
        dout : out std_logic_vector(31 downto 0));
end component;

 signal  wr2, wr3    :  STD_LOGIC;
 signal reset    :  STD_LOGIC;
 signal dad, dad2, dad3   :  STD_LOGIC_VECTOR (8 downto 0);
 signal ini, ini2, ini3, dout, dout2, dout3     :  STD_LOGIC_VECTOR (31 downto 0);

begin
	
	VM1 : VM port map(
	   clk => bus_clk, 
	   rst => rst, 
	   mem_d_in => mem_d_in,
	   mem_d_8_in => mem_d_8_in, 
	   mem_d_stk_out => mem_d_stk_out,
	   mem_d_fail_stk_out => mem_d_fail_stk_out,
	   mem_d_first_table_out => data_out_first_table,
	   mem_d_first_record_out => data_out_first_record,
	   mem_d_set_table_out => data_out_set_table,
	   read => read, 
	   read_8 => read_8,
	   read_stk => read_stk,
	   read_fail_stk => read_fail_stk,
	   read_first_table => read_first_table,
	   read_first_record => read_first_record,
	   read_set_table => read_set_table,
	   write_first_table => write_first_table,
	   write_first_record => write_first_record,
	   write_fail_stk => write_fail_stk,
       write_stk => write_stk, 
	   write => write, 
	   write_8 => write_8, 
	   write_set_table => write_set_table,
	   S_fail => fail, 
	   S_match => match_reg , 
	   addr_8 => addr_8, 
	   addr_in_stk => addr_in_stk,
	   addr_out_stk => addr_out_stk,
	   addr_in_fail_stk => addr_in_fail_stk,
	   addr_out_fail_stk => addr_out_fail_stk,
       addr => addr,
       addr_first_table => addr_first_table,
       addr1_first_record => addr1_first_record,
       addr2_first_record => addr2_first_record,
       addr1_set_table => addr1_set_table,
       addr2_set_table => addr2_set_table,
       mem_d_stk_in => mem_d_stk_in,
       mem_d_fail_stk_in => mem_d_fail_stk_in,
       parse_success => S_parse_success,
       parse_fail => S_parse_fail);
       
    parse_success <= S_parse_success;
    parse_fail <= S_parse_fail;
    
	   
	--match <= '1';
	  
	
	MEMORY1 : MEMORY port map(
	   clk => bus_clk,
	   read => read, 
	   write => write,
	   --write => rst, 
	   rst => rst,
	   addr => addr, 
	   data_in => mem_d_out,
	   data_out => mem_d_in);
	   
	MEMORY2 : MEMORY_8 port map(
	   read => read_8, 
	   write => write_8,
	   rst => rst, 
	   addr => addr_8, 
	   data => mem_d_8_in);
	   
	MEMORY_RETURN : MEMORY_STK port map(
       read => read_stk, 
       write => write_stk, 
       addr_in => addr_in_stk,
       addr_out => addr_out_stk, 
       data_in => mem_d_stk_in,
       data_out => mem_d_stk_out);
       
	MEMORY_FAIL : MEMORY_STK port map(
       read => read_fail_stk, 
       write => write_fail_stk, 
       addr_in => addr_in_fail_stk,
       addr_out => addr_out_fail_stk, 
       data_in => mem_d_fail_stk_in,
       data_out => mem_d_fail_stk_out);
    
         
   SET_TABLE1 : SET_TABLE port map(
      read => read_set_table,
      write => write_set_table,
      addr1 => addr1_set_table,
      addr2 => addr2_set_table,
      data_in => data_in_set_table,
      data_out => data_out_set_table);
         
    data_in_first_table <= (others => '0');
    
    FIRST_RECORD1 : FIRST_RECORD port map(
       read => read_first_record,
       write => write_first_record,
       addr1 => addr1_first_record,
       addr2 => addr2_first_record,
       data_in => data_in_first_record,
       data_out => data_out_first_record);
    
    data_in_first_record <= (others => '0');
    --addr2_first_record <= data_out_first_table;
       
    check <= '1' when (mem_d_stk_out = "00000000000000000000000000010000") else '0';
	match <= match_reg;
	
	process(clk)
	begin
	   if(clk'event and clk = '1') then
	       test <= test + '1';
	   end if;
    end process;
	
	bus_clk <= test(24);

	process(bus_clk)
		--variable count : integer := 0;
	begin
		if(bus_clk'event and bus_clk = '1') then
			count <= count + 1;
			if(count = 3) then	
				rst <= '1';
			else
				rst <= '0';
			end if;
		end if;
	end process;  
	
			
end Behavioral;