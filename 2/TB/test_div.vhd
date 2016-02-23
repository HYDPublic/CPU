--
-- ====================================================================
-- Test Bench for Counter.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity divTest is
end divTest;

architecture rtl of divTest is  
component div
   generic ( N : integer ) ; 
   port ( a,b : in std_logic_vector(N-1 downto 0);c: in std_logic; en: in std_logic ; d_hi: out std_logic_vector(N-1 downto 0); d_lo:out std_logic_vector(N-1 downto 0) ) ;
end component;
signal  a,b,d_hi,d_lo : std_logic_vector (3 downto 0);
signal  c,en : std_logic;

begin
        tester : div
         generic map(N=>4)
        port map(
          a=>a,b=>b,d_hi=>d_hi,d_lo=>d_lo,c=>c,en=>en
         );
        
        testbench : process
        begin
          -- test output respones to several inputs.
          a<="0111";
          b<="0010";
          c<='0';
          en<='1';
          wait;
        end process testbench;
        
end rtl;

