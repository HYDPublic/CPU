---==========Library===========
library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all; 

entity Histogram is
	port(
		RD1_DATA					: in std_logic_vector (9 downto 0);
		iX_Cont,	iY_Cont		: in std_logic_vector(10 downto 0); 
		clk						: in std_logic;
		outD						: out std_logic_vector(11 downto 0)); 		
end Histogram;

--==========Architecure===========
architecture behv of Histogram is

--==========Signals===========						
type 	 	dataout is 						  array (127 downto 0) of std_logic_vector(19 downto 0);
signal 	BlackWhiteScale 				: dataout := ((others=> (others=>'0')));
signal 	Ready_to_print 				: dataout := ((others=> (others=>'0')));
signal 	outWire							: std_logic_vector(11 downto 0);
signal 	x 									: unsigned(10 downto 0) := (others => '0');
signal 	y 									: unsigned(10 downto 0) := (others => '0');
signal 	color									: unsigned(9 downto 0) := (others => '0');
signal 	normY  							: std_logic_vector(10 downto 0);
signal	vWire								: std_logic;
constant BLACK		 						: std_logic_vector (11 downto 0) := "000000000000";
constant WHITE		 						: std_logic_vector (11 downto 0) := "111111111111";
--============================

begin  --architecture
		x <= UNSIGNED(iX_Cont);
		y <= UNSIGNED(iY_Cont);
		  color  <= UNSIGNED(RD1_DATA);
		outD <= outWire;

--========Process that makes the array ready to histogram========================		
		 process(clk)	
		  variable colorI : integer :=  to_integer( UNSIGNED(RD1_DATA)/8);
		
		 begin  --process
			   if(rising_edge(clk)) then
				  if ((x = "00000000000") and (y = "00000000000")) then
						for i in 0 to 127 loop
						
							Ready_to_print(i) <= "000000" & BlackWhiteScale(i)(19 downto 6); 				--divide by 1024
						end loop;
			  	  elsif ((x = "00000000001") and (y = "00000000000")) then
						for k in 0 to 127 loop
							BlackWhiteScale(k) <= (others => '0');
						end loop;
				   else
					
	
								BlackWhiteScale(colorI) <= BlackWhiteScale(colorI) + 1; --8 colors per a cell
				

				  end if;
			 end if;
		 end process;
--========Process that prints out to the VGA========================		
		process(clk)	 
			 variable normY : integer := 1024 - to_integer(UNSIGNED(iY_Cont));
	
			variable normX : integer := to_integer( UNSIGNED(iX_Cont))/10; -- 0<= X <1280
		 begin
		 if(rising_edge(clk)) then
				
				if ((x > "00000000000") or (y > "00000000000")) then	--if the x axel in the picture
								if (normY < (to_integer(UNSIGNED(Ready_to_print(normX)(11 downto 0))))) then	
									outWire <= BLACK;
								else
									outWire <= WHITE;
								end if;
					end if;
						
				end if;
		 end process;

end behv;