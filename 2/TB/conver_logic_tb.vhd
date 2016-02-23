LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
ENTITY conver_logic_tb  IS 
END ; 
 
ARCHITECTURE conver_logic_tb_arch OF conver_logic_tb IS
  SIGNAL out_1   :  std_logic_vector (6 downto 0) := (others => '0')  ; 
  SIGNAL receiver_input   :  std_logic_vector (15 downto 0) := (others => '0')  ; 
  SIGNAL out_2   :  std_logic_vector (6 downto 0) := (others => '0')  ; 
  SIGNAL out_3   :  std_logic_vector (6 downto 0) := (others => '0')  ; 
  SIGNAL out_0   :  std_logic_vector (6 downto 0) := (others => '0')  ; 
  COMPONENT conver_logic  
    PORT ( 
      out_1  : out std_logic_vector (6 downto 0) ; 
      receiver_input  : in std_logic_vector (15 downto 0) ; 
      out_2  : out std_logic_vector (6 downto 0) ; 
      out_3  : out std_logic_vector (6 downto 0) ; 
      out_0  : out std_logic_vector (6 downto 0) ); 
  END COMPONENT ; 
BEGIN
  DUT  : conver_logic  
    PORT MAP ( 
      out_1   => out_1  ,
      receiver_input   => receiver_input  ,
      out_2   => out_2  ,
      out_3   => out_3  ,
      out_0   => out_0   ) ; 
      
      
      receiver_input<="0001000100010001","0001001001001000" after 10 ns;
      
END ; 

