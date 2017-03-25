#line 1 "E:/startup_codes/atmega8_midscale/board.c"
#line 1 "e:/startup_codes/atmega8_midscale/board.h"
#line 22 "e:/startup_codes/atmega8_midscale/board.h"
extern void port_init(void) ;
extern void protocol_init();
#line 1 "e:/startup_codes/atmega8_midscale/lib_code.h"
#line 1 "e:/startup_codes/atmega8_midscale/interrupt.h"
extern void InitTimer0();
extern void InitTimer1();
#line 1 "e:/startup_codes/atmega8_midscale/board.h"
#line 22 "e:/startup_codes/atmega8_midscale/board.h"
extern void port_init(void) ;
extern void protocol_init();
#line 20 "E:/startup_codes/atmega8_midscale/board.c"
void InitTimer2();
void port_init(void)
{
 DDRC=0x00;
 DDRB=0xFF;
 DDRD=0xE0;

 PORTC=0x00;
 PORTB=0x00;






}

void protocol_init()
{ InitTimer2();

 InitTimer1();
 Port_init();
 Adc_init();
}
