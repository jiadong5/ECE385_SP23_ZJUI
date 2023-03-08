// module carry_lookahead_adder
// (
//     input   logic[15:0]     A,
//     input   logic[15:0]     B,
//     output  logic[15:0]     Sum,
//     output  logic           CO
// );

//     logic[3:0] C4; // Carry
//     logic[3:0] PG;
//     logic[3:0] GG;
//     assign C4[0] = 1'b0


//     carry_lookahead_adder4 CLA0(.A(A[3:0]), .B(B[3:0]), .Cin(C4[0]), .Sum(Sum[3:0]), .CO(C4[1]), .PG(PG[0]), .GG(GG[0]) );
//     carry_lookahead_adder4 CLA1(.A(A[7:4]), .B(B[7:4]), .Cin(C4[1]), .Sum(Sum[7:4]), .CO(C4[2]), .PG(PG[1]), .GG(GG[1]) );
//     carry_lookahead_adder4 CLA2(.A(A[11:8]), .B(B[11:8]), .Cin(C4[2]), .Sum(Sum[11:8]), .CO(C4[3]), PG(PG[2]), .GG(GG[2]) );
//     carry_lookahead_adder4 CLA3(.A(A[15:12]), .B(B[15:12]), .Cin(C4[3]), .Sum(Sum[15:12]), .CO(CO), PG(PG[3]), .PG(PG[3]));
     
// endmodule

// module carry_lookahead_adder4
// (
//     input logic[3:0] A,
//     input logic[3:0] B,
//     input logic Cin,
//     output logic[3:0] Sum,
// );

//     logic CO;
//     logic[3:0] C;
//     logic PG;
//     logic GG;

//     carry_lookahead_unit4 CLU(.*);

//     assign Sum = A ^ B ^ C;

// endmodule

// module carry_lookahead_unit4
// (
//     input logic[3:0] A,
//     input logic[3:0] B,
//     input logic Cin,
//     output logic CO,
//     output logic[3:0] C,
//     output logic PG,
//     output logic GG
// );

//     P = A ^ B;
//     G = A & B;

//     C[0] = Cin;
//     C[1] = Cin & P[0] | G[0];
//     C[2] = Cin & P[0] & P[1] | G[0] & P[1] | G[1];
//     C[3] = Cin & P[0] & P[1] & P[2] | G[0] & P[1] & P[2] | G[1] & P[2] | G[2];

//     CO = Cin & P[0] & P[1] & P[2] & P[3] | G[0] & P[1] & P[2] & P[3] | G[1] & P[2] & P[3] | G[2] & P[3] | G[3];

//     PG = P[0] & P[1] & P[2] & P[3];
//     GG = G[3] | G[2] & P[3] | G[1] & P[3] & P[2] | G[0] & P[3] & P[2] & P[1];

// endmodule


// module carry_lookahead_unit16
// (
//     input logic[15:0] A,
//     input logic[15:0] B,
//     input logic Cin,
//     output logic[3:0] C4
// )
//     output logic[3:0] PG,
//     output logic[3:0] GG,
//     logic[15:0] C; // Not required
//     carry_lookahead_unit4 CLU0(.A(A[3:0]), .B(B[3:0]), .Cin(Cin), .CO(C4[0]), .C(C[3:0]), .PG(PG[0]), .GG(GG[0]));
//     carry_lookahead_unit4 CLU1(.A[A[7:4]], .B(B[7:4]), .Cin(C4[0]), .CO(C4[1]),.C[C[7:4]], .PG(PG[1]), .GG(GG[1]) );
//     carry_lookahead_unit4 CLU2(.A[A[11:8]], .B(B[11:8]), .Cin(C4[1]), .CO(C4[2]), .C(C[11:8]), .PG(PG[2]), .GG(GG[2]));
//     carry_lookahead_unit4 CLU3(.A(A[15:12]), .B(B[15:12]), .Cin(C4[2]), CO(C4[3]), .C(C[15:12]), .PG(PG[3]), .GG(GG[3]));

// endmodule