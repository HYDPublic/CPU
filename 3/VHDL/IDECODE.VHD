						--  Idecode module (implements the register file for
LIBRARY IEEE; 			-- the MIPS computer)
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Idecode IS
	  PORT(	read_data_1	: INOUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			read_data_2	: INOUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Instruction : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			read_data 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			ALU_result	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			RegWrite 	: IN 	STD_LOGIC;
			MemtoReg 	: IN 	STD_LOGIC;
			Sign_extend : INOUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			
			Add_Result 	: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 );--
			Zero 			: OUT	STD_LOGIC;
			interrupt1 	: OUT 	STD_LOGIC;
			PC_plus_4 		: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
			
			OUTLed,SevSeg: OUT STD_LOGIC_VECTOR(31 downto 0);
			Bottons : in STD_LOGIC_VECTOR(31 downto 0);
			clock,reset	: IN 	STD_LOGIC ;
			write_register_address_0,write_register_address_1,write_register_address_2	: out STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			write_register_address		: in STD_LOGIC_VECTOR( 4 DOWNTO 0 )
			);
END Idecode;



ARCHITECTURE behavior OF Idecode IS

Component rand
port (
clk : in std_logic;
random_num : out std_logic_vector (7 downto 0) --output vector 
);
end Component;

COMPONENT TIMER is
port(
		
		hex0 :out std_logic_vector(0 to 6);
		hex1 :out std_logic_vector(0 to 6);
		hex2 :out std_logic_vector(0 to 6);
		hex3 :out std_logic_vector(0 to 6);
		--SW: in std_logic_vector(0 to 9);
		key: in std_logic_vector(0 to 3);
    	counter2 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
		 interrupt : out std_logic;
		clock_50 : std_logic
		);
			END COMPONENT; 
			
component seven_segment_encoder 
	port (
				
		clk			: in	std_logic;
		en			: in	std_logic;
		rst			: in	std_logic;
		number	 	: in 	std_logic_vector (15 downto 0);
		digit_lsb	: out	std_logic_vector (6 downto 0);
		digit_msb	: out	std_logic_vector (6 downto 0);
		digit_msb1	: out	std_logic_vector (6 downto 0);
		digit_msb2	: out	std_logic_vector (6 downto 0)
	);
end Component;


				
TYPE register_file IS ARRAY ( 0 TO 31 ) OF STD_LOGIC_VECTOR( 31 DOWNTO 0 );

	SIGNAL register_array				: register_file;
	SIGNAL temp 		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL LCD1,LCD2,LCD3,LCD4 		: STD_LOGIC_VECTOR( 6 DOWNTO 0 );
	SIGNAL write_data,count					: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_register_1_address		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL read_register_2_address		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL write_register_address1 		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL Branch_Add 			: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	SIGNAL read_data_1_in	:  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_data_2_in	:  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Sign_extend_in :  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Instruction_immediate_value,LCDsignal	: STD_LOGIC_VECTOR( 15 DOWNTO 0 );
	SIGNAL InBot		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL counter  :  	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	signal intrp : std_logic ;	

BEGIN
	read_register_1_address 	<= Instruction( 25 DOWNTO 21 );
   	read_register_2_address 	<= Instruction( 20 DOWNTO 16 );
   	write_register_address_1	<= Instruction( 15 DOWNTO 11 );
   	write_register_address_0 	<= Instruction( 20 DOWNTO 16 );
		write_register_address_2   <=Instruction( 25 DOWNTO 21 );
   	Instruction_immediate_value <= Instruction( 15 DOWNTO 0 );
		
					-- Read Register 1 Operation
	read_data_1 <=ALU_result WHEN (read_register_1_address=write_register_address AND write_register_address/="00000" AND RegWrite = '1') ELSE register_array(CONV_INTEGER( read_register_1_address ) );
					-- Read Register 2 Operation		 
	read_data_2 <=ALU_result WHEN	(read_register_2_address=write_register_address AND write_register_address/="00000" AND RegWrite = '1') ELSE 
	register_array(CONV_INTEGER( read_register_2_address ) ) ;
					-- Mux for Register Write Address
------------------------------------------------------------------------------------
			zero<='1' WHEN (read_data_1=read_data_2)	ELSE '0';	
		--	Branch_Add	<= PC_plus_4( 9 DOWNTO 2 ) +  Sign_extend( 7 DOWNTO 0 )-1;
	--	Add_result 	<= Branch_Add( 7 DOWNTO 0 );
			
			
		------------------------------------------------------------------------------------
	--OUTLed<= register_array( 11 );--connecting Leds to Register
	--LCD: seven_segment_encoder port map (clock,intrp,'0',register_array( 8 )(15 downto 0),LCD1,LCD2,LCD3,LCD4);
	SevSeg(6 downto 0)<=LCD1;
	SevSeg(13 downto 7)<=LCD2;
   SevSeg(20 downto 14)<=LCD3;
   SevSeg(27 downto 21)<=LCD4;
	SevSeg(31 downto 28)<="0000";
	
	TMR : TIMER
	PORT MAP (	
				hex0 	=> LCD1,
    	    	hex1 	=>  LCD2,
				hex2 		=>  LCD3,
				hex3 	=>  LCD4,
				key 			=>Bottons(3 downto 0),
				interrupt => intrp,
				counter2 =>register_array( 14 )(31 downto 0),
				clock_50 => clock );
	
	InBot(0)<=not(Bottons(0));
	InBot(1)<=not(Bottons(0));
	InBot(2)<=not(Bottons(1));
	InBot(3)<=not(Bottons(1));
	InBot(4)<=not(Bottons(2));
	InBot(5)<=not(Bottons(2));
	InBot(6)<=not(Bottons(3));
	InBot(7)<=not(Bottons(3));
	

		--------------------------------------------------------
					-- Mux to bypass data memory for Rformat instructions
	write_data <= ALU_result( 31 DOWNTO 0 ) 
			WHEN ( MemtoReg = '0' ) 	ELSE read_data;
		
					-- Sign Extend 16-bits to 32-bits
    	Sign_extend <= X"0000" & Instruction_immediate_value
		WHEN Instruction_immediate_value(15) = '0'
		ELSE	X"FFFF" & Instruction_immediate_value;

PROCESS
	BEGIN
		WAIT UNTIL clock'EVENT AND clock = '1';
	
		IF reset = '1' THEN
					-- Initial register values on reset are register = reg#
					-- use loop to automatically generate reset logic 
					-- for all registers
			FOR i IN 0 TO 31 LOOP
				register_array(i) <= CONV_STD_LOGIC_VECTOR( i, 32 );
 			END LOOP;
					-- Write back to register - don't write to register 0
  		ELSIF (RegWrite = '1' AND write_register_address /= 0) THEN
		      register_array( CONV_INTEGER( write_register_address)) <= write_data;
		
			
		END IF;
	END PROCESS;
END behavior;


