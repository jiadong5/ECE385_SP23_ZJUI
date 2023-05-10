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

// Four directions, each direction 40 * 64 and 3 walk steps
// mem has width of 3 bits and a total of 40 * 64 * 12
logic [4:0] mem [0:30719];

initial
begin
    $readmemh("sprite/player_front0.txt", mem, 0);
    $readmemh("sprite/player_front1.txt",mem, 1 * 2560);
    $readmemh("sprite/player_front2.txt",mem, 2 * 2560);

    $readmemh("sprite/player_left.txt", mem, 3 * 2560);
    $readmemh("sprite/player_back.txt", mem, 4 * 2560);
    $readmemh("sprite/player_right.txt", mem, 5 * 2560);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule
