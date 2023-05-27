

module enemy_control ( input logic Clk,
    frame_clk,
    Reset,
    input logic [8:0] Obj_X_Pos,
                      Obj_Y_Pos,
                      Player_X,
                      Player_Y,

    input logic [8:0] Obj_X_Motion,
                      Obj_Y_Motion,
    output logic [1:0] Obj_Step_Count
);

    enum logic [1:0] { S_0,
    S_1,
    S_2,
    S_3} State, Next_state;

    always_ff @ (posedge Clk)
    begin
        if (Reset)
            State <= S_0;
        else 
            State <= Next_state;
    end


    always_comb
    begin
        // assign next state
        unique case (State)
            S_0 : begin
                // if ((Obj_X_Motion == 0) && (Obj_Y_Motion == 0))
                    // Next_state = S_0;
                // else
                if(frame_clk)
                    Next_state = S_1;
                else
                    Next_state = S_0;
            end
            S_1 :
                if(frame_clk)
                    Next_state = S_2;
                else
                    Next_state = S_1;
            S_2 : 
                if(frame_clk)
                    Next_state = S_3;
                else
                    Next_state = S_2;
            S_3 :
                if(frame_clk)
                    Next_state = S_0;
                else
                    Next_state = S_3;
        endcase
        // assign output
            case (State)
                S_0 :
                    Obj_Step_Count = 2'd0;
                S_1 :
                    Obj_Step_Count = 2'd1;
                S_2 :
                    Obj_Step_Count = 2'd2;
                S_3 :
                    Obj_Step_Count = 2'd3;
                default : ;
            endcase
    end

endmodule
