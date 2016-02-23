library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.Numeric_STD.all;
use work.func_pack.all;

entity seven_segment_encoder is 

	port (
				
		clk			: in	std_logic;
		en			: in	std_logic;
		rst			: in	std_logic;
		number	 	: in 	std_logic_vector (15 downto 0);
		digit_lsb	: out	std_logic_vector (6 downto 0);
		digit_msb	: out	std_logic_vector (6 downto 0);
		digit_msb1	: out	std_logic_vector (6 downto 0);
		digit_msb2	: out	std_logic_vector (6 downto 0)
		
	);
end seven_segment_encoder;

architecture beh of seven_segment_encoder is

	begin
		process (clk,rst) 
--rising_edge (clk)
			begin
				if (rising_edge (clk)  ) then	
						
						digit_lsb <= seven_segment (number(3 downto 0)); 
						digit_msb <= seven_segment (number(7 downto 4));
						digit_msb1 <= seven_segment (number(11 downto 8));
						digit_msb2 <= seven_segment (number(15 downto 12));	
							
			
				end if;	
				
			end process;
		
	end beh;