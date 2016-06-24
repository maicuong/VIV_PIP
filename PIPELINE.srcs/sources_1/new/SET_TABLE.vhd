library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SET_TABLE is
		port (read, write : in std_logic;
			 addr1, addr2 : in std_logic_vector(7 downto 0);
		     data_in : in std_logic;
			 data_out : out std_logic);
end SET_TABLE;

architecture RTL of SET_TABLE is  
  type ram_type is array (20 downto 0, 5 downto 0) of std_logic; 
    signal RAM : ram_type := (others => (others => '0')) ; 
    signal addr_column, addr_line1, addr_line2, addr_line3, addr_line4 : std_logic_vector(7 downto 0);
begin

    --addr_column <= "00000011";
    --addr_line1 <= "00000001";
    --addr_line2 <= "00000100";
    --addr_line3 <= "00000110";
    --addr_line4 <= "00000000";
	
	RAM(16,0) <=  '1';
	RAM(17,0) <=  '1';
	
	RAM(18,1) <=  '1';
	RAM(19,1) <=  '1';
	
	--RAM(0,2) <= '1';
	RAM(1,2) <= '1';
	RAM(2,2) <= '1';
	RAM(3,2) <= '1';
    RAM(4,2) <= '1';
    RAM(5,2) <= '1';
	RAM(6,2) <= '1';
    RAM(7,2) <= '1';
    RAM(8,2) <= '1';
    RAM(9,2) <= '1';
    
	
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