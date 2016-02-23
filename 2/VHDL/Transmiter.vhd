
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
entity transmiter is 
  port ( 
  in_hi: in std_logic_vector(7 downto 0) :=(others=>'0') ; 
  in_lo: in std_logic_vector(7 downto 0) :=(others=>'0') ; 
  enable: in std_logic; 
  baude_rate_clock: in std_logic; 
  pin_tx: out std_logic :='1' 
  );
  end transmiter ;
  
architecture transmiter_arch of transmiter is
  
signal  send_reg :  std_logic_vector (17 downto 0)   ;  
signal out_bit :  std_logic;
signal status : std_logic_vector ( 1 downto 0):=(others=>'0');

begin
  
  send_reg<= ('1'&IN_HI&IN_LO&'0');
process(enable,baude_rate_clock)
  variable x : Integer :=0;
  --variable status : std_logic_vector ( 1 downto 0):=(others=>'0');

begin
 
  if rising_edge(baude_rate_clock) then
  
  
  case status is
  
  when "00"  => 
  if (enable='0') then
  status<="01";
  PIN_TX<='1';         
  end if;
  
  when "01"=> 
  if (x<=17) then
  PIN_TX<=send_reg(x);
  x:=x+1;
  else 
  status<="00";
  x:=0;  
  PIN_TX<='1';
  end if;

when others => status <="00";
       
end case;
end if;
end process;
end transmiter_arch;









