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
        Set_r, Byte_r, Set_or_r, Obyte_r, Rset_r, Call_r : out std_logic);
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
        else 
            Set_r <= '0';
         end if;
     end if;
 end process;

process(clk)
begin
    if(clk'event and clk = '1') then
        if (trg = '1') then
            if(instruction(31 downto 24) = "00000001") then
                Byte_r <= '1';
            else
                Byte_r <= '0';
            end if;
        else 
            Byte_r <= '0';
         end if;
     end if;
 end process;
 
 process(clk)
 begin
     if(clk'event and clk = '1') then
         if (trg = '1') then
             if(instruction(31 downto 24) = "10000010") then
                 Set_or_r <= '1';
             else
                 Set_or_r <= '0';
             end if;
         else 
             Set_or_r <= '0';
          end if;
      end if;
  end process;
  
process(clk)
  begin
      if(clk'event and clk = '1') then
          if (trg = '1') then
              if(instruction(31 downto 24) = "00000011") then
                  Obyte_r <= '1';
              else
                  Obyte_r <= '0';
              end if;
          else 
              Obyte_r <= '0';
           end if;
       end if;
   end process;

process(clk)
  begin
      if(clk'event and clk = '1') then
          if (trg = '1') then
              if(instruction(31 downto 24) = "00000100") then
                  Rset_r <= '1';
              else
                  Rset_r <= '0';
              end if;
          else 
              Rset_r <= '0';
           end if;
       end if;
   end process;

process(clk)
  begin
      if(clk'event and clk = '1') then
          if (trg = '1') then
              if(instruction(31 downto 24) = "00000101") then
                  Call_r <= '1';
              else
                  Call_r <= '0';
              end if;
          else 
              Call_r <= '0';
           end if;
       end if;
   end process;


end Behavioral;
