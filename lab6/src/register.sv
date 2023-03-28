module register #(N = 8) (
    input logic Clk, Reset, Load,
    input logic [N-1:0] Din,
    output logic [N-1:0] data_out
);

    always_ff @ (posedge Clk)
    begin
        if (Reset)
            data_out <= {N{1'b0}};
        else if (Load)
            data_out <= Din;
    end
endmodule