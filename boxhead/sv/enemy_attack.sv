

`define COOLDOWN_TIME 4

module enemy_attack(input Clk,
                          Reset,
                          frame_clk,
                    input [8:0] Player_X, Player_Y,
                                PixelX, PixelY,
                    input Enemy_Attack_Ready,

                    output logic is_obj,
                    output logic [9:0] Obj_address,
                    output logic Obj_On
);

    parameter [8:0] Width = 10'd18;
    parameter [8:0] Height = 10'd20;

    logic [8:0] Obj_X_Pos, Obj_Y_Pos;
    logic [4:0] CoolDown_Counter,CoolDown_Counter_in;

    assign Obj_X_Pos = Player_X;
    assign Obj_Y_Pos = Player_Y;

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

    always_ff @ (posedge Clk) begin
        if (Reset) begin
            CoolDown_Counter <= 0;
        end
        else begin
            CoolDown_Counter <= CoolDown_Counter_in;
        end

    end

    always_comb begin
        CoolDown_Counter_in = CoolDown_Counter;
        if(~Enemy_Attack_Ready) begin
            CoolDown_Counter_in = `COOLDOWN_TIME;
        end
        else if (frame2_clk_rising_edge) begin
            if(CoolDown_Counter == `COOLDOWN_TIME)
                CoolDown_Counter_in = 0;
            else
                CoolDown_Counter_in = CoolDown_Counter + 1'b1;
        end

    end

    always_comb begin
        if(CoolDown_Counter == `COOLDOWN_TIME) begin
            Obj_On = 1'b1;
        end
        else begin
            Obj_On = 1'b0;
        end
    end

    int DistX, DistY;
    always_comb begin
        DistX = PixelX - Obj_X_Pos;
        DistY = PixelY - Obj_Y_Pos;
        is_obj = 1'b0;
        Obj_address = 9'b0;
        if((PixelX >= Obj_X_Pos) && (PixelX <= Obj_X_Pos + Width) &&
            (PixelY >= Obj_Y_Pos) && (PixelY <= Obj_Y_Pos + Height)) begin
                is_obj = 1'b1;
                Obj_address = DistX + DistY * Width;
            end
    end




endmodule
