//-------------------------------------------------------------------------
//      audio.sv                                                         --
//      Created by Yihong Jin                                            --
//      Cited by Jiadong Hong (2023.5.16)                                --
//      Fall 2021                                                        --
//                                                                       --
//      This module helps to control the sound play of the board         --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------

module gengar_sound (	
    input logic  Clk,
	input logic  [16:0] gengar_add,
    input logic  gengar_enable,
	output logic [16:0] gengar_content
);
				  
	logic [16:0] music_memory [0:10000];	// The length of the txt file
	initial 
	begin 
		$readmemh("Gen-gar.txt",music_memory);
	end
	
	always_ff @ (posedge Clk)
		begin
            if(gengar_enable == 4'd01)
                begin
                    gengar_content <= music_memory[gengar_add];
                end
            else
                begin
                    gengar_content <= 17'd0;
                end
		end
endmodule