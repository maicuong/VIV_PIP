library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity op_decoder is
	port(Op : in std_logic_vector(7 downto 0);
		  Byte_r: out std_logic);
end op_decoder;

architecture Behavioral of op_decoder is

begin

	process(Op)
	begin
		if(Op = "00000001") then
			Byte_r <= '1';
		else
			Byte_r <= '0';
		end if;
	end process;

end Behavioral;


