library IEEE, STD;
use IEEE.std_logic_1164.all;
use STD.textio.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--library work;
--use work.lpm_pack.all;

entity FIRST_TABLE is
    port(
        clk, reset : in std_logic;
        wr : in std_logic;
        dad : in std_logic_vector(8 downto 0);
        ini : in std_logic_vector(31 downto 0);
        dout : out std_logic_vector(31 downto 0));
end FIRST_TABLE;

architecture RTL of FIRST_TABLE is
--type RamType is array(0 to 255) of bit_vector(31 downto 0);
type RamType is array(0 to 511) of std_logic_vector(31 downto 0);
signal RAM : RamType;
begin
    -- データ用RAM
        --process (clk) begin
        --if clk'event and clk = '1' then
            --if wr = '1' then
                --RAM(conv_integer(dad)) <= to_bitvector(ini);
            --end if;
            --dout <= to_stdlogicvector(RAM(conv_integer(dad)));
        --end if;
    --end process;
    
      process(CLK) begin
      if (CLK'event and CLK = '1') then
        if (WR = '1') then 
          RAM(CONV_INTEGER(dad)) <= ini; 
        end if; 
        --ADDR_REG <= ADDR_IN; 
        DOUT <= RAM(CONV_INTEGER(dad));
      end if; 
    end process;

end RTL;