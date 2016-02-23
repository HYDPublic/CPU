

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

package func_pack is

	function seven_segment (number : std_logic_vector) return std_logic_vector;

end func_pack;

package body func_pack is

	function seven_segment (number : std_logic_vector) return std_logic_vector is
	
		variable num_int : std_logic_vector (3 downto 0);
		
		begin
			
			num_int := number;
			
			case num_int is--checks which leds to turn on in the seven segment
			
				when x"0" => return "1000000";
				
				when x"1" => return "1111001";
				
				when x"2" => return "0100100";
				
				when x"3" => return "0110000";
				
				when x"4" => return "0011001";
				
				when x"5" => return "0010010";
				
				when x"6" => return "0000010";
				
				when x"7" => return "1111000";
				
				when x"8" => return "0000000";
				
				when x"9" => return "0010000";
				
				when x"A" => return "0001000";
				
				when x"B" => return "0000011";
				
				when x"C" => return "1000110";
				
				when x"D" => return "0100001";
				
				when x"E" => return "0000110";
				
				when x"F" => return "0001110";
				
				when others => return "0111111";
				
			end case;
			
		end seven_segment;
		
end func_pack;
			