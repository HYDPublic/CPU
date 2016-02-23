

-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties

  entity adder_with_reg is 
  generic ( N : integer:=32 ) ; 
   port ( a,b : in std_logic_vector(N-1 downto 0); en: in std_logic ; clk: in std_logic; c: in std_logic ; status : out std_logic_vector(5 downto 0);d: out std_logic_vector(N-1 downto 0)) ; 
  end adder_with_reg ;
  
  architecture struct of adder_with_reg is
 
  --compoment declertaion
  component add_sub is 
  generic ( N : integer ) ; 
    port ( a,b : in std_logic_vector(N-1 downto 0) ; c: in std_logic ; status : out std_logic_vector(5 downto 0);d: out std_logic_vector(N-1 downto 0)) ; 
  end component ; 

  component regin is 
  generic ( N : integer ) ; 
  PORT
   (
      clk,en,c: IN STD_LOGIC;
		  a,b: IN STD_LOGIC_vector(31 downto 0);
		 
      aout,bout: out STD_LOGIC_vector(31 downto 0);
		  cout: out STD_LOGIC
   );
  end component;
  
  component regout is 
  generic ( N : integer ) ; 
 PORT
   (
      clk,en: IN STD_LOGIC;
		  status_in: IN STD_LOGIC_vector(5 downto 0);
		  d_in:IN STD_LOGIC_vector(31 downto 0);
		 
      status_out: out STD_LOGIC_vector(5 downto 0);
		  d_out:out STD_LOGIC_vector(31 downto 0)
   );
 end component;
  
signal a_sig: std_logic_vector(N-1 downto 0);
signal b_sig: std_logic_vector(N-1 downto 0);
signal d_sig: std_logic_vector(N-1 downto 0);
signal ena_sig: std_logic;
signal c_sig: std_logic;
signal status_sig: std_logic_vector (5 downto 0);

begin
--port mapping to all units
Gate1: regin
generic map (N=>N)
port map (a=>a, b=>b,clk=>clk,en=>en,c=>c,aout=>a_sig,bout=>b_sig,cout=>c_sig);
Gate2: add_sub 
generic map (N=>N)
port map (a=>a_sig, b=>b_sig,c=>c_sig,status=>status_sig,d=>d_sig);  
Gate3: regout
generic map (N=>N)
port map (en=>en,clk=>clk ,status_in=>status_sig, d_in=>d_sig,status_out=>status,d_out=>d);


end struct;


