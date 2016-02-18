library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rw_counter_16 is
	port(lat, clk, rst, s_inc : in std_logic;
			d : in std_logic_vector(31 downto 0);
			f : out std_logic_vector(31 downto 0));
end rw_counter_16;

architecture Behavioral of rw_counter_16 is

	component ha
	port(a,b : in std_logic;
			c,f: out std_logic);
	end component;
	
	component reg_pos_et_d_ff 
	port(clk, D, lat, rst : in std_logic;
			Q : out std_logic);
	end component;
	
	signal S_HA_F : std_logic_vector(29 downto 0);
	signal S_C : std_logic_vector(30 downto 0);
	signal S_F, S_D : std_logic_vector(31 downto 0);
	
begin

	ha1 : ha port map(S_F(1), S_C(0), S_C(1), S_HA_F(0));
	ha2 : ha port map(S_F(2), S_C(1), S_C(2), S_HA_F(1));
	ha3 : ha port map(S_F(3), S_C(2), S_C(3), S_HA_F(2));
	ha4 : ha port map(S_F(4), S_C(3), S_C(4), S_HA_F(3));
	ha5 : ha port map(S_F(5), S_C(4), S_C(5), S_HA_F(4));
	ha6 : ha port map(S_F(6), S_C(5), S_C(6), S_HA_F(5));
	ha7 : ha port map(S_F(7), S_C(6), S_C(7), S_HA_F(6));
	ha8 : ha port map(S_F(8), S_C(7), S_C(8), S_HA_F(7));
	ha9 : ha port map(S_F(9), S_C(8), S_C(9), S_HA_F(8));
	ha10 : ha port map(S_F(10), S_C(9), S_C(10), S_HA_F(9));
	ha11 : ha port map(S_F(11), S_C(10), S_C(11), S_HA_F(10));
	ha12 : ha port map(S_F(12), S_C(11), S_C(12), S_HA_F(11));
	ha13 : ha port map(S_F(13), S_C(12), S_C(13), S_HA_F(12));
	ha14 : ha port map(S_F(14), S_C(13), S_C(14), S_HA_F(13));
	ha15 : ha port map(S_F(15), S_C(14), S_C(15), S_HA_F(14));
	ha16 : ha port map(S_F(16), S_C(15), S_C(16), S_HA_F(15));
	ha17 : ha port map(S_F(17), S_C(16), S_C(17), S_HA_F(16));
	ha18 : ha port map(S_F(18), S_C(17), S_C(18), S_HA_F(17));
	ha19 : ha port map(S_F(19), S_C(18), S_C(19), S_HA_F(18));
	ha20 : ha port map(S_F(20), S_C(19), S_C(20), S_HA_F(19));
	ha21 : ha port map(S_F(21), S_C(20), S_C(21), S_HA_F(20));
	ha22 : ha port map(S_F(22), S_C(21), S_C(22), S_HA_F(21));
	ha23 : ha port map(S_F(23), S_C(22), S_C(23), S_HA_F(22));
	ha24 : ha port map(S_F(24), S_C(23), S_C(24), S_HA_F(23));
	ha25 : ha port map(S_F(25), S_C(24), S_C(25), S_HA_F(24));
	ha26 : ha port map(S_F(26), S_C(25), S_C(26), S_HA_F(25));
	ha27 : ha port map(S_F(27), S_C(26), S_C(27), S_HA_F(26));
	ha28 : ha port map(S_F(28), S_C(27), S_C(28), S_HA_F(27));
	ha29 : ha port map(S_F(29), S_C(28), S_C(29), S_HA_F(28));
	ha30 : ha port map(S_F(30), S_C(29), S_C(30), S_HA_F(29));

	ff0 : reg_pos_et_d_ff port map(clk, S_D(0), lat, rst, S_F(0));
	ff1 : reg_pos_et_d_ff port map(clk, S_D(1), lat, rst, S_F(1));
	ff2 : reg_pos_et_d_ff port map(clk, S_D(2), lat, rst, S_F(2));
	ff3 : reg_pos_et_d_ff port map(clk, S_D(3), lat, rst, S_F(3));
	ff4 : reg_pos_et_d_ff port map(clk, S_D(4), lat, rst, S_F(4));
	ff5 : reg_pos_et_d_ff port map(clk, S_D(5), lat, rst, S_F(5));
	ff6 : reg_pos_et_d_ff port map(clk, S_D(6), lat, rst, S_F(6));
	ff7 : reg_pos_et_d_ff port map(clk, S_D(7), lat, rst, S_F(7));
	ff8 : reg_pos_et_d_ff port map(clk, S_D(8), lat, rst, S_F(8));
	ff9 : reg_pos_et_d_ff port map(clk, S_D(9), lat, rst, S_F(9));
	ff10 : reg_pos_et_d_ff port map(clk, S_D(10), lat, rst, S_F(10));
	ff11 : reg_pos_et_d_ff port map(clk, S_D(11), lat, rst, S_F(11));
	ff12 : reg_pos_et_d_ff port map(clk, S_D(12), lat, rst, S_F(12));
	ff13 : reg_pos_et_d_ff port map(clk, S_D(13), lat, rst, S_F(13));
	ff14 : reg_pos_et_d_ff port map(clk, S_D(14), lat, rst, S_F(14));
	ff15 : reg_pos_et_d_ff port map(clk, S_D(15), lat, rst, S_F(15));
	ff16 : reg_pos_et_d_ff port map(clk, S_D(16), lat, rst, S_F(16));
	ff17 : reg_pos_et_d_ff port map(clk, S_D(17), lat, rst, S_F(17));
	ff18 : reg_pos_et_d_ff port map(clk, S_D(18), lat, rst, S_F(18));
	ff19 : reg_pos_et_d_ff port map(clk, S_D(19), lat, rst, S_F(19));
	ff20 : reg_pos_et_d_ff port map(clk, S_D(20), lat, rst, S_F(20));
	ff21 : reg_pos_et_d_ff port map(clk, S_D(21), lat, rst, S_F(21));
	ff22 : reg_pos_et_d_ff port map(clk, S_D(22), lat, rst, S_F(22));
	ff23 : reg_pos_et_d_ff port map(clk, S_D(23), lat, rst, S_F(23));
	ff24 : reg_pos_et_d_ff port map(clk, S_D(24), lat, rst, S_F(24));
	ff25 : reg_pos_et_d_ff port map(clk, S_D(25), lat, rst, S_F(25));
	ff26 : reg_pos_et_d_ff port map(clk, S_D(26), lat, rst, S_F(26));
	ff27 : reg_pos_et_d_ff port map(clk, S_D(27), lat, rst, S_F(27));
	ff28 : reg_pos_et_d_ff port map(clk, S_D(28), lat, rst, S_F(28));
	ff29 : reg_pos_et_d_ff port map(clk, S_D(29), lat, rst, S_F(29));
	ff30 : reg_pos_et_d_ff port map(clk, S_D(30), lat, rst, S_F(30));
	ff31 : reg_pos_et_d_ff port map(clk, S_D(31), lat, rst, S_F(31));
	
	S_C(0) <= S_F(0);
	f <= S_F;
	
	process(s_inc, d, S_D, S_F, S_C, S_HA_F) 
	begin
		if(s_inc = '1') then	
			S_D(0) <= not S_F(0);
			S_D(30 downto 1) <= S_HA_F;
			S_D(31) <= S_F(31) xor S_C(30);
		else
			S_D <= d;
		end if;
	end process;

end Behavioral;

