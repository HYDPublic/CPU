-- ====================================================================
--
--	File Name:		add_sub.vhd
--	Description:	adder unit part of the arithmetic unit
--					
--
--	Date:			26/04/13
--	Designer:		Eyar Gilad, Dudu Abu
--
-- ===================================================================


-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties
entity add_sub is 
  generic ( N : integer ) ; 
  port ( a,b : in std_logic_vector(N-1 downto 0); en: in std_logic ; c: in std_logic ; status : out std_logic_vector(5 downto 0);d: out std_logic_vector(N-1 downto 0)) ; 
  end add_sub ;
architecture add_sub_arch of add_sub is

signal carry : std_logic;
signal b_comp : std_logic_vector(N-1 downto 0); 
signal wire : std_logic_vector(N-1 downto 0);
begin
  
process(a,b,c,en)
variable result : integer;
variable result_vec: std_logic_vector(N-1 downto 0);
begin
if(en='1') then --enable to add/sub unit 
  if (c='0') then--adding
  d<= std_logic_vector(signed(a)+signed(b));
  status<="000000";
  else-- subbing 
    d<= std_logic_vector(signed(a)-signed(b));
    result:=to_integer(unsigned(a)-unsigned(b));
    result_vec:=std_logic_vector(signed(a)-signed(b));
    
    --generate status output according to MSB of the result.
    if(unsigned(signed(a)-signed(b))=0)then
        status<="010101";
  
    else if(result_vec(N-1)='0') then
       status<="001110";
    else  
       status<="110010";
    end if;
    end if;
  end if;
end if; 
end process;
end add_sub_arch;
