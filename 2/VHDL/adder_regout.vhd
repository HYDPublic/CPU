-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY regout IS
  generic ( N : integer ) ;
   PORT
   (
      clk,en: IN STD_LOGIC;
		  status_in: IN STD_LOGIC_vector(5 downto 0);
		  d_in:IN STD_LOGIC_vector(N-1 downto 0);
		 
      status_out: out STD_LOGIC_vector(5 downto 0);
		  d_out:out STD_LOGIC_vector(N-1 downto 0)
   );
END regout;
architecture arch of regout is 
 -- signal tmp: std_logic_vector(7 downto 0); 
  begin 
    process (clk) 
      begin  
        if (clk'event and clk='1') then 
          if (en='1') then 
				     status_out<=status_in;
				      d_out<=d_in;
				  end if;
		     end if;
		  end process;
		  end arch;
