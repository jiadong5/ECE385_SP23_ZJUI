


module enemy_attackROM
(
		input [8:0] read_address,
		input Clk,
		output logic [4:0] data_Out
);

// 18 * 20 = 360. 2^9 = 512
logic [4:0] mem [0:359];

initial
begin
    $readmemh("sprite/Gengar_Attack.txt", mem, 0);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule