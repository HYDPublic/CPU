-- ====================================================================
--
--	File Name:		decoder.vhd
--	Description:	decoder for the arithmetic unit, selcting between 4 units
--					
--
--	Date:			26/04/13
--	Designer:		Eyar Gilad, Dudu Abu
--
-- ====================================================================


-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties
entity decoder is 
  port ( 
  dec : in std_logic_vector(2 downto 0) ; 
  d0: out std_logic; 
  d1: out std_logic; 
  d2: out std_logic ;
  d3: out std_logic ;
  d4: out std_logic) ; 
  end decoder ;
  
architecture decoder_arch of decoder is
begin
  
process(dec)
begin
case dec is--sort of decode logic, in each code other unit gets enable signal
when "000" | "001" => d0<= '1';d1<= '0';d2<= '0';d3<= '0';  d4<= '0';        
when "010"| "011" => d0<= '0';d1<= '0';d2<= '0';d3<= '0';  d4<= '1';      
when "100" => d0<= '0';d1<= '0';d2<= '1';d3<= '0';  d4<= '0';        
when "101" => d0<= '0';d1<= '0';d2<= '0';d3<= '1'; d4<= '0';   
when "110" => d0<= '0';d1<= '0';d2<= '0';d3<= '1'; d4<= '0';        
when "111" => d0<= '0';d1<= '1';d2<= '0';d3<= '0'; d4<= '1';
when others => d0<= '0';d1<= '0';d2<= '0';d3<= '0';d3<= '0'; d4<= '0';
end case;
end process;
end decoder_arch;



