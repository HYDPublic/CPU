LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 

ENTITY abs_tb  IS 
  GENERIC (
    N  : INTEGER :=4  ); 
END ; 

ARCHITECTURE abs_tb_arch OF abs_tb IS
 SIGNAL d   :  std_logic_vector (N - 1 downto 0)  ; 
 SIGNAL a  :  std_logic_vector (N - 1 downto 0)  ; 
 SIGNAL en   :  STD_LOGIC  ; 
  
  COMPONENT ab 
    GENERIC ( N  : INTEGER:=4  );  
    PORT ( 
      d  : out std_logic_vector (N - 1 downto 0) ; 
      a  : in std_logic_vector (N - 1 downto 0) ; 
      en  : in STD_LOGIC ); 
  END COMPONENT ; 
  
BEGIN
  DUT  : ab
    GENERIC MAP ( N  => N)
    PORT MAP ( 
      d => d  ,
      a   => a  ,
      en   => en   ) ; 
      
test:process  
 
 variable x:std_logic_vector ( N-1 downto 0);
 
 begin  
      a<="1011";
      en<='1';
      for i in 0 to 60
      loop
            wait for 10 ns;
            a<=std_logic_vector(unsigned(a)+1);
     end loop; 
  end process;  
END ; 






