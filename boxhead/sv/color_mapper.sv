

`define ENEMY_NUM 4
`define CYCLING_COLOR_NUM 9

module color_mapper
(
    input logic Clk,
                Reset,
                VGA_CLK,
                VGA_BLANK_N,
                game_frame_clk_rising_edge,
    input logic is_attack,
                is_player,
                is_enemy_attack,
                is_game_over,
                is_game_start,
                is_score,
                is_level,
                is_blood,
                is_blackboard,
    input logic is_enemy [`ENEMY_NUM],
    input logic[4:0] bkg_index,
                     player_index,
                     attack_index,
                     enemy_attack_index,
                     game_over_index,
                     game_start_index,
                     score_index,
                     level_index,
                     blood_index,
                     blackboard_index,
    input logic[4:0] enemy_index [`ENEMY_NUM],

    output logic [7:0] VGA_R,
                       VGA_G,
                       VGA_B
);

    logic [4:0] fgd_index;

    logic [23:0] bkg_color;
    logic [23:0] fgd_color;

    logic [4:0] cycling_counter;
    logic [4:0] cycling_fgd_index;

    always_ff @ (posedge game_frame_clk_rising_edge) begin
        if(Reset)
            cycling_counter <= 5'd0;
        else if (cycling_counter == `CYCLING_COLOR_NUM - 1)
            cycling_counter <= 5'd0;
        else 
            cycling_counter <= cycling_counter + 1;
    end

    // Background Color
    background_palette bkg_palette_inst(
        .*,
        .read_address(bkg_index),
        .data_Out(bkg_color)
    );

    // Foreground Color
    always_comb begin
        // it's not red(sprite bacground color), which corresponds to index 0
        if ((is_blood) && (blood_index)) 
            fgd_index = blood_index;
        else if ((is_level) && (level_index))
            fgd_index = level_index;
        else if ((is_score) && (score_index))
            fgd_index = score_index;
        else if ((is_blackboard) && (blackboard_index))
            fgd_index = blackboard_index;
        else if ((is_game_start) && (game_start_index))
            fgd_index = game_start_index;
        else if ((is_game_over) && (game_over_index))
            fgd_index = game_over_index;
        else if ((is_enemy_attack) && (enemy_attack_index))
            fgd_index = enemy_attack_index;
        else if ((is_attack) && (attack_index))
            fgd_index = attack_index;
        // If background is player and it's not red(sprite background color)
        // else if(((is_player) && (player_index)) ||
        //         ((is_attack) && (!attack_index) && (player_index)) )
        else if ((is_player) && (player_index))
            fgd_index = player_index;
        else if ((is_enemy[0]) && (enemy_index[0]))
            fgd_index = enemy_index[0];
        else if ((is_enemy[1]) && (enemy_index[1]))
            fgd_index = enemy_index[1];
        else if ((is_enemy[2]) && (enemy_index[2]))
            fgd_index = enemy_index[2];
        else if ((is_enemy[3]) && (enemy_index[3])) 
            fgd_index = enemy_index[3];
        else 
            fgd_index = 0;

        cycling_fgd_index = 5'd0;
        // Palette Cycling for attack
        if((is_attack) && (attack_index)) begin
            cycling_fgd_index = (fgd_index + cycling_counter - 1) % `CYCLING_COLOR_NUM + 1;
        case (cycling_fgd_index)
            5'd00 : fgd_color = 24'h010101;
            // Original color
            5'd01 : fgd_color = 24'hFFFFFF; // White
            5'd02 : fgd_color = 24'hD8B000; // Orange
            5'd03 : fgd_color = 24'hF8F000; // Yellow
            // New color
            5'd04 : fgd_color = 24'hE9C22D; // Yellow
            5'd05 : fgd_color = 24'hF2EDB1; // Light Yellow
            5'd06 : fgd_color = 24'h1F97D6; // Blue
            5'd07 : fgd_color = 24'h6B91AF; // Light Blue
            5'd08 : fgd_color = 24'h05518B; // Deep Blue
            5'd09 : fgd_color = 24'hE6E3E3; // Grey white

            default : fgd_color = 24'h010101;
        endcase
        end 
        // Original color for other foreground
        else begin
        case (fgd_index) 
            5'd00 :fgd_color = 24'h010101;
            5'd01 :fgd_color = 24'h000000;
            5'd02 :fgd_color = 24'hF8F8F8;
            5'd03 :fgd_color = 24'h980000;
            5'd04 :fgd_color = 24'hD03800;
            5'd05 :fgd_color = 24'hF88058;
            5'd06 :fgd_color = 24'hA06800;
            5'd07 :fgd_color = 24'h5888B8;
            5'd08 :fgd_color = 24'hD8B000;
            5'd09 :fgd_color = 24'hF8F000; // Yellow
            5'd10 :fgd_color = 24'h6080A8;
            5'd11 :fgd_color = 24'hB8C8F0;
            5'd12 :fgd_color = 24'h303888;
            5'd13 :fgd_color = 24'h8860B8;
            5'd14 :fgd_color = 24'h502898;
            5'd15 :fgd_color = 24'hB090D8;
            5'd16 :fgd_color = 24'hff0000;
            5'd17 :fgd_color = 24'h333333;
            5'd18 :fgd_color = 24'hbb0000;
            default : fgd_color = 24'h010101;
        endcase
        end
    end

    // Drawing 
    always_ff @(posedge VGA_CLK) begin
        if(VGA_BLANK_N) begin
            if (fgd_index == 0) begin
                VGA_R <= bkg_color[23:16];
                VGA_G <= bkg_color[15:8];
                VGA_B <= bkg_color[7:0];
            end
            else begin
                VGA_R <= fgd_color[23:16];
                VGA_G <= fgd_color[15:8];
                VGA_B <= fgd_color[7:0];
            end
        end
        else begin
            VGA_R <= 8'h0;
            VGA_G <= 8'h0;
            VGA_B <= 8'h0;
        end
    end




endmodule
