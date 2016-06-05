library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nany is
	port(
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		FAIL : out std_logic;
		MATCH : out std_logic);
end Nany;

architecture Behavioral of Nany is

begin

	MATCH <= TRG;
	FAIL  <= '0';
	
end Behavioral;
