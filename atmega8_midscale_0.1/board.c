//1         PORTC6        RESET/OUTPUT      -        //15        PORTC5        OUTPUT
//2         PORTD0        RX                -        //16        PORTC4        OUTPUT
//3         PORTD1        TX                -        //17        PORTC3        ANALOG-3
//4         PORTD2        INPUTS            -        //18        PORTC2        ANALOG-2
//5         PORTD3        INPUTS            -        //19        PORTC1        ANALOG-1
//6         PORTD4        INPUTS            -        //20        PORTC0        ANALOG-0
//7         VCC                             -        //21        GND
//8         GND                             -        //22        AREF
//9         PORTB6        OUTPUT-7SEG       -        //23        VCC
//10        PORTB7        OUTPUT-7SEG       -        //24        PORTB5        OUTPUT-7SEG
//11        PORTD5        OUTPUT-7SEG       -        //25        PORTB4        OUTPUT-7SEG
//12        PORTD6        OUTPUT-7SEG       -        //26        PORTB3        OUTPUT-7SEG
//13        PORTD7         OUTPUT-7SEG      -        //27        PORTB2        OUTPUT-7SEG
//14        PORTB0        OUTPUT-7SEG       -        //28        PORTB1        OUTPUT-7SEG

#include "board.h"
#include "lib_code.h"
#include "interrupt.h"
#include "board.h"


extern int channel1;

void InitTimer2();
void  Pwm_Start();
void port_init(void)
{
 DDRC=0x00;
 DDRB=0xFF;
 DDRD=0xE0;         //1110 0000        
 PORTC=0x00;
 PORTB=0x00;
        
// set multiplexed ports here---------------------
}

void protocol_init()
{
        InitTimer1();
        Port_init();
        Adc_init();
        Pwm_Start();
}

void update_IO_port()
{
PORTB = channel1;
//OC2  - pinb2 is controlled by timer has to be disabled if used as IO
}

void Pwm_Start()     // TIMER2 USED FOR PWM
{
SREG_I_bit = 1;
TCCR2=(1<<WGM21)|(1<<WGM20)|(1<<COM21)|(1<<CS20)| (1<<CS21)| (1<<CS22)  ;
OCR2= 10;

}