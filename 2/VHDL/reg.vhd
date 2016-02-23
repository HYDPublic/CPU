


-- ====================================================================
--
--	File Name:		decoder.vhd
--	Description:	decoder for the arithmetic unit, selcting between 4 units
--					
--
--	Date:			07/04/13
--	Designer:		yuval goldman & tal siton
--
-- ====================================================================


-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



--entity properties 
 entity reg is
 generic (N : integer) ;
  port ( 
  reg_in: in std_logic_vector(N-1 downto 0) :=(others=>'0'); 
  en: in std_logic ;
  reg_out: out std_logic_vector(N-1 downto 0) :=(others=>'0')  
  );
  end entity ;
  
  
  
  
  
  
architecture reg_arch of reg is
  
  begin
    
  process(en)
  begin
  
  if falling_edge(en) then
  reg_out<=reg_in;
  else
  end if;

end process;

end reg_arch;