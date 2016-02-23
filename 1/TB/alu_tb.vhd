LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
ENTITY alu_tb  IS 
  GENERIC (
    N  : INTEGER:=4   ); 
END ; 
 
ARCHITECTURE alu_tb_arch OF alu_tb IS
  SIGNAL status   :  std_logic_vector (5 downto 0)  ; 
  SIGNAL output_hi   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL input1   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL input2   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL output_lo   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL op   :  std_logic_vector (3 downto 0)  ; 
  COMPONENT ALU  
    GENERIC ( 
      N  : INTEGER:=4  );  
    PORT ( 
      status  : out std_logic_vector (5 downto 0) ; 
      output_hi  : out std_logic_vector (N - 1 downto 0) ; 
      input1  : in std_logic_vector (N - 1 downto 0) ; 
      input2  : in std_logic_vector (N - 1 downto 0) ; 
      output_lo  : out std_logic_vector (N - 1 downto 0) ; 
      op  : in std_logic_vector (3 downto 0) ); 
  END COMPONENT ; 
BEGIN
  DUT  : ALU  
    GENERIC MAP ( 
      N  => N   )
    PORT MAP ( 
      status   => status  ,
      output_hi   => output_hi  ,
      input1   => input1  ,
      input2   => input2  ,
      output_lo   => output_lo  ,
      op   => op   ) ; 
      
      test:process  
  variable x:std_logic_vector ( 3 downto 0);
 
 begin  
      for j in 0 to 1
     loop
      input1<="0010";--"0010"after 8 ns;
      input2<="1101";
      x:="0001";
      
     for i in 0 to 15
     loop
           op<=x;
           x:=std_logic_vector(unsigned(x)+2);
        wait for 15 ns;
     end loop;
     end loop;
   wait;
   end process; 
END ; 

