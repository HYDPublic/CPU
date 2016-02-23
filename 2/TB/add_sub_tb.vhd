LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
ENTITY add_sub_tb  IS 
  GENERIC (
    N  : INTEGER :=4  ); 
END ; 
 
ARCHITECTURE add_sub_tb_arch OF add_sub_tb IS
  SIGNAL d   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL status   :  std_logic_vector (5 downto 0)  ; 
  SIGNAL a   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL b   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL c   :  STD_LOGIC  ; 
  SIGNAL en   :  STD_LOGIC  ; 
  COMPONENT add_sub  
    GENERIC ( 
      N  : INTEGER :=4 );  
    PORT ( 
      d  : out std_logic_vector (N - 1 downto 0) ; 
      status  : out std_logic_vector (5 downto 0) ; 
      a  : in std_logic_vector (N - 1 downto 0) ; 
      b  : in std_logic_vector (N - 1 downto 0) ; 
      c  : in STD_LOGIC ; 
      en  : in STD_LOGIC ); 
  END COMPONENT ; 

BEGIN
  
  DUT  : add_sub  
    GENERIC MAP ( N  => N   )
   
    PORT MAP ( 
      d   => d  ,
      status   => status  ,
      a   => a  ,
      b   => b  ,
      c   => c  ,
      en   => en   ) ; 
    
test:process
  
 variable x:std_logic_vector ( 3 downto 0);
 variable y:std_logic_vector ( 3 downto 0);
 
 begin  
      x:="0001";
      y:="0101";
      en<='1';
      c<='0','1' after 30 ns;
      
      for i in 0 to 4
      loop
            a<=x;
            b<=y;
            x:=std_logic_vector(signed(x)-1);
            y:=std_logic_vector(signed(y)+1);
        wait for 10 ns;
     end loop; 
 end process;  
END ; 

