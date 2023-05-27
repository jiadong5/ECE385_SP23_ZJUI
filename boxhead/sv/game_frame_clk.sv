

module game_frame_clk(
    input logic Clk,
    input logic frame_clk,
    input logic Game_Over_On,
    output logic game_frame_clk_rising_edge
);

    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end

    // For game, Reduce frame clk frequency. 
    logic [1:0] counter = 2'd0;
    always_ff @ (posedge Clk) begin
        if(Game_Over_On) 
            game_frame_clk_rising_edge <= 1'b0;
        else begin
            game_frame_clk_rising_edge <= 1'b0;
            if (frame_clk_rising_edge) begin
                counter <= counter + 1;
                if  (counter == 3) begin
                    counter <= 0;
                    game_frame_clk_rising_edge <= 1'b1;
                end
            end
        end
    end


endmodule
