


module blood (
                input Clk,
                input [9:0] Player_Blood,
                input [8:0] PixelX, PixelY,
                input Godmode_On,
                
                output logic is_obj,
                output logic [4:0] Obj_Index,    // Index of color palette
                output logic [8:0] Obj_address
);

    parameter [8:0] Width = 13;
    parameter [8:0] Height = 13;
    parameter [8:0] TotalWidth = Width * 5;
    parameter [8:0] Player_Full_Blood_NoGod = 9'd50;

    logic [8:0] Obj_X_Pos, Obj_Y_Pos; // Position of left digit

    assign Obj_X_Pos = 5;
    assign Obj_Y_Pos = 16;

    int DistX,DistY;
    assign DistX = PixelX - Obj_X_Pos;
    assign DistY = PixelY - Obj_Y_Pos;

    // Draw
    always_comb begin
        is_obj = 1'b0;
        Obj_address = 0;

        if (Godmode_On) begin
            if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + TotalWidth)) &&
                (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + 3 * Height))) begin
                    is_obj = 1'b1;
                    /////// Shit code
                    if (Player_Blood <= 100) begin
                        if ( DistY <= Height) begin
                            if (DistX <= (Player_Blood / 10) * Width ) begin
                                Obj_address = (DistX % Width) + (DistY % Height) * Width;
                            end
                            else begin
                                Obj_address = (DistX % Width) + (DistY % Height) * Width + Width * Height;
                            end
                        end
                        else begin
                            Obj_address = (DistX % Width) + (DistY % Height) * Width + Width * Height;
                        end
                    end
                    else if (Player_Blood <= 200) begin
                        if (DistY <= Height) 
                            Obj_address = (DistX % Width) + (DistY % Height) * Width;
                        else if (DistY <= Height * 2) begin
                            if (DistX <= ((Player_Blood - 100) / 10) * Width ) begin
                                Obj_address = (DistX % Width) + (DistY % Height) * Width;
                            end
                            else begin
                                Obj_address = (DistX % Width) + (DistY % Height) * Width + Width * Height;
                            end
                        end
                        else 
                            Obj_address = (DistX % Width) + (DistY % Height) * Width + Width * Height;

                    end
                    else begin
                        if(DistY <= Height * 2)
                        Obj_address = (DistX % Width) + (DistY % Height) * Width;
                        else begin
                            if (DistX <= ((Player_Blood - 200) / 10) * Width ) begin
                                Obj_address = (DistX % Width) + (DistY % Height) * Width;
                            end
                            else begin
                                Obj_address = (DistX % Width) + (DistY % Height) * Width + Width * Height;
                            end
                        end
                    end
                    ////////////////////////
            end
        end
        // Normal Mode
        else begin
            if ((PixelX >= Obj_X_Pos) && (PixelX < (Obj_X_Pos + TotalWidth)) &&
                (PixelY >= Obj_Y_Pos) && (PixelY < (Obj_Y_Pos + Height))) begin
                    is_obj = 1'b1;
                    if (DistX <= (Player_Blood / 10) * Width ) begin
                        Obj_address = (DistX % 13) + DistY * Width;
                    end
                    else begin
                        Obj_address = (DistX % 13) + DistY * Width + Width * Height;
                    end
            end
        end
    end



endmodule
