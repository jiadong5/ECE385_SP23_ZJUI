

/*  Player
*/

module  attack ( input       Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             game_frame_clk_rising_edge,
               input [7:0] keycode,
               input [8:0] Player_X, Player_Y,
               input [1:0] Player_Direction,
               input [8:0]   PixelX, PixelY,     

               output logic  is_obj,             // Whether current pixel belongs to ball or background
                             Obj_On,
               output logic [8:0] Obj_address,
               output logic [8:0] Obj_X_Pos, Obj_Y_Pos
              );
    

    parameter [8:0] Short = 10'd16;         // Length of Short side of Obj
    parameter [8:0] Long = 10'd80;          // Length of Long side of Obj
    
    logic Obj_On_in;        // If the object displays or not
    logic[1:0] attack_counter;       // Used to transform between two forms of attack
    logic attack_form;

    logic[1:0] attack_interval_counter; // Used to set attack interval

    always_ff @ (posedge game_frame_clk_rising_edge) begin
        if(Reset) begin
            attack_counter <= 1'b0;
            attack_interval_counter <= 1'b0;
        end
        else begin
            attack_counter <= attack_counter + 1'b1;
            attack_interval_counter <= attack_interval_counter + 1'b1;
        end
    end

    always_comb begin
        if(attack_counter <= 2'd1)
            attack_form = 1'b1;
        else
            attack_form = 1'b0;
    end



    
    // Assign position based on player direction
    always_comb begin
        case (Player_Direction)
            // Front (Down)
            2'd0: begin
                Obj_X_Pos = Player_X - 10'd2; 
                Obj_Y_Pos = Player_Y + 10'd20;
            end
            // Left
            2'd1: begin
                Obj_X_Pos = Player_X;
                Obj_Y_Pos = Player_Y + 10'd2;
            end
            // Back (up)
            2'd2: begin
                Obj_X_Pos = Player_X + 10'd1;
                Obj_Y_Pos = Player_Y;
            end
            // Right
            2'd3: begin
                Obj_X_Pos = Player_X + 10'd18;
                Obj_Y_Pos = Player_Y + 10'd2;
            end
        endcase

    end

    // Update registers
    always_ff @ (posedge game_frame_clk_rising_edge)
    begin
        if (Reset)
            Obj_On <= 1'b0;
        else if (attack_interval_counter <= 2'd1) begin
            Obj_On <= Obj_On_in;
        end
        else 
            Obj_On <= 1'b0;
    end

    // If Object is displayed based on keycode
    always_comb
    begin
        Obj_On_in = 1'b0;
        // Press space
        if ((keycode == 10'd44))
            Obj_On_in = 1'b1;
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
                if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + Short)) &&
                    (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Long)) &&
                    (Obj_On == 1'b1)) begin
                        is_obj = 1'b1;
                        Obj_address =  DistX + DistY[3:0] * Short + attack_form * Short * Short;
                    end
            end
            // Left
            2'd1: begin
                // 
                if ((PixelX + Long >= Obj_X_Pos) && (PixelX < (Obj_X_Pos)) &&
                    (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Short)) &&
                    (Obj_On == 1'b1)) begin
                        is_obj = 1'b1;
                        DistX = Obj_X_Pos - PixelX;
                        Obj_address =  DistX[3:0] + DistY * Short + attack_form * Short * Short;
                    end
            end
            // Back (up)
            2'd2: begin
                if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + Short)) &&
                    (PixelY + Long >= Obj_Y_Pos) && (PixelY < Obj_Y_Pos) &&
                    (Obj_On == 1'b1)) begin
                        is_obj = 1'b1;
                        DistY = Obj_Y_Pos - PixelY;
                        Obj_address =  DistX + DistY[3:0] * Short + attack_form * Short * Short;
                    end
            end
            // Right
            2'd3: begin
                if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + Long)) &&
                    (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Short)) &&
                    (Obj_On == 1'b1)) begin
                        is_obj = 1'b1;
                        Obj_address =  DistX[3:0] + DistY * Short + attack_form * Short * Short;
                    end
            end
        endcase

    end
    

    
endmodule
