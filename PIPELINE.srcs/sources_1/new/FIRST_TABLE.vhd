library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FIRST_TABLE is
		port (read, write : in std_logic;
			 addr : in std_logic_vector(31 downto 0);
		     data_in : in std_logic_vector(7 downto 0);
			 data_out : out std_logic_vector(7 downto 0));
end FIRST_TABLE;

architecture RTL of FIRST_TABLE is
  type ram_type is array (10 downto 0) of std_logic_vector (7 downto 0); 
    signal RAM : ram_type ; 
    signal addr1, addr2, addr3 : std_logic_vector(7 downto 0);
begin

    --addr1 <= "00000101";
    --addr2 <= "00000111";
    --addr3 <= "00000010";
	
	RAM(5) <=  "00000001";
	RAM(7) <=  "00000010";
	RAM(1) <=  "00000011";
	
	process(read, write)
	begin
		if(read = '1') then
			data_out <= RAM((CONV_INTEGER(addr)-1));
		--elsif(write = '1') then
			--RAM(ADDR_REG) <= data_in;
			
		--else
			--data <= (others => '0');
		end if;
	end process;
	
end RTL;