//-------------------------------------------------------------------------
//      boxhead
//-------------------------------------------------------------------------


`define ENEMY_NUM 4
module boxhead( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1, HEX2, HEX3,HEX4,HEX5,HEX6,HEX7,
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
    logic game_frame_clk_rising_edge;

    logic [31:0] bkg_address;
    logic [12:0] player_address;
    logic [12:0] enemy_address [`ENEMY_NUM];
    logic [7:0] attack_address;
    logic [8:0] enemy_attack_address [`ENEMY_NUM];
    logic [8:0] existed_enemy_attack_address;

    logic [4:0] bkg_index;
    logic [4:0] player_index;
    logic [4:0] enemy_index [`ENEMY_NUM];
    logic [4:0] attack_index;
    // logic [4:0] enemy_attack_index [`ENEMY_NUM];
    logic [4:0] existed_enemy_attack_index;

    logic is_player;
    logic is_enemy [`ENEMY_NUM];
    logic is_attack;
    logic is_enemy_attack [`ENEMY_NUM];
    logic existed_is_enemy_attack;

    logic [8:0] Player_X, Player_Y;
    logic [1:0] Player_Direction;
    logic Attack_On;
    logic Enemy_Attack_On [`ENEMY_NUM];
    logic [8:0] Attack_X, Attack_Y;
    logic Enemy_Alive [`ENEMY_NUM];
    logic [8:0] Enemy_X [`ENEMY_NUM];
    logic [8:0] Enemy_Y [`ENEMY_NUM];
    logic Enemy_Attack_Ready [`ENEMY_NUM];

    logic [7:0] Score [`ENEMY_NUM];
    logic [7:0] Total_Score;
    logic [9:0] Enemy_Total_Damage [`ENEMY_NUM];
    parameter [9:0] Player_Full_Blood = 7'd100;
    logic [9:0] Player_Blood;

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
    // Comment to increase compile time
    /*
    backgroundROM backgroundROM_inst(
        .*,
        .read_address(bkg_address),
        .data_Out(bkg_index)
    );
    */ 

    assign bkg_index = 1;

    game_frame_clk game_frame_clk_inst(
        .Clk(Clk),
        .frame_clk(VGA_VS),
        .game_frame_clk_rising_edge(game_frame_clk_rising_edge)
    );

    player player_inst(
        .*,
        .Reset(Reset_h),
        .game_frame_clk_rising_edge(game_frame_clk_rising_edge),
        .keycode(keycode),
        .Attack_On(Attack_On),
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
                .game_frame_clk_rising_edge(game_frame_clk_rising_edge),
                .keycode(keycode),
                .PixelX(PixelX),
                .PixelY(PixelY),
                .is_alive(Enemy_Alive[i]),
                .Player_X(Player_X),
                .Player_Y(Player_Y),
                // Output
                .is_obj(is_enemy[i]),
                .Obj_address(enemy_address[i]),
                .Obj_X_Pos(Enemy_X[i]),
                .Obj_Y_Pos(Enemy_Y[i]),
                .Enemy_Attack_Ready(Enemy_Attack_Ready[i])
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
        .game_frame_clk_rising_edge(game_frame_clk_rising_edge),
        .keycode(keycode),
        // Output
        .is_obj(is_attack),
        .Obj_address(attack_address),
        .Obj_On(Attack_On),
        .Obj_X_Pos(Attack_X),
        .Obj_Y_Pos(Attack_Y)
    );

    attackROM attackROM_inst(
        .Clk(Clk),
        .read_address(attack_address),
        .data_Out(attack_index)
    );

    genvar k;
    generate 
        for (k = 0; k < `ENEMY_NUM; k++) begin: enemy_attack
            enemy_attack enemy_attack_inst(
                .Clk(Clk),
                .Reset(Reset_h),
                .game_frame_clk_rising_edge(game_frame_clk_rising_edge),
                .Player_X(Player_X),
                .Player_Y(Player_Y),
                .PixelX(PixelX),
                .PixelY(PixelY),
                .Enemy_Attack_Ready(Enemy_Attack_Ready[k]),
                // Output
                .is_obj(is_enemy_attack[k]),
                .Obj_address(enemy_attack_address[k]),
                .Obj_On(Enemy_Attack_On[k])
            );
        end
    endgenerate

    // Used to reduce size of ROM and read/write ROM
    always_comb begin
        if(Enemy_Attack_On[0]) begin
            existed_enemy_attack_address = enemy_attack_address[0];
            existed_is_enemy_attack = is_enemy_attack[0];
        end
        else if (Enemy_Attack_On[1]) begin
            existed_enemy_attack_address = enemy_attack_address[1];
            existed_is_enemy_attack = is_enemy_attack[1];
        end
        else if (Enemy_Attack_On[2]) begin
            existed_enemy_attack_address = enemy_attack_address[2];
            existed_is_enemy_attack = is_enemy_attack[2];
        end
        else if (Enemy_Attack_On[3]) begin
            existed_enemy_attack_address = enemy_attack_address[3];
            existed_is_enemy_attack = is_enemy_attack[3];
        end
        else begin
            existed_enemy_attack_address = 9'b0;
            existed_is_enemy_attack = 1'b0;
        end
    end

    enemy_attackROM enemy_attackROM_inst(
        .Clk(Clk),
        .read_address(existed_enemy_attack_address),
        .data_Out(existed_enemy_attack_index)
    );


    genvar j;
    generate
        for (j = 0; j < `ENEMY_NUM; j++) begin: game
            gamelogic gamelogic_inst(
                .Clk(Clk),
                .Reset(Reset_h),
                .game_frame_clk_rising_edge(game_frame_clk_rising_edge),
                .Player_X(Player_X),
                .Player_Y(Player_Y),
                .Attack_X(Attack_X),
                .Attack_Y(Attack_Y),
                .Enemy_X(Enemy_X[j]),
                .Enemy_Y(Enemy_Y[j]),
                .Player_Direction(Player_Direction),
                .Attack_On(Attack_On),
                .Enemy_Attack_On(Enemy_Attack_On[j]),
                // Output
                .Enemy_Alive(Enemy_Alive[j]),
                .Score(Score[j]),
                .Enemy_Total_Damage(Enemy_Total_Damage[j])
            );
        end
    endgenerate

    assign Total_Score = Score[0] + Score[1] + Score[2] + Score[3];
    assign Player_Blood = Player_Full_Blood - (Enemy_Total_Damage[0] + Enemy_Total_Damage[1] + Enemy_Total_Damage[2] + Enemy_Total_Damage[3]);
    
    color_mapper color_mapper_inst(
        .*,
        .enemy_attack_index(existed_enemy_attack_index),
        .is_enemy_attack(existed_is_enemy_attack)
    );

    // Display keycode on hex display
    HexDriver hex_inst_0 (Total_Score[3:0], HEX0);
    HexDriver hex_inst_1 (Total_Score[7:4], HEX1);

    HexDriver hex_inst_2 (Score[0][3:0], HEX2);
    HexDriver hex_inst_3 (Score[0][7:4], HEX3);

    HexDriver hex_inst_4 (Player_Blood[3:0], HEX4);
    HexDriver hex_inst_5 (Player_Blood[7:4], HEX5);
    
    HexDriver hex_inst_6 (Enemy_Total_Damage[0][3:0], HEX6);
    HexDriver hex_inst_7 (Enemy_Total_Damage[0][7:4], HEX7);
endmodule
