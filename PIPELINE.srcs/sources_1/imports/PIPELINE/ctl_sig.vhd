library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ctl_sig is
	port(
	   f1, Call_r, Call_cond, Alt_r, Alt_cond, fail_step1, fail_step2, 
	   Return_step1, Return_step2, Succ_step1, Succ_step2, Jump, First_step1, First_step2, 
	   First_step3, First_step4, Set_r, Rset_r, Oset_r: in std_logic;
	   s_inc, put_stk, put_fail_stk, s_dcr, s_dcr_fail, SPlat, SPlat_fail, PRlat, TRlat, IRlat, read, write, 
	   read_8, write_8, read_stk, write_stk, read_fail_stk, write_fail_stk, read_first_table, write_first_table,
	   read_first_record, write_first_record, read_set_table, write_set_table : out std_logic);
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
		process(f1, Call_cond, fail_step2, Return_step2, Jump, First_step1) begin
		if(f1 = '1' or Call_cond = '1' or fail_step2 = '1' or Return_step2 = '1' or Jump = '1' or First_step1 = '1') then	
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
	
	write <= '0';
	write_8 <= '0';
	
	process(Call_cond) begin
        if(Call_cond = '1') then    
            put_stk <= '1';
        else
            put_stk <= '0';
        end if;
    end process;
    
	process(Alt_cond) begin
        if(Alt_cond = '1') then    
            put_fail_stk <= '1';
        else
            put_fail_stk <= '0';
        end if;
    end process;
    
---SPlat
        process(Call_cond, Return_step2) begin
            if(Call_cond = '1' or Return_step2 = '1') then    
                SPlat <= '1';
            else
                SPlat <= '0';
            end if;
        end process;

        process(Alt_cond, fail_step2, Succ_step2) begin
            if(Alt_cond = '1' or fail_step2 = '1' or Succ_step2 = '1') then    
                SPlat_fail <= '1';
            else
                SPlat_fail <= '0';
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
         
        process(Alt_r)
         begin
        if(Alt_r = '1') then    
             write_fail_stk <= '1';
         else
             write_fail_stk <= '0';
         end if;
          end process;

        process(fail_step2, Succ_step2)
        begin
       if(fail_step2 = '1' or Succ_step2 = '1') then    
            s_dcr_fail <= '1';
        else
            s_dcr_fail <= '0';
        end if;
         end process;
         
         
        process(Return_step2)
         begin
        if(Return_step2 = '1') then    
             s_dcr <= '1';
         else
             s_dcr <= '0';
         end if;
          end process;
 
         process(fail_step1, Succ_step1)
         begin
        if(fail_step1 = '1' or Succ_step1 = '1') then    
             read_fail_stk <= '1';
         else
             read_fail_stk <= '0';
         end if;
          end process;

         process(Return_step1)
         begin
        if(Return_step1 = '1') then    
             read_stk <= '1';
         else
             read_stk <= '0';
         end if;
          end process;

    --process(First_step1)
      --begin
        --if(First_step1 = '1') then    
             --read_first_table <= '1';
         --else
             --read_first_table <= '0';
         --end if;
      --end process;          

    write_first_table <= '0';

    process(First_step1)
      begin
        if(First_step1 = '1') then    
             read_first_record <= '1';
         else
             read_first_record <= '0';
         end if;
      end process;        
    
    write_first_record <= '0';
    
    process(Set_r, Rset_r, Oset_r)
      begin
        if(Set_r = '1' or Rset_r = '1' or Oset_r = '1') then    
             read_set_table <= '1';
         else
             read_set_table <= '0';
         end if;
      end process;        
    
end Behavioral;