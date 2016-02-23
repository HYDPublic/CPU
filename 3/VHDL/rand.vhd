
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_STD.all;
use ieee.std_logic_arith.all;

entity rand is
generic ( width : integer := 8 ); 
port (
clk : in std_logic;
random_num : out std_logic_vector (width-1 downto 0) --output vector 
);
end rand;

architecture rtl of rand is

begin
process(clk)
variable rand_temp : std_logic_vector(width-1 downto 0):=(width-1 => '1',others => '0');
variable rand_temp2 : std_logic_vector(width-1 downto 0);
variable rand_temp3 : std_logic_vector(width-1 downto 0):=(width-1 => '1',others => '0');
variable lop:integer:=0;
variable temp : std_logic := '0';
begin
if(rising_edge(clk)) then
lop:=lop+1;
if(lop>10000000) then
	temp := rand_temp(width-1) xor rand_temp(width-2);
	rand_temp(width-1 downto 1) := rand_temp(width-2 downto 0);
	rand_temp(0) := temp;

	if(rand_temp<"00011100") then
		rand_temp2:="00000011";
	end if;
	if(rand_temp>="00011100" and rand_temp<"01000001") then
		rand_temp2:="00001100";
	end if;
	if(rand_temp>"01000000" and rand_temp<"01110001") then
		rand_temp2:="00110000";
	end if;
	if(rand_temp>"01110000") then
		rand_temp2:="11000000";
	end if;
lop:=0;
end if;
end if;
random_num <= rand_temp2;
end process;
end rtl;