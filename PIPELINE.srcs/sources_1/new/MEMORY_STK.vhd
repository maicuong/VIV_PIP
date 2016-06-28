library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEMORY_STK is
		port (clk, read, write : in std_logic;
				addr_in : in std_logic_vector(10 downto 0);
				addr_out : in std_logic_vector(10 downto 0);
				data_in : in std_logic_vector(31 downto 0);
				data_out : out std_logic_vector(31 downto 0));
end MEMORY_STK;

architecture RTL of MEMORY_STK is
  type ram_type is array (2045 downto 0) of std_logic_vector (31 downto 0); 
    signal RAM : ram_type := (others => (others => '0'));--:= ("00000000000000000000000000010000", "00000000000000000000000000010000", "00000000000000000000000000010000", "00000000000000000000000000010000"); 
    signal ADDR_REG : integer ; 
begin
	
	--ADDR_REG <= CONV_INTEGER(addr_out);
	--RAM(0) <=  "00000000000000000000000000010000";
	--RAM(1) <=  "00000000000000000000000000010000";
	--RAM(2) <=  "00000000000000000000000000010000";
	--RAM(3) <=  "00000000000000000000000000010000";
	
	process(clk)
	begin
	   if(clk'event and clk = '1') then
	   if(read = '1' and addr_out = "11111111111") then
	       data_out <= (others => '0');
		elsif(read = '1') then -- and ADDR_REG >= 0 and ADDR_REG <= 50) then
			data_out <= RAM(CONV_INTEGER(addr_out));
			--RAM(ADDR_REG) <= (others => '0');
		elsif(write = '1') then
			RAM(CONV_INTEGER(addr_in)) <= data_in;
			
			--RAM(0) <=  "00000000000000000000000000010000";
            --RAM(ADDR_REG) <=  "00000000000000000000000000010000";
            --RAM(2) <=  "00000000000000000000000000010000";
            --RAM(3) <=  "00000000000000000000000000010000";
			
		--else
			--data <= (others => '0');
		end if;
	end if;
	end process;
	
end RTL;