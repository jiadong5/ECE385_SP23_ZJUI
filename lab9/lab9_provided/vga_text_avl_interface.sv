/************************************************************************
Avalon-MM Interface VGA Text mode display

Modified for DE2-115 board

Register Map:
0x000-0x0257 : VRAM, 80x30 (2400 byte, 600 word) raster order (first column then row)
0x258        : control register

VRAM Format:
X->
[ 31  30-24][ 23  22-16][ 15  14-8 ][ 7    6-0 ]
[IV3][CODE3][IV2][CODE2][IV1][CODE1][IV0][CODE0]

IVn = Draw inverse glyph
CODEn = Glyph code from IBM codepage 437

Control Register Format:
[[31-25][24-21][20-17][16-13][ 12-9][ 8-5 ][ 4-1 ][   0    ] 
[[RSVD ][FGD_R][FGD_G][FGD_B][BKG_R][BKG_G][BKG_B][RESERVED]

VSYNC signal = bit which flips on every Vsync (time for new frame), used to synchronize software
BKG_R/G/B = Background color, flipped with foreground when IVn bit is set
FGD_R/G/B = Foreground color, flipped with background when Inv bit is set

************************************************************************/

module vga_text_avl_interface (
	// Avalon Clock Input, note this clock is also used for VGA, so this must be 50Mhz
	// We can put a clock divider here in the future to make this IP more generalizable
	input logic CLK,
	
	// Avalon Reset Input, active high
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,					// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,			// Avalon-MM Byte Enable
	input  logic [11:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,		// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,		// Avalon-MM Read Data
	
	// Exported Conduit (mapped to VGA port - make sure you export in Platform Designer)
	output logic [3:0]  red, green, blue,	// VGA color channels (mapped to output pins in top-level)
	output logic hs, vs,					// VGA HS/VS
	output logic sync, blank, pixel_clk		// Required by DE2-115 video encoder
);

    // Local variables
    logic [31:0] PALETTE_REG     [8];

    logic [9:0] DrawX, DrawY;           // Current pixel coordinate
    logic [7:0] DrawChar;               // Current character being drawn
    logic [3:0] DrawFGD_IDX;            // foreground color index of character
    logic [3:0] DrawBKG_IDX;            // background color index of character
    logic [31:0] DrawData;              // VRAM[DrawChar's address in VRAM]
    logic [31:0] DrawData_Address;
    logic [31:0] DataColumn, DataRow;

    logic [7:0] DrawRow;                // Current row in font_rom
    logic [3:0] FGD_R, FGD_G, FGD_B;
    logic [3:0] BKG_R, BKG_G, BKG_B;

    logic [31:0] REG_READDATA;          // READDATA from palette register
    logic [31:0] OCM_READDATA;          // READDATA from on chip memory

 
    //Declare submodules..e.g. VGA controller, ROMS, etc
    vga_controller vga_controller_inst(
        .*,
        .Clk(CLK),
        .Reset(RESET),
        .DrawX(DrawX),
        .DrawY(DrawY)
    );

    font_rom font_rom_inst(
        // .addr(DrawChar[6:0] << 4 + DrawY[3:0]), // DrawChar[6:0] * 16 + DrawY % 16 to get the address in ROM
        .addr({DrawChar[6:0], DrawY[3:0]}),
        .data(DrawRow)
    );
   
    // Set palette register
    always_ff @(posedge CLK) begin
        if (RESET) begin
            PALETTE_REG <= '{default:0};
        end
        else if (AVL_WRITE & AVL_CS & AVL_ADDR[11]) 
        begin
            PALETTE_REG[AVL_ADDR[2:0]] <= AVL_WRITEDATA;
            // case (AVL_BYTE_EN)
            //     4'b1111: PALETTE_REG[AVL_ADDR[10:0]] <= AVL_WRITEDATA;
            //     4'b1100: PALETTE_REG[AVL_ADDR[10:0]][31:16] <= AVL_WRITEDATA[31:16];
            //     4'b0011: PALETTE_REG[AVL_ADDR[10:0]][15:0] <= AVL_WRITEDATA[15:0];
            //     4'b0001: PALETTE_REG[AVL_ADDR[10:0]][7:0] <= AVL_WRITEDATA[7:0];
            //     4'b0010: PALETTE_REG[AVL_ADDR[10:0]][15:8] <= AVL_WRITEDATA[15:8];
            //     4'b0100: PALETTE_REG[AVL_ADDR[10:0]][23:16] <= AVL_WRITEDATA[23:16];
            //     4'b1000: PALETTE_REG[AVL_ADDR[10:0]][31:24] <= AVL_WRITEDATA[31:24];
            //     default: PALETTE_REG[AVL_ADDR[10:0]][31:0] <= 32'h0;
            // endcase
        end
        else if (AVL_READ & AVL_CS & AVL_ADDR[11])
        begin
            REG_READDATA <= PALETTE_REG[AVL_ADDR[2:0]];
        end
    end


    // Compute address in VRAM based on current DX,DY
    always_comb begin
        DataColumn = DrawX >> 3;
        DataRow = DrawY >> 4;
        DrawData_Address = (DataRow * 80 + DataColumn) >> 1;
    end

    on_chip_mem on_chip_mem_inst(
        .address_a(AVL_ADDR[10:0]),
        .address_b(DrawData_Address), // Read only
        .byteena_a(AVL_BYTE_EN),
        .clock(CLK),
        .data_a(AVL_WRITEDATA),  // Write data
        .data_b(32'b0),
        .rden_a(AVL_READ & AVL_CS & ~AVL_ADDR[11]),
        .rden_b(1'b1), // Read only
        .wren_a(AVL_WRITE & AVL_CS & ~AVL_ADDR[11]),
        .wren_b(1'b0), // Read only, never write
        .q_a(OCM_READDATA), // Read Data
        .q_b(DrawData)
    );

    always_comb begin
        if (AVL_ADDR[11]) begin
            AVL_READDATA = REG_READDATA;
        end
        else begin
            AVL_READDATA = OCM_READDATA;
        end
    end
    
    always_comb begin
        // Choose between two characters in DrawData
        if (DrawX[3:0] <= 5'd7)
        begin
            DrawChar = DrawData[15:8];
            DrawFGD_IDX = DrawData[7:4];
            DrawBKG_IDX = DrawData[3:0];
        end
        else
        begin
            DrawChar = DrawData[31:24];
            DrawFGD_IDX = DrawData[23:20];
            DrawBKG_IDX = DrawData[19:16];
        end
    end

    always_comb begin
        // Choose foreground and background palette register
        // If odd
        if (DrawFGD_IDX[0])
        begin
            FGD_R = PALETTE_REG[DrawFGD_IDX[3:1]][24:21];
            FGD_G = PALETTE_REG[DrawFGD_IDX[3:1]][20:17];
            FGD_B = PALETTE_REG[DrawFGD_IDX[3:1]][16:13];
        end
        else
        begin
            FGD_R = PALETTE_REG[DrawFGD_IDX[3:1]][12:9];
            FGD_G = PALETTE_REG[DrawFGD_IDX[3:1]][8:5];
            FGD_B = PALETTE_REG[DrawFGD_IDX[3:1]][4:1];
        end
            
        // If odd
        if (DrawBKG_IDX[0])
        begin
            BKG_R = PALETTE_REG[DrawBKG_IDX[3:1]][24:21];
            BKG_G = PALETTE_REG[DrawBKG_IDX[3:1]][20:17];
            BKG_B = PALETTE_REG[DrawBKG_IDX[3:1]][16:13];
        end
        else
        begin
            BKG_R = PALETTE_REG[DrawBKG_IDX[3:1]][12:9];
            BKG_G = PALETTE_REG[DrawBKG_IDX[3:1]][8:5];
            BKG_B = PALETTE_REG[DrawBKG_IDX[3:1]][4:1];
        end


    end


    always_comb begin
        if (DrawChar[7])
        begin
            // If need to draw
            if (DrawRow[7 - DrawX[2:0]])  // DrawX % 8
            begin
                red = BKG_R;
                green = BKG_G;
                blue = BKG_B;
            end
            else
            begin
                red = FGD_R;
                green = FGD_G;
                blue = FGD_B;
            end
        end
        // If is not inverted
        else
        begin
        // If need to draw
        if (DrawRow[7 - DrawX[2:0]]) 
            begin
                red = FGD_R;
                green = FGD_G;
                blue = FGD_B;
            end
            else
            begin
                red = BKG_R;
                green = BKG_G;
                blue = BKG_B;
            end
        end
    end

  
    


endmodule
