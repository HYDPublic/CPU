
-- ====================================================================
--
--	File Name:		top_lev_alu_tx_rx.vhd
--	Description:alu top level entity 
--					
--
--	Date:			07/04/13
--	Designer:		yuval goldman & tal siton
--
-- ===================================================================


-- libraries decleration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--entity properties

  entity top_lev_alu_tx_rx is 
  port ( 
  board_8_in: in std_logic_vector(7 downto 0); 
  key0:  in std_logic ;
  key1:  in std_logic ;
  key2:  in std_logic ;
  key3:  in std_logic ;
  pin_rx:  in std_logic ;
  clk:  in std_logic ;
  pin_tx:  out std_logic ;
  status_led: out std_logic_vector(5 downto 0);
  sev_seg_1_out: out std_logic_vector(6 downto 0);
  sev_seg_2_out: out std_logic_vector(6 downto 0);
  sev_seg_3_out: out std_logic_vector(6 downto 0);
  sev_seg_4_out: out std_logic_vector(6 downto 0));
  end top_lev_alu_tx_rx ;
  
  architecture top_lev_alu_tx_rx_arch of top_lev_alu_tx_rx is
 
  --compoment declertion
   
  component reg is
  generic (N : integer) ;
  port ( 
  reg_in: in std_logic_vector(N-1 downto 0) :=(others=>'0'); 
  en: in std_logic;
  reg_out: out std_logic_vector(N-1 downto 0) :=(others=>'0')  
  );
  end component ;
  
  component ALU is 
  generic ( N : integer:=4 ) ; 
  port ( 
  input1,input2 : in std_logic_vector(N-1 downto 0); 
  op: in std_logic_vector(3 downto 0) ; 
  clk: in std_logic ; 
  output_hi: out std_logic_vector(N-1 downto 0); 
  output_lo: out std_logic_vector(N-1 downto 0); 
  status: out std_logic_vector(5 downto 0)
  );
  end component ;
  
  component transmiter is 
  port ( 
  IN_HI: in std_logic_vector(7 downto 0) :=(others=>'0') ; 
  IN_LO: in std_logic_vector(7 downto 0) :=(others=>'0') ; 
  enable: in std_logic; 
  baude_rate_clock: in std_logic; 
  pin_tx: out std_logic :='1' );
  end component ;
  
  
  component receiver is 
  port ( 
  pin_rx: in std_logic :='1'; 
  baude_rate_clock: in std_logic; 
  output : out std_logic_vector(15 downto 0) :=(others=>'0') 
   );
  end component ;
  
  
  component conver_logic is 
  port ( 
  receiver_input: in std_logic_vector(15 downto 0) :=(others=>'0') ; 
  out_0: out std_logic_vector(6 downto 0) :=(others=>'0') ; 
  out_1: out std_logic_vector(6 downto 0) :=(others=>'0') ; 
  out_2: out std_logic_vector(6 downto 0) :=(others=>'0') ; 
  out_3: out std_logic_vector(6 downto 0) :=(others=>'0')
   );
  end component ;
  
  
  component br_clock is 
  port ( 
  clk: in std_logic ;
  br_clk : out std_logic
  ); 
  end component;
  
  
  
  --signal declertion
    signal reg_a_to_alu : std_logic_vector (7 downto 0);
    signal reg_b_to_alu : std_logic_vector (7 downto 0);
    signal op_to_alu : std_logic_vector (3 downto 0);
    signal alu_hi_to_trans : std_logic_vector (7 downto 0);  
    signal alu_lo_to_trans : std_logic_vector (7 downto 0);   
    signal rec_to_conv_log : std_logic_vector (15 downto 0);
    signal br_clk_wire : std_logic;





begin
--port mapping to all units

  reg_a: reg
  generic map (N=>8)
  port map (
  reg_in=>board_8_in,
  en=>key0,
  reg_out=>reg_a_to_alu
  );
  
  reg_b: reg
  generic map (N=>8)
  port map (
  reg_in=>board_8_in,
  en=>key2,
  reg_out=>reg_b_to_alu
  );

  reg_op: reg
  generic map (N=>4)
  port map (
  reg_in=>board_8_in(3 downto 0),
  en=>key1,
  reg_out=>op_to_alu
  );


  alu_unit: ALU
  generic map (N=>8)
  port map (
   input1=>reg_a_to_alu,
   input2=>reg_b_to_alu,
   op=>op_to_alu,
   clk=>clk,
   output_hi=>alu_hi_to_trans,
   output_lo=>alu_lo_to_trans,
   status=>status_led
  );
  
  
  trans_unit : transmiter
  port map (
   in_hi=>alu_hi_to_trans,
   in_lo=>alu_lo_to_trans,
   enable=>key3,
   baude_rate_clock=>br_clk_wire ,
   pin_tx=>pin_tx
  );
  
  
  rec_unit : receiver 
  port map (
  pin_rx=>pin_rx,
  baude_rate_clock=>br_clk_wire ,
  output=>rec_to_conv_log
  );
  
  con_log_unit : conver_logic
  port map (
    receiver_input=>rec_to_conv_log,
    out_0=>sev_seg_1_out,
    out_1=>sev_seg_2_out,
    out_2=>sev_seg_3_out,
    out_3=>sev_seg_4_out
  );

  br_clk_unit :br_clock
  port map(
    clk=>clk,
    br_clk=>br_clk_wire
  );



end top_lev_alu_tx_rx_arch;




