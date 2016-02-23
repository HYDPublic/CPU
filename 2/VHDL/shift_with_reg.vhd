
-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties

  entity shift_with_reg is 
  generic ( N : integer:=32 ) ; 
   port ( a,b : in std_logic_vector(N-1 downto 0);clk: in std_logic;en: in std_logic; code: in std_logic_vector(2 downto 0) ;d: out std_logic_vector(N-1 downto 0)) ; 
  end shift_with_reg ;
  
  architecture struct of shift_with_reg is
 
  --compoment declertaion
  component shift_unit is 
  generic ( N : integer ) ; 
    port ( a,b : in std_logic_vector(N-1 downto 0); code: in std_logic_vector(2 downto 0) ;d: out std_logic_vector(N-1 downto 0)) ; 
  end component ; 

  component shift_regin is 
  generic ( N : integer ) ; 
  PORT
   (
       clk,en: IN STD_LOGIC;
-----------------------------------------------		  
			code_in	: IN STD_LOGIC_vector(2 downto 0);
		  a_in: IN STD_LOGIC_vector(N-1 downto 0);
		  b_in:IN STD_LOGIC_vector(N-1 downto 0);
---------------------------------------------------		  
		  code_out: out STD_LOGIC_vector(2 downto 0);
		  a_out: out STD_LOGIC_vector(N-1 downto 0);
		  b_out:out STD_LOGIC_vector(N-1 downto 0)
   );
  end component;
  
  component shift_regout is 
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
--signal enm_sig: std_logic;
signal code_sig: std_logic_vector(2 downto 0);
--signal status_sig: std_logic_vector (5 downto 0);

begin
--port mapping to all units
Gate1: shift_regin
generic map (N=>N)
port map (a_in=>a, b_in=>b,clk=>clk,en=>en,code_in=>code,a_out=>a_sig,b_out=>b_sig,code_out=>code_sig);
Gate2: shift_unit
generic map (N=>N)
port map (a=>a_sig, b=>b_sig,code=>code_sig,d=>d_sig);  
Gate3: shift_regout
generic map (N=>N)
port map (en=>en,clk=>clk,d_in=>d_sig, d_out=>d);


end struct;

