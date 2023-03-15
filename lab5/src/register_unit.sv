
/* 8-bit register */
module reg_8 (input  logic Clk, Reset, Shift_In, Load, Shift_En,
              input  logic [7:0]  D,
              output logic Shift_Out,
              output logic [7:0]  Data_Out);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset) //notice, this is a sycnrhonous reset, which is recommended on the FPGA
			  Data_Out <= 8'h0;
		 else if (Load)
			  Data_Out <= D;
		 else if (Shift_En)
		 begin
			  //concatenate shifted in data to the previous left-most 3 bits
			  //note this works because we are in always_ff procedure block
			  Data_Out <= { Shift_In, Data_Out[7:1] }; 
	    end
    end
	
    assign Shift_Out = Data_Out[0];

endmodule


/* Flip-flip */
module dreg (input Clk, Load, Reset, D,
             output logic Q);
    
    always_ff @ (posedge Clk)
    begin
        if (Reset)
            Q <= 1'b0;
        else
            if (Load)
                Q <= D;
            else
                Q <= Q;
    end

endmodule


module register_unit
(
    input logic Clk, Reset, Ashift_In, Bshift_In, Ld_A, Ld_B, Shift_En,
    input logic[7:0] D,
    output logic B_out,  // B_out aka M
    output logic[7:0] AData_out, BData_out
);

    logic shift_bit;
    reg_8 regA(.*, .Shift_In(Ashift_In), .Load(Ld_A),
                .Shift_Out(shift_bit), .Data_Out(AData_out));
    reg_8 regB(.*, .Shift_In(shift_bit), .Load(Ld_B),
                .Shift_Out(B_Out), .Data_Out(BData_out));


endmodule