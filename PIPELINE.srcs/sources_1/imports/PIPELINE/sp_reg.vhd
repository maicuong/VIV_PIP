library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sp_reg is
	port(lat,clk,rst,s_inc,s_dcr : in std_logic;
			d : in std_logic_vector(15 downto 0);
			f_put : out std_logic_vector(15 downto 0);
			f_pop : out std_logic_vector(15 downto 0));
end sp_reg;

architecture Behavioral of sp_reg is
	component rw_counter
	port(lat,clk,rst,s_inc : in std_logic;
			d : in std_logic_vector(15 downto 0);
			f : out std_logic_vector(15 downto 0));
	end component;
	
	component rw_d_counter_16
	port(lat,clk,rst,s_dcr : in std_logic;
			d : in std_logic_vector(15 downto 0);
			f : out std_logic_vector(15 downto 0));
	end component;
	
	component d_ff
		port(clk, trg: in std_logic;
				next_trg : out std_logic);
	end component;
	
	signal inc_lat, dcr_lat : std_logic;
	signal inc_d, dcr_d, inc_f, dcr_f : std_logic_vector(15 downto 0);

	signal S_s_inc, S_s_dcr : std_logic;
	
	signal lat_inc, lat_dcr : std_logic;
	
	signal int_dcr_d, int_inc_d : integer;
	
	signal end_sig : std_logic := '0';
	
begin

	rw_counter1 : rw_counter port map (
		lat => lat_inc,
		clk => clk,
		rst => rst,
		s_inc => s_inc,
		d => inc_d,
		f => inc_f);
		
	--inc_d <= "0000000000000001" when (rst = '1') else (dcr_f + '1');
    inc_d <= (dcr_f + '1');
    		
	rw_d_counter_16_1 : rw_d_counter_16 port map (
		lat => lat_dcr,
		clk => clk,
		rst => rst,
		s_dcr => s_dcr,
		d => dcr_d,
		f => dcr_f);
	
	--dcr_d <= "0000000000000001" when (rst = '1') else (inc_f - '1');
    dcr_d <= (inc_f - '1');
    	
	s_inc_reg : d_ff port map(clk, s_inc, S_s_inc);
	s_dcr_reg : d_ff port map(clk, s_dcr, S_s_dcr);
	
	lat_inc <= S_s_dcr or s_inc or rst;
	lat_dcr <= S_s_inc or s_dcr or rst;
	
	--process(s_inc, s_dcr)
	--begin
	   --if(S_s_inc = '1') then
	       --S_s_inc <= '1';
	       --S_s_dcr <= '0';
			 --f <= inc_f;
	    --elsif(S_s_dcr = '1') then
	       --S_s_inc <= '0';
	       --S_s_dcr <= '1';
	       --process(dcr_f)
	       --begin
	           --if(dcr_f = "0000000000000000") then
	               --end_sig <= '1';
	           --end if;
	           --if(end_sig = '0') then 
			     f_put <= inc_f;
			     f_pop <= dcr_f;
			   --else
			     --f <= (others => '0');
			   --end if;
			--end process;
		
	    --end if;
	--end process;
	
	--f <= inc_f when S_s_inc = '1' else
		 --dcr_f when S_s_dcr = '1'
		 --else (others => '0');
		 
    --f <= dcr_f;
		
end Behavioral;
