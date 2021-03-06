
-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties

  entity mul_with_reg is 
  generic ( N : integer:=32 ) ; 
   port ( a,b : in std_logic_vector(N-1 downto 0); en: in std_logic ; clk: in std_logic; c: in std_logic ;d: out std_logic_vector(2*N-1 downto 0)) ; 
  end mul_with_reg ;
  
  architecture struct of mul_with_reg is
 
  --compoment declertaion
  component mul is 
  generic ( N : integer ) ; 
    port ( 
  a,b : in std_logic_vector(N-1 downto 0);
  d: out std_logic_vector(2*N-1 downto 0)) ; 
  end component ; 

  component mul_regin is 
  generic ( N : integer ) ; 
  PORT
   (
      clk,en: IN STD_LOGIC;
-----------------------------------------------		
		  a_in: IN STD_LOGIC_vector(N-1 downto 0);
		  b_in:IN STD_LOGIC_vector(N-1 downto 0);
------------------------------------------------------		 
		  a_out: out STD_LOGIC_vector(N-1 downto 0);
		  b_out:out STD_LOGIC_vector(N-1 downto 0)
   );
  end component;
  
  component mul_regout is 
  generic ( N : integer ) ; 
 PORT
   (
      clk,en: IN STD_LOGIC;
--------------------------------------------	  
		d_in: IN STD_LOGIC_vector(2*N-1 downto 0);
---------------------------------------------------		 
      d_out: out STD_LOGIC_vector(2*N-1 downto 0)

   );
 end component;
  
signal a_sig: std_logic_vector(N-1 downto 0);
signal b_sig: std_logic_vector(N-1 downto 0);
signal d_sig: std_logic_vector(2*N-1 downto 0);
--signal status_sig: std_logic_vector (5 downto 0);

begin
--port mapping to all units
Gate1: mul_regin
generic map (N=>N)
port map (a_in=>a, b_in=>b,clk=>clk,en=>en,a_out=>a_sig,b_out=>b_sig);
Gate2: mul 
generic map (N=>N)
port map (a=>a_sig, b=>b_sig, d=>d_sig);  
Gate3: mul_regout
generic map (N=>N)
port map (en=>en,clk=>clk ,d_in=>d_sig, d_out=>d);


end struct;

