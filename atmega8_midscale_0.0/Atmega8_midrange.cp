#line 1 "E:/startup_codes/atmega8_midscale/Atmega8_midrange.c"
#line 1 "e:/startup_codes/atmega8_midscale/lib_code.h"
#line 1 "e:/startup_codes/atmega8_midscale/interrupt.h"
extern void InitTimer0();
extern void InitTimer1();
#line 1 "e:/startup_codes/atmega8_midscale/board.h"
#line 22 "e:/startup_codes/atmega8_midscale/board.h"
extern void port_init(void) ;
extern void protocol_init();
#line 10 "E:/startup_codes/atmega8_midscale/Atmega8_midrange.c"
void update_IO_porta();


volatile int port_a =0x00;
void main()
{
extern int pulse_width;
protocol_init();
port_init();

while(1)
 {
 pulse_width =130;
  ((port_a) ^= 1 << 0) ;
 delay_ms(100);

 if( ( (((PIND) & (1 << (1)) ) ? 1 : 0) ) )
 {
  { if ( 1 ) { (( port_a ) |= (1 << (6)) ) ; } else { (( port_a ) &= ~ (1 << (6)) ) ; } } ;
 }
 else
 {
  { if ( 0 ) { (( port_a ) |= (1 << (6)) ) ; } else { (( port_a ) &= ~ (1 << (6)) ) ; } } ;
 }

 if(  (ADC_Read( 0  )) * ( ( 5000f  / 1023f ) ) * ( 1f ) * ( ( ( 100f  + 100f ) / 100f  ) )  > 5000)
 {
  { if (1) { (( port_a ) |= (1 << (2)) ) ; } else { (( port_a ) &= ~ (1 << (2)) ) ; } }  ;
 }
 else
 {
  { if (0) { (( port_a ) |= (1 << (2)) ) ; } else { (( port_a ) &= ~ (1 << (2)) ) ; } }  ;
 }
 update_IO_porta();
 }
}


void update_IO_porta()
{

PORTB = port_a;

}
