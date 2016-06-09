library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEMORY_STK is
		port (read, write, rst : in std_logic;
				addr : in std_logic_vector(15 downto 0);
				data_in : in std_logic_vector(31 downto 0);
				data_out : out std_logic_vector(31 downto 0));
end MEMORY_STK;

architecture RTL of MEMORY_STK is
  type ram_type is array (3 downto 0) of std_logic_vector (31 downto 0); 
    signal RAM : ram_type ;--:= ("00000000000000000000001000000000", "00000000000000000000001100000000", "00000000000000000000001100000000", "00000000000000000000000000000011"); 
    signal ADDR_REG : std_logic_vector(31 downto 0) ; 
begin
	
	process(read, write, rst)
	begin
		if(read = '1') then
			data_out <= RAM(CONV_INTEGER(addr));
		elsif(write = '1') then
			RAM(CONV_INTEGER(addr)) <= data_in;
		--elsif(rst = '1') then	
	        --RAM(3) <= "00000011000000000000001000000100"; --Obyte '4'
           -- RAM(2) <= "10000010000000010000001000000011"; --Set_or [23]
                     --1@@@@@@@ 1@@@@@@@  1@@@@@@@ 1@@@@@@@
           -- RAM(1) <= "00000010000000100000000100000111"; --Set [1-7]
            --RAM(0) <= "00000001000000000000000100000111"; --Byte '1'
		--else
			--data <= (others => '0');
		end if;
	end process;
	
end RTL;
