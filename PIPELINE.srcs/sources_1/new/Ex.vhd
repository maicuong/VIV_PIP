----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2016/05/31 21:56:47
-- Design Name: 
-- Module Name: Ex - Behavioral
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

entity Ex is
 Port (clk, end_sig, Set_r, Byte_r, Set_or_r, Obyte_r, Rset_r, Call_r, Return_r, Alt_r, Oset_r, Oset_or_r : in  std_logic;
        instruction : in std_logic_vector(15 downto 0);
        text_in : in std_logic_vector(7 downto 0);
        Wait_text, Next_text, Next_ist, Fail: out std_logic);
end Ex;

architecture Behavioral of Ex is
	---Byte
component Byte
    port(
    CLK : in std_logic;
    TRG : in std_logic;
    TEXT_IN : in std_logic_vector(7 downto 0);
    NEZ_IN : in std_logic_vector(7 downto 0) ;
    FAIL : out std_logic;
    MATCH : out std_logic);
end component;

component Set
    port(
    CLK : in std_logic;
    TRG : in std_logic;
    TEXT_IN : in std_logic_vector(7 downto 0);
    NEZ_IN : in std_logic_vector(15 downto 0) ;
    FAIL : out std_logic;
    MATCH : out std_logic);
end component;

component Set_or
    port(
    CLK : in std_logic;
    TRG : in std_logic;
    TEXT_IN : in std_logic_vector(7 downto 0);
    NEZ_IN : in std_logic_vector(15 downto 0) ;
    FAIL : out std_logic;
    MATCH : out std_logic);
end component;

component Obyte
	port(
	    CLK : in std_logic;
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(7 downto 0) ;
		NEXT_TEXT : out std_logic;
		MATCH : out std_logic);
end component;

component Nany
	port(
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		FAIL : out std_logic;
		MATCH : out std_logic);
end component;

component Rset
	port(
	    CLK : in std_logic;
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(15 downto 0) ;
		NEXT_IST : out std_logic;
		NEXT_TEXT : out std_logic);
end component;

component OSet
	port(
	    CLK : in std_logic;
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(15 downto 0) ;
		NEXT_TEXT : out std_logic;
		MATCH : out std_logic);
end component;

component OSet_or
	port(
	    CLK : in std_logic;
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(15 downto 0) ;
		NEXT_TEXT : out std_logic;
		MATCH : out std_logic);
end component;

signal S_byte_match, S_byte_fail : std_logic;
signal S_set_match, S_set_fail : std_logic;
signal S_set_or_match, S_set_or_fail : std_logic;
signal S_obyte_match, S_obyte_next_text : std_logic;
signal S_nany_match, S_nany_fail : std_logic;
signal S_rset_next_ist, S_rset_next_text : std_logic;
signal S_call, S_Return, S_Alt : std_logic;
signal S_oset_match, S_oset_next_text : std_logic;
signal S_oset_or_match, S_oset_or_next_text : std_logic;

begin

	Byte1 : Byte port map (
	    CLK => clk,
		TRG => Byte_r,
		TEXT_IN => text_in,
		NEZ_IN => instruction(7 downto 0),
		FAIL => S_byte_fail,
		MATCH => S_byte_match);
		
	Set1 : Set port map(
	    CLK => clk,
        TRG => Set_r,
        TEXT_IN => text_in,
        NEZ_IN => instruction,
        FAIL => S_set_fail,
        MATCH => S_set_match);
        
	Set_or1 : Set_or port map(
	        CLK => clk,
            TRG => Set_or_r,
            TEXT_IN => text_in,
            NEZ_IN => instruction(15 downto 0),
            FAIL => S_set_or_fail,
            MATCH => S_set_or_match);
            
     Obyte1 : Obyte port map(
            CLK => clk,
            TRG => Obyte_r,
            TEXT_IN => text_in,
            NEZ_IN => instruction(7 downto 0),
            NEXT_TEXT => S_obyte_next_text,
            MATCH => S_obyte_match);

	Rset1 : Rset port map(
	       CLK => clk,
           TRG => Rset_r,
           TEXT_IN => text_in, 
           NEZ_IN => instruction(15 downto 0),
           NEXT_IST => S_rset_next_ist,
           NEXT_TEXT => S_rset_next_text);
           
           
     Oset1 : Oset port map(
           CLK => clk,
           TRG => OSet_r,
           TEXT_IN => text_in,
           NEZ_IN => instruction(15 downto 0),
           NEXT_TEXT => S_oset_next_text,
           MATCH => S_oset_match);
           
     Oset_or1 : Oset_or port map(
           CLK => clk,
           TRG => OSet_or_r,
           TEXT_IN => text_in,
           NEZ_IN => instruction(15 downto 0),
           NEXT_TEXT => S_oset_or_next_text,
           MATCH => S_oset_or_match);
           
      process(clk)
                begin
                    if(clk'event and clk = '1') then
                        if(Call_r = '1') then
                            S_Call <= '1';
                         else
                            S_Call <= '0';
                         end if;
                     end if;
                end process;
                
      process(clk)
        begin
         if(clk'event and clk = '1') then
           if(Alt_r = '1') then
             S_Alt <= '1';
           else
             S_Alt <= '0';
           end if;
         end if;
      end process;

      process(clk)
                begin
                    if(clk'event and clk = '1') then
                        if(Return_r = '1') then
                            S_Return <= '1';
                         else
                            S_Return <= '0';
                         end if;
                     end if;
                end process;

    Next_ist <= S_set_match or S_byte_match or S_set_or_match or S_obyte_match or S_rset_next_ist or S_Call or S_Return or S_Alt or S_oset_match or S_oset_or_match;
    Fail <= (S_set_fail or S_byte_fail or S_set_or_fail) and not end_sig;
   Wait_text <= S_rset_next_text;
     Next_text <= S_set_match or S_byte_match or S_set_or_match or S_obyte_next_text or S_rset_next_text or S_oset_next_text or S_oset_or_next_text;

end Behavioral;