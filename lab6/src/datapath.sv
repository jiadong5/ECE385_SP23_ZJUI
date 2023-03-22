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

// used in MEM2IO
logic[15:0] Data_Bus,
            MDR_Input,
            MAR_Input,
            Data_from_CPU, 
            Data_to_CPU;

//  Used in PC
logic[15:0] Data_Calc;
logic[15:0] PCPP;
logic[15:0] PC_Input;

/*--Ckt assignments--*/

// assign circuits in MEM2IO
assign Data_to_CPU = MDR_In
assign Data_Bus = MDR;
assign MAR_Input = Data_Bus;
assign Data_from_CPU = MDR;

// assign circuits in PC
assign Data_Bus = PC;
assign PCPP = PC + 1;
assign Data_Bus = Data_Calc;

/*--Define Registers and MUXes.--*/

// Registers
register #(.N(16)) MDR_reg(.*, .load(LD_MDR), .Data_In(MDR_Input), .Data_Out(MDR));
register #(.N(16)) MAR_reg(.*, .load(LD_MAR), .Data_In(MAR_Input), .Data_Out(MAR));
register #(.N(16)) PC_reg(.*, .load(LD_PC), .Data_In(PC_Input), .Data_Out(PC));

// MUXes
MUX_IO MUX_to_MDR(.*);
MUX_PC MUX_to_PCR(.*);

endmodule