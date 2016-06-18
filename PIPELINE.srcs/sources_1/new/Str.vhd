library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Str is
	port(
	    CLK : in std_logic;
		FIRST_TRG : in std_logic;
		SECOND_TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(15 downto 0) ;
		GOTO_NEXT_TEXT : out std_logic;
		FAIL : out std_logic;
		MATCH : out std_logic);
end Str;

architecture Behavioral of Str is
	signal match_reg : std_logic := '0' ;
    signal fail_reg : std_logic := '0' ;
    signal goto_next_text_reg : std_logic := '0';
    
begin
process (CLK)
begin
    if(CLK'event and CLK = '1') then
        if (FIRST_TRG = '1') then
            if (TEXT_IN = NEZ_IN(15 downto 8)) then
                goto_next_text_reg <= '1' ;
            else
                fail_reg <= '1' ;
            end if;
        elsif (SECOND_TRG = '1') then
            if (TEXT_IN = NEZ_IN(7 downto 0)) then
                match_reg <= '1' ;
            else
                fail_reg <= '1' ;
            end if;
        else
            goto_next_text_reg <= '0';
            match_reg <= '0' ;
            fail_reg <= '0' ;
        end if;
    end if;
end process;

GOTO_NEXT_TEXT <= goto_next_text_reg;
MATCH <= match_reg;
FAIL <= fail_reg;

	--MATCH <= '1' when (TRG = '1' and TEXT_IN = NEZ_IN) else '0';
	--FAIL  <= '1' when (TRG = '1' and TEXT_IN /= NEZ_IN) else '0';
	
end Behavioral;