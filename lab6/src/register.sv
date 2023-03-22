

module register #(N = 8) (
    input logic Clk, Reset, Load,
    input logic [N-1:0] Din,
    output logic [N-1:0] Dout
);

    always_ff @ (posedge Clk)
    begin
        if (Reset)
            Dout <= {N{1'b0}};
        else if (Load)
            Dout <= Din;
    end
endmodule
