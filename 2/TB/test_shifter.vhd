--
-- ====================================================================
-- Test Bench for Counter.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity shifterTest is
end shifterTest;

architecture rtl of shifterTest is  
component shifter
   generic ( N : integer ) ; 
   port ( a,b : in std_logic_vector(N-1 downto 0); c: in std_logic ;d: out std_logic_vector(N-1 downto 0)) ; 
end component;
signal  c: std_logic;
signal  a,b,d : std_logic_vector (4 downto 0);
begin
        tester : shifter
         generic map(N=>5)
        port map(c=>c,
          a=>a,b=>b,d=>d
         );
        
        testbench : process
        begin
          -- test output respones to several inputs.
          a<="01110";
          b<="00010";
          c<='1';
          wait;
        end process testbench;
        
end rtl;



