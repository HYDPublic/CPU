LIBRARY ieee  ; 
USE ieee.std_logic_1164.all  ; 
ENTITY clock_muc_tb  IS 
END ; 
 
ARCHITECTURE clock_muc_tb_arch OF clock_muc_tb IS
  SIGNAL clk   :  STD_LOGIC  ; 
  COMPONENT clock_muc  
    PORT ( 
      clk  : out STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : clock_muc  
    PORT MAP ( 
      clk   => clk   ) ; 
END ; 

