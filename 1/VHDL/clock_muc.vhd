

-- ====================================================================
--
--	File Name:		clock_muc.vhd
--	Description:	clock for the muc/umuc unit
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
entity clock_muc is 
port ( 
clk: out std_logic 
); 
end clock_muc;

architecture rtl of clock_muc is 
signal clk_sig: std_logic :='1';
begin
process(clk_sig)--clock with 10 ns period time 
begin 
clk_sig <= not clk_sig after 5 ns; 
end process;
clk<=clk_sig;
end rtl;
