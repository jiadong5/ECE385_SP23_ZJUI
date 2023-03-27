module MUX_IO (
    input logic[15:0] Data_to_CPU,
    input logic[15:0] Data_Bus,
    input logic MIO_EN,
    output logic[15:0] MDR_Input
);


always_comb
begin
    if(~MIO_EN)
        MDR_Input = Data_Bus;
    else    
        MDR_Input = Data_to_CPU;
end
endmodule


module MUX_PC (
    input logic[15:0] Data_Bus,
    input logic[15:0] Data_Calc,
    input logic[15:0] PC_next,
    input logic[1:0] PCMUX,
    output logic[15:0] PC_Input
);


always_comb
begin
    case (PCMUX)
        default: PC_Input = PC_next;
        2'b10: PC_Input = Data_Calc;
        2'b11: PC_Input = Data_Bus;
    endcase
end
endmodule


module MUX_Data_Bus(
    input logic[15:0] PC,
    input logic[15:0] MDR,
    input logic[15:0] Data_Calc,
    input logic[15:0] Data_ALU,
    input logic[3:0] BUS_TICKET,
    output logic[15:0] Data_Bus
);


always_comb
begin
    case (BUS_TICKET)
        default: Data_Bus = 16'h0000;
        4'b0001: Data_Bus = Data_Calc;
        4'b0010: Data_Bus = Data_ALU;
        4'b0100: Data_Bus = MDR;
        4'b1000: Data_Bus = PC;
    endcase
end
endmodule

/*--used in REG_FILE--*/
// 0 -> 111
// 1 -> IR[11:9].
module MUX_For_DR(
    input logic[2:0] IR_11_9,
    input logic DRMUX,
    output logic[2:0] DR 
);

always_comb
begin
    case (DRMUX)
        1'b0: DR = 3'b111;
        1'b1: DR = IR_11_9;
    endcase
end
endmodule

// 0 -> IR[11:9] 
// 1 -> IR[8:6]
module MUX_SR1(
    input logic[2:0] IR_11_9,
    input logic[2:0] IR_8_6,
    input logic SR1MUX,
    output logic[2:0] SR1
);

always_comb
begin
    case(SR1MUX)
        1b'0: SR1 = IR_11_9;
        1b'1: SR1 = IR_8_6;
    endcase
end
endmodule

module MUX_RegFile_Write(
    input logic[2:0] DR,
    output logic LD_R0, LD_R1, LD_R2, LD_R3, LD_R4, LD_R5, LD_R6, LD_R7
);

always_comb
begin
    case(DR)
        3b'000:
            begin
                LD_R0 = 1;
                LD_R1 = 0;
                LD_R2 = 0;
                LD_R3 = 0;
                LD_R4 = 0;
                LD_R5 = 0;
                LD_R6 = 0;
                LD_R7 = 0;
            end
        3b'001:
            begin
                LD_R0 = 0;
                LD_R1 = 1;
                LD_R2 = 0;
                LD_R3 = 0;
                LD_R4 = 0;
                LD_R5 = 0;
                LD_R6 = 0;
                LD_R7 = 0;
            end
        3b'010:
            begin
                LD_R0 = 0;
                LD_R1 = 0;
                LD_R2 = 1;
                LD_R3 = 0;
                LD_R4 = 0;
                LD_R5 = 0;
                LD_R6 = 0;
                LD_R7 = 0;
            end
        3b'011:
            begin
                LD_R0 = 0;
                LD_R1 = 0;
                LD_R2 = 0;
                LD_R3 = 1;
                LD_R4 = 0;
                LD_R5 = 0;
                LD_R6 = 0;
                LD_R7 = 0;
            end
        3b'100:
            begin
                LD_R0 = 0;
                LD_R1 = 0;
                LD_R2 = 0;
                LD_R3 = 0;
                LD_R4 = 1;
                LD_R5 = 0;
                LD_R6 = 0;
                LD_R7 = 0;
            end
        3b'101:
            begin
                LD_R0 = 0;
                LD_R1 = 0;
                LD_R2 = 0;
                LD_R3 = 0;
                LD_R4 = 0;
                LD_R5 = 1;
                LD_R6 = 0;
                LD_R7 = 0;
            end
        3b'110:
            begin
                LD_R0 = 0;
                LD_R1 = 0;
                LD_R2 = 0;
                LD_R3 = 0;
                LD_R4 = 0;
                LD_R5 = 0;
                LD_R6 = 1;
                LD_R7 = 0;
            end
        3b'111:
            begin
                LD_R0 = 0;
                LD_R1 = 0;
                LD_R2 = 0;
                LD_R3 = 0;
                LD_R4 = 0;
                LD_R5 = 0;
                LD_R6 = 0;
                LD_R7 = 1;
            end
    endcase
end
endmodule

/*--ADDR part--*/
//
//
module MUX_For_ADDR2(
    input logic[15:0] IR_10_0_SEXT,
    input logic[15:0] IR_8_0_SEXT,
    input logic[15:0] IR_5_0_SEXT,
    input logic[1:0] ADDR2MUX,
    output logic[15:0] ADDR2_to_Adder
);

always_comb
begin
    case(ADDR2MUX)
        2b'00:
        2b'01:
        2b'10:
        2b'11:
    endcase
end
endmodule

module MUX_For_ADDR1(
    input logic[15:0] SR1OUT,
    input logic[15:0] PC_next,
    input logic ADDR1MUX,
    output logic ADDR1_to_Adder
);

always_comb
begin
    case(ADDR1MUX)
        1b'0:
        1b'1:
    endcase
end
endmodule
