library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FIRST_RECORD is
		port (read, write : in std_logic;
			 addr1, addr2 : in std_logic_vector(7 downto 0);
		     data_in : in std_logic_vector(7 downto 0);
			 data_out : out std_logic_vector(7 downto 0));
end FIRST_RECORD;

architecture RTL of FIRST_RECORD is  
  type ram_type is array (20 downto 0, 5 downto 0) of std_logic_vector (7 downto 0); 
    signal RAM : ram_type ; 
    signal addr_column, addr_line1, addr_line2, addr_line3, addr_line4 : std_logic_vector(7 downto 0);
begin

    --addr_column <= "00000011";
    --addr_line1 <= "00000001";
    --addr_line2 <= "00000100";
    --addr_line3 <= "00000110";
    --addr_line4 <= "00000000";
	
	RAM(0,0) <=  "00011001";
	RAM(1,0) <=  "00011001";
	RAM(2,0) <=  "00011001";
	RAM(3,0) <=  "00011001";
	RAM(4,0) <=  "00011001";
	RAM(5,0) <=  "00011001";
	RAM(6,0) <=  "00011001";
	RAM(7,0) <=  "00011001";
	RAM(8,0) <=  "00011001";
	RAM(9,0) <=  "00011001";
	RAM(10,0) <=  "00001000";
	RAM(11,0) <=  "00001000";
	RAM(12,0) <=  "00001000";
	RAM(13,0) <=  "00001000";
	RAM(14,0) <=  "00010001";
	RAM(15,0) <=  "00001000";
	RAM(16,0) <=  "00001000";
	RAM(17,0) <=  "00001000";
	RAM(18,0) <=  "00001000";
	RAM(19,0) <=  "00001000";

	
	process(read, write)
	begin
		if(read = '1') then
			--data_out <= "00000101"; --RAM(CONV_INTEGER(addr1),CONV_INTEGER(addr2));
			data_out <= RAM(CONV_INTEGER(addr1),CONV_INTEGER(addr2));
		--elsif(write = '1') then
			--RAM(ADDR_REG) <= data_in;
			
		--else
			--data <= (others => '0');
		end if;
	end process;
	
end RTL;