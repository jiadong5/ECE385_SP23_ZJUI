


module bloodROM
(
		input [8:0] read_address,
		input Clk,
		output logic [4:0] data_Out
);

// 13 * 13 * 2 = 338 = 2^9
logic [4:0] mem [0:337];

initial
begin
    $readmemh("sprite/Red.txt", mem, 0);
    $readmemh("sprite/Empty.txt", mem, 1 * 13 * 13);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule
