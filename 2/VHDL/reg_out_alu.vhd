


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
 entity reg_out_alu is
 generic (N : integer) ;
  port ( 
  reg_out_a_in: in std_logic_vector(N-1 downto 0) :=(others=>'0'); 
  reg_out_b_in: in std_logic_vector(N-1 downto 0) :=(others=>'0'); 
  reg_out_stat_in: in std_logic_vector(5 downto 0) :=(others=>'0'); 
  --en: in std_logic :='0';
  clk : in std_logic;
  reg_out_a_out: out std_logic_vector(N-1 downto 0) :=(others=>'0') ;
 reg_out_b_out: out std_logic_vector(N-1 downto 0) :=(others=>'0') ;
reg_out_stat_out: out std_logic_vector(5 downto 0) :=(others=>'0')  
   );
  end entity ;
  
  
  
  
architecture reg_out_alu_arch of reg_out_alu is
  
  begin
    
  process(clk)
  begin
  
  if (clk'event and clk='1')then
  --if (en='1') then
  reg_out_a_out<=reg_out_a_in;
  reg_out_b_out<=reg_out_b_in;
  reg_out_stat_out<=reg_out_stat_in;
  --else
  --end if;
  end if;

end process;

end reg_out_alu_arch;