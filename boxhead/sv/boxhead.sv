

module boxhead( 
    input               CLOCK_50,
    input        [3:0]  KEY,          //bit 0 is set up as Reset
    output logic [6:0]  HEX0, HEX1,
    // VGA Interface 
    output logic [7:0]  VGA_R,        //VGA Red
    VGA_G,        //VGA Green
    VGA_B,        //VGA Blue
    output logic        VGA_CLK,      //VGA Clock
    VGA_SYNC_N,   //VGA Sync signal
    VGA_BLANK_N,  //VGA Blank signal
    VGA_VS,       //VGA virtical sync signal
    VGA_HS,       //VGA horizontal sync signal

    // SDRAM Interface for Nios II Software
    output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
    inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
    output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
    output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
    output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
    DRAM_CAS_N,   //SDRAM Column Address Strobe
    DRAM_CKE,     //SDRAM Clock Enable
    DRAM_WE_N,    //SDRAM Write Enable
    DRAM_CS_N,    //SDRAM Chip Select
    DRAM_CLK      //SDRAM Clock
);

    logic Reset_h, Clk;

    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end  

    logic [9:0] DrawX, DrawY;
    logic [8:0] PixelX, PixelY;

    logic [31:0] bkg_address;
    logic [11:0] player_address;
    logic [4:0] bkg_index;
    logic [4:0] player_index;
    logic [23:0] bkg_color;
    logic [23:0] player_color;

    logic is_player;
    logic test_is_player;

    assign PixelX = DrawX[9:1];
    assign PixelY = DrawY[9:1];

    assign bkg_address = PixelX + PixelY * 320;

    vga_controller vga_controller_inst(
        .*,
        .Reset(Reset_h),
        .hs(VGA_HS),
        .vs(VGA_VS),
        .pixel_clk(VGA_CLK),
        .blank(VGA_BLANK_N),
        .sync(VGA_SYNC_N)
    );

    backgroundRAM background_ram(
        .*,
        .data_In(),
        .write_address(),
        .read_address(bkg_address),
        .we(),
        .data_Out(bkg_index)
    );

    player player_inst(
        .*,
        .Reset(Reset_h),
        .frame_clk(VGA_VS),
        .keycode(),
        .is_player(is_player),
        .player_address(player_address)
    );

    playerROM playerROM_inst(
        .Clk(Clk),
        .read_address(player_address),
        .data_Out(player_index)
    );
    
    palette bkg_palette_inst(
        .*,
        .read_address(bkg_index),
        .data_Out(bkg_color)
    );

    palette player_palette_inst(
        .*,
        .read_address(player_index),
        .data_Out(player_color)
    );

    assign test_is_player = 1'b1;
    always_comb begin
        // If background is player and it's not red(sprite background color)
        if((is_player == 1'b1) && (player_index != 5'h0)) begin
            VGA_R = player_color[23:16];
            VGA_G = player_color[15:8];
            VGA_B = player_color[7:0];
        end
        else begin
            VGA_R = bkg_color[23:16];
            VGA_G = bkg_color[15:8];
            VGA_B = bkg_color[7:0];
        end

    end

    assign HEX0 = 7'hFF;
    assign HEX1 = 7'hFF;

endmodule
