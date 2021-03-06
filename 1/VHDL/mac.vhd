-- ====================================================================
--
--	File Name:		mac_umac.vhd
--	Description:	synchronic unit with 1/10 ns clock, Multply and acumulate 
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
entity muc is 
  generic ( N : integer ) ; 
  port ( input1,input2 : in std_logic_vector(N-1 downto 0);clk:in std_logic; sel: in std_logic;en:in std_logic;res:in std_logic ; output: out std_logic_vector(2*N-1 downto 0));
  end muc; 

architecture struct of muc is
--mul/umul unit decleration
component mul is
generic ( N : integer ) ; 
port ( a,b : in std_logic_vector(N-1 downto 0);en: in std_logic; c: in std_logic ;d: out std_logic_vector(2*N-1 downto 0)) ; 
end component;
--add/sub unit decleration
component add_sub is
generic ( N : integer ) ;
port ( a,b : in std_logic_vector(N-1 downto 0); en: in std_logic ; c: in std_logic ; status : out std_logic_vector(5 downto 0);d: out std_logic_vector(N-1 downto 0)) ; 
end component;

    signal prod : STD_LOGIC_VECTOR (2*N-1 downto 0);
    signal acc_in : STD_LOGIC_VECTOR (2*N-1 downto 0);
    signal acc_out : STD_LOGIC_VECTOR (2*N-1 downto 0):=(others => '0');
    signal Cout : STD_LOGIC;
    signal status  : STD_LOGIC_VECTOR (5 downto 0);
    
begin
--port mapping the mul unit to input and output
Gate1: mul
generic map (N=>N)
port map (a=>input1, b=>input2, en=>'1' ,c=>sel ,d=>prod);
--port mapping the add/sub unit to input and output
Gate2: add_sub 
generic map (N=>2*N)
port map (a=>acc_out, b=>prod,en=>'1', c=>'0',status=>status,d=>acc_in);

   
   mul_and_acu:process
   begin     
       wait until rising_edge(clk);--this unit work on rising of clock
            if ( en='1')-- the process happning when the unit has enable sign
             then
               if (res='1') then
                    acc_out <= (others => '0'); --reseting the mac register 
              else
                    acc_out <=  acc_in;--Muliply and acuumlate
            end if;
          end if;
           
  end process;
     output <= acc_out;--output of the unit
end struct;