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

//  Used in PC
logic[15:0] Data_Calc;
logic[15:0] PCPP;
logic[15:0] PC_Input;

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
assign PCPP = PC + 1;

/*--Define Registers and MUXes.--*/

// Registers
register #(.N(16)) MDR_reg(.*, .Load(LD_MDR), .Din(MDR_Input), .data_out(MDR));
register #(.N(16)) MAR_reg(.*, .Load(LD_MAR), .Din(MAR_Input), .data_out(MAR));
register #(.N(16)) PC_reg(.*, .Load(LD_PC), .Din(PC_Input), .data_out(PC));
register #(.N(16)) IR_reg(.*, .Load(LD_IR), .Din(Data_Bus), .data_out(IR));
register #(.N(12)) LED_reg(.*, .Load(LD_LED), .Din(IR[11:0]), .data_out(LED));

// MUXes
MUX_IO MUX_to_MDR(.*);
MUX_PC MUX_to_PCR(.*);
MUX_Data_Bus MUX_for_BUS(.*);
endmodule