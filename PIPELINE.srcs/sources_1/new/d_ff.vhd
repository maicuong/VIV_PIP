----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2016/06/12 23:16:29
-- Design Name: 
-- Module Name: d_ff - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity d_ff is
  Port ( clk, trg : in std_logic;
    next_trg : out std_logic );
end d_ff;

architecture Behavioral of d_ff is

begin

process(clk)
begin
    if(clk'event and clk = '1') then
        if(trg = '1') then
            next_trg <= '1';
        else
            next_trg <= '0';
        end if;
     end if;
end process;

end Behavioral;
