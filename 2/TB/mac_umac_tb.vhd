
LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
ENTITY mac_umac_tb IS 
  GENERIC (
    N  : INTEGER:=3   ); 
END ; 
 
ARCHITECTURE mac_umac_tb_arch OF mac_umac_tb IS
  SIGNAL sel   :  STD_LOGIC  ; 
  SIGNAL output   :  std_logic_vector (2 * N - 1 downto 0)  ; 
  SIGNAL input1   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL res   :  STD_LOGIC  ; 
  SIGNAL input2   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL en   :  STD_LOGIC  ; 
  signal clk : std_logic := '0' ;
 
  COMPONENT mac_umac  
    GENERIC ( 
      N  : INTEGER:=3  );  
    PORT ( 
      sel  : in STD_LOGIC ; 
       clk:in std_logic; 
      output  : out std_logic_vector (2 * N - 1 downto 0) ; 
      input1  : in std_logic_vector (N - 1 downto 0) ; 
      res  : in STD_LOGIC ; 
      input2  : in std_logic_vector (N - 1 downto 0) ; 
      en  : in STD_LOGIC ); 
  END COMPONENT ;
   
   
   
   
   
BEGIN
  DUT  : mac_umac  
    GENERIC MAP ( 
      N  => N   )
    PORT MAP ( 
      sel   => sel  ,
      output   => output  ,
      input1   => input1  ,
      clk =>clk,
      res   => res  ,
      input2   => input2  ,
      en   => en   ) ; 
      
      clk<= not clk after 5 ns;
      en<='1';--,not en after 10 ns;
      res<='0';
      input1<="010";--"011" after 10 ns,"010" after 20 ns;
      input2<="011";------"100" after 10 ns,"100" after 20 ns;
      sel<='1';
END ; 

