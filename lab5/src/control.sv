


/*
 * Moore State Machine lookup table
 * S_start: initial state, wait until Run is set to 1
 * S_clear: Clear XA
 * S0: XA <- A + MS (bit 0) (fn = 0, If M= 1 add S to partial product)
 * S1: Shfit XAB
 * S2: XA <- A + MS (bit 1)
 * S3: Shift XAB
 * S4: XA <- A + MS (bit 2)
 * S5: Shift XAB
 * S6: XA <- A + MS (bit 3)
 * S7: Shift XAB
 * S8: XA <- A + MS (bit 4)
 * S9: Shift XAB 
 * S10: XA <- A + MS (bit 5)
 * S11: Shift XAB
 * S12: XA <- A + MS (bit 6)
 * S13: Shift XAB
 * S14: XA <- A + MS (bit 7) (fn = 1 if M = 1)
 * S15: Shift XAB
 * S_wait: Wait until Run Swith returns to 0
 */


module control
(
    input logic Clk,
    input logic Reset,          // Reset to initial state
    input logic ClearA_LoadB,   // Enable store S into register B
    input logic Run,            // Start multiplication, ClearA_LoadB should already be release
    input logic M,                    // B[0] from register B

    output logic Clr_LD,
    output logic ClearA,              
    output logic Shift,               // start shift operation
    output logic Add,                 // start add operation (A + S -> A)
    output logic Sub                  // start subtract operation (A - S -> A)
);

    enum logic[4:0] {S_start,S_clear,S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S_wait} curr_state, next_state;


    always_ff @ (posedge Clk)
    begin
        if (Reset)
            curr_state <= S_start;
        else
            curr_state <= next_state;
    end

    always_comb
    begin
        // Next state logic
        next_state = curr_state;

        unique case (curr_state)
            S_start: if (Run)
                    next_state = S_clear;
            S_clear: next_state = S0;
            S0 : next_state = S1;
            S1 : next_state = S2;
            S2 : next_state = S3;
            S3 : next_state = S4;
            S4 : next_state = S5;
            S5 : next_state = S6;
            S6 : next_state = S7;
            S7 : next_state = S8;
            S8 : next_state = S9;
            S9 : next_state = S10;
            S10 : next_state = S11;
            S11 : next_state = S12;
            S12 : next_state = S13;
            S13 : next_state = S14;
            S14 : next_state = S15;
            S15 : next_state = S_wait;
            S_wait : if (!Run)
                    next_state = S_start;

        endcase
        // Output logic
        Clr_LD = 1'b0;
        Add = 1'b0;
        Sub = 1'b0;
        case (curr_state)
        
            S_start:
                begin
                    if (ClearA_LoadB)
                        Clr_LD = 1'b1;
                    ClearA = 1'b0;
                    Shift = 1'b0;
                    Add = 1'b0;
                    Sub = 1'b0;
                end
            
            S_clear:
                begin
                    Shift = 1'b0;
                    ClearA = 1'b1;
                end

            // Add/Sub state
            S0: 
                begin
                    Clr_LD = 1'b0;
                    Shift = 1'b0;
                    ClearA = 1'b0;
                    if(M)
                    begin
                        Add = 1'b1;
                        Sub = 1'b0;
                    end
                end
            S2 :
                begin 
                    Clr_LD = 1'b0;
                    Shift = 1'b0;
                    ClearA = 1'b0;
                    if(M)
                    begin 
                        Add = 1'b1;
                        Sub = 1'b0;
                    end
                end
            S4 :
                begin 
                    Clr_LD = 1'b0;
                    Shift = 1'b0;
                    ClearA = 1'b0;
                    if(M)
                    begin
                        Add = 1'b1;
                        Sub = 1'b0;
                    end
                end

            S6 :
                begin 
                    Clr_LD = 1'b0;
                    Shift = 1'b0;
                    ClearA = 1'b0;
                    if(M)
                    begin
                        Add = 1'b1;
                        Sub = 1'b0;
                    end
                end

            S8 :
                begin 
                    Clr_LD = 1'b0;
                    Shift = 1'b0;
                    ClearA = 1'b0;
                    if(M)
                    begin
                        Add = 1'b1;
                        Sub = 1'b0;
                    end
                end

            S10 :
                begin 
                    Clr_LD = 1'b0;
                    Shift = 1'b0;
                    ClearA = 1'b0;
                    if(M)
                    begin
                        Add = 1'b1;
                        Sub = 1'b0;
                    end
                end

            S12 :
                begin 
                    Clr_LD = 1'b0;
                    Shift = 1'b0;
                    ClearA = 1'b0;
                    if(M)
                    begin
                        Add = 1'b1;
                        Sub = 1'b0;
                    end

                end
            S14 :
                begin 
                    Clr_LD = 1'b0;
                    Shift = 1'b0;
                    ClearA = 1'b0;
                    if(M)
                    begin
                        Add = 1'b0;
                        Sub = 1'b1;
                    end


                end

            // Wait state
            S_wait :
                begin
                    if (ClearA_LoadB)
                        Clr_LD = 1'b1;
                    ClearA = 1'b0;
                    Shift = 1'b0;
                    Add = 1'b0;
                    Sub = 1'b0;

                end


            // Default shift state
            default:
                begin
                    ClearA = 1'b0;
                    Clr_LD = 1'b0;
                    Shift = 1'b1;
                    Add = 1'b0;
                    Sub = 1'b0;
                end
        endcase
        
    end


endmodule