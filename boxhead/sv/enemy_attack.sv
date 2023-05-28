

`define COOLDOWN_TIME 10
`define LAST_TIME 2

module enemy_attack(input Clk,
                          Reset,
                          game_frame_clk_rising_edge,
                    input [8:0] Player_X, Player_Y,
                                PixelX, PixelY,
                    input Enemy_Attack_Ready,

                    output logic is_obj,
                    output logic [9:0] Obj_address,
                    output logic Obj_On,
                    output logic Enemy_Attack_Valid
);

    parameter [8:0] Width = 10'd18;
    parameter [8:0] Height = 10'd20;

    logic [8:0] Obj_X_Pos, Obj_Y_Pos;
    logic [4:0] CoolDown_Counter,CoolDown_Counter_in;
    logic [2:0] LastTime_Counter, LastTime_Counter_in;

    assign Obj_X_Pos = Player_X;
    assign Obj_Y_Pos = Player_Y;

    // How long enemy's attack affect last
    always_ff @ (posedge Clk) begin
        if (Reset)
            LastTime_Counter <= 3'd0;
        else 
            LastTime_Counter <= LastTime_Counter_in;
    end

    always_comb begin
        LastTime_Counter_in = LastTime_Counter;
        if (Enemy_Attack_Ready)
            LastTime_Counter_in = 3'd1;
        else if (game_frame_clk_rising_edge) begin
            if((LastTime_Counter) && (LastTime_Counter != 3'd3))
                LastTime_Counter_in = LastTime_Counter + 1'b1;
            else if (LastTime_Counter == 3'd3)
                LastTime_Counter_in = 3'd0;
        end
    end

    // Update registers
    always_ff @ (posedge Clk) begin
        if (Reset) begin
            CoolDown_Counter <= 0;
        end
        else begin
            CoolDown_Counter <= CoolDown_Counter_in;
        end

    end

    // Record cooling down time
    always_comb begin
        CoolDown_Counter_in = CoolDown_Counter;
        if (Enemy_Attack_Ready)
            CoolDown_Counter_in = 4'd1;
        if (game_frame_clk_rising_edge) begin
            if ((CoolDown_Counter) && (CoolDown_Counter != `COOLDOWN_TIME))
                CoolDown_Counter_in = CoolDown_Counter + 1'b1;
            else if (CoolDown_Counter == `COOLDOWN_TIME)
                CoolDown_Counter_in = 4'd0;
        end

    end

    // Check if should show enemy attack
    always_comb begin
        if((LastTime_Counter >= 1)) begin
            Obj_On = 1'b1;
        end
        else begin
            Obj_On = 1'b0;
        end

        if((Obj_On) && (CoolDown_Counter == `COOLDOWN_TIME - 1)) begin
            Enemy_Attack_Valid = 1'b1;
        end
        else begin
            Enemy_Attack_Valid = 1'b0;
        end
    end

    int DistX, DistY;
    always_comb begin
        DistX = PixelX - Obj_X_Pos;
        DistY = PixelY - Obj_Y_Pos;
        is_obj = 1'b0;
        Obj_address = 9'b0;
        if((PixelX >= Obj_X_Pos) && (PixelX <= Obj_X_Pos + Width) &&
            (PixelY >= Obj_Y_Pos) && (PixelY <= Obj_Y_Pos + Height) && (Obj_On == 1'b1)) begin
                is_obj = 1'b1;
                Obj_address = DistX + DistY * Width;
            end
    end




endmodule
