library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEMORY is
		port (read, write : in std_logic;
				addr : in std_logic_vector(31 downto 0);
				data : inout std_logic_vector(31 downto 0));
end MEMORY;

architecture RTL of MEMORY is
  type ram_type is array (5 downto 0) of std_logic_vector (31 downto 0); 
    signal RAM : ram_type := (--1@@@@@@@ 1@@@@@@@  1@@@@@@@ 1@@@@@@@
                               "00000000000000000000001000000000",
                               "00000100000000000000001000000000", --Nany
                               --1@@@@@@@ 1@@@@@@@  1@@@@@@@ 1@@@@@@@ 
                               "00000011000000000000001000000100", --Obyte '4'
                               "10000010000000010000001000000011", --Set_or [23]
                              --1@@@@@@@ 1@@@@@@@  1@@@@@@@ 1@@@@@@@
                               "00000010000000100000000100000111", --Set [1-7]
                               "00000001000000000000000100000001"); --Byte '1'
                               
    signal ADDR_REG : std_logic_vector(31 downto 0) ; 
begin
	
	process(read, write)
	begin
		if(read = '1') then
			data <= RAM(CONV_INTEGER(addr));
		elsif(write = '1') then
			RAM(CONV_INTEGER(addr)) <= data;
		else
			data <= (others => '0');
		end if;
	end process;
	
end RTL;
