-- ====================================================================
--
--	File Name:		shift_unit.vhd
--	Description:	shift unit of the alu 
--					
--
--	Date:			07/04/13
--	Designer:		yuval goldman & tal siton
--
-- ===================================================================


-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties
entity shift_unit is 
  generic ( N : integer ) ; 
  port ( a,b : in std_logic_vector(N-1 downto 0); code: in std_logic_vector(2 downto 0) ;d: out std_logic_vector(N-1 downto 0)) ; 
  end shift_unit  ;
architecture shift_unit_arch of shift_unit is
begin
process(a,b,code)
variable x: integer;  
begin
if(code(2 downto 1)="00") then --only opcode #8,#9 is relevant 
  x:=to_integer(unsigned(b));
  if (code(0)='0') then--selcting between shift right to left
     d<= std_logic_vector(unsigned(a) sll x);
  else
      d<= std_logic_vector(unsigned(a) srl x);
  end if;  
else
      d<=(others=>'0');
end if;
end process;
end shift_unit_arch;



