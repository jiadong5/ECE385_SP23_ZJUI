//-------------------------------------------------------------------------
//      audio.sv                                                         --
//      Created by Yihong Jin                                            --
//      Cited by Jiadong Hong (2023.5.28)                                --
//      Fall 2021                                                        --
//                                                                       --
//      This module helps to control the sound play of the board         --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module gengar_audio (   
	input logic Clk, Reset, 
	input logic INIT_FINISH,
	input logic data_over,
	input logic [16:0] gengar_frequency,
    input logic gengar_enable,
	output logic INIT_gengar,
	output [16:0] gengar_add
);

logic [15:0] counter;
logic [15:0] inner_counter;
enum logic {WAIT,RUN} current_state, next_state;
logic [16:0] inner_Add;


always_ff @ (posedge Clk)
	begin
		if (Reset)
		begin
			current_state <= WAIT;
			counter <= 16'd0;
			gengar_add <= 17'd0;
		end
		else
		begin
			current_state <= next_state;
			counter <= inner_counter;
			gengar_add <= inner_Add;
		end
	end
		
always_comb
	begin
		unique case(current_state)
			WAIT:
				begin
					// if (INIT_FINISH == 4'd01) 
					// 	begin
					// 		next_state = RUN;
					// 		INIT = 1'd01;
					// 	end
					// else
					// 	begin
					// 		next_state = WAIT;
							
					// 	end
                    if (INIT_FINISH == 4'd01)
                        begin
                            if (gengar_enable == 4'd01)
                                begin
                                    next_state = RUN;
                                end
                            else
                                begin
                                    next_state = WAIT;
                                end
                        end
                    else
                        begin
                            next_state = WAIT;
                        end
					INIT_gengar = 1'd01;	
					inner_counter = 16'd0;
					inner_Add = 17'd0;
				end
			RUN:
			begin
				INIT_gengar = 1'd01;
				
				if (counter< gengar_frequency+1)
					inner_counter = counter+16'd1;
				else
					inner_counter = 16'd0;
					
				if (counter== gengar_frequency && gengar_add<=17'd10000 && data_over!=0)
                    begin
                        next_state = RUN;
					    inner_Add = gengar_add+17'd1;
                    end
				else if (gengar_add < 17'd10000)
                    begin
                        next_state = RUN;
				    	inner_Add = gengar_add;
                    end
				else
                    begin
                        next_state = WAIT;
				    	inner_Add = 17'd0;
                    end
			end	
		
		default: ;
		endcase	
	end

endmodule