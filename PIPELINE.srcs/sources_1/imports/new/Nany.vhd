library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Nany is
	port(
	    CLK : in std_logic;
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		FAIL : out std_logic;
		MATCH : out std_logic);
end Nany;

architecture Behavioral of Nany is

begin

process(clk)
    begin
        if(clk'event and clk = '1') then
            if(TRG = '1') then
                MATCH <= '1';
                FAIL <= '0';
            else
                MATCH <= '0';
                FAIL <= '0';
            end if;
        end if;
    end process;
	
end Behavioral;
