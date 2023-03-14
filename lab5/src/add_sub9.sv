
module full_adder
(
    input logic A,
    input logic B,
    input logic Cin,
    output logic Sum,
    output logic CO
);

    always_comb
    begin
        Sum = A^B^Cin;
        CO = (A & B) | (A & Cin) | (B & Cin);
    end

endmodule


module add_sub9
(
    input [7:0] A,B,
    input fn,   // fn = 1: substract
                // fn = 0: add
    output [8:0] S
);

    logic Cin[7:0];       // Internal carries in the 8-bit adder
    logic[7:0] BB;      // Internal B or NOT(B)
    logic A8, BB8;      // Internal sign extension bits

    assign BB = (B ^ (8(fn)));
    assign A8 = A[7];
    assign BB8 = BB[7]; 

	full_adder FA0(.A(A[0]), .B(BB[0]), .Cin(fn), .Sum(S[0]), .CO(Cin[0]));
    full_adder FA1(.A(A[1]), .B(BB[1]), .Cin(Cin[0]), .Sum(S[1]), .CO(Cin[1]));
	full_adder FA2(.A(A[2]), .B(BB[2]), .Cin(Cin[1]), .Sum(S[2]), .CO(Cin[2]));
    full_adder FA3(.A(A[3]), .B(BB[3]), .Cin(Cin[2]), .Sum(S[3]), .CO(Cin[3]));
    full_adder FA4(.A(A[4]), .B(BB[4]), .Cin(Cin[3]), .Sum(S[4]), .CO(Cin[4]));
    full_adder FA5(.A(A[5]), .B(BB[5]), .Cin(Cin[4]), .Sum(S[5]), .CO(Cin[5]));
    full_adder FA6(.A(A[6]), .B(BB[6]), .Cin(Cin[5]), .Sum(S[6]), .CO(Cin[6]));
    full_adder FA7(.A(A[7]), .B(BB[7]), .Cin(Cin[6]), .Sum(S[7]), .CO(Cin[7]));
    full_adder FA8(.A(A8), .B(BB8), .Cin(Cin[7]), .Sum(S[8]), .CO());

endmodule