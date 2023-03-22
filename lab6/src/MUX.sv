module MUX_IO (
    input logic[15:0] Data_to_CPU,
    input logic[15:0] Data_Bus,
    input logic MIO_EN,
    output logic[15:0] MDR_Input
);
//

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
    input logic[15:0] PCPP,
    input logic[1:0] PCMUX,
    output logic[15:0] PC_Input
);

always_comb
begin
    case (PCMUX)
        default: PC_Input = PCPP;
        2'b10: PC_Input = Data_Calc;
        2'b11: PC_Input = Data_Bus;
    endcase
end
endmodule

