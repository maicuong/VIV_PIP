library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity op_decoder is
	port(Op : in std_logic_vector(7 downto 0);
	     trg : in std_logic;
		 Byte_r: out std_logic;
		 Set_r : out std_logic;
		 Set_or_r : out std_logic;
		 Obyte_r : out std_logic;
		 Nany_r : out std_logic;
		 Rset_r : out std_logic;
		 Call_r : out std_logic);
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
	
    process(Op)
    begin
        if(Op = "00000010") then
            Set_r <= '1';
        else
            Set_r <= '0';
        end if;
    end process;
    
    process(Op)
    begin
        if(Op = "10000010") then
            Set_or_r <= '1';
        else
            Set_or_r <= '0';
        end if;
    end process;
    
    process(Op)
    begin
        if(Op = "00000011") then
            Obyte_r <= '1';
        else
            Obyte_r <= '0';
        end if;
    end process;
    
    process(Op)
    begin
        if(Op = "00000100") then
            Nany_r <= '1';
        else
            Nany_r <= '0';
        end if;
    end process;

    process(Op)
    begin
        if(Op = "00000101") then
            Rset_r <= '1';
        else
            Rset_r <= '0';
        end if;
    end process;

    process(Op)
    begin
        if(Op = "00000110") then
            Call_r <= '1';
        else
            Call_r <= '0';
        end if;
    end process;

end Behavioral;


