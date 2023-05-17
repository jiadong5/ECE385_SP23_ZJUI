/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module enemyROM
(
		input [15:0] read_address0,
        input [15:0] read_address1,
		input Clk,
		output logic [4:0] data_Out0,
        output logic [4:0] data_Out1
);

// Four directions, each direction 26 * 26 and 3 walk steps
// mem has width of 5 bits and a total of 26 * 26 * 12 = 8112, 2^13
// 26 * 26 = 676
logic [4:0] mem [0:8111];

initial
begin
    // Front
    $readmemh("sprite/Gengar_S_1.txt", mem, 0);
    $readmemh("sprite/Gengar_S_2.txt",mem, 1 * 676);
    $readmemh("sprite/Gengar_S_0.txt",mem, 2 * 676);

    // Left
    $readmemh("sprite/Gengar_A_1.txt", mem, 3 * 676);
    $readmemh("sprite/Gengar_A_2.txt", mem, 4 * 676);
    $readmemh("sprite/Gengar_A_0.txt", mem, 5 * 676);

    // Back
    $readmemh("sprite/Gengar_W_1.txt", mem, 6 * 676);
    $readmemh("sprite/Gengar_W_2.txt", mem, 7 * 676);
    $readmemh("sprite/Gengar_W_0.txt", mem, 8 * 676);

    // Right
    $readmemh("sprite/Gengar_D_1.txt", mem, 9 * 676);
    $readmemh("sprite/Gengar_D_2.txt", mem, 10 * 676);
    $readmemh("sprite/Gengar_D_0.txt", mem, 11 * 676);


end


always_ff @ (posedge Clk) begin
	data_Out0 <= mem[read_address0];
    data_Out1 <= mem[read_address1];
end

endmodule
