

module scoreROM
(
		input [14:0] read_address0,read_address1,
		input Clk,
		output logic [4:0] data_Out0,data_Out1
);

// 40 * 46 * 10 = 18400. 2^15 = 32678
// logic [4:0] mem [0:18399];
// 20 * 25 * 12 = 6000. 2^13 = 8192
logic [4:0] mem [0:5999];

initial
begin
    $readmemh("sprite/0.txt", mem, 0);
    $readmemh("sprite/1.txt", mem, 20 * 25 * 1);
	$readmemh("sprite/2.txt", mem, 20 * 25 * 2);
	$readmemh("sprite/3.txt", mem, 20 * 25 * 3);
	$readmemh("sprite/4.txt", mem, 20 * 25 * 4);
	$readmemh("sprite/5.txt", mem, 20 * 25 * 5);
	$readmemh("sprite/6.txt", mem, 20 * 25 * 6);
	$readmemh("sprite/7.txt", mem, 20 * 25 * 7);
	$readmemh("sprite/8.txt", mem, 20 * 25 * 8);
	$readmemh("sprite/9.txt", mem, 20 * 25 * 9);
	$readmemh("sprite/L.txt", mem, 20 * 25 * 10);
	$readmemh("Sprite/S.txt", mem, 20 * 25 * 11);
end


always_ff @ (posedge Clk) begin
	data_Out0 <= mem[read_address0];
	data_Out1 <= mem[read_address1];
end

endmodule
