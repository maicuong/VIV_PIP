----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2016/06/13 23:21:55
-- Design Name: 
-- Module Name: f - Behavioral
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

entity f is
   port(
        clk, trg : in std_logic;
instruction : in std_logic_vector(31 downto 0);
text_in : in std_logic_vector(7 downto 0);
nez_in : out std_logic_vector(15 downto 0); 
text_out : out std_logic_vector(7 downto 0);
f_out : out std_logic);
end f;

architecture Behavioral of f is

begin

    process(clk)
    begin
        if(clk'event and clk = '1') then
            if(trg = '1') then
                nez_in <= instruction(15 downto 0);
                text_out <= text_in;
                f_out <= '1';
            else
                f_out <= '0';
            end if;
         end if;
     end process;


end Behavioral;