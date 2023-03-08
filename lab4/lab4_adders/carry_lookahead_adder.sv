module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    // Input to lookahead unit
    logic[3:0] PG;
    logic[3:0] GG;

    // Output from lookahead unit
    logic[3:0] C4; 
    logic[4:1] unused_C;

    // Set C4[3:0] for 4bit CLA adders, output CO.
    carry_lookahead_unit16(.PG(PG), .GG(GG), .Cin(1'b0), .CO(CO), .C4(C4));

    // Get the value of PG,GG
    carry_lookahead_adder4 CLA0(.A(A[3:0]), .B(B[3:0]), .Cin(1'b0), .Sum(Sum[3:0]), .CO(unused_C[1]), .PG(PG[0]), .GG(GG[0]) );
    carry_lookahead_adder4 CLA1(.A(A[7:4]), .B(B[7:4]), .Cin(C4[1]), .Sum(Sum[7:4]), .CO(unused_C[2]), .PG(PG[1]), .GG(GG[1]) );
    carry_lookahead_adder4 CLA2(.A(A[11:8]), .B(B[11:8]), .Cin(C4[2]), .Sum(Sum[11:8]), .CO(unused_C[3]), PG(PG[2]), .GG(GG[2]) );
    carry_lookahead_adder4 CLA3(.A(A[15:12]), .B(B[15:12]), .Cin(C4[3]), .Sum(Sum[15:12]), .CO(unused_C[4]), PG(PG[3]), .PG(PG[3]));
     
endmodule

module carry_lookahead_adder4
(
    input logic[3:0] A,
    input logic[3:0] B,
    input logic Cin,
    output logic[3:0] Sum,
    output logic CO,
    output logic PG,
    output logc GG
);

    // Input to lookahead unit
    logic[3:0] P;
    logic[3:0] G;
    // Output from lookahead unit
    logic[3:0] C;
    logic[4:1] unused_C;

    assign P = A ^ B;
    assign G = A & B;
    
    // Set C[3:0] for full adders, output CO, PG,GG
    carry_lookahead_unit4 CLU(.*);

    full_adder FA0(.A(A[0]), .B(B[0]), .Cin(Cin), .Sum(Sum[0]), .CO(unused_C[1]));
    full_adder FA1(.A(A[1]), .B(B[1]), .Cin(C[1]), .Sum(Sum[1]), .CO(unused_C[2]));
    full_adder FA2(.A(A[2]), .B(B[2]), .Cin(C[2]), .Sum(Sum[2]), .CO(unused_C[3]));
    full_adder FA3(.A(A[3]), .B(B[3]), .Cin(C[3]), .Sum(Sum[3]), .CO(unused_C[4]));


endmodule

module carry_lookahead_unit4
(
    input logic[3:0] P,
    input logic[3:0] G,
    input logic Cin,

    output logic CO,
    output logic[3:0] C,
    output logic PG,
    output logic GG
);

    C[0] = Cin;
    C[1] = Cin & P[0] | G[0];
    C[2] = Cin & P[0] & P[1] | G[0] & P[1] | G[1];
    C[3] = Cin & P[0] & P[1] & P[2] | G[0] & P[1] & P[2] | G[1] & P[2] | G[2];

    CO = Cin & P[0] & P[1] & P[2] & P[3] | G[0] & P[1] & P[2] & P[3] | G[1] & P[2] & P[3] | G[2] & P[3] | G[3];

    PG = P[0] & P[1] & P[2] & P[3];
    GG = G[3] | G[2] & P[3] | G[1] & P[3] & P[2] | G[0] & P[3] & P[2] & P[1];

endmodule


module carry_lookahead_unit16
(
    input logic[3:0] PG,
    input logic[3:0] GG,
    input logic Cin,

    output logic CO;
    output logic[3:0] C4,
)

    C4[0] = GG[0] | Cin & PG[0];
    C4[1] = GG[1] | GG[0] & PG[1] | Cin & PG[0] & PG[1];
    C4[2] = GG[2] | GG[1] & PG[2] | GG[0] & PG[2] & PG[1] |  Cin & PG[2] & PG[1] & PG[0];
    C4[3] = GG[3] | GG[2] & PG[3] | GG[1] & PG[3] & PG[2] | GG[0] & PG[3] & PG[2] & PG[1] | Cin & PG[3] & PG[2] & PG[1] & PG[0];

endmodule