library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity TIMER is
port(
		
		hex0 :out std_logic_vector(0 to 6);
		hex1 :out std_logic_vector(0 to 6);
		hex2 :out std_logic_vector(0 to 6);
		hex3 :out std_logic_vector(0 to 6);
		--SW: in std_logic_vector(0 to 9);
		key: in std_logic_vector(0 to 3);
		counter2 	: in 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
		clock_50 : std_logic;
		
		interrupt : out std_logic
		);
	function segment (s: integer:=0) --function return 7-bit  
   return std_logic_vector is	      
	begin
	case s is
		when 0 => return "1000000";
		when 1 => return "1111001";
		when 2 => return "0100100";
		when 3 => return "0110000";
		when 4 => return "0011001";
		when 5 => return "0010010";
		when 6 => return "0000010";
		when 7 => return "1111000";
		when 8 => return "0000000";
		when 9 => return "0010000";
		when others => return "1111111";
		end case;
		end segment;
	end;
		
architecture counter of TIMER is
signal count : integer := 1;

signal int : std_logic :='0';	
signal clk : std_logic :='0';	
begin	
	
--clock divider from 50Mhz to 10hz				
process(clock_50)
begin
if(clock_50'event and clock_50='1') then
count <=count+1;
if(count = 12500000) then--to_integer(unsigned(counter2))
clk <= not clk;
count <=1;
end if;
end if;
end process;

process(clk)--period of clk is 1 second (1Hz)
type timee is array(0 to 3) of integer;
variable zetime: timee:=(0,0,0,0) ; 
variable flag: std_logic;
variable  int2: integer :=0 ;
begin
if(key(0)'event and key(0)'last_value='0') then --little trick to make key push button behave like switch
flag:=not flag;
end if;

if(clk'event and clk='1' and flag='1' ) then --here the main shit happens
--
--
if(int2 =0) then 
interrupt<= '0';
int2 := 1 ;
else
interrupt<= '1';
int2 :=0;
end if;


zetime(0):= zetime(0)+1;
if (zetime(0)=10) then
zetime(0):=0;
zetime(1):= zetime(1)+1;
if (zetime(1)=10) then
zetime(1):=0;
zetime(2):= zetime(2)+1;
if (zetime(2)=6) then
zetime(2):=0;
zetime(3):= zetime(3)+1;
end if;
end if;
end if;
end if;

if(key(1)='0') then -- just wipe out all digits from 7-sigment
zetime:=(0,0,0,0) ; 
end if;



hex0<=segment(zetime(0)); --call to function  
hex1<=segment(zetime(1));
hex2<=segment(zetime(2));
hex3<=segment(zetime(3));

end process;
end;
