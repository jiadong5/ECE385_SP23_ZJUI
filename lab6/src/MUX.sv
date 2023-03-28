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
        1'b0: SR1 = IR_11_9;
        1'b1: SR1 = IR_8_6;
    endcase
end
endmodule

module MUX_RegFile_Write(
    input logic[2:0] DR,
    input logic LD_REG,
    output logic LD_R0, LD_R1, LD_R2, LD_R3, LD_R4, LD_R5, LD_R6, LD_R7
);

always_comb
begin
    case(DR)
        3'b000:
            begin
                LD_R0 = 1 & LD_REG;
                LD_R1 = 0;
                LD_R2 = 0;
                LD_R3 = 0;
                LD_R4 = 0;
                LD_R5 = 0;
                LD_R6 = 0;
                LD_R7 = 0;
            end
        3'b001:
            begin
                LD_R0 = 0;
                LD_R1 = 1 & LD_REG;
                LD_R2 = 0;
                LD_R3 = 0;
                LD_R4 = 0;
                LD_R5 = 0;
                LD_R6 = 0;
                LD_R7 = 0;
            end
        3'b010:
            begin
                LD_R0 = 0;
                LD_R1 = 0;
                LD_R2 = 1 & LD_REG;
                LD_R3 = 0;
                LD_R4 = 0;
                LD_R5 = 0;
                LD_R6 = 0;
                LD_R7 = 0;
            end
        3'b011:
            begin
                LD_R0 = 0;
                LD_R1 = 0;
                LD_R2 = 0;
                LD_R3 = 1 & LD_REG;
                LD_R4 = 0;
                LD_R5 = 0;
                LD_R6 = 0;
                LD_R7 = 0;
            end
        3'b100:
            begin
                LD_R0 = 0;
                LD_R1 = 0;
                LD_R2 = 0;
                LD_R3 = 0;
                LD_R4 = 1 & LD_REG;
                LD_R5 = 0;
                LD_R6 = 0;
                LD_R7 = 0;
            end
        3'b101:
            begin
                LD_R0 = 0;
                LD_R1 = 0;
                LD_R2 = 0;
                LD_R3 = 0;
                LD_R4 = 0;
                LD_R5 = 1 & LD_REG;
                LD_R6 = 0;
                LD_R7 = 0;
            end
        3'b110:
            begin
                LD_R0 = 0;
                LD_R1 = 0;
                LD_R2 = 0;
                LD_R3 = 0;
                LD_R4 = 0;
                LD_R5 = 0;
                LD_R6 = 1 & LD_REG;
                LD_R7 = 0;
            end
        3'b111:
            begin
                LD_R0 = 0;
                LD_R1 = 0;
                LD_R2 = 0;
                LD_R3 = 0;
                LD_R4 = 0;
                LD_R5 = 0;
                LD_R6 = 0;
                LD_R7 = 1 & LD_REG;
            end
    endcase
end
endmodule


module MUX_RegFile_Read(
    input logic Clk, Reset,
    input logic[2:0] SR,
    input logic[15:0] R0_Out,
    input logic[15:0] R1_Out,
    input logic[15:0] R2_Out,
    input logic[15:0] R3_Out,
    input logic[15:0] R4_Out,
    input logic[15:0] R5_Out,
    input logic[15:0] R6_Out,
    input logic[15:0] R7_Out,
    output logic[15:0] data_out 
);

always_comb
    begin
        case(SR)
            3'b000: data_out = R0_Out;
            3'b001: data_out = R1_Out;
            3'b010: data_out = R2_Out;
            3'b011: data_out = R3_Out;
            3'b100: data_out = R4_Out;
            3'b101: data_out = R5_Out;
            3'b110: data_out = R6_Out;
            3'b111: data_out = R7_Out;
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
        2'b00: ADDR2_to_Adder = IR_10_0_SEXT;
        2'b01: ADDR2_to_Adder = IR_8_0_SEXT;
        2'b10: ADDR2_to_Adder = IR_5_0_SEXT;
        2'b11: ADDR2_to_Adder = 16'h0000;
    endcase
end
endmodule

module MUX_For_ADDR1(
    input logic[15:0] SR1OUT,
    input logic[15:0] PC,
    input logic ADDR1MUX,
    output logic[15:0] ADDR1_to_Adder
);

always_comb
begin
    case(ADDR1MUX)
        1'b0: ADDR1_to_Adder = SR1OUT;
        1'b1: ADDR1_to_Adder = PC;
    endcase
end
endmodule

// MUX for SEXT.
module MUX_SEXT_10(
    input logic[10:0] IR_10_0,
    output logic[15:0] IR_10_0_SEXT
);

always_comb
begin
    case(IR_10_0[10])
        1'b0: IR_10_0_SEXT = {5'b00000, IR_10_0};
        1'b1: IR_10_0_SEXT = {5'b11111, IR_10_0};
    endcase
end
endmodule

module MUX_SEXT_8(
    input logic[8:0] IR_8_0,
    output logic[15:0] IR_8_0_SEXT
);

always_comb
begin
    case(IR_8_0[8])
        1'b0: IR_8_0_SEXT = {7'b0000000, IR_8_0};
        1'b1: IR_8_0_SEXT = {7'b1111111, IR_8_0};
    endcase
end
endmodule

module MUX_SEXT_5(
    input logic[5:0] IR_5_0,
    output logic[15:0] IR_5_0_SEXT
);

always_comb
begin
    case(IR_5_0[5])
        1'b0: IR_5_0_SEXT = {10'b0000000000, IR_5_0};
        1'b1: IR_5_0_SEXT = {10'b1111111111, IR_5_0};
    endcase
end
endmodule

/*--NZP part--*/
module MUX_For_NZP(
    input logic[15:0] Data_Bus,
    output logic[2:0] NZP_In
);

always_comb
begin
    if (Data_Bus == {16'h0000})
        NZP_In = 3'b010;
    else if (Data_Bus[15] == 0)
        NZP_In = 3'b001;
    else
        NZP_In = 3'b100;
end
endmodule

// a mux that not so mux.
module MUX_For_BEN(
    input logic[2:0] NZP_Out,
    input logic[2:0] IR_11_9,
    output logic BEN_In
);

logic[2:0] LogicAnd;
assign LogicAnd = NZP_Out & IR_11_9;

always_comb
begin
    case(LogicAnd)
        default: BEN_In = 1'b1;
        3'b000: BEN_In = 1'b0;
    endcase
end
endmodule

/*--ALU Part--*/
module MUX_SEXT_4(
    input logic[4:0] IR_4_0,
    output logic[15:0] IR_4_0_SEXT
);

always_comb
begin
    case(IR_4_0[4])
        1'b0: IR_4_0_SEXT = {11'b00000000000, IR_4_0};
        1'b1: IR_4_0_SEXT = {11'b11111111111, IR_4_0};
    endcase
end
endmodule

module MUX_For_SR2(
    input logic[15:0] IR_4_0_SEXT,
    input logic[15:0] SR2OUT,
    input logic SR2MUX,
    output logic[15:0] ALU_In_B
);

always_comb
begin
    case(SR2MUX)
        1'b1: ALU_In_B = IR_4_0_SEXT;
        1'b0: ALU_In_B = SR2OUT;
    endcase
end
endmodule

module MUX_For_ALU(
    input logic[15:0] ALU_In_B,
    input logic[15:0] SR1OUT,
    input logic[1:0] ALUK,
    output logic[15:0] Data_ALU
);

logic[15:0] And_Out;
logic[15:0] Add_Out;
logic[15:0] Not_Out;

assign And_Out = {ALU_In_B & SR1OUT};
assign Add_Out = {ALU_In_B + SR1OUT};
assign Not_Out = {~SR1OUT};

always_comb
begin
    case(ALUK)
        2'b00: Data_ALU = Add_Out;
        2'b01: Data_ALU = And_Out;
        2'b11: Data_ALU = SR1OUT;
        2'b10: Data_ALU = Not_Out;
    endcase
end
endmodule