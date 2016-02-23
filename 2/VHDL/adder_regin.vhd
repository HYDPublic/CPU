-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY regin IS
  generic ( N : integer ) ;
   PORT
   (
      clk,en,c: IN STD_LOGIC;
		  a,b: IN STD_LOGIC_vector(N-1 downto 0);
		 
      aout,bout: out STD_LOGIC_vector(N-1 downto 0);
		  cout: out STD_LOGIC
   );
END regin;
architecture arch of regin is 
 -- signal tmp: std_logic_vector(7 downto 0); 
  begin 
    process (clk) 
      begin  
        if (clk'event and clk='1') then 
          if (en='1') then 
				     aout<=a;
				      bout<=b;
				     
			         	cout<=c;
		       end if;
		     end if;
		  end process;
		  end arch;
