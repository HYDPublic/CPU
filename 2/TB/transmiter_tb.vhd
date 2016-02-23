LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
ENTITY transmiter_tb  IS 
END ; 
 
ARCHITECTURE transmiter_tb_arch OF transmiter_tb IS
  SIGNAL IN_LO   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL PIN_TX   :  STD_LOGIC  ; 
  SIGNAL baude_rate_clock   :  STD_LOGIC  ; 
  SIGNAL enable   :  STD_LOGIC  ; 
  SIGNAL IN_HI   :  std_logic_vector (7 downto 0)  ; 
  SIGNAL clk_wire   :  STD_LOGIC  ;
 SIGNAL tx_rx_wire   :  STD_LOGIC  ;
SIGNAL rx_out_wire   : std_logic_vector (15 downto 0)  ; 
  
  COMPONENT Transmiter  
    PORT ( 
      IN_LO  : in std_logic_vector (7 downto 0) ; 
      PIN_TX  : out STD_LOGIC ; 
      baude_rate_clock  : in STD_LOGIC ; 
      enable  : in STD_LOGIC ; 
      IN_HI  : in std_logic_vector (7 downto 0) ); 
  END COMPONENT ;
  
  COMPONENT clock_muc is 
  port ( 
  clk: out std_logic 
  );  
  END COMPONENT ;

 
  COMPONENT receiver is 
  port ( 
  pin_rx: in std_logic :='1'; 
  baude_rate_clock: in std_logic; 
  output : out std_logic_vector(15 downto 0) :=(others=>'0') 
   );
  END COMPONENT ;




BEGIN
  DUT  : Transmiter  
    PORT MAP ( 
      IN_LO   => IN_LO  ,
      PIN_TX   => tx_rx_wire  ,
      baude_rate_clock   => clk_wire  ,
      enable   => enable  ,
      IN_HI   => IN_HI   ) ; 
      
      DUT1  : clock_muc  
    PORT MAP ( 
    clk=>clk_wire);
    
    DUT2: receiver
     PORT MAP ( 
       pin_rx   => tx_rx_wire  ,
      baude_rate_clock   => clk_wire  ,
      output => rx_out_wire);
       
    
    IN_LO<="00000001";
    IN_HI<="10000000";    
    enable<='0','1' after 12 ns;
    
    
    
END ; 


