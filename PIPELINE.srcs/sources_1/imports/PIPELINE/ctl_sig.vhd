library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ctl_sig is
	port(
	   f1, dec, fail, wait_text : in std_logic;
	   s_inc, s_inc_sp, SPlat, get_sp, PRlat, TRlat, IRlat, read, write, read_8, write_8, read_stk, write_stk : out std_logic);
end ctl_sig;

architecture Behavioral of ctl_sig is

begin	
	---s_inc
	process(f1, fail) begin
		if(f1 = '1') then	
			s_inc <= '1';
	   elsif(fail = '1') then
	       s_inc <= '0';
		else
			s_inc <= '0';
		end if;
	end process;
	
	---PRlatch
		process(f1, fail) begin
		if(f1 = '1' or fail = '1') then	
			PRlat <= '1';
		else
			PRlat <= '0';
		end if;
	end process;
	
	---TRlatch
        process(f1, fail, wait_text) begin
        if(f1 = '1' or fail = '1' or wait_text = '1') then    
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
	process(f1, wait_text) begin
		if(f1 = '1' or wait_text = '1') then	
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
	
	---SPlat
    process(fail) begin
        if(fail = '1') then    
            SPlat <= '1';
        else
            SPlat <= '0';
        end if;
    end process;
    
    ---s_inc_sp
    process(fail) begin
        if(fail = '1') then    
            s_inc_sp <= '1';
        else
            s_inc_sp <= '0';
        end if;
    end process;
    
    ---get_sp
    process(fail) begin
        if(fail = '1') then    
            get_sp <= '1';
        else
            get_sp <= '0';
        end if;
    end process;
    
    ---read_stk
    process(fail) begin
        if(fail = '1') then    
            read_stk <= '1';
        else
            read_stk <= '0';
        end if;
    end process;
    
    write_stk <= '0';


end Behavioral;