

module  ball ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [7:0]   keycode,
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
               input [8:0]   PixelX, PixelY,     
               output logic  is_player,             // Whether current pixel belongs to ball or background
               output logic [11:0] player_address
              );
    
    parameter [9:0] Ball_X_Center = 10'd160;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center = 10'd120;  // Center position on the Y axis
    
    parameter [9:0] Ball_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max = 10'd479;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max = 10'd239;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step = 10'd1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step = 10'd1;      // Step size on the Y axis
    parameter [9:0] Ball_Size = 10'd40;

    parameter [9:0] Height = 10'd64;
    parameter [9:0] Width = 10'd40;
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion; // Current position
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in; // Next position

    
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end

    // Update registers
    // always_ff @ (posedge Clk)
    // begin
    //     if (Reset)
    //     begin
    //         Ball_X_Pos <= Ball_X_Center;
    //         Ball_Y_Pos <= Ball_Y_Center;
    //         Ball_X_Motion <= 10'd0;
    //         Ball_Y_Motion <= 10'd0;
    //     end
    //     else
    //     begin
    //         Ball_X_Pos <= Ball_X_Pos_in;
    //         Ball_Y_Pos <= Ball_Y_Pos_in;
    //         Ball_X_Motion <= Ball_X_Motion_in;
    //         Ball_Y_Motion <= Ball_Y_Motion_in;
    //     end
    // end
    // //////// Do not modify the always_ff blocks. ////////
    
    // // You need to modify always_comb block.
    // always_comb
    // begin
    //     // By default, keep motion and position unchanged
    //     Ball_X_Pos_in = Ball_X_Pos;
    //     Ball_Y_Pos_in = Ball_Y_Pos;
    //     Ball_X_Motion_in = Ball_X_Motion;
    //     Ball_Y_Motion_in = Ball_Y_Motion;
        
    //     // Update position and motion only at rising edge of frame clock
    //     if (frame_clk_rising_edge)
    //     begin
    //         // Handle keypress
    //         case(keycode)
    //         10'd26: // Up W
    //                 begin
    //                 Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
    //                 Ball_X_Motion_in = 1'b0;
    //                 end
    //         10'd22: // Down S
    //                 begin
    //                 Ball_Y_Motion_in = Ball_Y_Step;
    //                 Ball_X_Motion_in = 1'b0;
    //                 end
    //         10'd4:  // Left A
    //                 begin
    //                 Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
    //                 Ball_Y_Motion_in = 1'b0;
    //                 end
    //         10'd7:  // Right D
    //                 begin
    //                 Ball_X_Motion_in = Ball_X_Step;
    //                 Ball_Y_Motion_in = 1'b0;
    //                 end
    //         endcase

    //         // Be careful when using comparators with "logic" datatype because compiler treats 
    //         //   both sides of the operator as UNSIGNED numbers.
    //         // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
    //         // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
    //         if( Ball_Y_Pos + Ball_Size >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
    //             Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
    //         else if ( Ball_Y_Pos <= Ball_Y_Min + Ball_Size )  // Ball is at the top edge, BOUNCE!
    //             Ball_Y_Motion_in = Ball_Y_Step;
    //         if ( Ball_X_Pos + Ball_Size >= Ball_X_Max) // Ball is at the right edge, BOUNCE!
    //             Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
    //         else if ( Ball_X_Pos <= Ball_X_Min + Ball_Size ) // Ball is at the left edge, BOUNCE!
    //             Ball_X_Motion_in = Ball_X_Step;

    //         // Update the ball's position with its motion
    //         Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
    //         Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
    //     end
    // end


    assign Ball_X_Pos = Ball_X_Center;
    assign Ball_Y_Pos = Ball_Y_Center;

    // assign Xdist = PixelX - Ball_X_Pos;
    // assign Ydist = PixelY - Ball_Y_Pos;
    
    // // Compute whether the pixel corresponds to ball or background
    // always_comb begin
    //     // player_address = 11'b0;
    //     // if ( 10'd0 <= Xdist <= (Width - 1) && 10'd0 <= Ydist <= (Height - 1) )
    //     // if ((9'd160 <= PixelX <= 9'd200) && (9'd120 <= PixelY <= 9'd184))
    //     // if ((9'd160 <= PixelX <= 9'd200))
    //         is_player = 1'b0;
    // end

    int DistX, DistY, Size;
    assign DistX = PixelX - Ball_X_Pos;
    assign DistY = PixelY - Ball_Y_Pos;
    always_comb begin
        if ((PixelX >= Ball_X_Pos) && (PixelX <= (Ball_X_Pos + Width)) &&
            (PixelY >= Ball_Y_Pos) && (PixelY <= (Ball_Y_Pos + Height))) begin
            is_player = 1'b1;
            player_address = DistX + DistY * 40;
        end
        else begin
            is_player = 1'b0;
            player_address = 11'b0;
        end
    end
    

    
endmodule
