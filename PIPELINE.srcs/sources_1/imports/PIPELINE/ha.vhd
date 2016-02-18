library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ha is
	port(a,b : in std_logic;
			c,f : out std_logic);
end ha;

architecture Behavioral of ha is

begin
	c <= a and b;
	f <= a  xor b;
end Behavioral;

