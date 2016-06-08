library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Rset is
	port(
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(15 downto 0) ;
		NEXT_IST : out std_logic;
		NEXT_TEXT : out std_logic);
end Rset;

architecture Behavioral of Rset is
	
begin
	
	NEXT_TEXT <= '1' when (TRG = '1' and (TEXT_IN >= NEZ_IN(15 downto 8) and TEXT_IN <= NEZ_IN(7 downto 0))) else '0';
	NEXT_IST  <= '1' when (TRG = '1' and not (TEXT_IN >= NEZ_IN(15 downto 8) and TEXT_IN <= NEZ_IN(7 downto 0))) else '0';
	
end Behavioral;
