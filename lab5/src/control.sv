

module control
(
    input logic Clk,
    input logic Reset,          // Reset to initial state
    input logic ClearA_LoadB,   // Enable store S into register B
    input logic Run,            // Start multiplication, ClearA_LoadB should already be release
    input M,                    // B[0] from register B

    output Clr_LD,              
    output Shift,               // start shift operation
    output Add,                 // start add operation (A + S -> A)
    output Sub                  // start subtract operation (A - S -> A)
);

    enum logic[3:0] {S0,S1,S2,S3,S4,S5,S6,S7,S8} curr_state, next_state;


    always_ff @ (postedge Clk)
    begin
        if (Reset)
            curr_state <= S0;
        else
            curr_state <= next_state;
    end

    always_comb
    begin
        // Next state logic
        next_state = curr_state;
        unique case (curr_state)
            S0 :
            S1 :
            S2 :
            S3 :
            S4 :
            S5 :
            S6 :
            S7 :
            S8 :
        endcase

        // Output logic
        unique case (curr_state)
            S0 :
                begin

                end
    
            S1 :
            S2 :
            S3 :
            S4 :
            S5 :
            S6 :
            S7 :
            S8 :

            default:
                begin

                end
        endcase
        
    end


endmodule