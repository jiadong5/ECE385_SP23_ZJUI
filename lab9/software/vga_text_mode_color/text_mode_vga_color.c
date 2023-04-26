/*
 * text_mode_vga_color.c
 * Minimal driver for text mode VGA support
 * This is for Week 2, with color support
 *
 *  Created on: Oct 25, 2021
 *      Author: zuofu
 */

#include <system.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <alt_types.h>
#include "text_mode_vga_color.h"
#include "palette_test.h"

void textVGAColorClr()
{
	for (int i = 0; i<(ROWS*COLUMNS) * 2; i++)
	{
		vga_ctrl->VRAM[i] = 0x00;
	}
    for (int i = 0; i < 8; i++)
        vga_ctrl->PALETTE[i] = 0x00000000;
}

void textVGADrawColorText(char* str, int x, int y, alt_u8 background, alt_u8 foreground)
{
	int i = 0;
	while (str[i]!=0)
	{
		vga_ctrl->VRAM[(y*COLUMNS + x + i) * 2] = foreground << 4 | background;
		vga_ctrl->VRAM[(y*COLUMNS + x + i) * 2 + 1] = str[i];
		i++;
	}
}

void setColorPalette (alt_u8 color, alt_u8 red, alt_u8 green, alt_u8 blue)
{
	//fill in this function to set the color palette starting at offset 0x0000 2000 (from base)
	// If even, in letter 16 bits
    if (color % 2 == 0)
    {
    	vga_ctrl->PALETTE[color / 2] &= 0xFFFFE000;
        vga_ctrl->PALETTE[color / 2] |= red << 9 | green << 5 | blue << 1;
    }
    else
    {
    	vga_ctrl->PALETTE[color / 2] &= 0x00001FFF;
        vga_ctrl->PALETTE[color / 2] |= red << 21 | green << 17 | blue << 13;
    }

//    if (color == 0)
//    {
//    	vga_ctrl->PALETTE[0] = 0x00000000;
//    }


}


void textVGAColorScreenSaver()
{
	//This is the function you call for your week 2 demo
	char color_string[80];
    int fg, bg, x, y;
	textVGAColorClr();
	//initialize palette
	for (int i = 0; i < 16; i++)
	{
		setColorPalette (i, colors[i].red, colors[i].green, colors[i].blue);
	}
	while (1)
	{
		fg = rand() % 16;
		bg = rand() % 16;
		while (fg == bg)
		{
			fg = rand() % 16;
			bg = rand() % 16;
		}
		sprintf(color_string, "Drawing %s text with %s background", colors[fg].name, colors[bg].name);
		x = rand() % (80-strlen(color_string));
		y = rand() % 30;
		textVGADrawColorText (color_string, x, y, bg, fg);
		usleep (100000);
	}
}

void textVGAReadWriteTest()
{
	//Register write and readback test
	alt_u32 checksum[ROWS], readsum[ROWS];

	for (int j = 0; j < ROWS; j++)
	{
		checksum[j] = 0;
		for (int i = 0; i < COLUMNS; i++)
		{
			vga_ctrl->VRAM[j*COLUMNS + i] = i + j;
			checksum[j] += i + j;
		}
	}
	for (int j = 0; j < ROWS; j++)
	{
		readsum[j] = 0;
		for (int i = 0; i < COLUMNS; i++)
		{
			readsum[j] += vga_ctrl->VRAM[j*COLUMNS + i];
			//printf ("%x \n\r", vga_ctrl->VRAM[j*COLUMNS + i]);
		}
		printf ("Row: %d, Checksum: %x, Read-back Checksum: %x\n\r", j, checksum[j], readsum[j]);
		if (checksum[j] != readsum[j])
		{
			printf ("Checksum mismatch!, check your Avalon-MM code\n\r");
			while (1){};
		}
	}
	printf("Checksum match!\n");
}

void PaletteRegReadWriteTest()
{
	alt_u32 check[8], read[8];
	for (int i = 0; i < 8; i ++)
	{
		vga_ctrl->PALETTE[i] = i;
		check[i] = i;
	}
	for (int j = 0; j < 8; j++)
	{
		read[j] = vga_ctrl->PALETTE[j];
	}
	for (int i = 0; i < 8; i++)
	{
		printf("check: %x, read: %x\n", check[i],read[i]);
		if (check[i] != read[i])
		{
			printf("Palette mismatch!\n");
			while (1){};
		}
	}
	printf("Palette Read Write match!\n");
}
int main()
{
	PaletteRegReadWriteTest();
	textVGAReadWriteTest();

    paletteTest();
    textVGAColorScreenSaver();


}
