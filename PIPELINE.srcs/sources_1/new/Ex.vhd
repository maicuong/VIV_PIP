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
  Port (clk, Set_r : in  std_logic;
        instruction : in std_logic_vector(15 downto 0);
        text_in : in std_logic_vector(7 downto 0);
        Next_text, Next_ist, Fail: out std_logic);
end Ex;

architecture Behavioral of Ex is
	---Byte
component Byte
    port(
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
    TRG : in std_logic;
    TEXT_IN : in std_logic_vector(7 downto 0);
    NEZ_IN : in std_logic_vector(15 downto 0) ;
    FAIL : out std_logic;
    MATCH : out std_logic);
end component;

component Obyte
	port(
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
		TRG : in std_logic;
		TEXT_IN : in std_logic_vector(7 downto 0);
		NEZ_IN : in std_logic_vector(7 downto 0) ;
		NEXT_IST : out std_logic;
		NEXT_TEXT : out std_logic);
end component;



signal S_byte_match, S_byte_fail : std_logic;
signal S_set_match, S_set_fail : std_logic;
signal S_set_or_match, S_set_or_fail : std_logic;
signal S_obyte_match, S_obyte_next_text : std_logic;
signal S_nany_match, S_nany_fail : std_logic;
signal S_rset_next_ist, S_rset_next_text : std_logic;

begin


		
	Set1 : Set port map(
	    CLK => clk,
        TRG => Set_r,
        TEXT_IN => text_in,
        NEZ_IN => instruction,
        FAIL => S_set_fail,
        MATCH => S_set_match);

    Next_ist <= S_set_match;
    Fail <= S_set_fail;
    Next_text <= S_set_match;

end Behavioral;