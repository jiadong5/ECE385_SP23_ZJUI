
`define ENEMY_NUM 4

`define RESPAWN_TIME 40
module gamelogic #(parameter id)
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
    output logic [7:0] Enemy_Score,
    output logic [9:0] Enemy_Total_Damage,
    output logic       Enemy_Is_Attacked
);
    parameter [8:0] Attack_Short = 10'd16; // Short side of attack
    parameter [8:0] Attack_Long = 10'd80; // Long side of attack
    parameter [8:0] Enemy_Height = 10'd26;
    parameter [8:0] Enemy_Width = 10'd26;
    parameter [6:0] Player_Damage = 7'd10;
    parameter [9:0] Enemy_Damage = 10'd10;
    parameter [6:0] Enemy_Full_Blood = 7'd100;

    logic [9:0] Enemy_Total_Damage_in;
    logic [6:0] Enemy_Blood, Enemy_Blood_in;
    logic [9:0] Rebirth_Time;
    logic [9:0] Rebirth_Time_in;

    logic [7:0] Enemy_Score_in;
    logic Enemy_Alive_in;

    always_ff @(posedge Clk) begin
        if (Reset) begin
            Enemy_Total_Damage <= 10'b0;
            // Enemy_Blood <= Enemy_Full_Blood;
            Enemy_Blood <= 7'd0;
            Rebirth_Time <= 10'd0;
            Enemy_Score <= 8'd0;
        end
        else begin
            Enemy_Total_Damage <= Enemy_Total_Damage_in;
            Enemy_Blood <= Enemy_Blood_in;
            Rebirth_Time <= Rebirth_Time_in;
            Enemy_Score <= Enemy_Score_in;
        end
    end

    // Player attack enemy
    always_comb begin
        Enemy_Blood_in = Enemy_Blood;
        Rebirth_Time_in = Rebirth_Time;
        Enemy_Score_in = Enemy_Score;
        Enemy_Is_Attacked = 1'b0;
        
        if (~Enemy_Alive) begin
            if (game_frame_clk_rising_edge) begin
                if (Rebirth_Time == (`RESPAWN_TIME * (id[0] + 1))) begin
                    Rebirth_Time_in = 10'd0;
                    Enemy_Blood_in = Enemy_Full_Blood;
                end
                else begin
                    Rebirth_Time_in = Rebirth_Time + 1'd1;
                end
            end
        end

        // Player attack enemy and judge based on different directions
        else if (Attack_On & Enemy_Alive & game_frame_clk_rising_edge) begin
            case(Player_Direction)
                // Down (Front)
                2'd0: begin
                    if ((Enemy_X + Enemy_Width >= Attack_X) && (Enemy_X <= Attack_X + Attack_Short) && 
                        (Enemy_Y + Enemy_Height >= Attack_Y) && (Enemy_Y <= Attack_Y + Attack_Long)) begin
                            Enemy_Blood_in = Enemy_Blood + (~(Player_Damage) + 1'b1);
                            Enemy_Is_Attacked = 1'b1;
                    end
                end
                // Left 
                2'd1: begin
                    if ((Enemy_X + Enemy_Width + Attack_Long >= Attack_X) && (Enemy_X <= Attack_X) && 
                        (Enemy_Y + Enemy_Height >= Attack_Y) && (Enemy_Y <= Attack_Y + Attack_Short)) begin
                            Enemy_Blood_in = Enemy_Blood + (~(Player_Damage) + 1'b1);
                            Enemy_Is_Attacked = 1'b1;
                    end
                end
                // Up(Back)
                2'd2: begin
                    if ((Enemy_X + Enemy_Width >= Attack_X) && (Enemy_X <= Attack_X + Attack_Short) && 
                        (Enemy_Y + Enemy_Width + Attack_Long>= Attack_Y) && (Enemy_Y <= Attack_Y)) begin
                            Enemy_Blood_in = Enemy_Blood + (~(Player_Damage) + 1'b1);
                            Enemy_Is_Attacked = 1'b1;
                    end
                end
                // Right
                2'd3: begin
                    if ((Enemy_X + Enemy_Width >= Attack_X) && (Enemy_X <= Attack_X + Attack_Long) && 
                        (Enemy_Y + Enemy_Height >= Attack_Y) && (Enemy_Y <= Attack_Y + Attack_Short) ) begin
                            Enemy_Blood_in = Enemy_Blood + (~(Player_Damage) + 1'b1);
                            Enemy_Is_Attacked = 1'b1;
                    end
                end
            endcase
            if (Enemy_Blood_in <= 6'd0)
                Enemy_Score_in = Enemy_Score + 1'b1;
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
