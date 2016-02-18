library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--16 bit register

entity reg_16 is
	port(clk, lat, rst : in std_logic;
			a : in std_logic_vector(31 downto 0);
			f : out std_logic_vector(31 downto 0));
end reg_16;

architecture Behavioral of reg_16 is

	component reg_pos_et_d_ff
		port(clk, D, lat, rst: in std_logic;
				Q : out std_logic);
	end component;
	
	signal S_F : std_logic_vector(31 downto 0);

begin

	reg_pos_et_d_ff0 : reg_pos_et_d_ff port map(clk, a(0), lat, rst, S_F(0));
	reg_pos_et_d_ff1 : reg_pos_et_d_ff port map(clk, a(1), lat, rst, S_F(1));
	reg_pos_et_d_ff2 : reg_pos_et_d_ff port map(clk, a(2), lat, rst, S_F(2));
	reg_pos_et_d_ff3 : reg_pos_et_d_ff port map(clk, a(3), lat, rst, S_F(3));
	reg_pos_et_d_ff4	: reg_pos_et_d_ff port map(clk, a(4), lat, rst, S_F(4));
	reg_pos_et_d_ff5 : reg_pos_et_d_ff port map(clk, a(5), lat, rst, S_F(5));
	reg_pos_et_d_ff6 : reg_pos_et_d_ff port map(clk, a(6), lat, rst, S_F(6));
	reg_pos_et_d_ff7 : reg_pos_et_d_ff port map(clk, a(7), lat, rst, S_F(7));
	reg_pos_et_d_ff8 : reg_pos_et_d_ff port map(clk, a(8), lat, rst, S_F(8));
	reg_pos_et_d_ff9 : reg_pos_et_d_ff port map(clk, a(9), lat, rst, S_F(9));
	reg_pos_et_d_ff10 : reg_pos_et_d_ff port map(clk, a(10), lat, rst, S_F(10));
	reg_pos_et_d_ff11 : reg_pos_et_d_ff port map(clk, a(11), lat, rst, S_F(11));
	reg_pos_et_d_ff12 : reg_pos_et_d_ff port map(clk, a(12), lat, rst, S_F(12));
	reg_pos_et_d_ff13 : reg_pos_et_d_ff port map(clk, a(13), lat, rst, S_F(13));
	reg_pos_et_d_ff14 : reg_pos_et_d_ff port map(clk, a(14), lat, rst, S_F(14));
	reg_pos_et_d_ff15 : reg_pos_et_d_ff port map(clk, a(15), lat, rst, S_F(15));
	reg_pos_et_d_ff16 : reg_pos_et_d_ff port map(clk, a(16), lat, rst, S_F(16));
	reg_pos_et_d_ff17 : reg_pos_et_d_ff port map(clk, a(17), lat, rst, S_F(17));
	reg_pos_et_d_ff18 : reg_pos_et_d_ff port map(clk, a(18), lat, rst, S_F(18));
	reg_pos_et_d_ff19 : reg_pos_et_d_ff port map(clk, a(19), lat, rst, S_F(19));
	reg_pos_et_d_ff20 : reg_pos_et_d_ff port map(clk, a(20), lat, rst, S_F(20));
	reg_pos_et_d_ff21 : reg_pos_et_d_ff port map(clk, a(21), lat, rst, S_F(21));
	reg_pos_et_d_ff22 : reg_pos_et_d_ff port map(clk, a(22), lat, rst, S_F(22));
	reg_pos_et_d_ff23 : reg_pos_et_d_ff port map(clk, a(23), lat, rst, S_F(23));
	reg_pos_et_d_ff24 : reg_pos_et_d_ff port map(clk, a(24), lat, rst, S_F(24));
	reg_pos_et_d_ff25 : reg_pos_et_d_ff port map(clk, a(25), lat, rst, S_F(25));
	reg_pos_et_d_ff26 : reg_pos_et_d_ff port map(clk, a(26), lat, rst, S_F(26));
	reg_pos_et_d_ff27 : reg_pos_et_d_ff port map(clk, a(27), lat, rst, S_F(27));
	reg_pos_et_d_ff28 : reg_pos_et_d_ff port map(clk, a(28), lat, rst, S_F(28));
	reg_pos_et_d_ff29 : reg_pos_et_d_ff port map(clk, a(29), lat, rst, S_F(29));
	reg_pos_et_d_ff30 : reg_pos_et_d_ff port map(clk, a(30), lat, rst, S_F(30));
	reg_pos_et_d_ff31 : reg_pos_et_d_ff port map(clk, a(31), lat, rst, S_F(31));


	f <= S_F;

end Behavioral;

