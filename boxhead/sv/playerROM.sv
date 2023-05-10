/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module playerROM
(
		input [11:0] read_address,
		input Clk,
		output logic [4:0] data_Out
);

// mem has width of 3 bits and a total of 40 * 64
logic [4:0] mem [0:2559];

initial
begin
	 $readmemh("player.txt", mem);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule
