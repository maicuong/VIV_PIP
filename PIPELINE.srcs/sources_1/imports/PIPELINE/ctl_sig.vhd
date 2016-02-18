library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ctl_sig is
	port(f1, f2 : in std_logic;
			 PRout, MARout,
			s_inc, s_mdi,
			PRlat, MARlat, IRlat, read, write : out std_logic);
end ctl_sig;

architecture Behavioral of ctl_sig is

begin
	
	---PRout
	process(f1) begin
		if(f1 = '1') then	
			PRout <= '1';
		else
			PRout <= '0';
		end if;
	end process;
	
	MARout <= '0';
	
	---s_inc
	process(f1) begin
		if(f1 = '1') then	
			s_inc <= '1';
		else
			s_inc <= '0';
		end if;
	end process;
	
	---PRlatch
		process(f1) begin
		if(f1 = '1') then	
			PRlat <= '1';
		else
			PRlat <= '0';
		end if;
	end process;
	
	---MARlat
	process(f1) begin
		if(f1 = '1') then	
			MARlat <= '1';
		else
			MARlat <= '0';
		end if;
	end process;
	
	---s_mdi
	process(f2) begin
		if(f2 = '1') then	
			s_mdi <= '1';
		else
			s_mdi <= '0';
		end if;
	end process;
	

	---IRlat
	process(f2) begin
		if(f2 = '1') then	
			IRlat <= '1';
		else
			IRlat <= '0';
		end if;
	end process;
	

	---read
	process(f2) begin
		if(f2 = '1') then	
			read <= '1';
		else
			read <= '0';
		end if;
	end process;
	
	write <= '0';

end Behavioral;