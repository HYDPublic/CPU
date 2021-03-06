LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
ENTITY muc_tb_MAc  IS 
  GENERIC (
    N  : INTEGER:=3   ); 
END ; 
 
ARCHITECTURE muc_tb_MAc_arch OF muc_tb_MAc IS
  SIGNAL sel   :  STD_LOGIC  ; 
  SIGNAL output   :  std_logic_vector (2 * N - 1 downto 0)  ; 
  SIGNAL input1   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL res   :  STD_LOGIC  ; 
  SIGNAL input2   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL clk   :  STD_LOGIC  ;
  SIGNAL en   :  STD_LOGIC  ; 
  COMPONENT muc  
    GENERIC ( 
      N  : INTEGER:=3  );  
    PORT ( 
      sel  : in STD_LOGIC ; 
      output  : out std_logic_vector (2 * N - 1 downto 0) ; 
      input1  : in std_logic_vector (N - 1 downto 0) ; 
      res  : in STD_LOGIC ; 
      input2  : in std_logic_vector (N - 1 downto 0) ;
	  clk  : in STD_LOGIC ;
      en  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : muc  
    GENERIC MAP ( 
      N  => N   )
    PORT MAP ( 
      sel   => sel  ,
      output   => output  ,
      input1   => input1  ,
      res   => res  ,
      input2   => input2  ,
      en   => en   ,
	  clk   => clk
	  ) ; 
      
	  en<='1';
      clk<='1',not clk after 10 ns;
      res<='0';
      input1<="010";--"011" after 10 ns,"010" after 20 ns;
      input2<="011";------"100" after 10 ns,"100" after 20 ns;
      --sel<='1';
END ; 

