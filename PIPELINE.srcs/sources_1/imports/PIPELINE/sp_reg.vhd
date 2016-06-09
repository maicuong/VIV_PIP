library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sp_reg is
	port(lat,clk,rst,s_inc,s_dcr : in std_logic;
			d : in std_logic_vector(15 downto 0);
			f : out std_logic_vector(15 downto 0));
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
	
	component reg_pos_et_d_ff
		port(clk, D, lat, rst: in std_logic;
				Q : out std_logic);
	end component;
	
	signal inc_lat, dcr_lat : std_logic;
	signal inc_d, dcr_d, inc_f, dcr_f : std_logic_vector(15 downto 0);

	signal S_s_inc, S_s_dcr : std_logic;
begin

	rw_counter1 : rw_counter port map (
		lat => lat,
		clk => clk,
		rst => rst,
		s_inc => s_inc,
		d => inc_d,
		f => inc_f);
		
	rw_d_counter_16_1 : rw_d_counter_16 port map (
		lat => lat,
		clk => clk,
		rst => rst,
		s_dcr => s_dcr,
		d => dcr_d,
		f => dcr_f);
	
	--s_inc_reg : reg_pos_et_d_ff port map(clk, s_inc, s_inc, rst, S_s_inc);
	--s_dcr_reg : reg_pos_et_d_ff port map(clk, s_dcr, s_dcr, rst, S_s_dcr);
	process(s_inc, s_dcr)
	begin
	   if(s_inc = '1') then
	       S_s_inc <= '1';
	       S_s_dcr <= '0';
	    elsif(s_dcr = '1') then
	       S_s_inc <= '0';
	       S_s_dcr <= '1';
	    end if;
	end process;
	
	--f <= inc_f when S_s_inc = '1' else
		 --dcr_f when S_s_dcr = '1';
		 --else (others => '0');
		 
    f <= inc_f;
		
end Behavioral;
