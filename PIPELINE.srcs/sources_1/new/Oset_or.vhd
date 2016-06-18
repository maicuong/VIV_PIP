----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2016/06/17 16:12:08
-- Design Name: 
-- Module Name: Oset_or - Behavioral
-- Project Name: 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OSet_or is
	port(
	    CLK : in std_logic;
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(15 downto 0) ;
		NEXT_TEXT : out std_logic;
		MATCH : out std_logic);
end OSet_or;

architecture Behavioral of OSet_or is
	signal next_text_reg : std_logic := '0' ;
signal match_reg : std_logic := '0' ;

begin
process (CLK)
begin
    if(CLK'event and CLK = '1') then
        if (TRG = '1') then
            if (TEXT_IN = NEZ_IN(15 downto 8) or TEXT_IN = NEZ_IN(7 downto 0)) then
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
