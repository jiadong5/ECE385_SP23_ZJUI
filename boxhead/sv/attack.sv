

/*  Player
*/

module  attack ( input       Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [7:0] keycode,
               input [8:0] Player_X, Player_Y,
               input [1:0] Player_Direction,
               input [8:0]   PixelX, PixelY,     

               output logic  is_obj,             // Whether current pixel belongs to ball or background
                             Obj_On,
               output logic [7:0] Obj_address,
               output logic [8:0] Obj_X_Pos, Obj_Y_Pos
              );
    
    parameter [8:0] Height = 10'd16;         // Height of object (unit)
    parameter [8:0] Width = 10'd16;          // Width of object (unit)
    parameter [8:0] TotalHeight = 10'd80;
    parameter [8:0] TotalWidth = 10'd80;
    
    logic Obj_On_in;        // If the object displays or not


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

    always_comb begin
        case (Player_Direction)
            // Front (Down)
            2'd0: begin
                Obj_X_Pos = Player_X; 
                Obj_Y_Pos = Player_Y + 10'd16;
            end
            // Left
            2'd1: begin
                Obj_X_Pos = Player_X;
                Obj_Y_Pos = Player_Y;
            end
            // Back (up)
            2'd2: begin
                Obj_X_Pos = Player_X;
                Obj_Y_Pos = Player_Y;
            end
            // Right
            2'd3: begin
                Obj_X_Pos = Player_X + 10'd16;
                Obj_Y_Pos = Player_Y;
            end
        endcase

    end

    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
            Obj_On <= 1'b0;
        else
            Obj_On <= Obj_On_in;
    end

    // If Object is displayed based on keycode
    always_comb
    begin
        Obj_On_in = 1'b0;
        // Update position and motion only at rising edge of frame clock
        // Don't know why but frame clk is not required
        // if (frame2_clk_rising_edge)
        // begin
            // Press space
            if (keycode == 10'd44)
                Obj_On_in = 1'b1;
        // end
    end

    int DistX, DistY;
    always_comb begin

        DistX = PixelX - Obj_X_Pos;
        DistY = PixelY - Obj_Y_Pos;
        is_obj = 1'b0;
        Obj_address = 11'b0;
        case (Player_Direction)
            // Front (Down)
            2'd0: begin
                if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + Width)) &&
                    (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + TotalHeight)) &&
                    (Obj_On == 1'b1)) begin
                        is_obj = 1'b1;
                        Obj_address =  DistX + DistY[3:0] * Width;
                    end
            end
            // Left
            2'd1: begin
                // 
                if ((PixelX + TotalWidth >= Obj_X_Pos) && (PixelX < (Obj_X_Pos)) &&
                    (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height)) &&
                    (Obj_On == 1'b1)) begin
                        is_obj = 1'b1;
                        DistX = Obj_X_Pos - PixelX;
                        Obj_address =  DistX[3:0] + DistY * Width;
                    end
            end
            // Back (up)
            2'd2: begin
                if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + Width)) &&
                    (PixelY + TotalHeight >= Obj_Y_Pos) && (PixelY < Obj_Y_Pos) &&
                    (Obj_On == 1'b1)) begin
                        is_obj = 1'b1;
                        DistY = Obj_Y_Pos - PixelY;
                        Obj_address =  DistX + DistY[3:0] * Width;
                    end
            end
            // Right
            2'd3: begin
                if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + TotalWidth)) &&
                    (PixelY  >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height)) &&
                    (Obj_On == 1'b1)) begin
                        is_obj = 1'b1;
                        Obj_address =  DistX[3:0] + DistY * Width;
                    end
            end
        endcase

    end
    

    
endmodule
