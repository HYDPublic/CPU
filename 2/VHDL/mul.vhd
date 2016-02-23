-- ====================================================================
--
--	File Name:		mul_umul.vhd
--	Description:	multiplu unit of the alu 
--					
--
--	Date:			26/04/13
--	Designer:		Eyar Gilad, Dudu Abu
--
-- ===================================================================


-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties
entity mul is 
  generic ( N : integer ) ; 
  port ( 
  a,b : in std_logic_vector(N-1 downto 0); d: out std_logic_vector(2*N-1 downto 0)) ; 
  end mul;

architecture mul_arch of mul is


begin
process(a,b)
 
begin
  d<= std_logic_vector(signed(a)* signed(b));
 
end process;
end mul_arch;

