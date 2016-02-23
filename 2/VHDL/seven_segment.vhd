
-- ====================================================================
--
--	File Name:		decoder.vhd
--	Description:	decoder for the arithmetic unit, selcting between 4 units
--					
--
--	Date:			07/04/13
--	Designer:		yuval goldman & tal siton
--
-- ====================================================================


-- libraries decleration

library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;

entity seven_segment is 
 port (
	num : in std_logic_vector(3 downto 0);
	en: in std_logic; 	
	segment: out std_logic_vector (6 downto 0)
	);
end entity;
architecture seven_segment_arch of seven_segment is
	-- input: 4 bit number (0-F) in Hx 
	-- output : 7 segment code -  in 7 bit vector where the bits represent:
	--			bit 6 - G
	--			bit 5 - F
	--			bit 4 - E
	--			bit 3 - D
	--			bit 2 - C
	--			bit 1 - B
	--			bit 0 - A
signal output : std_logic_vector (6 downto 0):="0000000";	
begin
  process(num)
	begin	
	if (en='1')	then
	  CASE num IS
      WHEN  "0000"  =>  output <= "1000000";
      WHEN  "0001" =>   output  <= "1111001";
      WHEN  "0010"  =>  output <= "0100100";
      WHEN  "0011"  =>  output <= "0110000";
      WHEN  "0100"  =>  output <= "0011001";
      WHEN  "0101" =>  output  <= "0010010";
      WHEN  "0110"  =>  output <= "0000010";
      WHEN  "0111"  =>  output <= "1111000";
      WHEN  "1000"  =>  output <= "0000000";
      WHEN  "1001" =>  output  <= "0010000";
      WHEN  "1010"  =>  output <= "0001000";
      WHEN  "1011"  =>  output <= "0000011";
      WHEN  "1100"  =>  output <= "1000110";
      WHEN  "1101" =>  output  <= "0100001";
      WHEN  "1110"  =>  output <= "0000110";
      WHEN  "1111"  =>  output <= "0001110";
      WHEN OTHERS =>  output <= "0111111";
    END CASE;
	else
		         output<="0111111";
	end if; 
	end process;
	segment<=output;
end seven_segment_arch;
			


