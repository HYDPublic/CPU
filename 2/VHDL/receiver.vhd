
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
entity receiver is 
  port ( 
  pin_rx: in std_logic :='1'; 
  baude_rate_clock: in std_logic; 
  output : out std_logic_vector(15 downto 0) :=(others=>'0') 
   );
  end receiver ;
  
architecture receiver_arch of receiver is
  
signal  out_reg :  std_logic_vector (15 downto 0)   ;  
signal status : std_logic_vector ( 1 downto 0):=(others=>'0');

begin
  


process(baude_rate_clock)
 
 variable x : Integer :=0;
 

 begin
 
  if rising_edge(baude_rate_clock) then
  
  
  case status is
  
  when "00"  => 
  if (pin_rx='0') then
  status<="01";  
  end if;
  
  when "01"=> 
  if (x<16) then
  out_reg(x)<=pin_rx;
  x:=x+1;
  else 
  output<=out_reg;
  status<="00";
  x:=0;  
  end if;

when others => status <="00";
       
end case;
end if;
end process;



end receiver_arch;











