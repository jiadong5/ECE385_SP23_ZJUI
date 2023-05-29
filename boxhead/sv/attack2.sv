

`define UP 82
`define DOWN 81
`define LEFT 80
`define RIGHT 79
`define Z 29
`define X 27
`define SPACE 44

module  attack2 ( input       Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             game_frame_clk_rising_edge,
               input [15:0] keycode,
               input [8:0] Player_X, Player_Y,
               input [1:0] Player_Direction,
               input [8:0]   PixelX, PixelY,     
               input logic One_Enemy_Is_Attacked2,
               input [3:0] Game_Level,

               output logic  is_obj,             // Whether current pixel belongs to ball or background
                             Obj_On,
               output logic [10:0] Obj_address,
               output logic [8:0] Obj_X_Pos, Obj_Y_Pos
              );
    

    parameter [8:0] Size = 10'd25;         // Length of Short side of Obj
    parameter [8:0] Long = 10'd80;          // Length of Long side of Obj
    parameter [8:0] Obj_X_Step = 9'd5;
    parameter [8:0] Obj_Y_Step = 9'd5;

    logic [8:0] Obj_X_Motion, Obj_X_Motion_in;
    logic [8:0] Obj_Y_Motion, Obj_Y_Motion_in;
    logic [8:0] Obj_X_Pos_in, Obj_Y_Pos_in;
    logic [8:0] Obj_Step_Count, Obj_Step_Count_in;
    
    logic Obj_On_in;        // If the object displays or not

    always_ff @ (posedge Clk) begin
        if(Reset) begin
            Obj_X_Pos <= 9'd0;
            Obj_Y_Pos <= 9'd0;
            Obj_X_Motion <= 10'd0;
            Obj_Y_Motion <= 10'd0;
            Obj_Step_Count <= 9'd0;
        end
        else begin
            Obj_X_Pos <= Obj_X_Pos_in;
            Obj_Y_Pos <= Obj_Y_Pos_in;
            Obj_X_Motion <= Obj_X_Motion_in;
            Obj_Y_Motion <= Obj_Y_Motion_in;
            Obj_Step_Count <= Obj_Step_Count_in;
        end
    end
    // Assign position based on player direction
    always_comb begin
        Obj_X_Pos_in = Obj_X_Pos;
        Obj_Y_Pos_in = Obj_Y_Pos;
        Obj_X_Motion_in = Obj_X_Motion;
        Obj_Y_Motion_in = Obj_Y_Motion;
        Obj_Step_Count_in = Obj_Step_Count;
        if ((game_frame_clk_rising_edge & ~Obj_On)) begin
            case (Player_Direction)
                // Front (Down)
                2'd0: begin
                    Obj_X_Pos_in = Player_X - 10'd2; 
                    Obj_Y_Pos_in = Player_Y + 10'd20;
                    Obj_X_Motion_in = 9'd0;
                    Obj_Y_Motion_in = Obj_Y_Step;
                end
                // Left
                2'd1: begin
                    Obj_X_Pos_in = Player_X;
                    Obj_Y_Pos_in = Player_Y + 10'd2;
                    Obj_X_Motion_in = (~(Obj_X_Step) + 1);
                    Obj_Y_Motion_in = 9'd0;
                end
                // Back (up)
                2'd2: begin
                    Obj_X_Pos_in = Player_X + 10'd1;
                    Obj_Y_Pos_in = Player_Y;
                    Obj_X_Motion_in = 9'd0;
                    Obj_Y_Motion_in = (~(Obj_Y_Step) + 1);
                end
                // Right
                2'd3: begin
                    Obj_X_Pos_in = Player_X + 10'd18;
                    Obj_Y_Pos_in = Player_Y + 10'd2;
                    Obj_X_Motion_in = Obj_X_Step;
                    Obj_Y_Motion_in = 9'd0;
                end
            endcase
        end
        else if (game_frame_clk_rising_edge & Obj_On) begin
            Obj_X_Pos_in = Obj_X_Pos + Obj_X_Motion;
            Obj_Y_Pos_in = Obj_Y_Pos + Obj_Y_Motion;
            if (Obj_Step_Count == 20)
                Obj_Step_Count_in = 9'd0;
            else if (One_Enemy_Is_Attacked2)
                Obj_Step_Count_in = 9'd0;
            else
                Obj_Step_Count_in = Obj_Step_Count + 1'b1;
        end

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
        Obj_On_in = Obj_On;
        // Press space
        if (((keycode[7:0] == `X) | (keycode[15:8] == `X)) && (~Obj_On))
            Obj_On_in = 1'b1;
        else if (Obj_Step_Count == 20) 
            Obj_On_in = 1'b0;
        else if (One_Enemy_Is_Attacked2)
            Obj_On_in = 1'b0;
    end


    // Draw
    int DistX, DistY;
    always_comb begin
        DistX = PixelX - Obj_X_Pos;
        DistY = PixelY - Obj_Y_Pos;
        is_obj = 1'b0;
        Obj_address = 11'b0;
        if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + Size)) &&
            (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Size)) &&
            (Obj_On == 1'b1)) begin
                is_obj = 1'b1;
                Obj_address =  DistX + DistY * Size ;
        end
    end

    
endmodule
