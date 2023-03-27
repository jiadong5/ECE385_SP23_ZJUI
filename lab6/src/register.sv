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

module Reg_RegFile_Read(
    input logic Clk, Reset,
    input logic LD_REG,
    input logic[2:0] SR,
    input logic[15:0] R0_Out,
    input logic[15:0] R1_Out,
    input logic[15:0] R2_Out,
    input logic[15:0] R3_Out,
    input logic[15:0] R4_Out,
    input logic[15:0] R5_Out,
    input logic[15:0] R6_Out,
    input logic[15:0] R7_Out,
    output logic[15:0] data_out 
);

always_ff @ (posedge Clk)
    begin
        if (Reset)
                data_out <= {16'b0};
        else if(Load)
            begin 
                case(SR)
                    3b'000: data_out <= R0_Out;
                    3b'001: data_out <= R1_Out;
                    3b'010: data_out <= R2_Out;
                    3b'011: data_out <= R3_out;
                    3b'100: data_out <= R4_Out;
                    3b'101: data_out <= R5_Out;
                    3b'110: data_out <= R6_Out;
                    3b'111: data_out <= R7_Out;
                endcase
            end
    end
endmodule
