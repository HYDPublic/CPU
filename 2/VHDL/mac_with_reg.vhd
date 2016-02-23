
-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties

  entity mac_with_reg is 
  generic ( N : integer:=32 ) ; 
   port ( a,b : in std_logic_vector(N-1 downto 0); en: in std_logic ; 
   clk: in std_logic; res: in std_logic ; d: out std_logic_vector(2*N-1 downto 0)) ; 
  end mac_with_reg ;
  
  architecture struct of mac_with_reg is
 
  --compoment declertaion
  component muc is 
  generic ( N : integer ) ; 
port ( input1,input2 : in std_logic_vector(N-1 downto 0);
clk:in std_logic;
-- en:in std_logic;
 res:in std_logic ; 
 output: out std_logic_vector(2*N-1 downto 0));
  end component ; 

  component mac_regin is 
  generic ( N : integer ) ; 
  PORT
(
		  clk,en: IN STD_LOGIC;
-----------------------------------------------		  
		  res: IN STD_LOGIC;
		  a_in: IN STD_LOGIC_vector(N-1 downto 0);
		  b_in:IN STD_LOGIC_vector(N-1 downto 0);
---------------------------------------------------		  
		  res_out: out STD_LOGIC;
		  a_out: out STD_LOGIC_vector(N-1 downto 0);
		  b_out:out STD_LOGIC_vector(N-1 downto 0)
   );
  end component;
  
  component mac_regout is 
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
--signal enm_sig: std_logic;
signal sel_sig: std_logic;
signal res_sig: std_logic;

--signal status_sig: std_logic_vector (5 downto 0);

begin
--port mapping to all units
Gate1: mac_regin
generic map (N=>N)
port map (a_in=>a, b_in=>b,clk=>clk,en=>en,res=>res,a_out=>a_sig,b_out=>b_sig,res_out=>res_sig);
Gate2: muc
generic map (N=>N)
port map (input1=>a_sig,clk=>clk, input2=>b_sig,res=>res_sig,output=>d_sig);  
Gate3: mac_regout
generic map (N=>N)
port map (en=>en,clk=>clk ,d_in=>d_sig, d_out=>d);


end struct;

