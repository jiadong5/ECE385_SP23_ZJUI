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
    
    // local logic variables go here
    logic       AShift_In, 
                BShift_In,
                Ld_A, 
                Ld_B,
                Ld_X, 
                D_X, 
                Shift_En,
                AShift_Out, 
                BShift_out,
                ClearA,
                Reset_A;
    logic[7:0]  A;
    logic[7:0]  newA;
    logic[7:0]  newB;

    // local vars used for control unit
    logic       M;
    logic       Clr_LD;
    logic       Shift;
    logic       Add;
    logic       Sub;
    // local vars used for add_sub9.
    logic       fn;
    logic[8:0] Sum;
    
    // Assign values of settings
    assign  Aval = newA;
    assign  Bval = newB;
    assign  Ld_A = Add^Sub;
    assign  Ld_X = Ld_A;
    assign  fn = Sub;
    assign  BShift_In = AShift_Out;
    assign  AShift_In = X;
    assign  D_X = Sum[8];
    assign  Reset_A = (Ld_B) | ~Reset | ClearA;
    assign A = Sum[7:0];
    
    // Initialize the register units
    reg_8   reg_A(
        .Clk(Clk),
        .Reset(Reset_A),
        .Shift_In(AShift_In),
        .Load(Ld_A),
        .Shift_En(Shift_En),
        .D(A),
        .Shift_Out(AShift_Out),
        .Data_Out(newA)

    );

    reg_8   reg_B(
        .Clk(Clk),
        .Reset(~Reset),
        .Shift_In(BShift_In),
        .Load(Ld_B),
        .Shift_En(Shift_En),
        .D(S),
        .Shift_Out(BShift_out),
        .Data_Out(newB)
    );

    dreg    reg_x(
        .Clk(Clk),
        .Load(Ld_X),
        .Reset(Reset_A),
        .D(D_X),
        .Q(X)
    );

    // Execution.
    add_sub9    add_unit(
        .A(newA),
        .B(S),
        .fn(fn),
        .S(Sum)
    );
    control     control_unit(
        .Clk(Clk),
        .Reset(~Reset),
        .ClearA_LoadB(~ClearA_LoadB),
        .Run(~Run),
        .M(BShift_out),
        .Clr_LD(Ld_B),
        .ClearA(ClearA),
        .Shift(Shift_En),
        .Add(Add),
        .Sub(Sub)
    );

    HexDriver   HexAL(.In0(newA[3:0]), .Out0(AhexL));
    HexDriver   HexBL(.In0(newB[3:0]), .Out0(BhexL));
    HexDriver   HexAU(.In0(newA[7:4]), .Out0(AhexU));
    HexDriver   HexBU(.In0(newB[7:4]), .Out0(BhexU));
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