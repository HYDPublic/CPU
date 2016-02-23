-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
ENTITY out_sel_regin IS
  generic ( N : integer ) ;
   PORT
   (
		  clk,en: IN STD_LOGIC;
-----------------------------------------------		  
			status_in	: IN STD_LOGIC_vector(5 downto 0);
		  a_in: IN STD_LOGIC_vector(2*N-1 downto 0);
		  b_in:IN STD_LOGIC_vector(N-1 downto 0);
		  sel_in: IN STD_LOGIC;
---------------------------------------------------		  
		  status_out: out STD_LOGIC_vector(5 downto 0);
		  a_out: out STD_LOGIC_vector(2*N-1 downto 0);
		  b_out:out STD_LOGIC_vector(N-1 downto 0);
		  sel_out: out STD_LOGIC
   );
END out_sel_regin;
architecture arch of out_sel_regin is 
 -- signal tmp: std_logic_vector(7 downto 0); 
  begin 
    process (clk) 
      begin  
        if (clk'event and clk='1') then 
          if (en='1') then 
				     status_out<=status_in;
				     	a_out<=a_in;
						b_out<=b_in;
						sel_out<=sel_in;
				--else
					--code_out<=code_in;
				end if;
		     end if;
		  end process;
		  end arch;
