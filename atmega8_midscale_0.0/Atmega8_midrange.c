///---------------project settings------------------------------------
// NOTE: DOnt forget to disable MCLR pin
// dont forget to put internal oscillator or two pins cannot be used
// internal oscillator is 4MHz remember
//PWM not working with RA5 has been changed to RC5
///---------------project settings------------------------------------
#include "lib_code.h"
#include "interrupt.h"
#include "board.h"
void update_IO_porta();


volatile int port_a =0x00;
void main()
{
extern int pulse_width;
protocol_init();
port_init();

while(1)
 {
   pulse_width =130;                                                // setting the pusle width here
   TOGGLE_BIT(port_a,0);                                          // blink check
   delay_ms(100);

   if(BUTTON())       // using PORTA.f3 MCLR latched pin / this PIn cannot be used for output
   {
    BUT_LED_TEST(SET_BIT_1);
   }
   else
   {
    BUT_LED_TEST(CLEAR_BIT_0);
   }

   if( VOLT_DIV_MEASURE_CH1() > 5000)   // value in milli volts
   {
     ADC_LED_TEST(1) ;
   }
   else
   {
     ADC_LED_TEST(0) ;
   }
     update_IO_porta();
 }
}


void update_IO_porta()
{
        
PORTB = port_a;
        
}