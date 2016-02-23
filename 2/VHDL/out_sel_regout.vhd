-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY out_sel_regout IS
  generic ( N : integer ) ;
   PORT
   (
	  clk,en: IN STD_LOGIC;
--------------------------------------------	  
		d_lo_in: IN STD_LOGIC_vector(N-1 downto 0);
		d_hi_in:IN STD_LOGIC_vector(N-1 downto 0);
		status_in :IN STD_LOGIC_vector(5 downto 0);
---------------------------------------------------		 
      d_lo_out: out STD_LOGIC_vector(N-1 downto 0);
		d_hi_out:out STD_LOGIC_vector(N-1 downto 0);
		status_out :out STD_LOGIC_vector(5 downto 0)
   );
END out_sel_regout;
architecture arch of out_sel_regout is 
 -- signal tmp: std_logic_vector(7 downto 0); 
  begin 
    process (clk) 
      begin  
        if (clk'event and clk='1') then 
          if (en='1') then 
				     d_lo_out<=d_lo_in;
					  d_hi_out<=d_hi_in;
					  status_out<=status_in;
			 -- else
				--	d_out<=d_in;
		       end if;
		     end if;
		  end process;
		  end arch;
