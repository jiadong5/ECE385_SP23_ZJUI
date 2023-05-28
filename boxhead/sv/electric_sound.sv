//-------------------------------------------------------------------------
//      audio.sv                                                         --
//      Created by Yihong Jin                                            --
//      Cited by Jiadong Hong (2023.5.16)                                --
//      Fall 2021                                                        --
//                                                                       --
//      This module helps to control the sound play of the board         --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------

module ele_sound (	
    input logic  Clk,
	input logic  [16:0] ele_add,
    input logic  ele_enable,
	output logic [16:0] ele_content
);
				  
	logic [16:0] music_memory [0:5900];	// The length of the txt file
	initial 
	begin 
		$readmemh("ele.txt",music_memory);
	end
	
	always_ff @ (posedge Clk)
		begin
            if(ele_enable == 4'd01)
                begin
                    ele_content <= music_memory[ele_add];
                end
            else
                begin
                    ele_content <= 17'd0;
                end
		end
endmodule