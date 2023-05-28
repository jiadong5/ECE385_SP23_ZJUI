//-------------------------------------------------------------------------
//      audio.sv                                                         --
//      Created by Yihong Jin                                            --
//      Cited by Jiadong Hong (2023.5.16)                                --
//      Fall 2021                                                        --
//                                                                       --
//      This module helps to control the sound play of the board         --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------

module pika_sound (	
    input logic  Clk,
	input logic  [16:0] pika_add,
    input logic  pika_enable,
	output logic [16:0] pika_content
);
				  
	logic [16:0] music_memory [0:11929];	// The length of the txt file
	initial 
	begin 
		$readmemh("Pi-ka.txt",music_memory);
	end
	
	always_ff @ (posedge Clk)
		begin
            if(pika_enable == 4'd01)
                begin
                    pika_content <= music_memory[pika_add];
                end
            else
                begin
                    pika_content <= 17'd0;
                end
		end
endmodule