#line 1 "E:/startup_codes/Atmega_midscale/atmega8_midscale/board.c"
#line 1 "e:/startup_codes/atmega_midscale/atmega8_midscale/board.h"
#line 22 "e:/startup_codes/atmega_midscale/atmega8_midscale/board.h"
extern void port_init(void) ;
extern void protocol_init();
extern void update_IO_port();
#line 1 "e:/startup_codes/atmega_midscale/atmega8_midscale/lib_code.h"
#line 1 "e:/startup_codes/atmega_midscale/atmega8_midscale/interrupt.h"
extern void InitTimer0();
extern void InitTimer1();
#line 1 "e:/startup_codes/atmega_midscale/atmega8_midscale/board.h"
#line 22 "e:/startup_codes/atmega_midscale/atmega8_midscale/board.h"
extern void port_init(void) ;
extern void protocol_init();
extern void update_IO_port();
#line 22 "E:/startup_codes/Atmega_midscale/atmega8_midscale/board.c"
extern int channel1;

void InitTimer2();
void Pwm_Start();
void port_init(void)
{
 DDRC=0x00;
 DDRB=0xFF;
 DDRD=0xE0;
 PORTC=0x00;
 PORTB=0x00;


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

}

void Pwm_Start()
{
SREG_I_bit = 1;
TCCR2=(1<<WGM21)|(1<<WGM20)|(1<<COM21)|(1<<CS20)| (1<<CS21)| (1<<CS22) ;
OCR2= 10;

}
