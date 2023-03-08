module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);
    logic[15:0] Sum0;
    logic[15:0] Sum1;
    logic[3:0] Cout0;
    logic[3:0] Cout1;
    logic[2:0] C4;  // C4, C8, C12


    // Set up seven adders
    full_adder4 FAC_00(.A(A[3:0]), .B(B[3:0]), .Cin(1'b0), .Sum(Sum0[3:0]),.CO(Cout0[0]));

    full_adder4 FAC_01(.A(A[7:4]), .B(B[7:4]), .Cin(1'b0), .Sum(Sum0[7:4]),.CO(Cout0[1]));
    full_adder4 FAC_02(.A(A[11:8]),.B(B[11:8]), .Cin(1'b0), .Sum(Sum0[11:8]),.CO(Cout0[2]));
    full_adder4 FAC_03(.A(A[15:12]),.B(B[15:12]), .Cin(1'b0), .Sum(Sum0[15:12]),.CO(Cout0[3]));

    full_adder4 FAC_11(.A(A[7:4]), .B(B[7:4]), .Cin(1'b1), .Sum(Sum1[7:4]), .CO(Cout1[1]));
    full_adder4 FAC_12(.A(A[11:8]),.B(B[11:8]), .Cin(1'b1), .Sum(Sum1[11:8]),.CO(Cout1[2]));
    full_adder4 FAC_13(.A(A[15:12]),.B(B[15:12]), .Cin(1'b1), .Sum(Sum1[15:12]),.CO(Cout1[3]));


    always_comb
    begin

        // Set C4,C8,C12,Cout
        C4[0] = Cout0[0];
        C4[1] = C4[0] & Cout1[1] | Cout0[1];
        C4[2] = C4[1] & Cout1[2] | Cout0[2];
        CO = C4[2] & Cout1[3] | Cout0[3];

        // Decide on the sum
        Sum[3:0] = Sum0[3:0];
        unique case (C4[0]) 
            1'b0:  Sum[7:4] = Sum0[7:4];
            1'b1:  Sum[7:4] = Sum1[7:4];
        endcase

        unique case (C4[1])
            1'b0: Sum[11:8] = Sum0[11:8];
            1'b1: Sum[11:8] = Sum1[11:8];
        endcase

        unique case(C4[2])
            1'b0: Sum[15:12] = Sum0[15:12];
            1'b1: Sum[15:12] = Sum1[15:12];
        endcase
    end

     
endmodule
