/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module background_palette
(
	input logic [4:0] read_address,
	input Clk,
	output logic [23:0] data_Out
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:31];

initial
begin
	 $readmemh("sprite/background_palette.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule
