//--only one timer is used, there were problem with other timers so was removed.
//-- it can be added dependent on project specific requirement
 //--------------------------------------------------------------------------------------------------
#include "lib_code.h"
#include "interrupt.h"
#include "board.h"
int counter=0;
int pulse_width =175;
volatile extern int channelB ;
//Timer1 Prescaler = 64; Preload = 12499; Actual Interrupt Time = 100 ms
void InitTimer1(){
  OCIE1A_bit = 1;
  SREG_I_bit = 1;
  TCCR1A = 0x00;            //0x80 will enable   OC1A PWM put it zero
  TCCR1B = 0x0A;            // Used for prescaling timer, has to be taken from timer genrator, 4th bit can be
  OCR1AH = 0x30;
  OCR1AL = 0xD3;
   OCIE1A_bit = 1;
}

void Timer1Overflow_ISR() org IVT_ADDR_TIMER1_COMPA 
{
     TOGGLE_BIT(channelB,5);                      //the timer value  must be more than the main delay routine
     PORTB = channelB;

}
 
 
  
 /*
void Timer1Overflow_ISR() org IVT_ADDR_TIMER1_COMPA {

    counter=counter+1;                                                   for configuring as timer    TCCR1B = 0x09;   use     PORTB
                                                                         for configuring as timer    TCCR1B = 0x0A or above;   use     CHANNELB
    pulse_width =10;               / doesnt work atleast in proteus
    if(counter<pulse_width)
        PORTB |= 1 << 5;  //setting a bit

    else if((counter>=pulse_width) && (counter< 255))
       PORTB &= ~(1 << 5);
    else
        counter=0;
  }*/