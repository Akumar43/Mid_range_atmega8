
#include "board.h"
#include "lib_code.h"
#include "interrupt.h"
#include "board.h"
extern int channelB;

void InitTimer2();
void  Pwm_Start();


//////////////////////PORT INIIALIZATIONS///////////////////////////////////////
void port_init(void)
{
 DDRC=0x00;
 DDRB=0xFF;
 DDRD=0xE0;         //1110 0000        
 PORTC=0x00;
 PORTB=0x00;
}
//////////////////////PORT INIIALIZATIONS///////////////////////////////////////

void protocol_init()
{
        InitTimer1();
        Port_init();
        Adc_init();
        Pwm_Start();
        UART1_Init(9600);

}

void update_IO_port()
{
//PORTB = channelB;       - portb is upadted  in interrupt routine
                            //OC2  - pinb2 is controlled by timer has to be disabled if used as IO
}

void Pwm_Start()                   // TIMER2 USED FOR PWM
{
SREG_I_bit = 1;
TCCR2=(1<<WGM21)|(1<<WGM20)|(1<<COM21)|(1<<CS20)| (1<<CS21)| (1<<CS22)  ;
OCR2= 10;
}