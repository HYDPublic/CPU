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
entity sobel_with_reg is
port(
	-- INPUT  --
	iPxlclk,RESET_N,iDVAL         : in STD_LOGIC;
	input_data           : in STD_LOGIC_VECTOR(9 downto 0);
	thresh               : in STD_LOGIC_VECTOR(7 downto 0);
	-- OUTPUT --
	output_data   : out STD_LOGIC_VECTOR(9 downto 0));
end sobel_with_reg;

--========== Architecture ==============--
--======================================--
architecture test of sobel_with_reg is

-- COMPONENTS --
----------------
component Sobel is
port(
	-- INPUT  --
	CLOCK,RESET_N,iDVAL         : in STD_LOGIC;
	input_data           : in STD_LOGIC_VECTOR(9 downto 0);
	thresh               : in STD_LOGIC_VECTOR(7 downto 0);
	-- OUTPUT --
	output_data   : out STD_LOGIC_VECTOR(9 downto 0));
end component Sobel;

	signal iDVAL_in   :  std_logic;
	signal input_data_in   :  std_logic_vector(9 downto 0);
	signal thresh_in : std_logic_vector(7 downto 0);
	signal output_data_out : STD_LOGIC_VECTOR(9 downto 0);

begin

test: Sobel port map(
							RESET_N => RESET_N,
							CLOCK => iPxlclk,
							iDVAL => iDVAL_in,
							input_data  => input_data_in,
							thresh => thresh_in,
							output_data => output_data_out);

process(iPxlclk,RESET_N)
	begin
	if(rising_edge(iPxlclk)) then
		iDVAL_in <= iDVAL;
		input_data_in <= input_data;
		thresh_in <= thresh;
		output_data <= output_data_out;
	end if;
end process;
	
	
end test;