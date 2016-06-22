library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEMORY_8 is
		port (read, write, rst : in std_logic;
				addr : in std_logic_vector(31 downto 0);
				data : inout std_logic_vector(7 downto 0));
end MEMORY_8;

architecture RTL of MEMORY_8 is
  type ram_type is array (100 downto 0) of std_logic_vector (7 downto 0); 
    signal RAM : ram_type ;--:= ("00000000",
                              --"00000010",
                              --"00000010",
                              --"00000010",
                              --"00000010",
                              --"00000010",
                              --"00000101",
                              --"00000100", 
                              --"00000011", 
                              --"00000010", 
                              --"00000001"); 
    signal ADDR_REG : std_logic_vector(31 downto 0) ; 
begin
	
    RAM(19) <= "00010100";
RAM(18) <= "00010010";
RAM(17) <= "00010000";
RAM(16) <= "00001110";
RAM(15) <= "00001100";
RAM(14) <= "00001010";
RAM(13) <= "00001000";
RAM(12) <= "00000110";
RAM(11) <= "00000110";
RAM(10) <= "00010000";
    RAM(9) <= "00000100";
    RAM(8) <= "00000011";
    RAM(7) <= "00000010";
    RAM(6) <= "00000001";
    RAM(5) <= "00000000";
    RAM(4) <= "00001000";
    RAM(3) <= "00010000";
    RAM(2) <= "00000010";
    RAM(1) <= "00001000";
    RAM(0) <= "00000101";
	
	
	process(read, write, rst)
	begin
		if(read = '1') then
			data <= RAM(CONV_INTEGER(addr));
		--elsif(write = '1') then
			--RAM(CONV_INTEGER(addr)) <= data;
	    --elsif(rst = '1') then
	
		--else
			--data <= (others => '0');
		end if;
	end process;
	
end RTL;