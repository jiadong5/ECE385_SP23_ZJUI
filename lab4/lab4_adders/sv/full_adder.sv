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


module full_adder4
(
    input logic[3:0] A,
    input logic[3:0] B,
    input logic Cin,
    output logic[3:0] Sum,
    output logic CO
);

    logic [3:0] C;
    assign C[0] = Cin;

	full_adder FA0(.A(A[0]), .B(B[0]), .Cin(C[0]), .Sum(Sum[0]), .CO(C[1]));
    full_adder FA1(.A(A[1]), .B(B[1]), .Cin(C[1]), .Sum(Sum[1]), .CO(C[2]));
	full_adder FA2(.A(A[2]), .B(B[2]), .Cin(C[2]), .Sum(Sum[2]), .CO(C[3]));
    full_adder FA3(.A(A[3]), .B(B[3]), .Cin(C[3]), .Sum(Sum[3]), .CO(CO));

endmodule