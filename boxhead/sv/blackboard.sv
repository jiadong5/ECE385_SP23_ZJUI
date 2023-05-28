


module  blackboard ( input       Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
               input [8:0]   PixelX, PixelY,     

               output logic  is_obj,             // Whether current pixel belongs to ball or background
               output logic [11:0] Obj_address
              );
    

    parameter [8:0] Width = 10'd120;         // Length of Short side of Obj
    parameter [8:0] Height = 10'd30;          // Length of Long side of Obj
    

    logic [8:0] Obj_X_Pos = 10'd192;
    logic [8:0] Obj_Y_Pos = 10'd21;



    int DistX, DistY;
    assign DistX = PixelX - Obj_X_Pos;
    assign DistY = PixelY - Obj_Y_Pos;
    always_comb begin
        is_obj = 1'b0;
        Obj_address = 11'b0;
        if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + Width)) &&
            (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height))) begin
                is_obj = 1'b1;
                Obj_address = DistX + DistY * Width;
        end 
    end

endmodule