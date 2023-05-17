//-------------------------------------------------------------------------
//      boxhead
//-------------------------------------------------------------------------


`define ENEMY_NUM 4
module boxhead( input               CLOCK_50,
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
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
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
    logic [7:0] keycode;
    
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
    end
    
    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;
    
    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            .from_sw_reset(hpi_reset),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_RD_N),    
                            .OTG_WR_N(OTG_WR_N),    
                            .OTG_CS_N(OTG_CS_N),
                            .OTG_RST_N(OTG_RST_N)
    );
     
     nios_system nios_system(
                             .clk_clk(Clk),         
                             .reset_reset_n(1'b1),    // Never reset NIOS
                             .sdram_wire_addr(DRAM_ADDR), 
                             .sdram_wire_ba(DRAM_BA),   
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),  
                             .sdram_wire_cs_n(DRAM_CS_N), 
                             .sdram_wire_dq(DRAM_DQ),   
                             .sdram_wire_dqm(DRAM_DQM),  
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N), 
                             .sdram_clk_clk(DRAM_CLK),
                             .keycode_export(keycode),  
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
                             .otg_hpi_reset_export(hpi_reset)
    );
    
    logic [9:0] DrawX, DrawY;
    logic [8:0] PixelX, PixelY;

    logic [31:0] bkg_address;
    logic [12:0] player_address;
    logic [12:0] enemy_address [`ENEMY_NUM];
    logic [7:0] attack_address;

    logic [4:0] bkg_index;
    logic [4:0] player_index;
    logic [4:0] enemy_index [`ENEMY_NUM];
    logic [4:0] attack_index;

    logic [23:0] bkg_color;
    logic [23:0] player_color;
    logic [23:0] enemy_color [`ENEMY_NUM];
    logic [23:0] attack_color;

    logic is_player;
    logic is_enemy [`ENEMY_NUM];
    logic is_attack;
    logic [8:0] Player_X, Player_Y;
    logic [1:0] Player_Direction;

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
        .read_address(bkg_address),
        .data_Out(bkg_index)
    );

    player player_inst(
        .*,
        .Reset(Reset_h),
        .frame_clk(VGA_VS),
        .keycode(keycode),
        .is_obj(is_player),
        .Obj_address(player_address),
        .Obj_X_Pos(Player_X),
        .Obj_Y_Pos(Player_Y),
        .Obj_Direction(Player_Direction)
    );

    playerROM playerROM_inst(
        .Clk(Clk),
        .read_address(player_address),
        .data_Out(player_index)
    );


    genvar i;
    generate 
        for (i = 0; i < `ENEMY_NUM; i++) begin: multi_enemy
            enemy #(.id(i)) enemy_inst(
                .Clk(Clk),
                .Reset(Reset_h),
                .frame_clk(VGA_VS),
                .keycode(keycode),
                .PixelX(PixelX),
                .PixelY(PixelY),
                .Player_X(Player_X),
                .Player_Y(Player_Y),
                .is_obj(is_enemy[i]),
                .Obj_address(enemy_address[i])
            );
        end
    endgenerate    

    enemyROM enemyROM_inst(
        .Clk(Clk),
        .read_address0(enemy_address[0]),
        .read_address1(enemy_address[1]),
        .data_Out0(enemy_index[0]),
        .data_Out1(enemy_index[1])
    );

    enemyROM enemyROM_inst1(
        .Clk(Clk),
        .read_address0(enemy_address[2]),
        .read_address1(enemy_address[3]),
        .data_Out0(enemy_index[2]),
        .data_Out1(enemy_index[3])
    );
    
    attack attack_inst(
        .*,
        .Reset(Reset_h),
        .frame_clk(VGA_VS),
        .keycode(keycode),
        .is_obj(is_attack),
        .Obj_address(attack_address)
    );

    attackROM attackROM_inst(
        .Clk(Clk),
        .read_address(attack_address),
        .data_Out(attack_index)
    );

   
    background_palette bkg_palette_inst(
        .*,
        .read_address(bkg_index),
        .data_Out(bkg_color)
    );

    foreground_palette player_palette_inst(
        .Clk(Clk),
        .read_address0(player_index),
        .data_Out0(player_color)
    );

    foreground_palette enemy_palette_inst(
        .Clk(Clk),
        .read_address0(enemy_index[0]),
        .read_address1(enemy_index[1]),
        .data_Out0(enemy_color[0]),
        .data_Out1(enemy_color[1]),
    );

    foreground_palette enemy_palette_inst1(
        .Clk(Clk),
        .read_address0(enemy_index[2]),
        .read_address1(enemy_index[3]),
        .data_Out0(enemy_color[2]),
        .data_Out1(enemy_color[3]),
    );

    foreground_palette attack_palette_inst(
        .Clk(Clk),
        .read_address0(attack_index),
        .data_Out0(attack_color)
    );

    always_comb begin
        // it's not red(sprite bacground color), which corresponds to index 0
        if ((is_attack) && (attack_index)) begin
            VGA_R = attack_color[23:16];
            VGA_G = attack_color[15:8];
            VGA_B = attack_color[7:0];
        end
        // If background is player and it's not red(sprite background color)
        else if(((is_player) && (player_index)) ||
                ((is_attack) && (!attack_index) && (player_index)) ) begin
            VGA_R = player_color[23:16];
            VGA_G = player_color[15:8];
            VGA_B = player_color[7:0];
        end
        else if ((is_enemy[0]) && (enemy_index[0])) begin
            VGA_R = enemy_color[0][23:16];
            VGA_G = enemy_color[0][15:8];
            VGA_B = enemy_color[0][7:0];
        end
        else if ((is_enemy[1]) && (enemy_index[1])) begin
            VGA_R = enemy_color[1][23:16];
            VGA_G = enemy_color[1][15:8];
            VGA_B = enemy_color[1][7:0];
        end
        else if ((is_enemy[2]) && (enemy_index[2])) begin
            VGA_R = enemy_color[2][23:16];
            VGA_G = enemy_color[2][15:8];
            VGA_B = enemy_color[2][7:0];
        end
        else if ((is_enemy[3]) && (enemy_index[3])) begin
            VGA_R = enemy_color[3][23:16];
            VGA_G = enemy_color[3][15:8];
            VGA_B = enemy_color[3][7:0];
        end
        else begin
            VGA_R = bkg_color[23:16];
            VGA_G = bkg_color[15:8];
            VGA_B = bkg_color[7:0];
        end

    end

    // Display keycode on hex display
    // HexDriver hex_inst_0 (keycode[3:0], HEX0);
    // HexDriver hex_inst_1 (keycode[7:4], HEX1);

    
endmodule
