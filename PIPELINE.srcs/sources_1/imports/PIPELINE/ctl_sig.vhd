library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ctl_sig is
	port(
	   f1: in std_logic;
	   s_inc,  PRlat, TRlat, IRlat, read, write, read_8, write_8 : out std_logic);
end ctl_sig;

architecture Behavioral of ctl_sig is

begin	
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
	
	---TRlatch
        process(f1) begin
        if(f1 = '1') then    
            TRlat <= '1';
        else
            TRlat <= '0';
        end if;
    end process;
	

	---IRlat
	process(f1) begin
		if(f1 = '1') then	
			IRlat <= '1';
		else
			IRlat <= '0';
		end if;
	end process;
	

	---read
	process(f1) begin
		if(f1 = '1') then	
			read_8 <= '1';
		else
			read_8 <= '0';
		end if;
	end process;

	process(f1) begin
		if(f1 = '1') then	
			read <= '1';
		else
			read <= '0';
		end if;
	end process;
	
	write <= '0';
	write_8 <= '0';


end Behavioral;