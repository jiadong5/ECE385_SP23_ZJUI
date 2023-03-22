module MUX_IO (
    input logic[15:0] Data_to_CPU,
    input logic[15:0] Data_Bus,
    input logic MIO_EN,
    output logic[15:0] MDR_In,
);

always_comb
begin
    case(MIO_EN)
    1'b0: out = 

endmodule