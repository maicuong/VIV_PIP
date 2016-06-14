library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ctl_sig is
	port(
	   f1, Call_r: in std_logic;
	   s_inc, s_inc_sp, s_dcr, SPlat, PRlat, TRlat, IRlat, read, write, read_stk, write_stk, read_8, write_8 : out std_logic);
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
	
---SPlat
        process(Call_r) begin
            if(Call_r = '1') then    
                SPlat <= '1';
            else
                SPlat <= '0';
            end if;
        end process;
        
        ---s_inc_sp
        process(Call_r) begin
            if(Call_r = '1') then    
                s_inc_sp <= '1';
            else
                s_inc_sp <= '0';
            end if;
        end process;
	
    --write_stk
        process(Call_r)
        begin
        if(Call_r = '1') then    
            write_stk <= '1';
        else
            write_stk <= '0';
        end if;
        end process;
	
	---PRlatch
		process(f1, Call_r) begin
		if(f1 = '1'or Call_r = '1') then	
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