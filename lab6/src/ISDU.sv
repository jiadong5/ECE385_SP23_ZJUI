//------------------------------------------------------------------------------
// Company:          UIUC ECE Dept.
// Engineer:         Stephen Kempf
//
// Create Date:    17:44:03 10/08/06
// Design Name:    ECE 385 Lab 6 Given Code - Incomplete ISDU
// Module Name:    ISDU - Behavioral
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 02-13-2017
//    Spring 2017 Distribution
//------------------------------------------------------------------------------


module ISDU (   input logic         Clk, 
									Reset,
									Run,
									Continue,
									
				input logic[3:0]    Opcode, 
				input logic         IR_5,
				input logic         IR_11,
				input logic         BEN,
				  
				output logic        LD_MAR,
									LD_MDR,
									LD_IR,
									LD_BEN,
									LD_CC,
									LD_REG,
									LD_PC,
									LD_LED, // for PAUSE instruction
									
				output logic        GatePC,
									GateMDR,
									GateALU,
									GateMARMUX,
									
				output logic [1:0]  PCMUX,
				output logic        DRMUX,
									SR1MUX,
									SR2MUX,
									ADDR1MUX,
				output logic [1:0]  ADDR2MUX,
									ALUK,
				  
				output logic        Mem_CE,
									Mem_UB,
									Mem_LB,
									Mem_OE,
									Mem_WE
				);

	enum logic [4:0] {  Halted, 
						PauseIR1, 
						PauseIR2, 
						S_18, 		// Start state
						S_33_1, 	// MDR <= M
						S_33_2, 	// MDR <- M
						S_33_3,		// State 3 for sync
						S_35, 		// IR <- MDR
						S_32, 		// BEN <- nzp & IR[11:9]
						S_01,		// ADD
						S_05,		// AND
						S_09,		// NOT
						S_00, 		// BR1:
						S_22,		// BR2: PC <- PC + off9
						S_12,		// JMP: PC <- BaseR
						S_04,		// JSR1: R7 <- PC
						S_21,		// JSR2.1: PC <- PC + off11
						S_20,		// JSR2.2: PC <- BaseR, not used
						S_06,		// LDR1: MAR <- BaseR + off6
						S_25_1,		// LDR2.1: MDR <- M[MAR]
						S_25_2,		// LDR2.2: MDR <- M[MAR]
						S_25_3, 	// State 3 for sync
						S_27,		// LDR3: DR <- MDR
						S_07,		// STR1: MAR <- BaseR + off6
						S_23,		// STR2: MDR <- SR
						S_16_1,		// STR3.1: M[MAR] <- MDR
						S_16_2		// STR3.2: M[MAR] <- MDR
						}   State, Next_state;   // Internal state logic
		
	always_ff @ (posedge Clk)
	begin
		if (Reset) 
			State <= Halted;
		else 
			State <= Next_state;
	end
   
	always_comb
	begin 
		// Default next state is staying at current state
		Next_state = State;
		
		// Default controls signal values
		LD_MAR = 1'b0;
		LD_MDR = 1'b0;
		LD_IR = 1'b0;
		LD_BEN = 1'b0;
		LD_CC = 1'b0;
		LD_REG = 1'b0;
		LD_PC = 1'b0;
		LD_LED = 1'b0;
		 
		GatePC = 1'b0;
		GateMDR = 1'b0;
		GateALU = 1'b0;
		GateMARMUX = 1'b0;
		 
		ALUK = 2'b00;
		 
		PCMUX = 2'b00;
		DRMUX = 1'b0;
		SR1MUX = 1'b0;
		SR2MUX = 1'b0;
		ADDR1MUX = 1'b0;
		ADDR2MUX = 2'b00;
		 
		Mem_OE = 1'b1;
		Mem_WE = 1'b1;
	
		// Assign next state
		unique case (State)
			Halted : 
				if (Run) 
					Next_state = S_18;                      
			S_18 : 
				Next_state = S_33_1;
			// Any states involving SRAM require more than one clock cycles.
			// The exact number will be discussed in lecture.
			S_33_1 : 
				Next_state = S_33_2;
			S_33_2 : 
				// Next_state = S_35;
				Next_state = S_33_3;
			S_33_3 :
				Next_state = S_35;
			S_35 : 
				Next_state = S_32;
			// the values in IR.
			PauseIR1 : 
				if (~Continue) 
					Next_state = PauseIR1;
				else 
					Next_state = PauseIR2;
			PauseIR2 : 
				if (Continue) 
					Next_state = PauseIR2;
				else 
					Next_state = S_18;
			S_32 : 
				case (Opcode)
					4'b0001 : 
						Next_state = S_01; // ADD
					4'b0101 :
						Next_state = S_05; // AND
					4'b1001 :
						Next_state = S_09; // NOT
					4'b0000 :
						Next_state = S_00; // BR
					4'b1100 :
						Next_state = S_12; // JMP
					4'b0100 :
						Next_state = S_04; // JSR
					4'b0110 :
						Next_state = S_06; // LDR
					4'b0111 :
						Next_state = S_07; // STR
					4'b1101 :
						Next_state = PauseIR1; // Pause
					default : 
						Next_state = S_18;
				endcase
			S_01 : // ADD
				Next_state = S_18; 
			S_05 : // AND
				Next_state = S_18;
			S_09 : // NOT
				Next_state = S_18;
			S_00 : // BR1
				if (BEN)
					Next_state = S_22;
				else
					Next_state = S_18;
			S_22 : // BR2
				Next_state = S_18;		
			S_12 : // JMP
				Next_state = S_18;
			S_04 : // JSR1
				if (IR_11)
					Next_state = S_21;
				else
					Next_state = S_20; // won't happen
			S_21 : // JSR2.1
				Next_state = S_18;
			S_20 : // JSR2.2
				Next_state = S_18;
			S_06 : // LDR1
				Next_state = S_25_1;
			S_25_1: // LDR2.1
				Next_state = S_25_2;
			S_25_2: // LDR2.2
				// Next_state = S_27;
				Next_state = S_25_3;
			S_25_3:
				Next_state = S_27;
			S_27: // LDR3
				Next_state = S_18;
			S_07: // STR1
				Next_state = S_23;
			S_23: // STR2
				Next_state = S_16_1;
			S_16_1: // STR3.1
				Next_state = S_16_2;
			S_16_2: // STR3.2
				Next_state = S_18;
			default : ;

		endcase
		
		// Assign control signals based on current state
		case (State)
			Halted: ;
			S_18 : 
				begin 
					GatePC = 1'b1;
					LD_MAR = 1'b1;
					PCMUX = 2'b00;	 // PC <- PC + 1
					LD_PC = 1'b1;
					// Mem_OE = 1'b0;	 // For 3 states read
				end
			S_33_1 : 
				Mem_OE = 1'b0;
			S_33_2 : 
				begin 
					Mem_OE = 1'b0;
					// LD_MDR = 1'b1;
				end
			S_33_3 :
				begin
					Mem_OE = 1'b0;
					LD_MDR = 1'b1;
				end
			S_35 : 
				begin 
					GateMDR = 1'b1;
					LD_IR = 1'b1;
				end
			PauseIR1:
				begin
					LD_LED = 1'b1;
				end 
			PauseIR2:
				begin
					LD_LED = 1'b1;
				end

			S_32 : 
				LD_BEN = 1'b1;
			S_01 :  // ADD: DR <- SR1 + OP2
				begin 
					SR2MUX = IR_5;	// ADD or ADDi
					DRMUX = 1'b1; 	// DR<- IR[11:9]
					SR1MUX = 1'b1; 	// SR1 <= IR[8:6]
					ALUK = 2'b00;
					GateALU = 1'b1;
					LD_REG = 1'b1;
                    LD_CC = 1'b1;
				end
			
			S_05 : // AND: DR <- SR1 & OP2
				begin
					SR2MUX = IR_5;	// AND or ANDi
					DRMUX = 1'b1; 	// DR<- IR[11:9]
					SR1MUX = 1'b1; 	// SR1 <= IR[8:6]
					ALUK = 2'b01;
					GateALU = 1'b1;
					LD_REG = 1'b1;
					LD_CC = 1'b1;
				end

			S_09 : // NOT: DR <- NOT(SR)
				begin
					DRMUX = 1'b1; 	// DR <- IR[11:9]
					SR1MUX = 1'b1; 	// SR1 <- IR[8:6]
					ALUK = 2'b10;
					GateALU = 1'b1;
					LD_REG = 1'b1;
					LD_CC = 1'b1;
				end
				
			S_00 : // BR1: Evaluate BEN
					;
			S_22 : // BR2: PC <- PC + off9	
				begin
					ADDR1MUX = 1'b1; 	// PC
					ADDR2MUX = 2'b01;	// SEXT 9
					PCMUX = 2'b10;		// From Calc
					LD_PC = 1'b1;
				end
			
			S_12 : // JMP: PC <- BaseR
				begin
					SR1MUX = 1'b1;		// BaseR <- IR[8:6]
					ADDR1MUX = 1'b0;	// BaseR
					ADDR2MUX = 2'b11;	// 0
					PCMUX = 2'b10;		// From Calc
					LD_PC = 1'b1;
				end
			
			S_04 : // JSR1: R7 <- PC
				begin
					DRMUX = 1'b0;		// 111(R7)
					GatePC = 1'b1;
					LD_REG = 1'b1;
				end
			
			S_21 : // JSR2.1: PC <- PC + off11
				begin
					ADDR1MUX = 1'b1;	// PC
					ADDR2MUX = 2'b00; 	// SEXT 11
					PCMUX = 2'b10;		// From Calc
					LD_PC = 1'b1;
				end
			
			S_20 : // JSR2.2: PC <- BaseR, not used
					;
			
			S_06 : // LDR1: MAR <- BaseR + off6
				begin
					SR1MUX = 1'b1;		// BaseR <- IR[8:6]
					ADDR1MUX = 1'b0;	// BaseR
					ADDR2MUX = 2'b10;	// SEXT 6
					GateMARMUX = 1'b1;
					LD_MAR = 1'b1;
					// Mem_OE = 1'b0;
				end
			S_25_1: // LDR2.1: MDR <- M[MAR]
				begin
					Mem_OE = 1'b0;
				end
			S_25_2: // LDR2.2: MDR <= M[MAR]
				begin
					Mem_OE = 1'b0;
					// LD_MDR = 1'b1;
				end
			S_25_3:
				begin
					Mem_OE = 1'b0;
					LD_MDR = 1'b1;
				end
			S_27 : // LDR3: DR <- MDR
				begin
					DRMUX = 1'b1;	// DR <- IR[11:9]
					GateMDR = 1'b1;
					LD_REG = 1'b1;
					LD_CC = 1'b1;
				end
			
			S_07 : // STR1: MAR <- BaseR + off6
				begin
					SR1MUX = 1'b1;		// BaseR <- IR[8:6]
					ADDR1MUX = 1'b0;	// BaseR
					ADDR2MUX = 2'b10;	// SEXT 6
					GateMARMUX = 1'b1;
					LD_MAR = 1'b1;
				end
			S_23 : // STR2: MDR <- SR
				begin
					SR1MUX = 1'b0; 		// SR <- IR[11:9]
					ADDR1MUX = 1'b0;	// SR
					ADDR2MUX = 2'b11;	// 0
					GateMARMUX = 1'b1;
					LD_MDR = 1'b1;
				end
			S_16_1: // M[MAR] <- MDR
					// TODO, write may need 3 cycles?
				begin
					Mem_WE = 1'b0;
				end
			S_16_2:	// M[MAR] <- MDR
				begin
					Mem_WE = 1'b0;
				end

			default : ;
		endcase
	end 

	 // These should always be active
	assign Mem_CE = 1'b0;
	assign Mem_UB = 1'b0;
	assign Mem_LB = 1'b0;
	
endmodule
