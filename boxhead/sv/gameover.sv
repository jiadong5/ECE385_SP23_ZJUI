

module gameover(
    input Clk,
          Reset,
          Game_Over_On,
    input [8:0] PixelX,PixelY,

    output logic is_obj,
    output logic [14:0] Obj_address
);

    parameter [8:0] Height = 9'd31;
    parameter [8:0] Width = 9'd203;
    parameter [8:0] Obj_X_Center = 9'd160;
    parameter [8:0] Obj_Y_Center = 9'd100;


    logic[8:0] Obj_X_Pos, Obj_Y_Pos;

    assign Obj_X_Pos = Obj_X_Center - Width[8:1];
    assign Obj_Y_Pos = Obj_Y_Center - Height[8:1];

    int DistX, DistY;
    assign DistX = PixelX - Obj_X_Pos;
    assign DistY = PixelY - Obj_Y_Pos;
    always_comb begin
        is_obj = 1'b0;
        Obj_address = 15'b0;
        if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + Width)) &&
            (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height)) &&
            (Game_Over_On)) begin
            is_obj = 1'b1;
            Obj_address = DistX + DistY * Width;
        end

    end

endmodule
