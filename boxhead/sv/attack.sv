

/*  Player
*/

module  attack ( input       Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [7:0] keycode,
               input [9:0] Player_X, Player_Y,
               input [1:0] Player_Direction,
               input [8:0]   PixelX, PixelY,     

               output logic  is_obj,             // Whether current pixel belongs to ball or background
               output logic [7:0] Obj_address
              );
    
    parameter [9:0] Height = 10'd16;         // Height of object
    parameter [9:0] Width = 10'd16;          // Width of object
    
    logic [9:0] Obj_X_Pos, Obj_Y_Pos;
    logic Obj_On, Obj_On_in;        // If the object displays or not


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

    assign Obj_X_Pos = Player_X + 10'd5; 
    assign Obj_Y_Pos = Player_Y + 10'd40;

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
    assign DistX = PixelX - Obj_X_Pos;
    assign DistY = PixelY - Obj_Y_Pos;
    always_comb begin
        if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + Width)) &&
            (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height)) &&
            (Obj_On == 1'b1)) begin
            is_obj = 1'b1;
            Obj_address =  DistX + DistY * Width;
        end
        else begin
            is_obj = 1'b0;
            Obj_address = 11'b0;
        end
    end
    

    
endmodule
