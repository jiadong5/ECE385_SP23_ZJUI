


module blood (
                input Clk,
                input [9:0] Player_Blood,
                input [8:0] PixelX, PixelY,
                
                output is_obj,
                output [4:0] Obj_Index,    // Index of color palette
                output [8:0] Obj_address
);

    parameter [8:0] Width = 13;
    parameter [8:0] Height = 13;
    parameter [8:0] TotalWidth = Width * 10;

    logic [8:0] Obj_X_Pos, Obj_Y_Pos; // Position of left digit

    assign Obj_X_Pos = 40;
    assign Obj_Y_Pos = 16;

    int DistX,DistY;
    assign DistX = PixelX - Obj_X_Pos;
    assign DistY = PixelY - Obj_Y_Pos;

    // Draw
    always_comb begin
        is_obj = 1'b0;
        Obj_address = 0;

        // if ((PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height)) ) begin
        //     is_obj = 1'b1;
        //     Obj_Index = 5'd15;
        // end

        if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + TotalWidth)) &&
            (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height))) begin
                is_obj = 1'b1;
                if (DistX <= (Player_Blood / 10) * Width ) begin
                    Obj_address = (DistX % 13) + DistY * Width;
                end
                else begin
                    Obj_address = (DistX % 13) + DistY * Width + Width * Height;
                end
        end
    end



endmodule
