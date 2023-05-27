//-------------------------------------------------------------------------
//      audio.sv                                                         --
//      Created by Yihong Jin                                            --
//      Cited by Jiadong Hong (2023.5.16)                                --
//      Fall 2021                                                        --
//                                                                       --
//      This module helps to control the sound play of the board         --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------

module music (	input logic  Clk,
				input logic  [16:0]Add,
				output logic [16:0]music_content
);
				  
	logic [16:0] music_memory [0:80549];	// The length of the txt file
	initial 
	begin 
		$readmemh("littleroot_town.txt",music_memory);
	end
	
	always_ff @ (posedge Clk)
		begin
			music_content <= music_memory[Add];
		end
endmodule
