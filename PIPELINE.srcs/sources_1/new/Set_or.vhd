library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Set_or is
	port(
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(15 downto 0) ;
		FAIL : out std_logic;
		MATCH : out std_logic);
end Set_or;

architecture Behavioral of Set_or is
	
begin
	
	MATCH <= '1' when (TRG = '1' and (TEXT_IN = NEZ_IN(15 downto 8) or TEXT_IN = NEZ_IN(7 downto 0))) else '0';
	FAIL  <= '1' when (TRG = '1' and (TEXT_IN /= NEZ_IN(15 downto 8) and TEXT_IN /= NEZ_IN(7 downto 0))) else '0';
	
end Behavioral;
