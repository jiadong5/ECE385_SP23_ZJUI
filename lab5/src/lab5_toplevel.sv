/*
 * Date Created: Tue, Mar 14 2023
 * ECE 385 Lab5 multiplier design
 * Credits belong to Hanggang Zhu and Jiadong Hong
 */

module lab5_toplevel
(
    input logic[7:0] S,
    input logic Clk,
    input logic Reset,
    input logic Run,
    input logic ClearA_LoadB,

    output logic[6:0] AhexU, AhexL, BhexU, BhexL,
    output logic[7:0] Aval, Bval,
    output logic X

);

    // Test the add_sub9 module
    // logic[7:0] A,B;
    // logic fn;
    // logic[8:0] Sum;


    // add_sub9 add_sub9_inst
    // (
    //     .A(A),
    //     .B(B),
    //     .fn(fn),
    //     .S(Sum)
    // );


endmodule