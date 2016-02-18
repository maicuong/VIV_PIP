library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEMORY_8 is
		port (read, write : in std_logic;
				addr : in std_logic_vector(31 downto 0);
				data : inout std_logic_vector(7 downto 0));
end MEMORY_8;

architecture RTL of MEMORY_8 is
  type ram_type is array (3 downto 0) of std_logic_vector (7 downto 0); 
    signal RAM : ram_type := ("00000000", "00011000", "00001000", "00000000"); 
    signal ADDR_REG : std_logic_vector(31 downto 0) ; 
begin
	
	process(read, write)
	begin
		if(read = '1') then
			data <= RAM(CONV_INTEGER(addr));
		elsif(write = '1') then
			RAM(CONV_INTEGER(addr)) <= data;
		--else
			--data <= (others => '0');
		end if;
	end process;
	
end RTL;
