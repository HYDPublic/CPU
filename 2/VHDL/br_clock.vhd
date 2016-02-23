


-- ====================================================================
--
--	File Name:		clock_muc.vhd
--	Description:	clock for the muc/umuc unit
--					
--
--	Date:			07/04/13
--	Designer:		yuval goldman & tal siton
--
-- ====================================================================

-- libraries decleration
library IEEE; 
use IEEE.std_logic_1164.all;


--entity properties
 entity br_clock is 
 port ( 
  clk: in std_logic ;
  br_clk : out std_logic
  ); 
end br_clock;

architecture br_clock_arch of br_clock is 

signal clk_sig: std_logic :='1';

begin



process(clk)--clock with 10 ns period time 
  
variable x : integer := 0;
  
  
begin 
 
 if rising_edge(clk) then
   
 if (x>100) then
 clk_sig <= not clk_sig ;
 x:=0;
 else
 x:=x+1;
 end if;
   
 end if;
end process;

br_clk<=clk_sig;

end br_clock_arch;
