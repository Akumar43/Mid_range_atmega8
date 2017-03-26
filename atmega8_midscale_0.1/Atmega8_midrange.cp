#line 1 "E:/startup_codes/Atmega_midscale/atmega8_midscale/Atmega8_midrange.c"
#line 1 "e:/startup_codes/atmega_midscale/atmega8_midscale/lib_code.h"
#line 1 "e:/startup_codes/atmega_midscale/atmega8_midscale/interrupt.h"
extern void InitTimer0();
extern void InitTimer1();
#line 1 "e:/startup_codes/atmega_midscale/atmega8_midscale/board.h"
#line 22 "e:/startup_codes/atmega_midscale/atmega8_midscale/board.h"
extern void port_init(void) ;
extern void protocol_init();
extern void update_IO_port();
#line 14 "E:/startup_codes/Atmega_midscale/atmega8_midscale/Atmega8_midrange.c"
volatile int channel1 =0x00;
void main()
{
extern int pulse_width;
protocol_init();
port_init();
PORTB=0XFF;
while(1)
 {
  OCR2  = 100;
 pulse_width =130;
  ((channel1) ^= 1 << 0) ;
 delay_ms(100);

 if( ( (((PIND) & (1 << (1)) ) ? 1 : 0) ) )
 {
  { if ( 1 ) { (( channel1 ) |= (1 << (6)) ) ; } else { (( channel1 ) &= ~ (1 << (6)) ) ; } } ;
 }
 else
 {
  { if ( 0 ) { (( channel1 ) |= (1 << (6)) ) ; } else { (( channel1 ) &= ~ (1 << (6)) ) ; } } ;
 }

 if(  (ADC_Read( 0 )) * ( ( 5000f  / 1023f ) ) * ( 1f ) * ( ( ( 100f  + 100f ) / 100f  ) )  > 5000)
 {
  { if (1) { (( channel1 ) |= (1 << (2)) ) ; } else { (( channel1 ) &= ~ (1 << (2)) ) ; } }  ;
 }
 else
 {
  { if (0) { (( channel1 ) |= (1 << (2)) ) ; } else { (( channel1 ) &= ~ (1 << (2)) ) ; } }  ;
 }
  ((channel1) |= (1 << (7)) )  ;
  ((channel1) |= (1 << (4)) )  ;
  ((channel1) |= (1 << (3)) )  ;
  ((channel1) |= (1 << (1)) )  ;
 update_IO_port();
 }
}
