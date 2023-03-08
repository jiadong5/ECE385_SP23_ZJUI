module ripple_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

	logic [15:0] Cin;
		
    assign Cin[0] = 1'b0;

	full_adder FA0(.A(A[0]), .B(B[0]), .Cin(Cin[0]), .Sum(Sum[0]), .CO(Cin[1]));
    full_adder FA1(.A(A[1]), .B(B[1]), .Cin(Cin[1]), .Sum(Sum[1]), .CO(Cin[2]));
	full_adder FA2(.A(A[2]), .B(B[2]), .Cin(Cin[2]), .Sum(Sum[2]), .CO(Cin[3]));
    full_adder FA3(.A(A[3]), .B(B[3]), .Cin(Cin[3]), .Sum(Sum[3]), .CO(Cin[4]));
    full_adder FA4(.A(A[4]), .B(B[4]), .Cin(Cin[4]), .Sum(Sum[4]), .CO(Cin[5]));
    full_adder FA5(.A(A[5]), .B(B[5]), .Cin(Cin[5]), .Sum(Sum[5]), .CO(Cin[6]));
    full_adder FA6(.A(A[6]), .B(B[6]), .Cin(Cin[6]), .Sum(Sum[6]), .CO(Cin[7]));
    full_adder FA7(.A(A[7]), .B(B[7]), .Cin(Cin[7]), .Sum(Sum[7]), .CO(Cin[8]));
    full_adder FA8(.A(A[8]), .B(B[8]), .Cin(Cin[8]), .Sum(Sum[8]), .CO(Cin[9]));
    full_adder FA9(.A(A[9]), .B(B[9]), .Cin(Cin[9]), .Sum(Sum[9]), .CO(Cin[10]));
    full_adder FA10(.A(A[10]), .B(B[10]), .Cin(Cin[10]), .Sum(Sum[10]), .CO(Cin[11]));
    full_adder FA11(.A(A[11]), .B(B[11]), .Cin(Cin[11]), .Sum(Sum[11]), .CO(Cin[12]));
    full_adder FA12(.A(A[12]), .B(B[12]), .Cin(Cin[12]), .Sum(Sum[12]), .CO(Cin[13]));
    full_adder FA13(.A(A[13]), .B(B[13]), .Cin(Cin[13]), .Sum(Sum[13]), .CO(Cin[14]));
    full_adder FA14(.A(A[14]), .B(B[14]), .Cin(Cin[14]), .Sum(Sum[14]), .CO(Cin[15]));
    full_adder FA15(.A(A[15]), .B(B[15]), .Cin(Cin[15]), .Sum(Sum[15]), .CO(CO));


     
endmodule
