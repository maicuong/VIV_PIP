library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Rset is
	port(
	    CLK : in std_logic;
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(15 downto 0) ;
		NEXT_IST : out std_logic;
		NEXT_TEXT : out std_logic);
end Rset;

architecture Behavioral of Rset is
    signal next_text_reg, next_ist_reg : std_logic;
begin
	
process (CLK)
begin
    if(CLK'event and CLK = '1') then
       if (TRG = '1') then
            if (TEXT_IN >= NEZ_IN(15 downto 8) and TEXT_IN <= NEZ_IN(7 downto 0)) then
                next_text_reg <= '1' ;
                next_ist_reg <= '0' ;
            else
                next_ist_reg <= '1' ;
                next_text_reg <= '0' ;
            end if;
        else
            next_text_reg <= '0' ;
            next_ist_reg <= '0' ;
        end if;
    end if;
end process;
	
    NEXT_TEXT <= next_text_reg;
    NEXT_IST <= next_ist_reg;

	
end Behavioral;
