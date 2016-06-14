----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2016/06/13 00:11:33
-- Design Name: 
-- Module Name: Dec - Behavioral
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

entity Dec is
  Port ( clk, trg : in std_logic;
        instruction : in std_logic_vector(31 downto 0);
        text_in : in std_logic_vector(7 downto 0);
        Set_r : out std_logic;
        nez_in, text_out : out std_logic_vector(7 downto 0) );
end Dec;

architecture Behavioral of Dec is

begin

process(clk)
begin
    if(clk'event and clk = '1') then
        if (trg = '1') then
            if(instruction(31 downto 24) = "00000010") then
                Set_r <= '1';
            else
                Set_r <= '0';
            end if;
            nez_in <= instruction(7 downto 0);
            text_out <= text_in;
        else 
            Set_r <= '0';
         end if;
     end if;
 end process;

end Behavioral;
