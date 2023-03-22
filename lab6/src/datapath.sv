module datapath(
    input logic Clk, 
    input logic Reset,
    input logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED,
    input logic GatePC, GateMDR, GateALU,GateMARMUX,
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

// Circuit flow Assignments
// TODO: To implement LC-3 Circuit Diagram.

// Define Registers and MUXes.



// Week 1 part of the circuit.
// I/O from SRAM part.
Mem2IO      MENM2IO;
tristate    TRISTATE;

endmodule