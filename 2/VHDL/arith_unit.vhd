-- ====================================================================
--
--	File Name:		arith_unit.vhd
--	Description:	arithmetic unit of the alu
--					
--
--	Date:			07/04/13
--	Designer:		yuval goldman & tal siton
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
 clk:in std_logic;
output: out std_logic_vector(2*N-1 downto 0);
status: out std_logic_vector(5 downto 0));
end arith_unit; 

architecture struct of arith_unit is
--mul/umul unitdecleration
component mul is
  generic ( N : integer ) ; 
  port ( 
  a,b : in std_logic_vector(N-1 downto 0);
 -- en: in std_logic; 
  d: out std_logic_vector(2*N-1 downto 0)) ;
end component;

-- add/sub unit decleration
component add_sub is
generic ( N : integer ) ; 
port ( 
a,b : in std_logic_vector(N-1 downto 0); 
--en: in std_logic ; 
c: in std_logic ; 
d: out std_logic_vector(N-1 downto 0);
status: out std_logic_vector(5 downto 0)) ;
end component;

--devider unit decleration
component ab is 
 generic ( N : integer ) ; 
  port ( 
  a : in std_logic_vector(N-1 downto 0); 
   --c: in std_logic;
  -- en: in std_logic ;
  d: out std_logic_vector(N-1 downto 0)) ; 
  end component ;
  
  --decoder unit decleration
 -- component decoder is 
  --port ( 
  --dec : in std_logic_vector(2 downto 0) ; 
  --d0: out std_logic; d1: out std_logic; 
  --d2: out std_logic;
 -- d3: out std_logic )  ; 
 -- end component ;
  
  --muc/umuc unit decleration
 component muc is 
  generic ( N : integer ) ; 
 port ( 
  input1,input2 : in std_logic_vector(N-1 downto 0); 
  --code: in std_logic_vector(2 downto 0);
  --en:in std_logic;
 clk:in std_logic;
 res:in std_logic ; 
 output: out std_logic_vector(2*N-1 downto 0));
 end component; 
  
 
  

--defining signals
signal wire_mul: std_logic_vector(2*N-1 downto 0);
signal wire_hi2: std_logic_vector(N-1 downto 0);
signal wire_lo2: std_logic_vector(N-1 downto 0);
signal wire: std_logic_vector(N-1 downto 0);
--signal d0: std_logic;
--signal d1: std_logic;
--signal d2: std_logic;
--signal d3: std_logic;
signal over: std_logic_vector(N-1 downto 0) :=(others=>'0');
signal resm: std_logic:='0';
signal macwire :std_logic_vector(2*N-1 downto 0);
signal output_sig :std_logic_vector(2*N-1 downto 0);
--signal clk: std_logic;





begin 
 --port mappping ths units, decoder output to enables, selcect signal the last bit of code
 -- output from each unit to signals.
--deco: decoder
--port map (dec=>code(2 downto 0), d0=>d0,d1=>d1,d2=>d2,d3=>d3);
  
Gate0: add_sub
generic map (N=>N)
port map (a=>input1, b=>input2,c=>code(0), d=>wire,status=>status);
  --en=>d0
Gate1: mul
generic map (N=>N)
port map (a=>input1, b=>input2, d=>wire_mul);
 --en=>d1
  
Gate2: ab
generic map (N=>N)
port map (a=>input1, d=>wire_lo2);
--en=>d2,   
  
Gate3: muc
generic map ( N=>N ) port map (input1=>input1,input2=>input2,res=>resm ,clk=>clk,output=>macwire) ; 
--en=>d3 ,--code=>code(2 downto 0)

  
  
c1:process (code,wire,wire_hi2,wire_lo2,input1,input2,wire_mul,macwire)

begin


--ghgahghagh
--add/sub code
if(code= "000" or code="001" ) then  
               output_sig<=over & wire;
 --mul code
elsif(code= "010") then
            output_sig<= wire_mul;
--umul code				
elsif(code= "011") then
            output_sig<= wire_mul;
--divider code				
elsif(code= "100") then
             output_sig<=wire_hi2 & wire_lo2;
--reset mac code			 
elsif(code= "101") then
     resm<='1' ;
	  output_sig<=(others=>'0');
	  ----  resm<='0','1'after 1 ns , '0' after 2 ns ;
--mac umuc code            
elsif(code="110" or code= "111") then 
      resm<='0'; 
      output_sig<=macwire ;
   
else
 output_sig<=(others=>'0');

end if;

end process;
output<=output_sig;
end struct;
