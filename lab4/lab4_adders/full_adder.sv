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