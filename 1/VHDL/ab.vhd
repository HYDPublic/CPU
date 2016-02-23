-- ====================================================================
--
--	File Name:		abs.vhd
--	Description:	abs 
--
--	Date:			26/04/13
--	Designer:		Eyar Gilad, Dudu Abu 
--
-- ====================================================================


-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ab is 
  generic ( N : integer ) ; 
  port ( a: in std_logic_vector(N-1 downto 0);
   en: in std_logic ; d: out std_logic_vector(N-1 downto 0)) ; 
  end ab ;
  
architecture ab_arch of ab is
  
begin
process(a,en)
variable result_vec: std_logic_vector(N-1 downto 0);

begin 
if(en='1') then  
     d<=std_logic_vector(to_unsigned(abs(to_integer(signed(a))),N));--the integer  part 
   end if;

end process;
end ab_arch;



