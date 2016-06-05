library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Obyte is
	port(
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(7 downto 0) ;
		NEXT_TEXT : out std_logic;
		MATCH : out std_logic);
end Obyte;

architecture Behavioral of Obyte is

begin

	MATCH <= TRG;
	NEXT_TEXT  <= '1' when (TRG = '1' and TEXT_IN = NEZ_IN) else '0';
	
end Behavioral;
