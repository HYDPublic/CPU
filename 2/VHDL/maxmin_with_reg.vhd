
-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties

  entity maxmin_with_reg is 
  generic ( N : integer:=32 ) ; 
   port (en,c: in std_logic; a,b : in std_logic_vector(N-1 downto 0); clk: in std_logic ;d: out std_logic_vector(N-1 downto 0)) ; 
  end maxmin_with_reg ;
  
  architecture struct of maxmin_with_reg is
 
  --compoment declertaion
  component max_min is 
  generic ( N : integer ) ; 
  port (c: in std_logic; a,b : in std_logic_vector(N-1 downto 0); d:out std_logic_vector(N-1 downto 0) ) ; 
  end component ; 

  component maxmin_regin is 
  generic ( N : integer ) ; 
  PORT
   (
       clk,en,c_in: IN STD_LOGIC;
       c_out: OUT STD_LOGIC;
-----------------------------------------------		  
		 
		  a_in: IN STD_LOGIC_vector(N-1 downto 0);
		  b_in:IN STD_LOGIC_vector(N-1 downto 0);
---------------------------------------------------		  
		
		  a_out: out STD_LOGIC_vector(N-1 downto 0);
		  b_out:out STD_LOGIC_vector(N-1 downto 0)
   );
  end component;
  
  component maxmin_regout is 
  generic ( N : integer ) ; 
 PORT
   (
      clk,en: IN STD_LOGIC;
--------------------------------------------	  
		d_in: IN STD_LOGIC_vector(N-1 downto 0);
		
---------------------------------------------------		 
      d_out: out STD_LOGIC_vector(N-1 downto 0)

   );
 end component;
  
signal a_sig: std_logic_vector(N-1 downto 0);
signal b_sig: std_logic_vector(N-1 downto 0);
signal d_sig: std_logic_vector(N-1 downto 0);
signal c_sig: std_logic;
--signal status_sig: std_logic_vector (5 downto 0);

begin
--port mapping to all units
Gate1: maxmin_regin
generic map (N=>N)
port map (c_in=>c, c_out=>c_sig, a_in=>a, b_in=>b, clk=>clk, en=>en, a_out=>a_sig, b_out=>b_sig);
Gate2: max_min 
generic map (N=>N)
port map (c=>c_sig, a=>a_sig, b=>b_sig,d=>d_sig);  
Gate3: maxmin_regout
generic map (N=>N)
port map (en=>en,clk=>clk , d_in=>d_sig, d_out=>d);


end struct;

