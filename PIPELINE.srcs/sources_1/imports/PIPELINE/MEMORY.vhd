library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEMORY is
		port (read, write, rst : in std_logic;
				addr : in std_logic_vector(31 downto 0) := (others => '0');
				data : inout std_logic_vector(31 downto 0));
end MEMORY;

architecture RTL of MEMORY is
  type ram_type is array (100 downto 0) of std_logic_vector (31 downto 0); 
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
	
	        RAM(0) <= "00000010000000000000000100000010"; --Byte '1'	
RAM(1) <= "00001001000000000000000100000010"; --Byte '1'
RAM(2) <= "00000001000000000001000000000110"; --Byte '1'
RAM(3) <= "00000001000000000000000000000000"; --Byte '1'
RAM(4) <= "10000010000000000000100100001010"; --Byte '1'
RAM(5) <= "00000010000000000000101100001100"; --Byte '1'
RAM(6) <= "00000100000000000000000100000111"; --Byte '1'
RAM(7) <= "00000001000000000000111100010000"; --Byte '1'
RAM(8) <= "00000001000000000001000000000110"; --Call 16 2
RAM(9) <= "00000001000000000000000000000000"; --Byte '1'
RAM(10) <= "00000001000000000000000100000010";
RAM(11) <= "10000010000000000000001100000100"; --Byte '1'
RAM(12) <= "00000011000000000000010100000110"; --Byte '1'
RAM(13) <= "00000001000000000000011100001000"; --Byte '1'
RAM(14) <= "00000001000000000000100100001010"; --Byte '1'
RAM(15) <= "00000011000000000000101100001100"; --Byte '1'
RAM(16) <= "00000001000000000000110100001000"; --Byte '1'
RAM(17) <= "00001000000000000000111100010000"; --Byte '1'
RAM(18) <= "10001000000000000001000100010010"; --Byte '1'
RAM(19) <= "00000000000000000001001100010100"; --Byte '1'	
	
	
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