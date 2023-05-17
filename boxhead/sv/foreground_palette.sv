/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module foreground_palette
(
	input logic [4:0] read_address0,
					  read_address1,
	input Clk,
	output logic [23:0] data_Out0,
						data_Out1
);

// mem has width of 3 bits and a total of 400 addresses
logic [23:0] mem [0:31];

initial
begin
	 $readmemh("sprite/foreground_palette.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out0 <= mem[read_address0];
	data_Out1 <= mem[read_address1];
end

endmodule
