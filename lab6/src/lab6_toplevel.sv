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

logic Reset_S_H, Run_S_H, Continue_S_H;

slc3 my_slc(.*, .Reset(Reset_S_H), .Run(Run_S_H), .Continue(Continue_S_H));
// Even though test memory is instantiated here, it will be synthesized into 
// a blank module, and will not interfere with the actual SRAM.
// Test memory is to play the role of physical SRAM in simulation.
test_memory my_test_memory(.Reset(Reset_S_H), .I_O(Data), .A(ADDR), .*);

sync Reset_sync (.Clk(Clk), .d(~Reset), .q(Reset_S_H));
sync Run_sync (.Clk(Clk), .d(~Run), .q(Run_S_H));
sync Continue_sync (.Clk(Clk), .d(~Continue), .q(Continue_S_H));

endmodule