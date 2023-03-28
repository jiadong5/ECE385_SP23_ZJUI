module datapath(
    input logic Clk, 
    input logic Reset,
    input logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
    input logic GatePC, GateMDR, GateALU, GateMARMUX,
	input logic DRMUX, SR1MUX, SR2MUX, ADDR1MUX, MIO_EN,
    input logic [15:0] MDR_In,
	input logic [1:0]  ADDR2MUX, ALUK, PCMUX,
    output logic BEN,
    output logic [11:0] LED,
    output logic [15:0] IR,
    output logic [15:0] MAR,
    output logic [15:0] MDR,
    output logic [15:0] PC
);

/*--Define local variables--*/

// used in Data Bus MUX
logic[15:0] Data_ALU;
logic[3:0]  BUS_TICKET;
// used in MEM2IO
logic[15:0] Data_Bus,
            MDR_Input,
            MAR_Input,
            Data_from_CPU, 
            Data_to_CPU;

// used in PC
logic[15:0] Data_Calc;
logic[15:0] PC_next;
logic[15:0] PC_Input;

// used in RegFile
logic[2:0] DR;
logic[2:0] SR1;
logic[2:0] SR2;
logic[2:0] IR_11_9;
logic[2:0] IR_8_6;
logic      LD_R0,
           LD_R1,
           LD_R2,
           LD_R3,
           LD_R4,
           LD_R5,
           LD_R6,
           LD_R7;
logic[15:0] SR1OUT;
logic[15:0] SR2OUT;
logic[15:0] R0_Out;
logic[15:0] R1_Out;
logic[15:0] R2_Out;
logic[15:0] R3_Out;
logic[15:0] R4_Out;
logic[15:0] R5_Out;
logic[15:0] R6_Out;
logic[15:0] R7_Out;

// used in ADDR part.
logic[10:0] IR_10_0;
logic[8:0] IR_8_0;
logic[5:0] IR_5_0;
logic[15:0] IR_10_0_SEXT,
            IR_8_0_SEXT,
            IR_5_0_SEXT,
            ADDR2_to_Adder,
            ADDR1_to_Adder;

// used in NZP part
logic[2:0] NZP_In;
logic[2:0] NZP_Out;
logic BEN_In;

// used in ALU part
logic[4:0] IR_4_0;
logic[15:0] IR_4_0_SEXT;
logic[15:0] ALU_In_B; 

/*--Ckt assignments--*/

// assign variables in Data Bus.
assign BUS_TICKET[3] = GatePC;
assign BUS_TICKET[2] = GateMDR;
assign BUS_TICKET[1] = GateALU;
assign BUS_TICKET[0] = GateMARMUX;

// assign circuits in MEM2IO
assign Data_to_CPU = MDR_In;
assign MAR_Input = Data_Bus;
assign Data_from_CPU = MDR;

// assign circuits in PC
assign PC_next = PC + 1;

// assign REG_FILE part.  
assign IR_11_9 = IR[11:9];
assign IR_8_6 = IR[8:6];
assign IR_4_0 = IR[4:0];
assign SR2 = IR[2:0];

// assign ADDR part
assign IR_10_0 = IR[10:0];
assign IR_8_0 = IR[8:0];
assign IR_5_0 = IR[5:0];
assign Data_Calc = ADDR1_to_Adder + ADDR2_to_Adder;

/*--Define Registers and MUXes.--*/

/*--Registers--*/
register #(.N(16)) MDR_reg(.*, .Load(LD_MDR), .Din(MDR_Input), .data_out(MDR));
register #(.N(16)) MAR_reg(.*, .Load(LD_MAR), .Din(MAR_Input), .data_out(MAR));
register #(.N(16)) PC_reg(.*, .Load(LD_PC), .Din(PC_Input), .data_out(PC));
register #(.N(16)) IR_reg(.*, .Load(LD_IR), .Din(Data_Bus), .data_out(IR));
register #(.N(12)) LED_reg(.*, .Load(LD_LED), .Din(IR[11:0]), .data_out(LED));
// used in REG_FILE:
register #(.N(16)) R0(.*, .Load(LD_R0), .Din(Data_Bus), .data_out(R0_Out));
register #(.N(16)) R1(.*, .Load(LD_R1), .Din(Data_Bus), .data_out(R1_Out));
register #(.N(16)) R2(.*, .Load(LD_R2), .Din(Data_Bus), .data_out(R2_Out));
register #(.N(16)) R3(.*, .Load(LD_R3), .Din(Data_Bus), .data_out(R3_Out));
register #(.N(16)) R4(.*, .Load(LD_R4), .Din(Data_Bus), .data_out(R4_Out));
register #(.N(16)) R5(.*, .Load(LD_R5), .Din(Data_Bus), .data_out(R5_Out));
register #(.N(16)) R6(.*, .Load(LD_R6), .Din(Data_Bus), .data_out(R6_Out));
register #(.N(16)) R7(.*, .Load(LD_R7), .Din(Data_Bus), .data_out(R7_Out));
MUX_RegFile_Read Reg_For_SR1(.*, .SR(SR1), .data_out(SR1OUT));
MUX_RegFile_Read Reg_For_SR2(.*, .SR(SR2), .data_out(SR2OUT));

// used in NZP
register #(.N(3)) NZP_reg(.*, .Load(LD_CC), .Din(NZP_In), .data_out(NZP_Out));
register #(.N(1)) BEN_reg(.*, .Load(LD_BEN), .Din(BEN_In), .data_out(BEN));

/*--MUXes--*/
MUX_IO MUX_to_MDR(.*);
MUX_PC MUX_to_PCR(.*);
MUX_Data_Bus MUX_for_BUS(.*);

// used in RegFile
MUX_SR1 MUX_SR1_Choice(.*);
MUX_For_DR MUX_DR(.*);
MUX_RegFile_Write MUX_DR_Write(.*);

// used in ADDR
MUX_SEXT_10 SEXT10(.*);
MUX_SEXT_5 SEXT5(.*);
MUX_SEXT_8 SEXT8(.*);
MUX_For_ADDR1 MUX_ADDR1(.*);
MUX_For_ADDR2 MUX_ADDR2(.*);

// used in NZP
MUX_For_NZP MUX_NZP(.*);
MUX_For_BEN MUX_BEN(.*);

// used in ALU
MUX_SEXT_4 SEXT4(.*);
MUX_For_SR2 MUX_SR2(.*);
MUX_For_ALU MUX_ALU(.*);

endmodule