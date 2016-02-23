--
-- ====================================================================
-- Test Bench for Counter.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity arithTest is
end arithTest;

architecture rtl of arithTest is  
 
 component arith_unit is 
  generic ( N : integer ) ; 
  port (
  input1,input2 : in std_logic_vector(N-1 downto 0) ; 
  code: in std_logic_vector(2 downto 0);
  output: out std_logic_vector(2*N-1 downto 0));
  end component; 

signal code: std_logic_vector(2 downto 0);
signal  input1,input2 : std_logic_vector (4 downto 0);
signal output: std_logic_vector(9 downto 0);

begin
        tester : arith_unit 
         generic map(N=>5)
        port map(
          input1=>input1,
          input2=>input2,
          code=>code,
          output=>output
         );
        
        testbench : process
        begin
          
          -- test output respones to several inputs.
          input1<="00101";
          input2<="00010";
          code<="110","111" after 10 ns,"101" after 20 ns,"011" after 30 ns,"100" after 40 ns,"101" after 50 ns,"110" after 60 ns, "111" after 70 ns;
          wait;
        end process testbench;
        
end rtl;








