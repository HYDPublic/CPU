LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 


ENTITY mul_umul_tb  IS 
  GENERIC (N  : INTEGER:=4   ); 
END ; 
 
ARCHITECTURE mul_umul_tb_arch OF mul_umul_tb IS
  
  SIGNAL d   :  std_logic_vector (2*N - 1 downto 0)  ; 
  SIGNAL a   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL b   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL c   :  STD_LOGIC  ; 
  SIGNAL en   :  STD_LOGIC  ; 

  COMPONENT mul_umul  
    GENERIC ( N  : INTEGER:=4  );  
    PORT ( 
      d  : out std_logic_vector (2*N - 1 downto 0) ; 
      a  : in std_logic_vector (N - 1 downto 0) ; 
      b  : in std_logic_vector (N - 1 downto 0) ; 
      c  : in STD_LOGIC ; 
      en  : in STD_LOGIC ); 
  END COMPONENT ; 
  
BEGIN
  DUT  : mul_umul  
    GENERIC MAP ( N  => N)
    PORT MAP ( 
      d => d  ,
      a   => a  ,
      b   => b  ,
      c   => c  ,
      en   => en   ) ; 
      
test:process  
 
 variable x:std_logic_vector ( 3 downto 0);
  variable y:std_logic_vector ( 3 downto 0);
 
 begin  
      x:="0000";
      y:="0111";
      c<='0';
      en<='1';
      
      for i in 0 to 6
      loop
            a<=x;
            b<=y;
            x:=std_logic_vector(unsigned(x)+1);
            y:=std_logic_vector(unsigned(y)+1);
        wait for 10 ns;
     end loop; 
 end process;  
END ; 

