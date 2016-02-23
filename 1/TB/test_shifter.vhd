--
-- ====================================================================
-- Test Bench for Counter.

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity shifterTest is
  GENERIC (
    N  : INTEGER :=5  ); 
end shifterTest;

architecture rtl of shifterTest is  
component shift_unit
   generic ( N : INTEGER:=5 ) ; 
   port ( a,b : in std_logic_vector(N-1 downto 0); code: in std_logic_vector(2 downto 0) ;d: out std_logic_vector(N-1 downto 0)) ; 
end component;
signal  c: std_logic_vector(2 downto 0) ;
signal  a,b,d : std_logic_vector (4 downto 0);
BEGIN
  DUT  : shift_unit
         generic map(N=>N)
        port map(code=>c,
          a=>a,b=>b,d=>d
         );
        
        testbench : process

        variable x:std_logic_vector ( N-1 downto 0);
        variable y:std_logic_vector ( N-1 downto 0);
        
        begin
          x:="00101";
          y:="00010";
          c<="001";
          -- test output respones to several inputs.
          for i in 0 to 6
      loop
            a<=x;
            b<=y;
            x:=std_logic_vector(unsigned(a)+1);
            --y:=std_logic_vector(unsigned(b)+1);
            wait for 10 ns;
            c(0)<=not c(0);
            end loop;
        end process testbench;
        
end rtl;



