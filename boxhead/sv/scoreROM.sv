

module scoreROM
(
		input [14:0] read_address,
		input Clk,
		output logic [4:0] data_Out
);

// 40 * 46 * 10 = 18400. 2^15 = 32678
logic [4:0] mem [0:18399];

initial
begin
    $readmemh("sprite/0.txt", mem, 0);
    $readmemh("sprite/1.txt", mem, 40 * 46 * 1);
	$readmemh("sprite/2.txt", mem, 40 * 46 * 2);
	$readmemh("sprite/3.txt", mem, 40 * 46 * 3);
	$readmemh("sprite/4.txt", mem, 40 * 46 * 4);
	$readmemh("sprite/5.txt", mem, 40 * 46 * 5);
	$readmemh("sprite/6.txt", mem, 40 * 46 * 6);
	$readmemh("sprite/7.txt", mem, 40 * 46 * 7);
	$readmemh("sprite/8.txt", mem, 40 * 46 * 8);
	$readmemh("sprite/9.txt", mem, 40 * 46 * 9);
end


always_ff @ (posedge Clk) begin
	data_Out<= mem[read_address];
end

endmodule