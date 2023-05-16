

/*  Player
*/

module  player ( input       Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [7:0]   keycode,
               input [8:0]   PixelX, PixelY,     
               output logic  is_obj,             // Whether current pixel belongs to ball or background
               output logic [12:0] Obj_address,
               output logic [8:0] Obj_X_Pos, Obj_Y_Pos,
               output logic [1:0] Obj_Direction
              );
    
    parameter [8:0] Obj_X_Center = 10'd160;  // Center position on the X axis
    parameter [8:0] Obj_Y_Center = 10'd120;  // Center position on the Y axis
    parameter [8:0] Height = 10'd20;         // Height of object
    parameter [8:0] Width = 10'd18;          // Width of object

    parameter [8:0] Obj_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [8:0] Obj_X_Max = 10'd319;     // Rightmost point on the X axis
    parameter [8:0] Obj_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [8:0] Obj_Y_Max = 10'd239;     // Bottommost point on the Y axis
    parameter [8:0] Obj_X_Step = 10'd2;      // Step size on the X axis
    parameter [8:0] Obj_Y_Step = 10'd2;      // Step size on the Y axis
    parameter [8:0] Obj_Size = 10'd40;

    
    logic [8:0] Obj_X_Motion, Obj_Y_Motion; // Current position, left upper point of object
    logic [8:0] Obj_X_Pos_in, Obj_X_Motion_in, Obj_Y_Pos_in, Obj_Y_Motion_in; // Next position
    logic [1:0] Obj_Direction_in;

    // Count how many steps object has walked in one direction
    logic [1:0] Obj_Up_Count, Obj_Down_Count, Obj_Left_Count, Obj_Right_Count;
    logic [1:0] Obj_Up_Count_in, Obj_Down_Count_in, Obj_Left_Count_in, Obj_Right_Count_in;
    

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

    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            // CenterX - Width / 2. CenterY - Height / 2
            Obj_X_Pos <= Obj_X_Center - Width[8:1];
            Obj_Y_Pos <= Obj_Y_Center - Height[8:1];
            Obj_X_Motion <= 10'd0;
            Obj_Y_Motion <= 10'd0;

            Obj_Direction <= 2'd0;
            Obj_Up_Count <= 2'd0;
            Obj_Down_Count <= 2'd0;
            Obj_Left_Count <= 2'd0;
            Obj_Right_Count <= 2'd0;
        end
        else
        begin
            Obj_X_Pos <= Obj_X_Pos_in;
            Obj_Y_Pos <= Obj_Y_Pos_in;
            Obj_X_Motion <= Obj_X_Motion_in;
            Obj_Y_Motion <= Obj_Y_Motion_in;

            Obj_Direction <= Obj_Direction_in;
            Obj_Up_Count <= Obj_Up_Count_in;
            Obj_Down_Count <= Obj_Down_Count_in;
            Obj_Left_Count <= Obj_Left_Count_in;
            Obj_Right_Count <= Obj_Right_Count_in;
        end
    end
    
    // Movement change of the object based on keycode
    always_comb
    begin
        // By default position, direction unchanged and no motion
        Obj_X_Pos_in = Obj_X_Pos;
        Obj_Y_Pos_in = Obj_Y_Pos;
        Obj_X_Motion_in = 10'd0;
        Obj_Y_Motion_in = 10'd0;

        Obj_Direction_in = Obj_Direction;
        Obj_Up_Count_in = Obj_Up_Count;
        Obj_Down_Count_in = Obj_Down_Count;
        Obj_Left_Count_in = Obj_Left_Count;
        Obj_Right_Count_in = Obj_Right_Count;
        
        // Update position and motion only at rising edge of frame clock
        if (frame2_clk_rising_edge)
        begin
            // Handle keypress
            case(keycode)
            10'd26: // Up W
                    begin
                    Obj_Y_Motion_in = (~(Obj_Y_Step) + 1'b1);
                    Obj_X_Motion_in = 1'b0;

                    Obj_Direction_in = 2'd2;
                    Obj_Up_Count_in = Obj_Up_Count + 1;
                    Obj_Down_Count_in = 2'd0;
                    Obj_Left_Count_in = 2'd0;
                    Obj_Right_Count_in = 2'd0;

                    if (Obj_Y_Pos <= Obj_Y_Min)
                        Obj_Y_Motion_in = 10'b0;
                    end
            10'd22: // Down S
                    begin
                    Obj_Y_Motion_in = Obj_Y_Step;
                    Obj_X_Motion_in = 1'b0;

                    Obj_Direction_in = 2'd0;
                    Obj_Up_Count_in = 2'd0;
                    Obj_Down_Count_in = Obj_Down_Count + 1;
                    Obj_Left_Count_in = 2'd0;
                    Obj_Right_Count_in = 2'd0;
                    
                    if (Obj_Y_Pos + Height >= Obj_Y_Max)
                        Obj_Y_Motion_in = 10'b0;
                    end
            10'd4:  // Left A
                    begin
                    Obj_X_Motion_in = (~(Obj_X_Step) + 1'b1);
                    Obj_Y_Motion_in = 1'b0;

                    Obj_Direction_in = 2'd1;
                    Obj_Up_Count_in = 2'd0;
                    Obj_Down_Count_in = 2'd0;
                    Obj_Left_Count_in = Obj_Left_Count + 1;
                    Obj_Right_Count_in = 2'd0;

                    if (Obj_X_Pos <= Obj_X_Min)
                        Obj_X_Motion_in = 1'b0;
                    end
            10'd7:  // Right D
                    begin
                    Obj_X_Motion_in = Obj_X_Step;
                    Obj_Y_Motion_in = 1'b0;

                    Obj_Direction_in = 2'd3;
                    Obj_Up_Count_in = 2'd0;
                    Obj_Down_Count_in = 2'd0;
                    Obj_Left_Count_in = 2'd0;
                    Obj_Right_Count_in = Obj_Right_Count + 1;

                    if (Obj_X_Pos + Width >= Obj_X_Max)
                        Obj_X_Motion_in = 1'b0;
                    end
            endcase

            // Update the ball's position with its motion, immediate change, use Motion_in instead of Motion
            Obj_X_Pos_in = Obj_X_Pos + Obj_X_Motion_in;
            Obj_Y_Pos_in = Obj_Y_Pos + Obj_Y_Motion_in;
        end
    end



    int DistX, DistY;
    assign DistX = PixelX - Obj_X_Pos;
    assign DistY = PixelY - Obj_Y_Pos;
    always_comb begin
        if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + Width)) &&
            (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height))) begin
            is_obj = 1'b1;

            // Obj_address = DistX + DistY * Width + Obj_Direction * Width * Height * 3;
            // Compute Object address based on its position, direction and walk step count
            case (Obj_Direction)
            // Front (Down)
            2'd0: begin
               if (~Obj_Down_Count[0]) 
                    Obj_address = DistX + DistY * Width;
                else
                    Obj_address = DistX + DistY * Width + Width * Height * (1 + Obj_Down_Count[1]);
            end
            // Left
            2'd1: begin
               if (~Obj_Left_Count[0]) 
                    Obj_address = DistX + DistY * Width + Width * Height * 3;
                else
                    Obj_address = DistX + DistY * Width + Width * Height * (4 + Obj_Left_Count[1]);
            end
            // Back (Up)
            2'd2: begin
               if (~Obj_Up_Count[0]) 
                    Obj_address = DistX + DistY * Width + Width * Height * 6;
                else
                    Obj_address = DistX + DistY * Width + Width * Height * (7 + Obj_Up_Count[1]);
            end
            // Right
            2'd3: begin
               if (~Obj_Right_Count[0]) 
                    Obj_address = DistX + DistY * Width + Width * Height * 9;
                else
                    Obj_address = DistX + DistY * Width + Width * Height * (10 + Obj_Right_Count[1]);
            end
            endcase


        end
        else begin
            is_obj = 1'b0;
            Obj_address = 11'b0;
        end
    end
    

    
endmodule
