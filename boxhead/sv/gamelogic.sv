
`define ENEMY_NUM 4
`define RESPAWN_TIME 100
module gamelogic
(
    input logic Clk,
                Reset,
                game_frame_clk_rising_edge,

    input logic [8:0] Player_X,
                      Player_Y,
                      Attack_X,
                      Attack_Y,
                      Enemy_X,
                      Enemy_Y,
    input logic [1:0] Player_Direction,
    input logic       Attack_On,
                      Enemy_Attack_On,

    // output logic [6:0] Player_Blood,
    //                    Enemy_Blood,
    output logic       Enemy_Alive,
    output logic [7:0] Score,
    output logic [9:0] Enemy_Total_Damage
);
    parameter [8:0] Attack_Short = 10'd16; // Short side of attack
    parameter [8:0] Attack_Long = 10'd80; // Long side of attack
    parameter [8:0] Enemy_Height = 10'd26;
    parameter [8:0] Enemy_Width = 10'd26;
    parameter [6:0] Player_Damage = 7'd100;
    parameter [9:0] Enemy_Damage = 10'd10;

    logic [9:0] Enemy_Total_Damage_in;
    logic [6:0] Enemy_Blood, Enemy_Blood_in;
    logic [9:0] Rebirth_Time;
    logic [9:0] Rebirth_Time_in;


    logic [7:0] Score_in;

    always_ff @(posedge Clk) begin
        if (Reset) begin
            Enemy_Total_Damage <= 10'b0;
            Enemy_Blood <= 7'd100;
            Rebirth_Time <= 10'd0;
            Score <= 8'd0;
        end
        else begin
            Enemy_Total_Damage <= Enemy_Total_Damage;
            // if (Attack_On)
            //     Enemy_Total_Damage <= Enemy_Total_Damage + Enemy_Damage;
            Enemy_Total_Damage <= Enemy_Total_Damage_in;
            Enemy_Blood <= Enemy_Blood_in;
            Rebirth_Time <= Rebirth_Time_in;
            Score <= Score_in;
        end
    end

    // Player attack enemy
    always_comb begin
        Enemy_Blood_in = Enemy_Blood;
        Rebirth_Time_in = Rebirth_Time;
        Score_in = Score;
        
        if (~Enemy_Alive) begin
            if (game_frame_clk_rising_edge) begin
                if (Rebirth_Time == `RESPAWN_TIME) begin
                    Rebirth_Time_in = 10'd0;
                    Enemy_Blood_in = 7'd100;
                end
                else begin
                    Rebirth_Time_in = Rebirth_Time + 1'd1;
                end
            end
        end

        // Player attack enemy and judge based on different directions
        else if (Attack_On & Enemy_Alive) begin
            case(Player_Direction)
                // Down (Front)
                2'd0: begin
                    if ((Enemy_X + Enemy_Width >= Attack_X) && (Enemy_X <= Attack_X + Attack_Short) && 
                        (Enemy_Y + Enemy_Height >= Attack_Y) && (Enemy_Y <= Attack_Y + Attack_Long)) begin
                            Enemy_Blood_in = Enemy_Blood + (~(Player_Damage) + 1'b1);
                            Score_in = Score + 1;
                    end
                end
                // Left 
                2'd1: begin
                    if ((Enemy_X + Enemy_Width + Attack_Long >= Attack_X) && (Enemy_X <= Attack_X) && 
                        (Enemy_Y + Enemy_Height >= Attack_Y) && (Enemy_Y <= Attack_Y + Attack_Short)) begin
                            Enemy_Blood_in = Enemy_Blood + (~(Player_Damage) + 1'b1);
                            Score_in = Score + 1;
                    end
                end
                // Up(Back)
                2'd2: begin
                    if ((Enemy_X + Enemy_Width >= Attack_X) && (Enemy_X <= Attack_X + Attack_Short) && 
                        (Enemy_Y + Enemy_Width + Attack_Long>= Attack_Y) && (Enemy_Y <= Attack_Y)) begin
                            Enemy_Blood_in = Enemy_Blood + (~(Player_Damage) + 1'b1);
                            Score_in = Score + 1;
                    end
                end
                // Right
                2'd3: begin
                    if ((Enemy_X + Enemy_Width >= Attack_X) && (Enemy_X <= Attack_X + Attack_Long) && 
                        (Enemy_Y + Enemy_Height >= Attack_Y) && (Enemy_Y <= Attack_Y + Attack_Short) ) begin
                            Enemy_Blood_in = Enemy_Blood + (~(Player_Damage) + 1'b1);
                            Score_in = Score + 1;
                    end
                end
            endcase
        end
    end

    // Enemy Attack Player
    always_comb begin
        Enemy_Total_Damage_in = Enemy_Total_Damage;
        if (game_frame_clk_rising_edge) begin
            if (Enemy_Attack_On) begin
                Enemy_Total_Damage_in = Enemy_Total_Damage + Enemy_Damage;
            end
        end
    end

    always_comb begin
        if (Enemy_Blood <= 6'd0) begin
            Enemy_Alive = 1'b0;
        end
        else
            Enemy_Alive = 1'b1;
    end

    

endmodule
