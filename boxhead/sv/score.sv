

module score (
                input Clk,
                input [7:0] Total_Score,
                input [8:0] PixelX, PixelY,
                
                output is_obj,
                output [14:0] Obj_address
);

    parameter [8:0] Width = 40;
    parameter [8:0] Height = 46;

    logic [8:0] Obj_X_Pos1, Obj_Y_Pos1; // Position of left digit
    logic [8:0] Obj_X_Pos0, Obj_Y_Pos0; // Position of right digit
    logic [7:0] Ten_Digit, Unit_Digit;

    assign Obj_X_Pos1 = 200;
    assign Obj_Y_Pos1 = 5;
    assign Obj_X_Pos0 = Obj_X_Pos1 + Width + 1;
    assign Obj_Y_Pos0 = Obj_Y_Pos1;
    assign Ten_Digit = Total_Score / 10;
    assign Unit_Digit = Total_Score % 10;

    int DistX1, DistY1;
    int DistX0, DistY0;
    assign DistX1 = PixelX - Obj_X_Pos1;
    assign DistY1 = PixelY - Obj_Y_Pos1;
    assign DistX0 = PixelX - Obj_X_Pos0;
    assign DistY0 = PixelY - Obj_Y_Pos0;
    always_comb begin
        is_obj = 1'b0;
        Obj_address = 15'b0;

        // Tenth digit
        if ((PixelX >= Obj_X_Pos1) && (PixelX < (Obj_X_Pos1 + Width)) &&
            (PixelY >= Obj_Y_Pos1) && (PixelY < (Obj_Y_Pos1 + Height))) begin
                is_obj = 1'b1;
                Obj_address = DistX1 + DistY1 * Width + Ten_Digit * Width * Height;
        end
        // Unit digit
        else if ((PixelX >= Obj_X_Pos0) && (PixelX < (Obj_X_Pos0 + Width)) &&
            (PixelY >= Obj_Y_Pos0) && (PixelY < (Obj_Y_Pos0 + Height))) begin
                is_obj = 1'b1;
                Obj_address = DistX0 + DistY0 * Width + Unit_Digit * Width * Height;
        end

    end


endmodule