/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module attackROM
(
		input [7:0] read_address,
		input Clk,
		output logic [4:0] data_Out
);

// 16 * 16 = 2 ^ 8 = 256
logic [4:0] mem [0:255];

initial
begin
    $readmemh("sprite/unit_lightening.txt", mem, 0);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule
