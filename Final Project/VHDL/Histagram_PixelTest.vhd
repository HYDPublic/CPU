--======================================--
--         CPU - Final Project          --
--  (C) Eliran Friedman & Adir Zar      --
--             June 2014                --
--======================================--
--======================================--
-- Component : Edge_Detection           --        
--                                      --  
--========== Library ===================--
library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_signed.all; 
use ieee.std_logic_arith.all;

--========== Entity ====================--
--======================================--
entity Histagram_PixelTest is
port(
	-- INPUT  --
	iPxlclk         : in STD_LOGIC;
	iX_Cont,iY_Cont           : in STD_LOGIC_VECTOR(10 downto 0);
	RD1_DATA					: in std_logic_vector (9 downto 0);
	-- OUTPUT --
	outD   : out STD_LOGIC_VECTOR(11 downto 0));
end Histagram_PixelTest;

--========== Architecture ==============--
--======================================--
architecture test of Histagram_PixelTest is

-- COMPONENTS --
----------------
component Histogram is
port(
	-- INPUT  --
	clk         : in STD_LOGIC;
	iX_Cont,iY_Cont           : in STD_LOGIC_VECTOR(10 downto 0);
	RD1_DATA					: in std_logic_vector (9 downto 0);
	-- OUTPUT --
	outD   	  : out STD_LOGIC_VECTOR(11 downto 0));
end component Histogram;

	signal RD1_DATA_in_reg   :  std_logic_vector(9 downto 0);
	signal iX_cont_in_reg, iY_cont_in_reg   :  std_logic_vector(10 downto 0);
	signal output_out : std_logic_vector(11 downto 0);


begin

test: Histogram port map(
							RD1_DATA => RD1_DATA_in_reg,
							clk => iPxlclk,
							iX_Cont => iX_cont_in_reg,
							iY_cont  => iY_cont_in_reg,
							outD => output_out);

process(iPxlclk)
	begin
	if(rising_edge(iPxlclk)) then
		RD1_DATA_in_reg <= RD1_DATA;
		iX_cont_in_reg <= iX_cont;
		iY_cont_in_reg <= iY_cont;
		outD <= output_out;
	end if;
end process;
	
	
end test;