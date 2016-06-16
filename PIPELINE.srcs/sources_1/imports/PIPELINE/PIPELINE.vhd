library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TEST is
    port(clk: in std_logic;
		 match : out std_logic);
end TEST;

architecture Behavioral of TEST is

	component VM port(
	   clk,rst : in std_logic;
	   mem_d_in : in std_logic_vector(31 downto 0);
	   mem_d_8_in : in std_logic_vector(7 downto 0);
	   mem_d_stk_out : in std_logic_vector(31 downto 0);
	   read, read_8, write, write_8, read_stk, write_stk : out std_logic;
	   S_fail, S_match : out std_logic;
	   addr_8 : out std_logic_vector(31 downto 0);
	   addr : out std_logic_vector(31 downto 0);
       addr_stk : out std_logic_vector(15 downto 0);
       mem_d_stk_in : out std_logic_vector(31 downto 0));
	end component;
	
	component MEMORY port(
	   read, write, rst : in std_logic;
	   addr : in std_logic_vector(31 downto 0);
	   data : inout std_logic_vector(31 downto 0));
	end component;
	
	component MEMORY_8 port(
	   read, write, rst : in std_logic;
	   addr : in std_logic_vector(31 downto 0);
	   data : inout std_logic_vector(7 downto 0));
	end component;
	
	component MEMORY_STK port(
       read, write : in std_logic;
       addr : in std_logic_vector(15 downto 0);
       data_in : in std_logic_vector(31 downto 0);
       data_out : out std_logic_vector(31 downto 0));
    end component;

	signal mem_d_in : std_logic_vector(31 downto 0);
	signal read,write : std_logic;
	signal addr, addr_8, mem_d_out : std_logic_vector(31 downto 0);
	
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
    signal addr_stk : std_logic_vector(15 downto 0);
    signal mem_d_stk_in, mem_d_stk_out : std_logic_vector(31 downto 0);
    
    signal check : std_logic;

begin
	
	VM1 : VM port map(
	   clk => bus_clk, 
	   rst => rst, 
	   mem_d_in => mem_d_in,
	   mem_d_8_in => mem_d_8_in, 
	   mem_d_stk_out => mem_d_stk_out,
	   read => read, 
	   read_8 => read_8,
	   read_stk => read_stk,
       write_stk => write_stk, 
	   write => write, 
	   write_8 => write_8, 
	   S_fail => fail, 
	   S_match => match_reg , 
	   addr_8 => addr_8, 
	   addr_stk => addr_stk,
       addr => addr,
       mem_d_stk_in => mem_d_stk_in);
	   
	--match <= '1';
	  
	
	MEMORY1 : MEMORY port map(
	   read => read, 
	   write => write, 
	   rst => rst,
	   addr => addr, 
	   data => mem_d_in);
	   
	MEMORY2 : MEMORY_8 port map(
	   read => read_8, 
	   write => write_8,
	   rst => rst, 
	   addr => addr_8, 
	   data => mem_d_8_in);
	   
	MEMORY3 : MEMORY_STK port map(
       read => read_stk, 
       write => write_stk, 
       addr => addr_stk, 
       data_in => mem_d_stk_in,
       data_out => mem_d_stk_out);
       
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