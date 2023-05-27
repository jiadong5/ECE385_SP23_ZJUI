


module blood (
                input Clk,
                input [9:0] Player_Blood,
                input [8:0] PixelX, PixelY,
                
                output is_obj,
                output [4:0] Obj_Index    // Index of color palette
);

    parameter [8:0] Width = 50;
    parameter [8:0] Height = 20;

    logic [8:0] Obj_X_Pos, Obj_Y_Pos; // Position of left digit
    logic [8:0] Blood_Width;

    assign Obj_X_Pos = 80;
    assign Obj_Y_Pos = 5;
    assign Blood_Width = Player_Blood[9:1];


    // Draw
    always_comb begin
        is_obj = 1'b0;
        Obj_Index = 5'd0;

        // if ((PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height)) ) begin
        //     is_obj = 1'b1;
        //     Obj_Index = 5'd15;
        // end

        if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + Blood_Width)) &&
            (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height))) begin
                is_obj = 1'b1;
                Obj_Index = 5'd16; // Green
        end
    end



endmodule