///---------------project NOTES------------------------------------
//OC2  - pinb2 is controlled by timer has to be disabled if used as IO.
//AVCC and AREF has to be pulled high for ADC.
//Timer2 and TImer0 could not be used till now Timer1 works fine
//Similarly OC1A and OC1B are latched with timers if timers are enalbed they wont act as GPIO

// to check which ports are input output refer board.c
//BLINK --INPUT- ADC --
///---------------project NOTES---------------------------------------------------------------------------
#include "lib_code.h"
#include "interrupt.h"
#include "board.h"


//----------------------globalvariables
volatile int channelB =0x00;

//----------------------Function declaration---------
void Read_Inputs();
void Read_Analogs();
void Digital_outputs();
void Task1();

///////////------------------MAIN------------------///////////
void main()
{
extern int pulse_width;
protocol_init();
port_init();
//------------initized parameters
INT_PWM_DUTY = 100;
pulse_width =125;     // setting the pusle width here        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
while(1)
 {
   Task1();
   Read_Inputs();
   Read_Analogs();
   digital_outputs();

 }
}
//-------------------------------------------------------
/*
 D.7,D.6,D.5, DDRD=0xE0;         //1110 0000
*/
void Read_Inputs()
{

    if(TEST_BIT(PIND,2))       // checked for all pin d0-d4
   {
    SET_BIT(channelB,7) ;
   }
   else
   {
    CLEAR_BIT(channelB,7);
   }
}
 /*
 adc 0-3     4,5 dont use
*/
void Read_Analogs()
{
   if( VOLT_DIV_AN0() > 5000)   // value in milli volts
   {
     SET_BIT(channelB,6) ;
   }
   else
   {
     CLEAR_BIT(channelB,6) ;
   }
   
      if( ADC_Read(1) > 512)   // value in milli volts
   {
     SET_BIT(channelB,4) ;
   }
   else
   {
     CLEAR_BIT(channelB,4) ;
   }
   
   
}
 ///
void digital_outputs()
{
     SET_BIT(channelB,1)    ;       //PORTB1 as output
     /////////
    // SET_BIT(DDRC,6)    ;               // rst pin cannot be used as it is programmingpin
    SET_BIT(DDRC,5)    ;
    SET_BIT(DDRC,4)    ;
    
    CLEAR_BIT(PORTC,5)   ;
    SET_BIT(PORTC,4)    ;
}

void Task1()
{
     UART_Write_Text("char ");
    TOGGLE_BIT(channelB,0);
    delay_ms(1000);
}
