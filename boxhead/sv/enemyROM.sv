/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module enemyROM
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

    $readmemh("sprite/player_left0.txt", mem, 3 * 2560);
    $readmemh("sprite/player_left1.txt", mem, 4 * 2560);
    $readmemh("sprite/player_left2.txt", mem, 5 * 2560);

    $readmemh("sprite/player_back0.txt", mem, 6 * 2560);
    $readmemh("sprite/player_back1.txt", mem, 7 * 2560);
    $readmemh("sprite/player_back2.txt", mem, 8 * 2560);

    $readmemh("sprite/player_right0.txt", mem, 9 * 2560);
    $readmemh("sprite/player_right1.txt", mem, 10 * 2560);
    $readmemh("sprite/player_right2.txt", mem, 11 * 2560);


end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule
