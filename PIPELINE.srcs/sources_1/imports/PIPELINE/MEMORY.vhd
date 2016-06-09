library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEMORY is
		port (read, write, rst : in std_logic;
				addr : in std_logic_vector(31 downto 0);
				data : inout std_logic_vector(31 downto 0));
end MEMORY;

architecture RTL of MEMORY is
  type ram_type is array (7 downto 0) of std_logic_vector (31 downto 0); 
    signal RAM : ram_type ;--:= (--1@@@@@@@ 1@@@@@@@  1@@@@@@@ 1@@@@@@@
                               --"00000000000000000000001000000000",
                              --1@@@@@@@ 1@@@@@@@  1@@@@@@@ 1@@@@@@@
                               --"00000101000000000000001000000011", --Rset [1-3]
                               --"00000100000000000000001000000000", --Nany
                               --1@@@@@@@ 1@@@@@@@  1@@@@@@@ 1@@@@@@@ 
                               --"00000011000000000000001000000100", --Obyte '4'
                               --"10000010000000010000001000000011", --Set_or [23]
                              --1@@@@@@@ 1@@@@@@@  1@@@@@@@ 1@@@@@@@
                               --"00000010000000100000000100000111", --Set [1-7]
                               --"00000001000000000000000100000001"); --Byte '1'
                               
    signal ADDR_REG : std_logic_vector(31 downto 0) ; 
begin
	
	process(read, write, rst)
	begin
		if(read = '1') then
			data <= RAM(CONV_INTEGER(addr));
		elsif(write = '1') then
			RAM(CONV_INTEGER(addr)) <= data;
		elsif(rst = '1') then
		RAM(7) <=  "00000000000000000000001000000000";
        RAM(6) <=  "00000110000000000000001100000001"; --Call 3 1
                  --1@@@@@@@ 1@@@@@@@  1@@@@@@@ 1@@@@@@@ 
        RAM(5) <=  "00000101000000000000000100000111"; --Rset [1-7]
        RAM(4) <=  "00000100000000000000001000000000"; --Nany
                 --1@@@@@@@ 1@@@@@@@  1@@@@@@@ 1@@@@@@@ 
        RAM(3) <= "00000011000000000000001000000100"; --Obyte '4'
        RAM(2) <= "10000010000000010000001000000011"; --Set_or [23]
                 --1@@@@@@@ 1@@@@@@@  1@@@@@@@ 1@@@@@@@
        RAM(1) <= "00000010000000100000000100001001"; --Set [1-9]
        RAM(0) <= "00000001000000000000000100000001"; --Byte '1'		  
		--else
			--data <= (others => '0');
		end if;
	end process;
	
end RTL;
