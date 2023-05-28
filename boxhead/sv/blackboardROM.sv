

module blackboardROM
(
		input [11:0] read_address,
		input Clk,
		output logic [4:0] data_Out
);

// 120 * 30 = 3600. 2^12 = 4096
logic [4:0] mem [0:3599];

initial
begin
    $readmemh("sprite/Blackboard.txt",mem,0);
end


always_ff @ (posedge Clk) begin
	data_Out <= mem[read_address];
end

endmodule
