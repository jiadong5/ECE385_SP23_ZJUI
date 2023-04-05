// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng

#include <stdint.h>

int main()
{
	volatile uint8_t *LED_PIO = (uint8_t*)0x50; //make a pointer to access the PIO block
    volatile uint8_t *SW_PIO = (uint8_t*)0x30;
    volatile uint8_t *KEY_PIO = (uint8_t*)0x20; // 11 at start

	*LED_PIO = 0; //clear all LEDs
    
	while ( (1+1) != 3) //infinite loop
	{

        // If accumulate is pressed
        if ( ~(*KEY_PIO) & 0x02)
        {
            *LED_PIO += *SW_PIO;
            // Wait untl accumulate button is not pressed
            while (1)
            {
                if ((~(*KEY_PIO) & 0x02) == 0)
                    break;
            }
        }

        // If reset is pressed
        if( ~(*KEY_PIO) & 0x01)
            *LED_PIO = 0x00;

	}

	return 1; //never gets here
}
