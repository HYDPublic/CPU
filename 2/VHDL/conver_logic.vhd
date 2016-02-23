
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
 entity conver_logic is 
  port ( 
  receiver_input: in std_logic_vector(15 downto 0) :=(others=>'0') ; 
  out_0: out std_logic_vector(6 downto 0) :=(others=>'0') ; 
  out_1: out std_logic_vector(6 downto 0) :=(others=>'0') ; 
  out_2: out std_logic_vector(6 downto 0) :=(others=>'0') ; 
  out_3: out std_logic_vector(6 downto 0) :=(others=>'0')
   );
  end conver_logic ;
  
  
  
  
  
  
architecture conver_logic_arch of conver_logic is
  
  
signal  out_1_wire :  std_logic_vector (6 downto 0)   ;  
signal  out_2_wire :  std_logic_vector (6 downto 0)   ;  
signal  out_3_wire :  std_logic_vector (6 downto 0)   ;  
signal  out_4_wire :  std_logic_vector (6 downto 0)   ;  


 component seven_segment is 
  port (
	num : in std_logic_vector(3 downto 0);
	en: in std_logic; 	
	segment: out std_logic_vector (6 downto 0)
	);
  end component;


begin
  
  
  first : seven_segment
  port map(
  num=>receiver_input (3 downto 0),
  en=>'1',
  segment=>out_0);
  
  second : seven_segment
  port map(
  num=>receiver_input (7 downto 4),
  en=>'1',
  segment=>out_1);
  
  third : seven_segment
  port map(
  num=>receiver_input (11 downto 8),
  en=>'1',
  segment=>out_2);
  
  four : seven_segment
  port map(
  num=>receiver_input (15 downto 12),
  en=>'1',
  segment=>out_3);
  
  

end conver_logic_arch;





