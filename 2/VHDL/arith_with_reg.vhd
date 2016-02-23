
-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties

  entity arith_with_reg is 
  generic ( N : integer:=32 ) ; 
   port ( 
	clk: IN STD_LOGIC;
	input1_top,input2_top : in std_logic_vector(N-1 downto 0); 
	code_top: in std_logic_vector(2 downto 0);
   output_top: out std_logic_vector(2*N-1 downto 0);
  status_top: out std_logic_vector(5 downto 0)); 
  end arith_with_reg ;
  
  architecture struct of arith_with_reg is
 
  --compoment declertaion
  component arith_unit is 
  generic ( N : integer ) ; 
port (
	clk: in std_logic;
	input1,input2 : in std_logic_vector(N-1 downto 0);
	code: in std_logic_vector(2 downto 0);
	output: out std_logic_vector(2*N-1 downto 0);
   status: out std_logic_vector(5 downto 0)); 
  end component ; 

  component arithmatic_regin is 
  generic ( N : integer ) ; 
  PORT
(
		  clk: IN STD_LOGIC;
-----------------------------------------------		  
		  input1,input2 : in std_logic_vector(N-1 downto 0) ; 
        code: in std_logic_vector(2 downto 0);
---------------------------------------------------		  
        input1out: out  std_logic_vector(N-1 downto 0) ; 
		  input2out: out  std_logic_vector(N-1 downto 0) ; 
		  codeout: out std_logic_vector(2 downto 0)
   );
  end component;
  
  component regout_arith is 
  generic  ( N : integer )  ; 
 PORT
   (
      clk: IN STD_LOGIC;
--------------------------------------------	  
		outputin: in std_logic_vector(2*N-1 downto 0);
		statusin:in std_logic_vector(5 downto 0);
---------------------------------------------------		 
		outputout: out std_logic_vector(2*N-1 downto 0);
		statusout:out std_logic_vector(5 downto 0)

   );
 end component;
  
signal input1_sig: std_logic_vector(N-1 downto 0);
signal input2_sig: std_logic_vector(N-1 downto 0);
signal code_sig: std_logic_vector(2 downto 0);
signal output_sig: std_logic_vector(2*N-1 downto 0);
signal status_sig: std_logic_vector(5 downto 0);
signal res_sig: std_logic;


--signal status_sig: std_logic_vector (5 downto 0);

begin
--port mapping to all units
Gate1: arithmatic_regin
generic map (N=>N)
port map (
clk=>clk,
input1=>input1_top, 
input2=>input2_top,
code=>code_top,
input1out=>input1_sig,
input2out=>input2_sig,
codeout=>code_sig
);


Gate2: arith_unit 
generic map (N=>N)
port map (
clk=>clk ,
input1=>input1_sig, 
input2=>input2_sig,
code=>code_sig,
status=>status_sig,
output=>output_sig); 
 
Gate3: regout_arith
generic map (N=>N)
port map (
clk=>clk ,
outputin=>output_sig, 
statusin=>status_sig,
outputout=>output_top,
statusout=>status_top
);


end struct;

