/*
    This sprite table was generated using 'conv_to_sv.py'. Find out more here: https://github.com/Atrifex/ECE385-HelperTools
    To use, instantiate this module in your color mapper. The SpriteX input should be connected to
        'ObjectXSize - DistX', where ObjectXSize is the width of your object in pixels along the
        x direction. DistX is the horizontal distance between the DrawX pxiel and the top left corner
        of the object in question, so something like: 'DistX = DrawX - ObjectXPosition' is fine.
        Similarly this goes for SpriteY. Warning: If you don't do this, your image will be flipped along
        the axis you ignored. This is a handy way to flip an image if you need to, though.
 
    In the color mapper, you can then simply do something like:
    module ColorMapper(...)
    ...
    logic [7:0] ObjectR, ObjectG, ObjectB
    parameter ObjectXSize = 10'd10;
    parameter ObjectYSize = 10'd10;
    ...
    always_comb
    ...
         if(ObjectOn == 1'b1)
         begin
             Red = ObjectR
             Green = ObjectG
             Blue = ObjectB
         end
     ...
     ObjectSpriteTable ost(
                           .SpriteX(ObjectXSize - DistX), .SpriteY(ObjectYSize - DistY),
                           .SpriteR(ObjectR), .SpriteG(ObjectG), .SpriteB(ObjectB)
                           );
 
     See the comment at the top of the generation script if you're still confused.
*/
module Right(input [9:0] SpriteX, SpriteY,
            output [7:0] SpriteR, SpriteG, SpriteB);

logic [9:0] X_Index, Y_Index;

assign X_Index = SpriteX % 10'd8;
assign Y_Index = SpriteY % 10'd8;
logic [9:0] SpriteTableR;

parameter bit [7:0] SpritePaletteR[2:0] = '{8'd0, 8'd255, 8'd80};

	always_comb
	begin
		SpriteTableR = 10'd0;
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd0 && SpriteY < 10'd8)
		begin
		    SpriteTableR = SpriteTableR_0_0[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd8 && SpriteY < 10'd16)
		begin
		    SpriteTableR = SpriteTableR_0_1[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd16 && SpriteY < 10'd24)
		begin
		    SpriteTableR = SpriteTableR_0_2[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd24 && SpriteY < 10'd32)
		begin
		    SpriteTableR = SpriteTableR_0_3[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd32 && SpriteY < 10'd33)
		begin
		    SpriteTableR = SpriteTableR_0_4[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd0 && SpriteY < 10'd8)
		begin
		    SpriteTableR = SpriteTableR_1_0[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd8 && SpriteY < 10'd16)
		begin
		    SpriteTableR = SpriteTableR_1_1[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd16 && SpriteY < 10'd24)
		begin
		    SpriteTableR = SpriteTableR_1_2[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd24 && SpriteY < 10'd32)
		begin
		    SpriteTableR = SpriteTableR_1_3[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd32 && SpriteY < 10'd33)
		begin
		    SpriteTableR = SpriteTableR_1_4[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd0 && SpriteY < 10'd8)
		begin
		    SpriteTableR = SpriteTableR_2_0[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd8 && SpriteY < 10'd16)
		begin
		    SpriteTableR = SpriteTableR_2_1[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd16 && SpriteY < 10'd24)
		begin
		    SpriteTableR = SpriteTableR_2_2[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd24 && SpriteY < 10'd32)
		begin
		    SpriteTableR = SpriteTableR_2_3[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd32 && SpriteY < 10'd33)
		begin
		    SpriteTableR = SpriteTableR_2_4[Y_Index][X_Index];
		end
	end

parameter bit [1:0] SpriteTableR_0_0[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd1,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd1,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd1,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd1,2'd1,2'd1,2'd0},
'{2'd0,2'd0,2'd1,2'd1,2'd1,2'd1,2'd1,2'd1},
'{2'd0,2'd1,2'd1,2'd1,2'd1,2'd1,2'd1,2'd1}};

parameter bit [1:0] SpriteTableR_0_1[7:0][7:0] = '{'{2'd0,2'd1,2'd1,2'd1,2'd1,2'd1,2'd1,2'd1},
'{2'd0,2'd1,2'd1,2'd1,2'd1,2'd1,2'd0,2'd1},
'{2'd0,2'd1,2'd1,2'd1,2'd1,2'd0,2'd1,2'd1},
'{2'd2,2'd0,2'd1,2'd1,2'd1,2'd1,2'd0,2'd0},
'{2'd0,2'd2,2'd0,2'd1,2'd1,2'd1,2'd1,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd1,2'd1,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableR_0_2[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableR_0_3[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd1,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableR_0_4[7:0][0:0] = '{'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0}};

parameter bit [1:0] SpriteTableR_1_0[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd1,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd1,2'd1,2'd1,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableR_1_1[7:0][7:0] = '{'{2'd1,2'd1,2'd1,2'd1,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd1,2'd0,2'd1,2'd1,2'd0,2'd0,2'd0},
'{2'd1,2'd1,2'd1,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd1,2'd1,2'd1,2'd0,2'd1},
'{2'd1,2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd1,2'd0,2'd0,2'd1,2'd1,2'd0,2'd1},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableR_1_2[7:0][7:0] = '{'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd1,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableR_1_3[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableR_1_4[7:0][0:0] = '{'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0}};

parameter bit [1:0] SpriteTableR_2_0[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableR_2_1[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd1,2'd0,2'd0},
'{2'd1,2'd0,2'd1,2'd1,2'd1,2'd1,2'd1,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd1,2'd1,2'd1,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableR_2_2[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableR_2_3[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableR_2_4[7:0][0:0] = '{'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0}};

logic [9:0] SpriteTableG;

parameter bit [7:0] SpritePaletteG[3:0] = '{8'd0, 8'd56, 8'd224, 8'd88};

	always_comb
	begin
		SpriteTableG = 10'd0;
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd0 && SpriteY < 10'd8)
		begin
		    SpriteTableG = SpriteTableG_0_0[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd8 && SpriteY < 10'd16)
		begin
		    SpriteTableG = SpriteTableG_0_1[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd16 && SpriteY < 10'd24)
		begin
		    SpriteTableG = SpriteTableG_0_2[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd24 && SpriteY < 10'd32)
		begin
		    SpriteTableG = SpriteTableG_0_3[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd32 && SpriteY < 10'd33)
		begin
		    SpriteTableG = SpriteTableG_0_4[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd0 && SpriteY < 10'd8)
		begin
		    SpriteTableG = SpriteTableG_1_0[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd8 && SpriteY < 10'd16)
		begin
		    SpriteTableG = SpriteTableG_1_1[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd16 && SpriteY < 10'd24)
		begin
		    SpriteTableG = SpriteTableG_1_2[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd24 && SpriteY < 10'd32)
		begin
		    SpriteTableG = SpriteTableG_1_3[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd32 && SpriteY < 10'd33)
		begin
		    SpriteTableG = SpriteTableG_1_4[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd0 && SpriteY < 10'd8)
		begin
		    SpriteTableG = SpriteTableG_2_0[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd8 && SpriteY < 10'd16)
		begin
		    SpriteTableG = SpriteTableG_2_1[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd16 && SpriteY < 10'd24)
		begin
		    SpriteTableG = SpriteTableG_2_2[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd24 && SpriteY < 10'd32)
		begin
		    SpriteTableG = SpriteTableG_2_3[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd32 && SpriteY < 10'd33)
		begin
		    SpriteTableG = SpriteTableG_2_4[Y_Index][X_Index];
		end
	end

parameter bit [1:0] SpriteTableG_0_0[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd1,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd1,2'd2},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd1,2'd2},
'{2'd0,2'd0,2'd0,2'd0,2'd1,2'd2,2'd1,2'd0},
'{2'd0,2'd0,2'd1,2'd2,2'd2,2'd1,2'd1,2'd1},
'{2'd0,2'd1,2'd2,2'd2,2'd2,2'd2,2'd1,2'd2}};

parameter bit [1:0] SpriteTableG_0_1[7:0][7:0] = '{'{2'd0,2'd1,2'd2,2'd2,2'd2,2'd2,2'd1,2'd2},
'{2'd0,2'd1,2'd2,2'd2,2'd2,2'd1,2'd0,2'd2},
'{2'd0,2'd2,2'd2,2'd1,2'd1,2'd0,2'd2,2'd2},
'{2'd1,2'd0,2'd2,2'd2,2'd2,2'd1,2'd0,2'd0},
'{2'd0,2'd1,2'd0,2'd2,2'd2,2'd2,2'd2,2'd2},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd2,2'd2,2'd2},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd2},
'{2'd0,2'd0,2'd0,2'd0,2'd3,2'd3,2'd3,2'd3}};

parameter bit [1:0] SpriteTableG_0_2[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd3,2'd3,2'd2},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd3},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd3,2'd3},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd3,2'd0,2'd3},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd3,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd3,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd3,2'd0,2'd3}};

parameter bit [1:0] SpriteTableG_0_3[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd3,2'd3},
'{2'd0,2'd0,2'd0,2'd0,2'd3,2'd0,2'd3,2'd2},
'{2'd0,2'd0,2'd3,2'd3,2'd0,2'd3,2'd3,2'd3},
'{2'd0,2'd0,2'd0,2'd3,2'd0,2'd3,2'd2,2'd2},
'{2'd0,2'd0,2'd0,2'd3,2'd0,2'd3,2'd3,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd3,2'd3,2'd3},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd3,2'd3,2'd3},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd3,2'd3,2'd3}};

parameter bit [1:0] SpriteTableG_0_4[7:0][0:0] = '{'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0}};

parameter bit [1:0] SpriteTableG_1_0[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd2,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd2,2'd1,2'd2,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableG_1_1[7:0][7:0] = '{'{2'd2,2'd1,2'd1,2'd2,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd1,2'd0,2'd1,2'd2,2'd0,2'd0,2'd0},
'{2'd2,2'd1,2'd1,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd2,2'd2,2'd2,2'd0,2'd2},
'{2'd2,2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd1,2'd0,2'd0,2'd1,2'd1,2'd0,2'd1},
'{2'd2,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd3,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableG_1_2[7:0][7:0] = '{'{2'd2,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd3,2'd3,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd3,2'd2,2'd3,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd3,2'd3,2'd3,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd3,2'd2,2'd3,2'd0,2'd0,2'd0,2'd0},
'{2'd3,2'd3,2'd3,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd3,2'd3,2'd3,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd3,2'd2,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableG_1_3[7:0][7:0] = '{'{2'd3,2'd3,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd3,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd3,2'd3,2'd3,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableG_1_4[7:0][0:0] = '{'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0}};

parameter bit [1:0] SpriteTableG_2_0[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableG_2_1[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd1,2'd0,2'd0},
'{2'd2,2'd0,2'd2,2'd1,2'd2,2'd1,2'd2,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd1,2'd1,2'd1,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableG_2_2[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableG_2_3[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableG_2_4[7:0][0:0] = '{'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0}};

logic [9:0] SpriteTableB;

parameter bit [7:0] SpritePaletteB[2:0] = '{8'd0, 8'd176, 8'd248};

	always_comb
	begin
		SpriteTableB = 10'd0;
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd0 && SpriteY < 10'd8)
		begin
		    SpriteTableB = SpriteTableB_0_0[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd8 && SpriteY < 10'd16)
		begin
		    SpriteTableB = SpriteTableB_0_1[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd16 && SpriteY < 10'd24)
		begin
		    SpriteTableB = SpriteTableB_0_2[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd24 && SpriteY < 10'd32)
		begin
		    SpriteTableB = SpriteTableB_0_3[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd0 && SpriteX < 10'd8 && SpriteY >= 10'd32 && SpriteY < 10'd33)
		begin
		    SpriteTableB = SpriteTableB_0_4[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd0 && SpriteY < 10'd8)
		begin
		    SpriteTableB = SpriteTableB_1_0[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd8 && SpriteY < 10'd16)
		begin
		    SpriteTableB = SpriteTableB_1_1[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd16 && SpriteY < 10'd24)
		begin
		    SpriteTableB = SpriteTableB_1_2[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd24 && SpriteY < 10'd32)
		begin
		    SpriteTableB = SpriteTableB_1_3[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd8 && SpriteX < 10'd16 && SpriteY >= 10'd32 && SpriteY < 10'd33)
		begin
		    SpriteTableB = SpriteTableB_1_4[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd0 && SpriteY < 10'd8)
		begin
		    SpriteTableB = SpriteTableB_2_0[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd8 && SpriteY < 10'd16)
		begin
		    SpriteTableB = SpriteTableB_2_1[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd16 && SpriteY < 10'd24)
		begin
		    SpriteTableB = SpriteTableB_2_2[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd24 && SpriteY < 10'd32)
		begin
		    SpriteTableB = SpriteTableB_2_3[Y_Index][X_Index];
		end
		else
		if(SpriteX >= 10'd16 && SpriteX < 10'd24 && SpriteY >= 10'd32 && SpriteY < 10'd33)
		begin
		    SpriteTableB = SpriteTableB_2_4[Y_Index][X_Index];
		end
	end

parameter bit [1:0] SpriteTableB_0_0[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd1,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd1,2'd1,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd1,2'd1,2'd1,2'd1,2'd0,2'd1}};

parameter bit [1:0] SpriteTableB_0_1[7:0][7:0] = '{'{2'd0,2'd0,2'd1,2'd1,2'd1,2'd1,2'd0,2'd1},
'{2'd0,2'd0,2'd1,2'd1,2'd1,2'd0,2'd0,2'd1},
'{2'd0,2'd1,2'd1,2'd0,2'd0,2'd0,2'd1,2'd1},
'{2'd0,2'd0,2'd1,2'd1,2'd1,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd1,2'd1,2'd1,2'd1,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd1,2'd1,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd2,2'd2,2'd2,2'd2}};

parameter bit [1:0] SpriteTableB_0_2[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd2,2'd2,2'd1},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd2},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd2,2'd2},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd2,2'd0,2'd2},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd2,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd2,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd2,2'd0,2'd2}};

parameter bit [1:0] SpriteTableB_0_3[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd2,2'd2},
'{2'd0,2'd0,2'd0,2'd0,2'd2,2'd0,2'd2,2'd1},
'{2'd0,2'd0,2'd2,2'd2,2'd0,2'd2,2'd2,2'd2},
'{2'd0,2'd0,2'd0,2'd2,2'd0,2'd2,2'd1,2'd1},
'{2'd0,2'd0,2'd0,2'd2,2'd0,2'd2,2'd2,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd2,2'd2,2'd2},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd2,2'd2,2'd2},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd2,2'd2,2'd2}};

parameter bit [1:0] SpriteTableB_0_4[7:0][0:0] = '{'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0}};

parameter bit [1:0] SpriteTableB_1_0[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd1,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd1,2'd0,2'd1,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableB_1_1[7:0][7:0] = '{'{2'd1,2'd0,2'd0,2'd1,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd0,2'd0,2'd1,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd1,2'd1,2'd1,2'd0,2'd1},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableB_1_2[7:0][7:0] = '{'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd2,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd1,2'd2,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd2,2'd2,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd2,2'd1,2'd2,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd2,2'd2,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd2,2'd2,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableB_1_3[7:0][7:0] = '{'{2'd2,2'd2,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd2,2'd2,2'd2,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableB_1_4[7:0][0:0] = '{'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0}};

parameter bit [1:0] SpriteTableB_2_0[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableB_2_1[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd1,2'd0,2'd1,2'd0,2'd1,2'd0,2'd1,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableB_2_2[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableB_2_3[7:0][7:0] = '{'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0},
'{2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0,2'd0}};

parameter bit [1:0] SpriteTableB_2_4[7:0][0:0] = '{'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0},
'{2'd0}};

assign SpriteR = SpritePaletteR[SpriteTableR];
assign SpriteG = SpritePaletteG[SpriteTableG];
assign SpriteB = SpritePaletteB[SpriteTableB];

endmodule
