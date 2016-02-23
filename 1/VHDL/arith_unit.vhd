-- ====================================================================
--
--	File Name:		arith_unit.vhd
--	Description:	arithmetic unit of the alu
--					
--
--	Date:			26/04/13
--	Designer:		Eyar Gilad, Dudu Abu
--
-- ====================================================================

-- 
-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties
entity arith_unit is 
generic ( N : integer ) ; 
port (
input1,input2 : in std_logic_vector(N-1 downto 0) ; 
code: in std_logic_vector(2 downto 0);
output: out std_logic_vector(2*N-1 downto 0);
status: out std_logic_vector(5 downto 0));
end arith_unit; 

architecture struct of arith_unit is
--mul unit decleration
component mul is
  generic ( N : integer ) ; 
  port ( 
  a,b : in std_logic_vector(N-1 downto 0);
  en: in std_logic; 
  c: in std_logic; 
  d: out std_logic_vector(2*N-1 downto 0)) ;
end component;

-- add/sub unit decleration
component add_sub is
generic ( N : integer ) ; 
port ( 
a,b : in std_logic_vector(N-1 downto 0); 
en: in std_logic ; 
c: in std_logic ; 
d: out std_logic_vector(N-1 downto 0);
status: out std_logic_vector(5 downto 0)) ;
end component;

--absolute unit decleration
component ab is 
 generic ( N : integer ) ; 
  port ( 
  a : in std_logic_vector(N-1 downto 0); 
   --c: in std_logic;
   en: in std_logic ;
  d: out std_logic_vector(N-1 downto 0)) ; 
  end component ;
  
  --decoder unit decleration
  component decoder is 
  port ( 
  dec : in std_logic_vector(2 downto 0) ; 
  d0: out std_logic; d1: out std_logic; 
  d2: out std_logic;
  d3: out std_logic;
  d4: out std_logic )  ; 
  end component ;
  
  --muc unit decleration
  component muc is 
  generic ( N : integer ) ; 
  port ( 
  input1,input2 : in std_logic_vector(N-1 downto 0); 
  sel: in std_logic;en:in std_logic;clk:in std_logic;
  res:in std_logic ; 
  output: out std_logic_vector(2*N-1 downto 0));
  end component; 
  
  --clock for the mac/umac unit decleration
  component clock_muc is 
    port ( 
      clk: out std_logic 
        ); 
    end component;
  
  -- max/min unit decleration
component max_min is
generic ( N : integer ) ; 
port ( 
a,b : in std_logic_vector(N-1 downto 0); 
en: in std_logic ; 
c: in std_logic ; 
d: out std_logic_vector(N-1 downto 0));
end component;
  

--defining signals
signal wire_mul: std_logic_vector(2*N-1 downto 0);
signal wire_hi2: std_logic_vector(N-1 downto 0);
signal wire_lo2: std_logic_vector(N-1 downto 0);
signal wire: std_logic_vector(N-1 downto 0);
signal d0: std_logic;
signal d1: std_logic;
signal d2: std_logic;
signal d3: std_logic;
signal d4: std_logic;
signal over: std_logic_vector(N-1 downto 0);
signal resm: std_logic;
signal macwire :std_logic_vector(2*N-1 downto 0);
signal clk: std_logic;
signal wire_max_min: std_logic_vector(N-1 downto 0);





begin 
 --port mappping ths units, decoder output to enables, selcect signal the last bit of code
 -- output from each unit to signals.
deco: decoder
port map (dec=>code(2 downto 0), d0=>d0,d1=>d1,d2=>d2,d3=>d3,d4=>d4);
  
Gate0: add_sub
generic map (N=>N)
port map (a=>input1, b=>input2,c=>code(0),en=>d0 ,d=>wire,status=>status);
  
Gate1: mul
generic map (N=>N)
port map (a=>input1, b=>input2, c=>code(0),en=>d1 ,d=>wire_mul);
  
Gate2: ab
generic map (N=>N)
port map (a=>input2,en=>d2,d=>wire_lo2);   
  
Gate3: muc
generic map ( N=>N ) port map (input1=>input1, input2=>input2,en=>d3 ,res=>resm ,sel=>code(0),clk=>clk,output=>macwire) ; 

Gate4: clock_muc
port map (clk=>clk);   
  
Gate5: max_min
generic map ( N=>N ) port map (a=>input1, b=>input2, c=>code(0),en=>d4 ,d=>wire_max_min);
  
c1:process (code,wire,wire_hi2,wire_lo2,input1,input2,wire_mul,macwire)

begin


case code(2 downto 0)  is

when "000" | "001" =>--add/sub code
              over<=(others=>'0');
              output<=over & wire;

when "010" => --min code
            over<=(others=>'0');
            output<= over & wire_max_min;
when "011" => --max code
            over<=(others=>'0');
            output<= over & wire_max_min;
when "100" =>--abs code
             over<=(others=>'0');
             output<=over & wire_lo2;
when "101" => -- mac code
     resm<='0' ; ----  resm<='0','1'after 1 ns , '0' after 2 ns ;
     output<=macwire ;       
when  "110" => --reset mac code
      resm<='1'; 
   
when  "111" => --mul
      output<= wire_mul;
when others => output<=(others=>'0');

end case;

end process;

end struct;
