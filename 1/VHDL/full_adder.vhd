-- ====================================================================
--
--	File Name:		full_adder.vhd
--	Description:	N bit adder with carry 
--					
--
--	Date:			26/04/13
--	Designer:		Eyar Gilad, Dudu Abu
--
-- ====================================================================

-- libraries decleration
library IEEE; 
use IEEE.std_logic_1164.all;

entity full_adder is 
  generic( N : integer:= 4);
port ( 
  x: in std_logic_vector(N-1 downto 0); 
  y: in std_logic_vector(N-1 downto 0);  
  sum: out std_logic_vector(N-1 downto 0); 
  cout: out std_logic ); 
end full_adder;

architecture rtl of full_adder is 
--1 bit adder compoment
component add_1_bit 
port ( 
  x: in std_logic; 
  y: in std_logic; 
  cin: in std_logic; 
  sum: out std_logic; 
  cout: out std_logic ); 
end component;

signal connect_cin_cout : std_logic_vector(N downto 0);
 
begin
  connect_cin_cout(0)<='0';
  bit_connector_Loop: for i in 0 to N-1 generate--connecting N one bit adders carry out of each one
                                                --as carry in for the next one
  title_loop : add_1_bit port map ( x=>x(i),y=>y(i),cin=>connect_cin_cout(i) , cout=>connect_cin_cout(i+1),sum=>sum(i));
 end generate;

 cout<=connect_cin_cout(N);--summing all results in vector and move it to output

end rtl;


