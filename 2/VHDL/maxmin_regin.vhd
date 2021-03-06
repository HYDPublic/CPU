-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY maxmin_regin IS
  generic ( N : integer ) ;
   PORT
   (
		  clk,en,c_in: IN STD_LOGIC;
		  c_out: out STD_LOGIC;
-----------------------------------------------		  
		 
		  a_in: IN STD_LOGIC_vector(N-1 downto 0);
		  b_in:IN STD_LOGIC_vector(N-1 downto 0);
---------------------------------------------------		  
		
		  a_out: out STD_LOGIC_vector(N-1 downto 0);
		  b_out:out STD_LOGIC_vector(N-1 downto 0)
   );
END maxmin_regin;
architecture arch of maxmin_regin is 
 -- signal tmp: std_logic_vector(7 downto 0); 
  begin 
    process (clk) 
      begin  
        if (clk'event and clk='1') then 
          if (en='1') then 
				    
						a_out<=a_in;
						b_out<=b_in;
						c_out<=c_in;
				  end if;
		     end if;
		  end process;
		  end arch;
