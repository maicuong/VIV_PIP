library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Byte is
	port(
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(7 downto 0) ;
		FAIL : out std_logic;
		MATCH : out std_logic);
end Byte;

architecture Behavioral of BYTE is
	--signal match_reg : std_logic := '0' ;
--signal fail_reg : std_logic := '0' ;

begin
--process (CLK)
--begin
    --if(CLK'event and CLK = '1') then
        --if (TRG = '1') then
            --if (TEXT_IN = NEZ_IN) then
               -- match_reg <= '1' ;
            --else
                --fail_reg <= '1' ;
            ---end if;
        --else
           -- match_reg <= '0' ;
            --fail_reg <= '0' ;
        --end if;
    --end if;
--end process;

	MATCH <= '1' when (TRG = '1' and TEXT_IN = NEZ_IN) else '0';
	FAIL  <= '1' when (TRG = '1' and TEXT_IN /= NEZ_IN) else '0';
	
end Behavioral;