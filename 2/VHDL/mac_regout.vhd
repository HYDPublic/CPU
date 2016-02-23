-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY mac_regout IS
  generic ( N : integer ) ;
   PORT
   (
	  clk,en: IN STD_LOGIC;
--------------------------------------------	  
		d_in: IN STD_LOGIC_vector(2*N-1 downto 0);
---------------------------------------------------		 
      d_out: out STD_LOGIC_vector(2*N-1 downto 0)

   );
END mac_regout;
architecture arch of mac_regout is 
 -- signal tmp: std_logic_vector(7 downto 0); 
  begin 
    process (clk) 
      begin  
        if (clk'event and clk='1') then 
          if (en='1') then 
				     d_out<=d_in;
			 -- else
				--	d_out<=d_in;
		       end if;
		     end if;
		  end process;
		  end arch;
