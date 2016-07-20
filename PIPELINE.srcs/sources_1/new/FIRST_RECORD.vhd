library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FIRST_RECORD is
		port (clk, read, write : in std_logic;
			 addr1, addr2 : in std_logic_vector(7 downto 0);
		     data_in : in std_logic_vector(7 downto 0);
			 data_out : out std_logic_vector(7 downto 0));
end FIRST_RECORD;

architecture RTL of FIRST_RECORD is  
  type ram_type is array (255 downto 0, 2 downto 0) of std_logic_vector (7 downto 0); 
    signal RAM : ram_type := (others => (others => (others => '0'))); 
    signal addr_column, addr_line1, addr_line2, addr_line3, addr_line4 : std_logic_vector(7 downto 0);
begin

    --addr_column <= "00000011";
    --addr_line1 <= "00000001";
    --addr_line2 <= "00000100";
    --addr_line3 <= "00000110";
    --addr_line4 <= "00000000";
	
	RAM(48,0) <=  "00011001"; -- 0
	RAM(49,0) <=  "00011001";
	RAM(50,0) <=  "00011001";
	RAM(51,0) <=  "00011001";
	RAM(52,0) <=  "00011001";
	RAM(53,0) <=  "00011001";
	RAM(54,0) <=  "00011001";
	RAM(55,0) <=  "00011001";
	RAM(56,0) <=  "00011001";
	RAM(57,0) <=  "00011001"; -- 9
	

	RAM(40,0) <=  "00010001"; -- (


	
	process(clk)
	begin
	   if(clk'event and clk = '1') then
		if(read = '1') then
			--data_out <= "00000101"; --RAM(CONV_INTEGER(addr1),CONV_INTEGER(addr2));
			data_out <= RAM(CONV_INTEGER(addr1),CONV_INTEGER(addr2));
		--elsif(write = '1') then
			--RAM(ADDR_REG) <= data_in;
			
		--else
			--data <= (others => '0');
		end if;
		end if;
	end process;
	
end RTL;