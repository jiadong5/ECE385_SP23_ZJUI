

/*  Enemy
*/

`define W 26
`define S 22
`define A 4
`define D 7
`define G 10

module  enemy #(parameter id) ( input       Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             game_frame_clk_rising_edge,
               input logic [15:0]   keycode,
               input [8:0]   PixelX, PixelY,     
               input [8:0]   Player_X, Player_Y,
               input         Enemy_Is_Attacked,
               input  logic  is_alive,
               output logic  is_obj,             // Whether current pixel belongs to ball or background
               output logic [13:0] Obj_address,
               output logic [8:0] Obj_X_Pos, Obj_Y_Pos,
               output logic Enemy_Attack_Ready
              );
    
    // parameter [8:0] Obj_X_Center = 10'd100;  // Center position on the X axis
    // parameter [8:0] Obj_Y_Center = 10'd60;  // Center position on the Y axis
    parameter [8:0] Obj_X_Center = 10'd70 * (id + 1);
    parameter [8:0] Obj_Y_Center = 10'd40 * (id + 1);


    parameter [8:0] Height = 10'd26;         // Height of object
    parameter [8:0] Width = 10'd26;          // Width of object
    parameter [8:0] Player_Height = 10'd20;
    parameter [8:0] Player_Width = 10'd18;
    parameter [8:0] Attack_Distance = 10'd3;

    parameter [8:0] Obj_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [8:0] Obj_X_Max = 10'd319;     // Rightmost point on the X axis
    parameter [8:0] Obj_Y_Min = 10'd52;       // Topmost point on the Y axis
    parameter [8:0] Obj_Y_Max = 10'd205;     // Bottommost point on the Y axis
    parameter [8:0] Obj_X_Step = 10'd1;      // Step size on the X axis
    parameter [8:0] Obj_Y_Step = 10'd1;      // Step size on the Y axis

    
    logic [8:0] Obj_X_Motion, Obj_Y_Motion; // Current position, left upper point of object
    logic [8:0] Obj_X_Pos_in, Obj_X_Motion_in, Obj_Y_Pos_in, Obj_Y_Motion_in; // Next position
    logic [1:0] Obj_Direction_in, Obj_Direction;
    logic Enemy_Attack_Ready_in;

    logic Enemy_Player_On, Enemy_Player_On_in;

    logic [2:0] Enemy_Stay_Counter; // When enemy is attacked, it steps back and stay still for some time

    // Record time enemy should stay still
    always_ff @ (posedge game_frame_clk_rising_edge) begin
        if (Reset)
            Enemy_Stay_Counter <= 3'b0;
        else if (Enemy_Is_Attacked)
            Enemy_Stay_Counter <= 3'b1;
        else if (Enemy_Stay_Counter)
            Enemy_Stay_Counter <= Enemy_Stay_Counter + 1;
        else if (Enemy_Stay_Counter == 3'd6)
            Enemy_Stay_Counter <= 3'd0;
        else 
            Enemy_Stay_Counter <= Enemy_Stay_Counter;
    end

    // Count how many steps object has walked in one direction
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
            Enemy_Attack_Ready <= 1'b0;
            Enemy_Player_On <= 1'b0;
        end
        else
        begin
            Obj_X_Pos <= Obj_X_Pos_in;
            Obj_Y_Pos <= Obj_Y_Pos_in;
            Obj_X_Motion <= Obj_X_Motion_in;
            Obj_Y_Motion <= Obj_Y_Motion_in;
            Obj_Direction <= Obj_Direction_in;
            Enemy_Attack_Ready <= Enemy_Attack_Ready_in;
            Enemy_Player_On <= Enemy_Player_On_in;
        end
    end

    always_comb begin
        Enemy_Player_On_in = Enemy_Player_On;
        if((keycode[7:0] == `G || keycode[15:8] == `G) && (game_frame_clk_rising_edge) && (id == 0))
            Enemy_Player_On_in = ~Enemy_Player_On;
    end
    
    // Movement change of the object based on keycode
    always_comb
    begin
        // By default position, direction unchanged and no motion
        // This happens when overlap with player
        Obj_X_Pos_in = Obj_X_Pos;
        Obj_Y_Pos_in = Obj_Y_Pos;
        Obj_X_Motion_in = 10'd0;
        Obj_Y_Motion_in = 10'd0;
        Obj_Direction_in = Obj_Direction;
        Enemy_Attack_Ready_in = Enemy_Attack_Ready;

        if (~is_alive)
            Enemy_Attack_Ready_in = 1'b0;
        
        // Update position and motion only at rising edge of frame clock
        // Dead enemy stays at the same place
        if (game_frame_clk_rising_edge & is_alive)
        begin

            // Fall back when attacked
            if (Enemy_Is_Attacked) begin
                case (Obj_Direction)
                    // Front (Down)
                    2'd0: begin
                        Obj_Y_Motion_in = (~(Obj_Y_Step + 2'd2) + 1'b1);
                    end
                    // Left
                    2'd1: begin
                        Obj_X_Motion_in = Obj_X_Step + 2'd2;
                    end
                    // Back (up)
                    2'd2: begin
                        Obj_Y_Motion_in = Obj_Y_Step + 2'd2;
                    end
                    // Right
                    2'd3: begin
                        Obj_X_Motion_in = (~(Obj_X_Step + 2'd2) + 1'b1);
                    end
                endcase
            end
            else if (Enemy_Stay_Counter != 0 ) begin
                Obj_X_Motion_in = 1'b0;
                Obj_Y_Motion_in = 1'b0;
            end
            // Walk Right
            // If is at left of player and last step is vertical
            else if (((Obj_X_Pos + Width < Player_X) && (~Enemy_Player_On)) || ((Enemy_Player_On) && (keycode[7:0] == `D | keycode[15:8] == `D))) begin
                Obj_X_Motion_in = Obj_X_Step;
                Obj_Y_Motion_in = 1'b0;
                Obj_Direction_in = 2'd3;

                if (Obj_X_Pos + Width >= Obj_X_Max)
                    Obj_X_Motion_in = 1'b0;
            end
            // Walk Left
            else if (((Obj_X_Pos > Player_X + Player_Width) && (~Enemy_Player_On)) || ((Enemy_Player_On) && (keycode[7:0] == `A | keycode[15:8] == `A ) )) begin
                Obj_X_Motion_in = (~(Obj_X_Step) + 1'b1);
                Obj_Y_Motion_in = 1'b0;
                Obj_Direction_in = 2'd1;

                if (Obj_X_Pos <= Obj_X_Min)
                    Obj_X_Motion_in = 1'b0;
            end
            // Walk Down
            else if (((Obj_Y_Pos + Height < Player_Y) && (~Enemy_Player_On)) || ((Enemy_Player_On) && (keycode[7:0] == `S | keycode[15:8] == `S))) begin
                Obj_X_Motion_in = 1'b0;
                Obj_Y_Motion_in = Obj_Y_Step;
                Obj_Direction_in = 2'd0;
                    
                if (Obj_Y_Pos + Height >= Obj_Y_Max)
                    Obj_Y_Motion_in = 10'b0;
            end
            // Walk Up
            else if (((Obj_Y_Pos > Player_Y + Player_Width) && (~Enemy_Player_On)) || ((Enemy_Player_On) && (keycode[7:0] == `W | keycode[15:8] == `W))) begin
                Obj_X_Motion_in = 1'b0;
                Obj_Y_Motion_in = (~(Obj_Y_Step) + 1'b1);
                Obj_Direction_in = 2'd2;
                if (Obj_Y_Pos <= Obj_Y_Min)
                    Obj_Y_Motion_in = 10'b0;
            end

            // Update the ball's position with its motion, immediate change, use Motion_in instead of Motion
            Obj_X_Pos_in = Obj_X_Pos + Obj_X_Motion_in;
            Obj_Y_Pos_in = Obj_Y_Pos + Obj_Y_Motion_in;

            if ((Obj_X_Motion_in == 0) && (Obj_Y_Motion_in == 0) && (~Enemy_Is_Attacked) && (Enemy_Stay_Counter == 0) && (~Enemy_Player_On)) 
                Enemy_Attack_Ready_in = 1'b1;
            else if ((Enemy_Player_On) && (Obj_X_Pos + Width + Attack_Distance >= Player_X) && 
                    (Obj_X_Pos <= Player_X + Player_Width + Attack_Distance) && 
                    (Obj_Y_Pos + Height + Attack_Distance >= Player_Y) &&
                    (Obj_Y_Pos <= Player_Y + Player_Height + Attack_Distance))
                Enemy_Attack_Ready_in = 1'b1;
            else
                Enemy_Attack_Ready_in = 1'b0;
        end
    end

    enemy_control enemy_control_inst(
        // Input
        .*,
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
            (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height)) && (is_alive)) begin
            is_obj = 1'b1;

            if(Enemy_Is_Attacked || (Enemy_Stay_Counter != 0))
                Obj_address = DistX + DistY * Width + Width * Height * (4 * Obj_Direction + 3);
            // Compute Object address based on its position, direction and walk step count
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
