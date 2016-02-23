-- ====================================================================
--
--	File Name:		out_sel.vhd
--	Description:	output select unit 
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
entity out_sel is 
  generic ( N : integer ) ;
  port ( a : in std_logic_vector(2*N-1 downto 0); b: in std_logic_vector ( N-1 downto 0);status_in : in std_logic_vector (5 downto 0);status_out : out std_logic_vector (5 downto 0);sel: in std_logic;d_hi: out std_logic_vector(N-1 downto 0); d_lo: out std_logic_vector(N-1 downto 0)) ; 
  end out_sel ;
  
architecture out_sel_arch of out_sel is
signal d_lo_tmp :std_logic_vector(N-1 downto 0);
signal d_hi_tmp :std_logic_vector(N-1 downto 0);
begin
process(a,b,sel) 
begin
 CASE sel IS--selcting between aritmetic unit and shifting unit
    WHEN  '0'  =>--arithmetic unit output is relevant
         d_lo<= a(N-1 downto 0);
         d_hi<=a(2*N-1 downto N);
         status_out<=status_in;
    WHEN  '1'  =>--shift unit output is relevant
        d_hi<=(others=>'0'); 
         d_lo<=b;
        status_out<="000000";
    WHEN OTHERS =>  status_out<="000000";  
      end case;
end process;
end out_sel_arch;


