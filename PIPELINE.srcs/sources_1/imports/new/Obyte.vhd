library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Obyte is
	port(
	    CLK : in std_logic;
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(7 downto 0) ;
		NEXT_TEXT : out std_logic;
		MATCH : out std_logic);
end Obyte;

architecture Behavioral of OBYTE is
	signal next_text_reg : std_logic := '0' ;
signal match_reg : std_logic := '0' ;

begin
process (CLK)
begin
    if(CLK'event and CLK = '1') then
        if (TRG = '1') then
            if (TEXT_IN = NEZ_IN) then
                next_text_reg <= '1' ;
            end if;
            match_reg <= '1';
        else
            match_reg <= '0' ;
            next_text_reg <= '0' ;
        end if;
    end if;
end process;

NEXT_TEXT <= next_text_reg;
MATCH <= match_reg;

	--MATCH <= '1' when (TRG = '1' and TEXT_IN = NEZ_IN) else '0';
	--FAIL  <= '1' when (TRG = '1' and TEXT_IN /= NEZ_IN) else '0';
	
end Behavioral;