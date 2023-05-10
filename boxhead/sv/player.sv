

/*  Player
*/

module  player ( input       Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [7:0]   keycode,
               input [8:0]   PixelX, PixelY,     
               output logic  is_player,             // Whether current pixel belongs to ball or background
               output logic [11:0] player_address
              );
    
    parameter [9:0] Obj_X_Center = 10'd160;  // Center position on the X axis
    parameter [9:0] Obj_Y_Center = 10'd120;  // Center position on the Y axis
    parameter [9:0] Height = 10'd64;
    parameter [9:0] Width = 10'd40;
    
    parameter [9:0] Obj_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] Obj_X_Max = 10'd479;     // Rightmost point on the X axis
    parameter [9:0] Obj_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Obj_Y_Max = 10'd239;     // Bottommost point on the Y axis
    parameter [9:0] Obj_X_Step = 10'd1;      // Step size on the X axis
    parameter [9:0] Obj_Y_Step = 10'd1;      // Step size on the Y axis
    parameter [9:0] Obj_Size = 10'd40;

    
    logic [9:0] Obj_X_Pos, Obj_X_Motion, Obj_Y_Pos, Obj_Y_Motion; // Current position
    logic [9:0] Obj_X_Pos_in, Obj_X_Motion_in, Obj_Y_Pos_in, Obj_Y_Motion_in; // Next position

    

    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end

    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            // CenterX - Width / 2. CenterY - Height / 2
            Obj_X_Pos <= Obj_X_Center - Width[9:1];
            Obj_Y_Pos <= Obj_Y_Center - Height[9:1];
            Obj_X_Motion <= 10'd0;
            Obj_Y_Motion <= 10'd0;
        end
        else
        begin
            Obj_X_Pos <= Obj_X_Pos_in;
            Obj_Y_Pos <= Obj_Y_Pos_in;
            Obj_X_Motion <= Obj_X_Motion_in;
            Obj_Y_Motion <= Obj_Y_Motion_in;
        end
    end
    
    // Movement change of the object based on keycode
    always_comb
    begin
        // By default, keep motion and position unchanged
        Obj_X_Pos_in = Obj_X_Pos;
        Obj_Y_Pos_in = Obj_Y_Pos;
        Obj_X_Motion_in = Obj_X_Motion;
        Obj_Y_Motion_in = Obj_Y_Motion;
        
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
            // Handle keypress
            case(keycode)
            10'd26: // Up W
                    begin
                    Obj_Y_Motion_in = (~(Obj_Y_Step) + 1'b1);
                    Obj_X_Motion_in = 1'b0;
                    end
            10'd22: // Down S
                    begin
                    Obj_Y_Motion_in = Obj_Y_Step;
                    Obj_X_Motion_in = 1'b0;
                    end
            10'd4:  // Left A
                    begin
                    Obj_X_Motion_in = (~(Obj_X_Step) + 1'b1);
                    Obj_Y_Motion_in = 1'b0;
                    end
            10'd7:  // Right D
                    begin
                    Obj_X_Motion_in = Obj_X_Step;
                    Obj_Y_Motion_in = 1'b0;
                    end
            endcase

    //         // Be careful when using comparators with "logic" datatype because compiler treats 
    //         //   both sides of the operator as UNSIGNED numbers.
    //         // e.g. Obj_Y_Pos - Obj_Size <= Obj_Y_Min 
    //         // If Obj_Y_Pos is 0, then Obj_Y_Pos - Obj_Size will not be -4, but rather a large positive number.
    //         if( Obj_Y_Pos + Obj_Size >= Obj_Y_Max )  // Obj is at the bottom edge, BOUNCE!
    //             Obj_Y_Motion_in = (~(Obj_Y_Step) + 1'b1);  // 2's complement.  
    //         else if ( Obj_Y_Pos <= Obj_Y_Min + Obj_Size )  // Obj is at the top edge, BOUNCE!
    //             Obj_Y_Motion_in = Obj_Y_Step;
    //         if ( Obj_X_Pos + Obj_Size >= Obj_X_Max) // Obj is at the right edge, BOUNCE!
    //             Obj_X_Motion_in = (~(Obj_X_Step) + 1'b1);
    //         else if ( Obj_X_Pos <= Obj_X_Min + Obj_Size ) // Obj is at the left edge, BOUNCE!
    //             Obj_X_Motion_in = Obj_X_Step;

            // Update the ball's position with its motion
            Obj_X_Pos_in = Obj_X_Pos + Obj_X_Motion;
            Obj_Y_Pos_in = Obj_Y_Pos + Obj_Y_Motion;
        end
    end



    int DistX, DistY;
    assign DistX = PixelX - Obj_X_Pos;
    assign DistY = PixelY - Obj_Y_Pos;
    always_comb begin
        if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + Width)) &&
            (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height))) begin
            is_player = 1'b1;
            player_address = DistX + DistY * Width;
        end
        else begin
            is_player = 1'b0;
            player_address = 11'b0;
        end
    end
    

    
endmodule
