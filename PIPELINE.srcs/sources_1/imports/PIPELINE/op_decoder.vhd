library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity op_decoder is
	port(Op : in std_logic_vector(7 downto 0);
	     trg : in std_logic;
		 Set_r : out std_logic);
end op_decoder;

architecture Behavioral of op_decoder is

begin
	
    process(Op)
    begin
        if(Op = "00000010") then
            Set_r <= '1';
        else
            Set_r <= '0';
        end if;
    end process;

end Behavioral;