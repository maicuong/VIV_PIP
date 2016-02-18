library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Positive edge-triggered
entity pos_et_d_ff is
	port(CK, D : in std_logic;
			Q,Q_BAR : out std_logic);
end pos_et_d_ff;

architecture Behavioral of pos_et_d_ff is
	
	signal S_A1, S_A2, S_A3, S_A4, S_Q, S_Q_BAR : std_logic;

begin
	
	S_A1 <= not (S_A2 and S_A4);
	S_A2 <= not (CK and S_A1);
	S_A3 <= not (S_A2 and CK and S_A4);
	S_A4 <= not (S_A3 and D);
	S_Q <= not (S_A2 and S_Q_BAR);
	S_Q_BAR <= not (S_Q and S_A3);
	Q <= S_Q;
	Q_BAR <= S_Q_BAR;


end Behavioral;

