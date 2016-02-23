-- ====================================================================
--
--	File Name:		ALU.vhd
--	Description:alu top level entity 
--					
--
--	Date:			07/04/13
--	Designer:		yuval goldman & tal siton
--
-- ===================================================================


-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties

  entity ALU is 
  generic ( N : integer ) ; 
  port ( 
  input1,input2 : in std_logic_vector(N-1 downto 0); 
  op: in std_logic_vector(3 downto 0) ; 
  clk: in std_logic ; 
  output_hi: out std_logic_vector(N-1 downto 0); 
  output_lo: out std_logic_vector(N-1 downto 0); 
  status: out std_logic_vector(5 downto 0));
  end ALU ;
  
  architecture struct of ALU is
 
  --compoment declertaion
  component arith_unit is 
  generic ( N : integer ) ; 
  port (
  input1,input2 : in std_logic_vector(N-1 downto 0); 
  code: in std_logic_vector(2 downto 0);
  clk: in std_logic ; 
  output: out std_logic_vector(2*N-1 downto 0);
  status: out std_logic_vector(5 downto 0)
  );
  end component ; 

  
  component shift_unit is 
  generic ( N : integer ) ; 
  port ( 
  a,b : in std_logic_vector(N-1 downto 0); 
  code: in std_logic_vector(2 downto 0) ;
  d: out std_logic_vector(N-1 downto 0)
  ) ; 
  end component ;
  
  
  component out_sel is 
  generic ( N : integer ) ; 
  port ( 
  a : in std_logic_vector(2*N-1 downto 0); 
  b:in std_logic_vector(N-1 downto 0); 
  status_in : in std_logic_vector (5 downto 0);
  status_out : out std_logic_vector (5 downto 0); 
  sel: in std_logic; 
  d_hi: out std_logic_vector(N-1 downto 0); 
  d_lo: out std_logic_vector(N-1 downto 0)
  ) ; 
  end component ;
  
  
signal arith: std_logic_vector(2*N-1 downto 0);
signal shift: std_logic_vector(N-1 downto 0);
signal status_sig: std_logic_vector (5 downto 0);


begin
--port mapping to all units

Gate1: arith_unit
generic map (N=>input1'length)
port map (
input1=>input1,
 input2=>input2,
 code=>op(2 downto 0),
 clk=>clk,
 output=>arith,
 status=>status_sig
 );
 
 
Gate2: shift_unit 
generic map (N=>input1'length)
port map (
a=>input1, 
b=>input2,
code=>op(2 downto 0),
d=>shift
);  


Gate3: out_sel
generic map (N=>input1'length)
port map (
a=>arith, 
b=>shift, 
sel=>op(3),
status_in=>status_sig
,status_out=>status
,d_hi=>output_hi
,d_lo=>output_lo
);


end struct;




