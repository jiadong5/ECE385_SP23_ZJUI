/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module attackROM
(
		input [8:0] read_address,
		input Clk,
		output logic [4:0] data_Out
);

// 16 * 16 * 2 = 2 ^ 9 = 512
logic [4:0] mem [0:511];

initial
begin
    $readmemh("sprite/unit_lightening_cycling.txt", mem, 0);
    $readmemh("sprite/unit_lightening_cycling2.txt", mem, 1 * 16 * 16);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule
