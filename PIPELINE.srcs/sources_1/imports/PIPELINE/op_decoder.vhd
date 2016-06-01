library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity op_decoder is
	port(Op : in std_logic_vector(7 downto 0);
	     trg : in std_logic;
		 Byte_r: out std_logic;
		 Set_r : out std_logic;
		 Set_or_r : out std_logic;
		 Obyte_r : out std_logic;
		 Nany_r : out std_logic);
end op_decoder;

architecture Behavioral of op_decoder is

begin

	process(Op,trg)
	begin
	   --if(trg'event and trg = '1') then
		if(Op = "00000001") then
			Byte_r <= '1';
			Set_r <= '0';
			Set_or_r <= '0';
			Obyte_r <= '0';
			Nany_r <= '0';
	    elsif(Op = "00000010") then
			Byte_r <= '0';
            Set_r <= '1';
            Set_or_r <= '0';
            Obyte_r <= '0';
            Nany_r <= '0';
	    elsif(Op = "10000010") then
            Byte_r <= '0';
            Set_r <= '0';
            Set_or_r <= '1';
            Obyte_r <= '0';
            Nany_r <= '0';
	    elsif(Op = "00000011") then
            Byte_r <= '0';
            Set_r <= '0';
            Set_or_r <= '0';
            Obyte_r <= '1';
            Nany_r <= '0';
	    elsif(Op = "00000100") then
            Byte_r <= '0';
            Set_r <= '0';
            Set_or_r <= '0';
            Obyte_r <= '0';
            Nany_r <= '1';
		else
            Byte_r <= '0';
            Set_r <= '0';
            Set_or_r <= '0';
            Obyte_r <= '0';
            Nany_r <= '0';
		end if;
	   --end if;
	end process;

end Behavioral;


