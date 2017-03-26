///---------------project NOTES------------------------------------
  //OC2  - pinb2 is controlled by timer has to be disabled if used as IO.
  //AVCC and AREF has to be pulled high for ADC.
  //Timer2 and TImer0 could be used till now Timer1 works fine
  //Similarly OC1A and OC1B are latched with timers if timers are enalbed they wont act as GPIO
  
///---------------project NOTES------------------------------------
#include "lib_code.h"
#include "interrupt.h"
#include "board.h"



volatile int channel1 =0x00;
void main()
{
extern int pulse_width;
protocol_init();
port_init();
PORTB=0XFF;
while(1)
 {
   INT_PWM_DUTY = 100;
   pulse_width =130;                                                // setting the pusle width here
   TOGGLE_BIT(channel1,0);                                          // blink check
   delay_ms(100);

   if(BUTTON)       // using PORTA.f3 MCLR latched pin / this PIn cannot be used for output
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
     SET_BIT(channel1,7)    ;
     SET_BIT(channel1,4)    ;
     SET_BIT(channel1,3)    ;
     SET_BIT(channel1,1)    ;
     update_IO_port();
 }
}