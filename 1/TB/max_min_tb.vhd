LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 

ENTITY max_min_tb  IS 
  GENERIC (
    N  : INTEGER :=4  ); 
END ; 
ARCHITECTURE max_min_tb_arch OF max_min_tb IS

 SIGNAL d   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL a  :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL b   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL c   :  STD_LOGIC  ; 
  SIGNAL en   :  STD_LOGIC  ; 
  
  
  COMPONENT max_min  
    GENERIC ( N  : INTEGER:=4  );  
    PORT ( 
      d  : out std_logic_vector (N - 1 downto 0) ; 
      a  : in std_logic_vector (N - 1 downto 0) ; 
      b  : in std_logic_vector (N - 1 downto 0) ; 
      c  : in STD_LOGIC ;
      en  : in STD_LOGIC ); 
  END COMPONENT ; 
  
BEGIN
  DUT  : max_min  
    GENERIC MAP ( N  => N)
    PORT MAP ( 
      d => d  ,
      a   => a  ,
      b   => b  ,
      c   => c  ,
      en   => en   ) ; 
      
test:process  
 
  variable x:std_logic_vector ( N-1 downto 0);
  variable y:std_logic_vector ( N-1 downto 0);
 begin  
      x:="0101";
      y:="1011";
      c<='1';
      en<='1';
      
      for i in 0 to 6
      loop
            a<=x;
            b<=y;
            x:=std_logic_vector(unsigned(a)+1);
            y:=std_logic_vector(unsigned(b)+1);
            wait for 10 ns;
            c<=not c;
     end loop; 
 end process;  
end max_min_tb_arch ; 



