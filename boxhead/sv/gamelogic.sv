
`define ENEMY_NUM 4
`define RESPAWN_TIME 80
module gamelogic
(
    input logic Clk,
                Reset,
                frame_clk,

    input logic [8:0] Player_X,
                      Player_Y,
                      Attack_X,
                      Attack_Y,
                      Enemy_X,
                      Enemy_Y,
    input logic [1:0] Player_Direction,
    input logic       Attack_On,

    // output logic [6:0] Player_Blood,
    //                    Enemy_Blood,
    output logic       Enemy_Alive
);
    parameter [8:0] Attack_Short = 10'd16; // Short side of attack
    parameter [8:0] Attack_Long = 10'd80; // Long side of attack
    parameter [8:0] Enemy_Height = 10'd26;
    parameter [8:0] Enemy_Width = 10'd26;
    parameter [6:0] Damage = 7'd100;

    logic [6:0] Player_Blood, Player_Blood_in;
    logic [6:0] Enemy_Blood, Enemy_Blood_in;

    logic [9:0] Rebirth_Time;
    logic [9:0] Rebirth_Time_In;


    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    logic frame2_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end

    // Reduce frame clk frequency. 
    logic [1:0] counter = 2'd0;
    always_ff @ (posedge Clk) begin
        frame2_clk_rising_edge  <= 1'b0;
        if (frame_clk_rising_edge) begin
            counter <= counter + 1;
            if  (counter == 3) begin
                counter <= 0;
                frame2_clk_rising_edge <= 1'b1;
            end
        end
    end

    // // Enemy Rebirth
    // always_ff @ (posedge frame2_clk_rising_edge) begin
    //     if(~Enemy_Alive) begin
    //         Rebirth_Time <= Rebirth_Time + 1'd1;
    //     end
    // end

    always_ff @(posedge Clk) begin
        if (Reset) begin
            Player_Blood <= 7'd100;
            Enemy_Blood <= 7'd100;
            Rebirth_Time <= 10'd0;
        end
        else begin
            Player_Blood <= Player_Blood_in;
            Enemy_Blood <= Enemy_Blood_in;
        end
    end

    always_comb begin
        Player_Blood_in = Player_Blood;
        Enemy_Blood_in = Enemy_Blood;
        
        // if (Rebirth_Time == `RESPAWN_TIME) begin
        //     Rebrith_Time = 10'd0;
        //     Enemy_Blood_in = 6'd100;
        // end

        // Player attack enemy and judge based on different directions
        if (Attack_On && (Enemy_Blood > 6'd0)) begin
            case(Player_Direction)
                // FIXME: Sometimes the damage doesn't work, especially when shooting left or right
                // Hard to find the reason
                // Down (Front)
                2'd0: begin
                    if (((Enemy_X + Enemy_Width >= Attack_X) && 
                        (Enemy_X + Enemy_Width <= Attack_X + Attack_Short)) || 
                        ((Enemy_X >= Attack_X) && 
                        (Enemy_X <= Attack_X + Attack_Short))) begin
                            if (((Enemy_Y + Enemy_Height >= Attack_Y) && 
                                (Enemy_Y + Enemy_Height <= Attack_Y + Attack_Long)) ||
                                ((Enemy_Y >= Attack_Y) && 
                                (Enemy_Y <= Attack_Y + Attack_Long))) begin
                                    Enemy_Blood_in = Enemy_Blood + (~(Damage) + 1'b1);
                            end
                    end
                end
                // Left 
                2'd1: begin
                    // if ((Attack_X - Attack_Long <= Enemy_X + Enemy_Width <= Attack_X ) || 
                    //     (Attack_X - Attack_Long <= Enemy_X <= Attack_X))  
                    if (((Attack_X <= Enemy_X + Enemy_Width + Attack_Long) && 
                        (Attack_X >= Enemy_X + Enemy_Width)) || 
                        ((Attack_X <= Enemy_X + Attack_Long) && 
                        (Attack_X >= Enemy_X))) begin
                            if (((Enemy_Y + Enemy_Height >= Attack_Y) && 
                                (Enemy_Y + Enemy_Height <= Attack_Y + Attack_Short)) ||
                                ((Enemy_Y >= Attack_Y) && 
                                (Enemy_Y <= Attack_Y + Attack_Short))) begin
                                    Enemy_Blood_in = Enemy_Blood + (~(Damage) + 1'b1);
                            end
                    end
                end
                // Up(Back)
                2'd2: begin
                    if (((Enemy_X + Enemy_Width >= Attack_X) &&
                        (Enemy_X + Enemy_Width <= Attack_X + Attack_Short)) || 
                        ((Enemy_X >= Attack_X) && 
                        (Enemy_X <= Attack_X + Attack_Short))) begin
                            if (((Attack_Y <= Enemy_Y + Enemy_Height + Attack_Long) && 
                                (Attack_Y >= Enemy_Y + Enemy_Height)) || 
                                ((Attack_Y <= Enemy_Y + Attack_Long) &&
                                (Attack_Y >= Enemy_Y))) begin
                            // if ((Attack_Y - Attack_Long <= Enemy_Y + Enemy_Height <= Attack_Y) || 
                            //     (Attack_Y - Attack_Long <= Enemy_Y <= Attack_Y))
                                Enemy_Blood_in = Enemy_Blood + (~(Damage) + 1'b1);
                            end
                    end
                end
                // Right
                2'd3: begin

                    if (((Enemy_X + Enemy_Width >= Attack_X) && 
                        (Enemy_X + Enemy_Width <= Attack_X + Attack_Long)) || 
                        ((Enemy_X >= Attack_X) && 
                        (Enemy_X <= Attack_X + Attack_Long))) begin
                            if (((Enemy_Y + Enemy_Height >= Attack_Y) && 
                                (Enemy_Y + Enemy_Height <= Attack_Y + Attack_Short)) ||
                                ((Enemy_Y >= Attack_Y) && 
                                (Enemy_Y <= Attack_Y + Attack_Short))) begin
                                    Enemy_Blood_in = Enemy_Blood + (~(Damage) + 1'b1);
                            end
                    end
                end
            endcase
        end
    end

    always_comb begin
        if (Enemy_Blood <= 6'd0) begin
            Enemy_Alive = 1'b0;
            Rebirth_Time = 10'd0;
        end
        else
            Enemy_Alive = 1'b1;
    end

    

endmodule
