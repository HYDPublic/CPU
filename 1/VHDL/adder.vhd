
-- ====================================================================
--
--	File Name:		<adder>.vhd
--	Description:	1 bit adder with carry 
--					
--
--	Date:			26/04/13
--	Designer:		Eyar Gilad, Dudu Abu
--
-- ====================================================================

-- libraries decleration
library IEEE; 
use IEEE.std_logic_1164.all;

--entity properties

entity add_1_bit is 
port ( 
x: in std_logic; 
y: in std_logic; 
cin: in std_logic; 
sum: out std_logic; 
cout: out std_logic 
); 
end add_1_bit;

architecture rtl of add_1_bit is 
begin --1 bit adder logic
  sum <= x xor y xor cin; 
  cout <= (x and y) or (x and cin) or (y and cin); 
end rtl;