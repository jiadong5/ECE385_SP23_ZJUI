
module gamestart(
    input Clk,
          Reset,
    input [7:0] keycode,
    input [8:0] PixelX,PixelY,

    output Game_Start_On,
    output is_obj,
    output logic [17:0] Obj_address
);

    // initial begin
    //     Game_Start_On = 1'b1;
    // end

    parameter [8:0] Height = 9'd30;
    parameter [8:0] Width = 9'd180;
    parameter [8:0] Obj_X_Center = 9'd160;
    parameter [8:0] Obj_Y_Center = 9'd80;

    logic[8:0] Obj_X_Pos, Obj_Y_Pos;
    logic Game_Start_On_in;

    assign Obj_X_Pos = Obj_X_Center - Width[8:1];
    assign Obj_Y_Pos = Obj_Y_Center - Height[8:1];

    // Update registers
    always_ff @ (posedge Clk) begin
        if(Reset) 
            Game_Start_On <= 1'b1;
        else
            Game_Start_On <= Game_Start_On_in;
    end

    always_comb begin
        Game_Start_On_in <= Game_Start_On;
        if ((keycode == 10'd22) && (Game_Start_On)) begin
            Game_Start_On_in <= 1'b0;
        end
    end

    // Draw Start title
    int DistX, DistY;
    assign DistX = PixelX - Obj_X_Pos;
    assign DistY = PixelY - Obj_Y_Pos;
    always_comb begin
        is_obj = 1'b0;
        Obj_address = 15'b0;
        if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + Width)) &&
            (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height)) &&
            (Game_Start_On)) begin
            is_obj = 1'b1;
            Obj_address = DistX + DistY * Width;
        end

    end

endmodule
