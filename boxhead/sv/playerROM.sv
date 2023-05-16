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

// Four directions, each direction 18 * 20 and 3 walk steps
// mem has width of 5 bits and a total of 18 * 20 * 12 = 4320, 2^13
// 18 * 20 = 360
logic [4:0] mem [0:4319];

initial
begin
    // Front
    $readmemh("sprite/Pikachu_S_1.txt", mem, 0);
    $readmemh("sprite/Pikachu_S_2.txt",mem, 1 * 360);
    $readmemh("sprite/Pikachu_S_0.txt",mem, 2 * 360);
    // Left
    $readmemh("sprite/Pikachu_A_1.txt", mem, 3 * 360);
    $readmemh("sprite/Pikachu_A_2.txt", mem, 4 * 360);
    $readmemh("sprite/Pikachu_A_0.txt", mem, 5 * 360);
    // Back
    $readmemh("sprite/Pikachu_W_1.txt", mem, 6 * 360);
    $readmemh("sprite/Pikachu_W_2.txt", mem, 7 * 360);
    $readmemh("sprite/Pikachu_W_0.txt", mem, 8 * 360);
    // Right
    $readmemh("sprite/Pikachu_D_1.txt", mem, 9 * 360);
    $readmemh("sprite/Pikachu_D_2.txt", mem, 10 * 360);
    $readmemh("sprite/Pikachu_D_0.txt", mem, 11 * 360);


end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule
