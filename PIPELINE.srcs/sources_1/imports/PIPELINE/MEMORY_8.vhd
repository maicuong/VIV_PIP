library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEMORY_8 is
		port (clk, read, write, rst : in std_logic;
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
 

    RAM(0) <= "00101000"; -- (
    RAM(1) <= "00101000"; -- (
    RAM(2) <= "00101000"; -- (
    RAM(3) <= "00101000"; -- (
    RAM(4) <= "00101000"; -- (
    RAM(5) <= "00101000"; -- (
    RAM(6) <= "00101000"; -- (
    RAM(7) <= "00101000"; -- (
    RAM(8) <= "00101000"; -- (
    RAM(9) <= "00101000"; -- (
    RAM(10) <= "00101000"; -- (
    RAM(11) <= "00101000"; -- (
    RAM(12) <= "00101000"; -- (
    RAM(13) <= "00101000"; -- (
    RAM(14) <= "00101000"; -- (
    RAM(15) <= "00101000"; -- (
    RAM(16) <= "00101000"; -- (
    RAM(17) <= "00101000"; -- (
    RAM(18) <= "00101000"; -- (
    
    --RAM(19) <= "00101011"; -- 1
    --RAM(20) <= "00000000"; -- 1
    --RAM(21) <= "00000000"; -- 1
    
    RAM(19) <= "00110001"; -- 1
    RAM(20) <= "00101011"; -- +
    RAM(21) <= "00110001"; -- 1
    
    RAM(22) <= "00101001"; -- )
    RAM(23) <= "00101001"; -- )
    RAM(24) <= "00101001"; -- )
    RAM(25) <= "00101001"; -- )
    RAM(26) <= "00101001"; -- )
    RAM(27) <= "00101001"; -- )
    RAM(28) <= "00101001"; -- )
    RAM(29) <= "00101001"; -- )
    RAM(30) <= "00101001"; -- )
    RAM(31) <= "00101001"; -- )
    RAM(32) <= "00101001"; -- )
    RAM(33) <= "00101001"; -- )
    RAM(34) <= "00101001"; -- )
    RAM(35) <= "00101001"; -- )
    RAM(36) <= "00101001"; -- )
    RAM(37) <= "00101001"; -- )
    RAM(38) <= "00101001"; -- )
    RAM(39) <= "00101001"; -- )
    RAM(40) <= "00101001"; -- )
    
    RAM(41) <= "00000000"; 
    
    
    
    
	
	process(clk)
	begin
	   if(clk'event and clk = '1') then
		if(read = '1') then
			data <= RAM(CONV_INTEGER(addr));
		--elsif(write = '1') then
			--RAM(CONV_INTEGER(addr)) <= data;
	    --elsif(rst = '1') then
	
		--else
			--data <= (others => '0');
		end if;
	   end if;
	end process;
	
end RTL;