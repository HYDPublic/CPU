				-- Top Level Structural Model for MIPS Processor Core
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.std_logic_signed.all;
use IEEE.Numeric_STD.all;

ENTITY MIPS IS

	PORT( reset, clock					: IN 	STD_LOGIC; 
		-- Output important signals to pins for easy display in Simulator
		PC								: INOUT  STD_LOGIC_VECTOR( 9 DOWNTO 0 );
		ALU_result_out, read_data_1_out, read_data_2_out, write_data_out,	
     	Instruction_out,OUTLeds	,SevLCD			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
		Branch_out, Zero_out, Memwrite_out, 
		Regwrite_out					: OUT 	STD_LOGIC ;
		INBot : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 ));
END 	MIPS;


ARCHITECTURE structure OF MIPS IS

COMPONENT PLL
	PORT
	(
		inclk0		: IN STD_LOGIC;
		c0		: OUT STD_LOGIC 
	);
END COMPONENT;



	COMPONENT Ifetch
   	     PORT(	Instruction	: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		PC_plus_4_out 		: OUT  	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
        		Add_result 			: IN 	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
        		Branch 				: IN 	STD_LOGIC;
        		Zero 					: IN 	STD_LOGIC;
				interruptIn     	: IN 	STD_LOGIC;
        		PC_out 				: OUT 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
        		clock,reset 		: IN 	STD_LOGIC );
	END COMPONENT; 

	COMPONENT Idecode
 	     PORT(	read_data_1 		: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		read_data_2 		: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		Instruction 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		read_data 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		ALU_result 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		RegWrite, MemtoReg 	: IN 	STD_LOGIC;
        		--RegDst 				: IN 	STD_LOGIC;
				
				Add_Result 	: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 );--
				Zero 			: OUT	STD_LOGIC;
				PC_plus_4 		: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
				interrupt1    : OUT	STD_LOGIC;
				OUTLed,SevSeg: OUT STD_LOGIC_VECTOR(31 downto 0);
				Bottons : in STD_LOGIC_VECTOR(31 downto 0);
        		Sign_extend 		: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		clock, reset		: IN 	STD_LOGIC; 
			write_register_address_0,write_register_address_1,write_register_address_2		: out STD_LOGIC_VECTOR( 4 DOWNTO 0 );
			write_register_address		: in STD_LOGIC_VECTOR( 4 DOWNTO 0 )
				);
	END COMPONENT;

	COMPONENT control
	     PORT( 	Opcode 				: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
             	RegDst 				: OUT 	STD_LOGIC;
             	ALUSrc 				: OUT 	STD_LOGIC;
             	MemtoReg 			: OUT 	STD_LOGIC;
             	RegWrite 			: OUT 	STD_LOGIC;
             	MemRead 			: OUT 	STD_LOGIC;
             	MemWrite 			: OUT 	STD_LOGIC;
             	Branch 				: OUT 	STD_LOGIC;
             	ALUop 				: OUT 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
             	clock, reset		: IN 	STD_LOGIC );
	END COMPONENT;

	COMPONENT  Execute
   	     PORT(	Read_data_1 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                Read_data_2 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
               	Sign_Extend 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
               	Function_opcode		: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
               	ALUOp 				: IN 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
               	ALUSrc 				: IN 	STD_LOGIC;
               	--Zero 				: OUT	STD_LOGIC;
               	ALU_Result 			: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
						ALU_ResultFor,ALU_ResultForFor 		: IN	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
               	--Add_Result 			: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
               	--PC_plus_4 			: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
               	clock, reset		: IN 	STD_LOGIC ;
						write_register_address_0,write_register_address_1		: in STD_LOGIC_VECTOR( 4 DOWNTO 0 );
						RegDst 				: IN 	STD_LOGIC;
						forward,forward2				: IN STD_LOGIC_VECTOR( 1 DOWNTO 0 );
			write_register_address		: out STD_LOGIC_VECTOR( 4 DOWNTO 0 )
			
						);
	END COMPONENT;
	
	
	
	COMPONENT dmemory
	     PORT(	read_data 			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		address 			: IN 	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
        		write_data 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		MemRead, Memwrite 	: IN 	STD_LOGIC;
        		Clock,reset			: IN 	STD_LOGIC );
	END COMPONENT;

					-- declare signals used to connect VHDL components
	SIGNAL PC_plus_4 		: STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	SIGNAL read_data_1 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_data_2 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Sign_Extend 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Add_result_signal,Add_result_signalLD,Add_resultLD 		: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	SIGNAL write_register_address_1		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL write_register_address_0,write_register_address_2,write_register_address		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL ALU_result,ALU_result1 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL OUTLed,SevSeg,Bottons		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_data 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL ALUSrc 			: STD_LOGIC;
	SIGNAL interuptCO 			: STD_LOGIC;
	SIGNAL forward1,forward2 		: STD_LOGIC_VECTOR(1 downto 0);
	SIGNAL Branch,Branch1,BranchLD: STD_LOGIC;
	SIGNAL RegDst,isFlush 			: STD_LOGIC;
	SIGNAL Zero_signal,ZeroLD	: STD_LOGIC;
	SIGNAL MemWrite 		: STD_LOGIC;
	SIGNAL MemtoReg 		: STD_LOGIC;
	SIGNAL Regwrite,fasterClock,isLD	: STD_LOGIC;
	SIGNAL MemRead 			: STD_LOGIC;
	SIGNAL ALUop 			: STD_LOGIC_VECTOR(  1 DOWNTO 0 );
	SIGNAL Instruction		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	
	
	-----------------REG IF/ID--------------
	SIGNAL IFIDInstruction,IFIDInstruction1,IFIDInstructionLD		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL tempo,tempi 		: STD_LOGIC_VECTOR(7 DOWNTO 0 );
	-----------------REG ID/EX-----------------
	SIGNAL IDEXread_data_1 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL IDEXread_data_2 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL IDEXSign_Extend,IDEXInstruction 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL IDEXALUOP 		: STD_LOGIC_VECTOR( 1 DOWNTO 0 );
	SIGNAL IDEXALUsrc		: STD_LOGIC;
	Signal IDEXisLD:boolean; 
	SIGNAL IDEXMEMread		: STD_LOGIC;
	SIGNAL IDEXMEMwrite		: STD_LOGIC;
	SIGNAL IDEXbranch		: STD_LOGIC;
	SIGNAL IDEXisFlush,isLW		: STD_LOGIC;
	SIGNAL IDEXRegDst 		: STD_LOGIC;
	SIGNAL IDEXwrite_register_address_0,IDEXwrite_register_address_2		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL IDEXwrite_register_address_1		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL IDEXMemtoReg 		: STD_LOGIC;
	SIGNAL IDEXRegwrite 		: STD_LOGIC;
	----------------REG EXMEM--------------------------------
	SIGNAL EXMEMread_data_2 	: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL EXMEMALU_result 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL EXMEMMEMwrite		: STD_LOGIC;
	SIGNAL EXMEMMEMread		: STD_LOGIC;
	SIGNAL EXMEMRegDst 		: STD_LOGIC;
	SIGNAL EXMEMwrite_register_address		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL EXMEMMemtoReg 		: STD_LOGIC;
	SIGNAL EXMEMRegwrite 		: STD_LOGIC;
	-----------------REG MEMWB---------------------
	SIGNAL MEMWBALU_result 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL MEMWBwrite_register_address		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL MEMWBread_data 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL MEMWBwritedata		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL MEMWBMemtoReg 		: STD_LOGIC;
	SIGNAL MEMWBRegwrite 		: STD_LOGIC;
	---------------------------------------

BEGIN
					-- copy important signals to output pins for easy 
					-- display in Simulator
   --Instruction_out 	<= Instruction;
   --ALU_result_out 	<= ALU_result;
   --read_data_1_out 	<= read_data_1;
	OUTLeds <=OUTLed;
	SevLCD<=SevSeg;
	Bottons<=INBot;
   --write_data_out  	<= read_data WHEN MemtoReg = '1' ELSE ALU_result;
  -- Branch_out 		<= Branch;
  -- Zero_out 		<= Zero_signal;
  -- RegWrite_out 	<= RegWrite;
  -- MemWrite_out 	<= MemWrite;	


----------------------forwarding UNIT-----------------------------------
forward1<="11" WHEN (EXMEMwrite_register_address=IDEXwrite_register_address_0 AND EXMEMwrite_register_address= IDEXwrite_register_address_2 AND EXMEMwrite_register_address/="00000") ELSE
			"10" WHEN (EXMEMwrite_register_address=IDEXwrite_register_address_0 AND EXMEMwrite_register_address/="00000") ELSE
			 "01" WHEN (EXMEMwrite_register_address= IDEXwrite_register_address_2 AND EXMEMwrite_register_address/="00000") ELSE 
			"00";
			
forward2<="11" WHEN (MEMWBwrite_register_address=IDEXwrite_register_address_0 AND MEMWBwrite_register_address= IDEXwrite_register_address_2 AND MEMWBwrite_register_address/="00000") ELSE
			"10" WHEN (MEMWBwrite_register_address=IDEXwrite_register_address_0 AND MEMWBwrite_register_address/="00000") ELSE
			 "01" WHEN (MEMWBwrite_register_address= IDEXwrite_register_address_2 AND MEMWBwrite_register_address/="00000") ELSE 
			"00";
------------------------------------------------------------------	

			
-------------------------------- connect the 5 MIPS components and PLL -------------------------------------	
PLL1 : PLL port map (clock,fasterClock); --clock multiplication


				
				
  IFE : Ifetch
	PORT MAP (	Instruction 	=> Instruction,
    	    	PC_plus_4_out 	=> PC_plus_4,
				Add_result 		=> Add_result_signalLD,
				Branch 			=> BranchLD,
				Zero 			=> ZeroLD,
				PC_out 			=> PC,        
				interruptIn	  =>	interuptCO,	
				--clock 			=> clock,
				clock=>fasterClock,
				reset 			=> reset );
				
				
   ID : Idecode
   	PORT MAP (read_data_1 => read_data_1,
        		read_data_2 	=> read_data_2,
        		Instruction 	=> IFIDInstruction1,
        		read_data 		=> read_data,
				ALU_result 		=> MEMWBALU_result,
				RegWrite 		=> MEMWBRegWrite,
				MemtoReg 		=> MEMWBMemtoReg,
				OUTLed 			=> OUTLed,
				SevSeg			=>SevSeg,
				Bottons			=>Bottons,
				interrupt1     =>interuptCO,
				zero				=>Zero_signal,
				Add_Result 		=>Add_result_signal,
				--PC_plus_4 		=>PC,
				PC_plus_4 		=>PC_plus_4,
				Sign_extend 	=> Sign_Extend,
        		--clock 			=> clock, 
			clock=>fasterClock,	
				reset 			=> reset,
				write_register_address_0 => write_register_address_0 ,
				write_register_address_1=>write_register_address_1,
				write_register_address_2=>write_register_address_2,
				write_register_address=>MEMWBwrite_register_address
		);


   CTL:   control
	PORT MAP ( 	Opcode 			=> IFIDInstruction1( 31 DOWNTO 26 ),
				RegDst 			=> RegDst,
				ALUSrc 			=> ALUSrc,
				MemtoReg 		=> MemtoReg,
				RegWrite 		=> RegWrite,
				MemRead 		=> MemRead,
				MemWrite 		=> MemWrite,
				Branch 			=> Branch,
				ALUop 			=> ALUop,
             --   clock 			=> clock,
				 clock=>fasterClock,
				reset 			=> reset );

   EXE:  Execute
   	PORT MAP (	Read_data_1 	=> IDEXread_data_1,
            Read_data_2 	=> IDEXread_data_2,
				Sign_extend 	=> IDEXSign_extend,
            Function_opcode=> IDEXInstruction( 5 DOWNTO 0 ),
				ALUOp 			=> IDEXALUOP,
				ALUSrc 			=> IDEXALUsrc,
				--Zero 				=>	Zero,
            ALU_Result		=> ALU_Result,
				ALU_ResultFor =>EXMEMALU_Result,
				ALU_ResultForFor=>MEMWBALU_result,
				--Add_Result 		=> Add_result,
				--PC_plus_4		=> IDEXPC_plus_4,
           -- Clock			=> clock,
			 clock=>fasterClock,
				Reset			=> reset,
				RegDst 			=> IDEXRegDst,
			write_register_address_0 =>IDEXwrite_register_address_0,
			write_register_address_1 =>IDEXwrite_register_address_1,		
			write_register_address	=>	write_register_address,
			forward=>forward1,
			forward2=>forward2
		
		);	
				
   MEM:  dmemory
	PORT MAP (	read_data 		=> MEMWBread_data,
				address 		=> EXMEMALU_Result (7 DOWNTO 0),--jump memory address by 4
				write_data 		=> EXMEMread_data_2,
				MemRead 		=> EXMEMMEMread, 
				Memwrite 		=> EXMEMMEMwrite, 
              -- clock 			=> clock,  
				 clock=>fasterClock,
				reset 			=> reset );
		
		
		--------------BRANCH calculations---------------------------------------	
	isFlush<=NOT(Zero_signal AND Branch);
	IFIDInstruction1<=x"20000000" WHEN IDEXisFlush='0' OR(IDEXisLD)
	ELSE IFIDInstruction;
	-----------------------------LW calculation-------------------------
	ZeroLD<='1' WHEN (IFIDInstruction(31 downto 26)="100011" AND ((IFIDInstruction(20 downto 16)=Instruction(20 downto 16)) OR IFIDInstruction(20 downto 16)=Instruction(15 downto 11) ) AND Instruction(31 downto 26)/="00100") 
					ELSE Zero_signal;
	BranchLD<='1' WHEN (IFIDInstruction(31 downto 26)="100011" AND ((IFIDInstruction(20 downto 16)=Instruction(20 downto 16)) OR IFIDInstruction(20 downto 16)=Instruction(15 downto 11) ) AND Instruction(31 downto 26)/="00100")
					ELSE Branch ;
		
	Add_result_signalLD<=PC_plus_4( 9 DOWNTO 2 ) +255	 WHEN (IFIDInstruction(31 downto 26)="100011" AND ((IFIDInstruction(20 downto 16)=Instruction(20 downto 16)) OR IFIDInstruction(20 downto 16)=Instruction(15 downto 11) ) AND Instruction(31 downto 26)/="00100")
											ELSE Add_result_signal;
	-------------------------------------------------------------------------
		
		process(fasterClock)
		variable temp1:integer;
		BEGIN
		if (rising_edge(fasterClock)) then	
		----------IFID---------------------
		IFIDInstruction<=Instruction;
		--------IDEX---------
		IDEXisLD<=(IFIDInstruction(31 downto 26)="100011" AND ((IFIDInstruction(20 downto 16)=Instruction(20 downto 16)) OR IFIDInstruction(20 downto 16)=Instruction(15 downto 11) ) AND Instruction(31 downto 26)/="00100");
		IDEXread_data_1<=read_data_1;
		IDEXread_data_2<=read_data_2;
		IDEXSign_Extend<=Sign_extend;
		IDEXALUOP<=ALUop;
		IDEXALUsrc<=ALUSrc;
		IDEXwrite_register_address_0<=write_register_address_0; --Rt
		IDEXwrite_register_address_1<=write_register_address_1;--Rd
		IDEXwrite_register_address_2<=write_register_address_2;--Rs
		IDEXRegDst<=RegDst;
	   IDEXMEMread	<=	MemRead;
		IDEXMEMwrite	<=	MemWrite;
		IDEXbranch	<=Branch;
		IDEXMemtoReg 	<=MemtoReg ;
	   IDEXRegwrite <=Regwrite ;	
	IDEXisFlush<=isFlush;
IDEXInstruction<=IFIDInstruction1;	
		-------------EXMEM-------------------
		EXMEMMEMread <=IDEXMEMread	;
		EXMEMMEMwrite<=IDEXMEMwrite;
		EXMEMread_data_2<=IDEXread_data_2;
		EXMEMALU_Result<=ALU_Result;
		EXMEMwrite_register_address<=write_register_address;
		EXMEMMemtoReg <=IDEXMemtoReg ;
	  EXMEMRegwrite <=IDEXRegwrite  ;	
		------------MEMWB----------------
		MEMWBwrite_register_address<=EXMEMwrite_register_address;
		MEMWBALU_result<=EXMEMALU_Result;
		read_data<=MEMWBread_data;
		MEMWBMemtoReg<= EXMEMMemtoReg;
		MEMWBRegwrite<= EXMEMRegwrite;
		-----------------------------
		end if;
		end process;		
END structure;

