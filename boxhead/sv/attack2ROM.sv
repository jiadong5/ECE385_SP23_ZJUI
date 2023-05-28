

module attack2ROM
(
		input [10:0] read_address,
		input Clk,
		output logic [4:0] data_Out
);

// 25 * 25 = 625
logic [4:0] mem [0:624];

initial
begin
    $readmemh("sprite/ele_ball.txt", mem, 0);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule
