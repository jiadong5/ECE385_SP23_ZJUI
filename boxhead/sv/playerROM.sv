/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module playerROM
(
		input [15:0] read_address,
		input Clk,
		output logic [4:0] data_Out
);

// For directions, each direction 40 * 64
// mem has width of 3 bits and a total of 40 * 64 * 4
logic [4:0] mem [0:10239];

initial
begin
    $readmemh("sprite/player_front.txt", mem, 0);
    $readmemh("sprite/player_left.txt", mem, 1 * 2560);
    $readmemh("sprite/player_back.txt", mem, 2 * 2560);
    $readmemh("sprite/player_right.txt", mem, 3 * 2560);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule
