//-------------------------------------------------------------------------
//      lab6_toplevel.sv                                                 --
//                                                                       --
//      Created 10-19-2017 by Po-Han Huang                               --
//                        Spring 2018 Distribution                       --
//                                                                       --
//      For use with ECE 385 Experment 6                                 --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------
`include "SLC3_2.sv"
import SLC3_2::*;
module lab6_toplevel( input logic [15:0] S,
                      input logic Clk, Reset, Run, Continue,
                      output logic [11:0] LED,
                      output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
                      output logic CE, UB, LB, OE, WE,
                      output logic [19:0] ADDR,
                      inout wire [15:0] Data);

slc3 my_slc(.*);
// Even though test memory is instantiated here, it will be synthesized into 
// a blank module, and will not interfere with the actual SRAM.
// Test memory is to play the role of physical SRAM in simulation.
test_memory my_test_memory(.Reset(~Reset), .I_O(Data), .A(ADDR), .*);

// define the local controls
// Gate Control: 
logic       GateALU;
logic       GateMDR;
logic       GateMARMUX;
logic       GatePC;
// Load Control:
logic       LD_BEN;
logic       LD_CC;
logic       LD_IR;
logic       LD_MAR;
logic       LD_MDR;
logic       LD_REG;
logic       LD_PC;
logic       LD_LED;
// Mux control
logic       MIO_EN
logic[3:0]  Opcode;
logic       IR_5;
logic       IR_11;
logic       BEN;
logic[1:0]  PCMUX;
logic       DRMUX,
			SR1MUX,
			SR2MUX,
			ADDR1MUX;
logic[1:0]  ADDR2MUX,
			ALUK;
logic       Mem_CE,
			Mem_UB,
			Mem_LB,
			Mem_OE,
			Mem_WE;

// Circuit flow Assignments
// TODO: To implement LC-3 Circuit Diagram.

// Module control execution:
// File: ISDU.sv 
// The Finite State Machine Part


endmodule