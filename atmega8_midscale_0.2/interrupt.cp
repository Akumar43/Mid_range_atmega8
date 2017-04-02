#line 1 "E:/startup_codes/Atmega_midscale/atmega8_midscale_TOP/interrupt.c"
#line 1 "e:/startup_codes/atmega_midscale/atmega8_midscale_top/lib_code.h"
#line 1 "e:/startup_codes/atmega_midscale/atmega8_midscale_top/interrupt.h"
extern void InitTimer0();
extern void InitTimer1();
#line 1 "e:/startup_codes/atmega_midscale/atmega8_midscale_top/board.h"
#line 22 "e:/startup_codes/atmega_midscale/atmega8_midscale_top/board.h"
extern void port_init(void) ;
extern void protocol_init();
extern void update_IO_port();
#line 7 "E:/startup_codes/Atmega_midscale/atmega8_midscale_TOP/interrupt.c"
int counter=0;
int pulse_width =175;
volatile extern int channelB ;

void InitTimer1(){
 OCIE1A_bit = 1;
 SREG_I_bit = 1;
 TCCR1A = 0x00;
 TCCR1B = 0x0A;
 OCR1AH = 0x30;
 OCR1AL = 0xD3;
 OCIE1A_bit = 1;
}

void Timer1Overflow_ISR() org IVT_ADDR_TIMER1_COMPA
{
  ((channelB) ^= 1 << 5) ;
 PORTB = channelB;

}
