-- ====================================================================
--
--	File Name:		max.vhd
--	Description:	max 
--
--	Date:			26/04/13
--	Designer:		Eyar Gilad, Dudu Abu 
--
-- ===================================================================

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity max_min is 
  generic ( N : integer ) ; 
  port ( a,b : in std_logic_vector(N-1 downto 0);
   c: in std_logic ; en: in std_logic ; d: out std_logic_vector(N-1 downto 0)) ; 
  end max_min ;
  
architecture max_min_arch of max_min is
  
begin
process(a,b,en)

variable x:std_logic_vector ( N-1 downto 0);
variable y:std_logic_vector ( N-1 downto 0);

begin 
if(en='1') then 
  if(c='0') then 
    if(signed(a)<signed(b))then
      d<=std_logic_vector(signed(b));
     else 
      d<=std_logic_vector(signed(a));
    end if;
  else
    if(signed(a)<signed(b))then
      d<=std_logic_vector(signed(a));
     else 
      d<=std_logic_vector(signed(b));
    end if;  
   end if; 
end if; 
end process;
end max_min_arch;



