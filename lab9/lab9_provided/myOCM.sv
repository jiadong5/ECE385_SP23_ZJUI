

module on_chip_mem (
    output logic [31:0] q,q1, // ReadData
    
    input logic [31:0] d, // Writedata
    input [11:0] write_addr, read_addr, read_addr1,
    input reset,
    input we,clk, // Write Enable
    input be      // Byte Enable
);

    logic [31:0] mem [1200];

    always_ff @ (posedge clk) begin
        if (reset) begin
            mem <= '{default:0};
        end
        else if (we) begin
            case (be)
                4'b1111: mem[write_addr] <= d;
                4'b1100: mem[write_addr][31:16] <= d[31:16];
                4'b0011: mem[write_addr][15:0] <= d[15:0];
                4'b0001: mem[write_addr][7:0] <= d[7:0];
                4'b0010: mem[write_addr][15:8] <= d[15:8];
                4'b0100: mem[write_addr][23:16] <= d[23:16];
                4'b1000: mem[write_addr][31:24] <= d[31:24];
                default: mem[write_addr][31:0] <= 32'h0;
            endcase
        end
        q <= mem[read_addr];
        q1 <= mem[read_addr1];
        
    end

endmodule
