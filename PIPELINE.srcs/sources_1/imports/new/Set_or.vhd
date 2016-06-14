library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SET_or is
	port(
	    CLK : in std_logic;
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(15 downto 0) ;
		FAIL : out std_logic;
		MATCH : out std_logic);
end SET_or;

architecture Behavioral of SET_or is
    signal match_reg : std_logic := '0' ;
    signal fail_reg : std_logic := '0' ;
begin
	
process (CLK)
begin
    if(CLK'event and CLK = '1') then
       if (TRG = '1') then
            if (TEXT_IN = NEZ_IN(15 downto 8) or TEXT_IN = NEZ_IN(7 downto 0)) then
                match_reg <= '1' ;
            else
                fail_reg <= '1' ;
            end if;
        else
            match_reg <= '0' ;
            fail_reg <= '0' ;
        end if;
    end if;
end process;
	
	MATCH <= match_reg;
	FAIL <= fail_reg;
	
	
	--MATCH <= '1' when (TRG = '1' and (TEXT_IN >= NEZ_IN(15 downto 8) and TEXT_IN <= NEZ_IN(7 downto 0))) else '0';
	--FAIL  <= '1' when (TRG = '1' and not (TEXT_IN >= NEZ_IN(15 downto 8) and TEXT_IN <= NEZ_IN(7 downto 0))) else '0';
	
end Behavioral;
