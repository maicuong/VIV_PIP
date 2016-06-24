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
  Port ( clk, trg, str_goto_next_text : in std_logic;
        instruction : in std_logic_vector(31 downto 0);
        Set_r, Byte_r, Set_or_r, Obyte_r, Rset_r, Call_r, 
        Return_r, Alt_r, OSet_r, OSet_or_r, Str_first_r, Str_second_r, 
        First_r, Fail_r, Succ_r, Pass_r, Skip_r : out std_logic);
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
         
process(clk)
    begin
      if(clk'event and clk = '1') then
         if (trg = '1') then
             if(instruction(31 downto 24) = "00000110") then
                Return_r <= '1';
             else
                Return_r <= '0';
             end if;
          else 
                Return_r <= '0';
          end if;
       end if;
  end process;
  
process(clk)
      begin
        if(clk'event and clk = '1') then
           if (trg = '1') then
               if(instruction(31 downto 24) = "00000111") then
                  Alt_r <= '1';
               else
                  Alt_r <= '0';
               end if;
            else 
                  Alt_r <= '0';
            end if;
         end if;
    end process;
    
process(clk)
       begin
            if(clk'event and clk = '1') then
               if (trg = '1') then
                   if(instruction(31 downto 24) = "00001000") then
                      Oset_r <= '1';
                   else
                      Oset_r <= '0';
                   end if;
                else 
                      Oset_r <= '0';
                end if;
             end if;
        end process;
        
process(clk)
    begin
     if(clk'event and clk = '1') then
       if (trg = '1') then
         if(instruction(31 downto 24) = "10001000") then
           Oset_or_r <= '1';
         else
           Oset_or_r <= '0';
         end if;
       else 
           Oset_or_r <= '0';
       end if;
     end if;
 end process;
    
process(clk)
     begin
      if(clk'event and clk = '1') then
        if (trg = '1') then
          if(instruction(31 downto 24) = "00001001") then
            Str_first_r <= '1';
          else
            Str_first_r <= '0';
          end if;
        else 
            Str_first_r <= '0';
        end if;
      end if;
  end process;
  
process(clk)
    begin
        if(clk'event and clk = '1') then
            if(str_goto_next_text = '1') then
                Str_second_r <= '1';
            else
                Str_second_r <= '0';
            end if;
         end if;
    end process;

process(clk)
     begin
      if(clk'event and clk = '1') then
        if (trg = '1') then
          if(instruction(31 downto 24) = "00001010") then
            First_r <= '1';
          else
            First_r <= '0';
          end if;
        else 
            First_r <= '0';
        end if;
      end if;
  end process;
  
process(clk)
       begin
        if(clk'event and clk = '1') then
          if (trg = '1') then
            if(instruction(31 downto 24) = "00001011") then
              Fail_r <= '1';
            else
              Fail_r <= '0';
            end if;
          else 
              Fail_r <= '0';
          end if;
        end if;
    end process;

process(clk)
       begin
        if(clk'event and clk = '1') then
          if (trg = '1') then
            if(instruction(31 downto 24) = "00001100") then
              Succ_r <= '1';
            else
              Succ_r <= '0';
            end if;
          else 
              Succ_r <= '0';
          end if;
        end if;
    end process;

process(clk)
       begin
        if(clk'event and clk = '1') then
          if (trg = '1') then
            if(instruction(31 downto 24) = "00000000") then
              Pass_r <= '1';
            else
              Pass_r <= '0';
            end if;
          else 
              Pass_r <= '0';
          end if;
        end if;
    end process;
    
process(clk)
           begin
            if(clk'event and clk = '1') then
              if (trg = '1') then
                if(instruction(31 downto 24) = "00001101") then
                  Skip_r <= '1';
                else
                  Skip_r <= '0';
                end if;
              else 
                  Skip_r <= '0';
              end if;
            end if;
        end process;

end Behavioral;