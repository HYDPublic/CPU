-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY regout_arith IS
  generic ( N : integer ) ;
   PORT
   (
        clk,en: IN STD_LOGIC;
		 
		outputin: in std_logic_vector(2*N-1 downto 0);
		statusin:in std_logic_vector(5 downto 0);
		outputout: out std_logic_vector(2*N-1 downto 0);
		statusout:out std_logic_vector(5 downto 0)
    
   );
END regout_arith;
architecture arch of regout_arith is 
 -- signal tmp: std_logic_vector(7 downto 0); 
  begin 
    process (clk) 
      begin  
        if (clk'event and clk='1') then 
          if (en='1') then 
				     outputout<=outputin;
				      statusout<=statusin;
				  end if;
		     end if;
		  end process;
		  end arch;
