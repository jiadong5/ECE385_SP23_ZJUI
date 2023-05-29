

module gamelevel (input Clk,
                        Reset,
                  input [8:0] PixelX, PixelY,
                  input [9:0] Total_Score,
                  output logic is_obj,
                  output logic [14:0] Obj_address,
                  output logic [3:0] Game_Level,
                  output logic [9:0] Enemy_Respawn_Unit_Time
);

    parameter [8:0] Width = 20;
    parameter [8:0] Height = 25;

    logic [8:0] Obj_X_Pos1, Obj_Y_Pos1;
    logic [8:0] Obj_X_Pos0, Obj_Y_Pos0;


    // Position of L
    assign Obj_X_Pos1 = 267;
    assign Obj_Y_Pos1 = 24;
    assign Obj_X_Pos0 = Obj_X_Pos1 + Width;
    assign Obj_Y_Pos0 = Obj_Y_Pos1;

    always_comb begin
        Game_Level = 4'd9;
        if (Total_Score <= 10'd10)
            Game_Level = 4'd1;
        else if (Total_Score <= 10'd15)
            Game_Level = 4'd2;
        else if (Total_Score <= 10'd30)
            Game_Level = 4'd3;
        else if (Total_Score <= 10'd55)
            Game_Level = 4'd4;
        else if (Total_Score <= 10'd75)
            Game_Level = 4'd5;
        else if (Total_Score <= 10'd99)
            Game_Level = 4'd6;

        case (Game_Level) 
        4'd1: 
            Enemy_Respawn_Unit_Time = 10'd70;
        4'd2:
            Enemy_Respawn_Unit_Time = 10'd40;
        4'd3:
            Enemy_Respawn_Unit_Time = 10'd25;
        4'd4:
            Enemy_Respawn_Unit_Time = 10'd15;
        4'd5:
            Enemy_Respawn_Unit_Time = 10'd10;
        4'd6:
            Enemy_Respawn_Unit_Time = 10'd5;
        default:
            Enemy_Respawn_Unit_Time = 10'd40;
        endcase
    end


    int DistX1, DistY1;
    int DistX0, DistY0;
    assign DistX1 = PixelX - Obj_X_Pos1;
    assign DistY1 = PixelY - Obj_Y_Pos1;
    assign DistX0 = PixelX - Obj_X_Pos0;
    assign DistY0 = PixelY - Obj_Y_Pos0;
    always_comb begin
        is_obj = 1'b0;
        Obj_address = 15'b0;

        // Letter L
        if ((PixelX >= Obj_X_Pos1) && (PixelX < (Obj_X_Pos1 + Width)) &&
            (PixelY >= Obj_Y_Pos1) && (PixelY < (Obj_Y_Pos1 + Height))) begin
                is_obj = 1'b1;
                Obj_address = DistX1 + DistY1 * Width + 10 * Width * Height;
        end
        // Level
        else if ((PixelX >= Obj_X_Pos0) && (PixelX < (Obj_X_Pos0 + Width)) &&
            (PixelY >= Obj_Y_Pos0) && (PixelY < (Obj_Y_Pos0 + Height))) begin
                is_obj = 1'b1;
                Obj_address = DistX0 + DistY0 * Width + Game_Level * Width * Height;
        end

    end


endmodule