library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rw_d_counter_16 is
	port(lat, clk, rst, s_dcr : in std_logic;
			d : in std_logic_vector(15 downto 0);
			f : out std_logic_vector(15 downto 0));
end rw_d_counter_16;

architecture Behavioral of rw_d_counter_16 is

	component reg_pos_et_d_ff
		port(
			clk, D, lat, rst : in std_logic;
			Q : out std_logic);
	end component;

	signal S_C : std_logic_vector(14 downto 0);
	signal S_D, S_F : std_logic_vector(15 downto 0);
	
begin

	ff0 : reg_pos_et_d_ff port map(clk, D(0), lat, rst, S_F(0));
	ff1 : reg_pos_et_d_ff port map(clk, D(1), lat, rst, S_F(1));
	ff2 : reg_pos_et_d_ff port map(clk, D(2), lat, rst, S_F(2));
	ff3 : reg_pos_et_d_ff port map(clk, D(3), lat, rst, S_F(3));
	ff4 : reg_pos_et_d_ff port map(clk, D(4), lat, rst, S_F(4));
	ff5 : reg_pos_et_d_ff port map(clk, D(5), lat, rst, S_F(5));
	ff6 : reg_pos_et_d_ff port map(clk, D(6), lat, rst, S_F(6));
	ff7 : reg_pos_et_d_ff port map(clk, D(7), lat, rst, S_F(7));
	ff8 : reg_pos_et_d_ff port map(clk, D(8), lat, rst, S_F(8));
	ff9 : reg_pos_et_d_ff port map(clk, D(9), lat, rst, S_F(9));
	ff10 : reg_pos_et_d_ff port map(clk, D(10), lat, rst, S_F(10));
	ff11 : reg_pos_et_d_ff port map(clk, D(11), lat, rst, S_F(11));
	ff12 : reg_pos_et_d_ff port map(clk, D(12), lat, rst, S_F(12));
	ff13 : reg_pos_et_d_ff port map(clk, D(13), lat, rst, S_F(13));
	ff14 : reg_pos_et_d_ff port map(clk, D(14), lat, rst, S_F(14));
	ff15 : reg_pos_et_d_ff port map(clk, D(15), lat, rst, S_F(15));


	process(s_dcr, d, S_F) 
	begin
		if(s_dcr = '1') then
			S_D(0) <= not S_F(0);
			S_D(1) <= not (S_F(1) xor S_F(0));
			S_D(2) <= not (S_F(2) xor (S_F(1) or S_F(0)));
			S_D(3) <= not (S_F(3) xor (S_F(2) or S_F(1) or S_F(0)));
			S_D(4) <= not (S_F(4) xor (S_F(3) or S_F(2) or S_F(1) or S_F(0)));
			S_D(5) <= not (S_F(5) xor (S_F(4) or S_F(3) or S_F(2) or S_F(1) or S_F(0)));
			S_D(6) <= not (S_F(6) xor (S_F(5) or S_F(4) or S_F(3) or S_F(2) or S_F(1) or S_F(0)));
			S_D(7) <= not (S_F(7) xor (S_F(6) or S_F(5) or S_F(4) or S_F(3) or S_F(2) or S_F(1) or S_F(0)));
			S_D(8) <= not (S_F(8) xor (S_F(7) or S_F(6) or S_F(5) or S_F(4) or S_F(3) or S_F(2) or S_F(1) or S_F(0)));
			S_D(9) <= not (S_F(9) xor (S_F(8) or S_F(7) or S_F(6) or S_F(5) or S_F(4) or S_F(3) or S_F(2) or S_F(1) or S_F(0)));
			S_D(10) <= not (S_F(10) xor (S_F(9) or S_F(8) or S_F(7) or S_F(6) or S_F(5) or S_F(4) or S_F(3) or S_F(2) or S_F(1) or S_F(0)));
			S_D(11) <= not (S_F(11) xor (S_F(10) or S_F(9) or S_F(8) or S_F(7) or S_F(6) or S_F(5) or S_F(4) or S_F(3) or S_F(2) or S_F(1) or S_F(0)));
			S_D(12) <= not (S_F(12) xor (S_F(11) or S_F(10) or S_F(9) or S_F(8) or S_F(7) or S_F(6) or S_F(5) or S_F(4) or S_F(3) or S_F(2) or S_F(1) or S_F(0)));
			S_D(13) <= not (S_F(13) xor (S_F(12) or S_F(11) or S_F(10) or S_F(9) or S_F(8) or S_F(7) or S_F(6) or S_F(5) or S_F(4) or S_F(3) or S_F(2) or S_F(1) or S_F(0)));
			S_D(14) <= not (S_F(14) xor (S_F(13) or S_F(12) or S_F(11) or S_F(10) or S_F(9) or S_F(8) or S_F(7) or S_F(6) or S_F(5) or S_F(4) or S_F(3) or S_F(2) or S_F(1) or S_F(0)));
			S_D(15) <= not (S_F(15) xor (S_F(14) or S_F(13) or S_F(12) or S_F(11) or S_F(10) or S_F(9) or S_F(8) or S_F(7) or S_F(6) or S_F(5) or S_F(4) or S_F(3) or S_F(2) or S_F(1) or S_F(0)));
		else
			S_D <= d;
		end if;
	end process;
	
	f <= S_F;



end Behavioral;


