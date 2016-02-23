
-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties

  entity out_sel_with_reg is 
  generic ( N : integer:=32 ) ; 
   port ( a : in std_logic_vector(2*N-1 downto 0);b:in std_logic_vector(N-1 downto 0);sel: in std_LOGIC;clk: in std_logic;en: in std_logic; status_in: in std_logic_vector(5 downto 0);
	status_out:out std_LOGIC_vector(5 downto 0);d_hi: out std_logic_vector(N-1 downto 0);d_lo:out std_logic_vector(N-1 downto 0)) ; 
  end out_sel_with_reg ;
  
  architecture struct of out_sel_with_reg is
 
  --compoment declertaion
  component out_sel is 
  generic ( N : integer ) ; 
 port ( a : in std_logic_vector(2*N-1 downto 0); b: in std_logic_vector ( N-1 downto 0);status_in : in std_logic_vector (5 downto 0);status_out : out std_logic_vector (5 downto 0);sel: in std_logic;d_hi: out std_logic_vector(N-1 downto 0); d_lo: out std_logic_vector(N-1 downto 0)) ; 
  end component ; 

  component out_sel_regin is 
  generic ( N : integer ) ; 
  PORT
   (
		  clk,en: IN STD_LOGIC;
-----------------------------------------------		  
			status_in	: IN STD_LOGIC_vector(5 downto 0);
		  a_in: IN STD_LOGIC_vector(2*N-1 downto 0);
		  b_in:IN STD_LOGIC_vector(N-1 downto 0);
		  sel_in: IN STD_LOGIC;
---------------------------------------------------		  
		  status_out: out STD_LOGIC_vector(5 downto 0);
		  a_out: out STD_LOGIC_vector(2*N-1 downto 0);
		  b_out:out STD_LOGIC_vector(N-1 downto 0);
		  sel_out: out STD_LOGIC
   );
  end component;
  
  component out_sel_regout is 
  generic ( N : integer ) ; 
 PORT
   (clk,en: IN STD_LOGIC;
--------------------------------------------	  
		d_lo_in: IN STD_LOGIC_vector(N-1 downto 0);
		d_hi_in:IN STD_LOGIC_vector(N-1 downto 0);
		status_in :IN STD_LOGIC_vector(5 downto 0);
---------------------------------------------------		 
      d_lo_out: out STD_LOGIC_vector(N-1 downto 0);
		d_hi_out:out STD_LOGIC_vector(N-1 downto 0);
		status_out :out STD_LOGIC_vector(5 downto 0)
   );
 end component;
  
signal a_sig: std_logic_vector(2*N-1 downto 0);
signal b_sig: std_logic_vector(N-1 downto 0);
signal d_hi_sig: std_logic_vector(N-1 downto 0);
signal d_lo_sig: std_logic_vector(N-1 downto 0);

--signal enm_sig: std_logic;
signal sel_sig: std_logic;
signal status1_sig: std_logic_vector (5 downto 0);
signal status2_sig: std_logic_vector (5 downto 0);


begin
--port mapping to all units
Gate1: out_sel_regin
generic map (N=>N)
port map (a_in=>a, b_in=>b,clk=>clk,en=>en,status_in=>status_in,sel_in=>sel,
			b_out=>b_sig,a_out=>a_sig,sel_out=>sel_sig,status_out=>status1_sig);
Gate2: out_sel
generic map (N=>N)
port map (a=>a_sig, b=>b_sig,status_in=>status1_sig,sel=>sel_sig,d_hi=>d_hi_sig,d_lo=>d_lo_sig,status_out=>status2_sig);  
Gate3: out_sel_regout
generic map (N=>N)
port map (en=>en,clk=>clk,d_hi_in=>d_hi_sig,d_lo_in=>d_lo_sig,status_in=>status2_sig,d_hi_out=>d_hi,d_lo_out=>d_lo,status_out=>status_out);


end struct;

