

`define UP 82
`define DOWN 81
`define LEFT 80
`define RIGHT 79
`define Z 29
`define X 27
`define SPACE 44
module godmode (input Clk,
                      Reset,
                      game_frame_clk_rising_edge,
                input [7:0] keycode,

                output logic Godmode_On
);
    // Update register
    // always_ff @ (Clk) begin
    //     if (Reset) begin
    //         Godmode_On <= 1'b0;
    //     end
    //     else begin
    //         Godmode_On <= Godmode_On_in;
    //     end
    // end

    enum logic [3:0] {
        S_0, // Start
        S_1, // Up
        S_2, // Up Up
        S_3, // Up Up Down
        S_4, // Up Up Down Down
        S_5, // Up Up Down Down Left
        S_6, // Up Up Down Down Left Left
        S_7, // Up Up Down Down Left Left Right
        S_8, // Up Up Down Down Left Left Right Right
        S_9, // Up Up Down Down Left Left Right Right b
        S_10, // Up Up Down Down Left Left Right Right b a
        S_11, // Up Up Down Down Left Left Right Right b a b
        S_12 // Up Up Down Down Left Left Right Right b a b a
    } State, Next_state;

    always_ff @ (posedge Clk)
    begin
        if (Reset)
            State <= S_0;
        else
            State <= Next_state;
    end

    always_comb begin
        // Assign next state
        unique case (State)
            S_0 : begin
                if (keycode == `UP) 
                    Next_state = S_1;
                else
                    Next_state = S_0;
            end
            S_1 : begin
                if (keycode == `UP)
                    Next_state = S_2;
                else if (((keycode == `SPACE) || (keycode == `DOWN) || (keycode == `LEFT) || (keycode == `RIGHT)))
                    Next_state = S_0;
                else
                    Next_state = S_1;
            end
            S_2 : begin
                if (keycode == `DOWN)
                    Next_state = S_3;
                else if (keycode == `SPACE)
                    Next_state = S_0;
                else
                    Next_state = S_2;
            end
            S_3 : begin
                if (keycode == `DOWN)
                    Next_state = S_4;
                else if (keycode == `SPACE)
                    Next_state = S_0;
                else
                    Next_state = S_3;
            end
            S_4 : begin
                if (keycode == `LEFT && (game_frame_clk_rising_edge))
                    Next_state = S_5;
                else if (keycode == `SPACE)
                    Next_state = S_0;
                else
                    Next_state = S_4;
            end
            S_5 : begin
                if (keycode == `RIGHT)
                    Next_state = S_6;
                else if (keycode == `SPACE)
                    Next_state = S_0;
                else
                    Next_state = S_5;
            end

            S_6 : begin
                if (keycode == `LEFT)
                    Next_state = S_7;
                else if (keycode == `SPACE)
                    Next_state = S_0;
                else
                    Next_state = S_6;
            end
            S_7 : begin
                if (keycode == `RIGHT)
                    Next_state = S_8;
                else if (keycode == `SPACE)
                    Next_state = S_0;
                else
                    Next_state = S_7;
            end
            S_8 : begin
                if (keycode == `Z)
                    Next_state = S_9;
                else if (keycode == `SPACE)
                    Next_state = S_0;
                else
                    Next_state = S_8;
            end
            S_9 : begin
                if (keycode == `X)
                    Next_state = S_10;
                else if (keycode == `SPACE)
                    Next_state = S_0;
                else
                    Next_state = S_9;
            end
            S_10 : begin
                if (keycode == `Z)
                    Next_state = S_11;
                else if (keycode == `SPACE)
                    Next_state = S_0;
                else
                    Next_state = S_10;
            end
            S_11 : begin
                if (keycode == `X)
                    Next_state = S_12;
                else if (keycode == `SPACE)
                    Next_state = S_0;
                else
                    Next_state = S_11;
            end
            S_12 : begin
                Next_state = S_12;
            end
        endcase

        case (State) 
            S_12: 
                Godmode_On = 1'b1;
            default: 
                Godmode_On = 1'b0;
        endcase

    end



endmodule