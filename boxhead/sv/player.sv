

/*  Player
*/

`define UP 82
`define DOWN 81
`define LEFT 80
`define RIGHT 79
`define Z 29
`define X 27
`define SPACE 44

module  player ( input       Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             game_frame_clk_rising_edge,
               input [15:0]   keycode,
               input [8:0]   PixelX, PixelY,     
               input  logic Attack_On,
               output logic  is_obj,             // Whether current pixel belongs to ball or background
               output logic [12:0] Obj_address,
               output logic [8:0] Obj_X_Pos, Obj_Y_Pos,
               output logic [1:0] Obj_Direction
              );
    
    parameter [8:0] Obj_X_Center = 10'd160;  // Center position on the X axis
    parameter [8:0] Obj_Y_Center = 10'd120;  // Center position on the Y axis
    parameter [8:0] Height = 10'd20;         // Height of object
    parameter [8:0] Width = 10'd18;          // Width of object

    parameter [8:0] Obj_X_Min = 10'd1;       // Leftmost point on the X axis
    parameter [8:0] Obj_X_Max = 10'd319;     // Rightmost point on the X axis
    parameter [8:0] Obj_Y_Min = 10'd52;       // Topmost point on the Y axis
    parameter [8:0] Obj_Y_Max = 10'd205;     // Bottommost point on the Y axis
    parameter [8:0] Obj_X_Step = 10'd3;      // Step size on the X axis
    parameter [8:0] Obj_Y_Step = 10'd3;      // Step size on the Y axis

    
    logic [8:0] Obj_X_Motion, Obj_Y_Motion; // Current position, left upper point of object
    logic [8:0] Obj_X_Pos_in, Obj_X_Motion_in, Obj_Y_Pos_in, Obj_Y_Motion_in; // Next position
    logic [1:0] Obj_Direction_in;

    // Count how many steps object has walked in one direction
    // logic [1:0] Obj_Up_Count, Obj_Down_Count, Obj_Left_Count, Obj_Right_Count;
    // logic [1:0] Obj_Up_Count_in, Obj_Down_Count_in, Obj_Left_Count_in, Obj_Right_Count_in;
    logic [1:0] Obj_Step_Count;
    
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
        end
        else
        begin
            Obj_X_Pos <= Obj_X_Pos_in;
            Obj_Y_Pos <= Obj_Y_Pos_in;
            Obj_X_Motion <= Obj_X_Motion_in;
            Obj_Y_Motion <= Obj_Y_Motion_in;
            Obj_Direction <= Obj_Direction_in;
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
        
        // Update position and motion only at rising edge of frame clock
        if (game_frame_clk_rising_edge)
        begin
            // Handle keypress
            if (keycode[7:0] == `UP | keycode[15:8] == `UP)
                    begin
                    Obj_Y_Motion_in = (~(Obj_Y_Step) + 1'b1);
                    Obj_X_Motion_in = 1'b0;
                    Obj_Direction_in = 2'd2;

                    if (Obj_Y_Pos <= Obj_Y_Min)
                        Obj_Y_Motion_in = 10'b0;
                    end
            if (keycode[7:0] == `DOWN | keycode[15:8] == `DOWN)
                    begin
                    Obj_Y_Motion_in = Obj_Y_Step;
                    Obj_X_Motion_in = 1'b0;
                    Obj_Direction_in = 2'd0;
                    
                    if (Obj_Y_Pos + Height >= Obj_Y_Max)
                        Obj_Y_Motion_in = 10'b0;
                    end
            if (keycode[7:0] == `LEFT | keycode[15:8] == `LEFT)
                    begin
                    Obj_X_Motion_in = (~(Obj_X_Step) + 1'b1);
                    Obj_Y_Motion_in = 1'b0;
                    Obj_Direction_in = 2'd1;

                    if (Obj_X_Pos <= Obj_X_Min)
                        Obj_X_Motion_in = 1'b0;
                    end
            if (keycode[7:0] == `RIGHT | keycode[15:8] == `RIGHT)
                    begin
                    Obj_X_Motion_in = Obj_X_Step;
                    Obj_Y_Motion_in = 1'b0;
                    Obj_Direction_in = 2'd3;

                    if (Obj_X_Pos + Width >= Obj_X_Max)
                        Obj_X_Motion_in = 1'b0;
                    end

            // Update the ball's position with its motion, immediate change, use Motion_in instead of Motion
            Obj_X_Pos_in = Obj_X_Pos + Obj_X_Motion_in;
            Obj_Y_Pos_in = Obj_Y_Pos + Obj_Y_Motion_in;
        end
    end

    player_control player_control_Inst(
        // Input
        .Clk(Clk),
        .frame_clk(game_frame_clk_rising_edge),
        .Reset(Reset),
        .Obj_X_Motion(Obj_X_Motion_in),
        .Obj_Y_Motion(Obj_Y_Motion_in),
        // Output
        .Obj_Step_Count(Obj_Step_Count)
    );



    int DistX, DistY;
    assign DistX = PixelX - Obj_X_Pos;
    assign DistY = PixelY - Obj_Y_Pos;
    always_comb begin
        if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + Width)) &&
            (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height))) begin
            is_obj = 1'b1;

            // Compute Object address based on its position, direction and walk step count
            if (Attack_On)
                Obj_address = DistX + DistY * Width + Width * Height * (4 * Obj_Direction + 3);
            else if (~Obj_Step_Count[0])
                Obj_address = DistX + DistY * Width + Width * Height * (4 * Obj_Direction);
            else
                Obj_address = DistX + DistY * Width + Width * Height * (4 * Obj_Direction + 1 + Obj_Step_Count[1]);
        end
        else begin
            is_obj = 1'b0;
            Obj_address = 11'b0;
        end
    end
    

    
endmodule
