#line 1 "E:/startup_codes/Atmega_midscale/atmega8_midscale_TOP/Atmega8_midrange.c"
#line 1 "e:/startup_codes/atmega_midscale/atmega8_midscale_top/lib_code.h"
#line 1 "e:/startup_codes/atmega_midscale/atmega8_midscale_top/interrupt.h"
extern void InitTimer0();
extern void InitTimer1();
#line 1 "e:/startup_codes/atmega_midscale/atmega8_midscale_top/board.h"
#line 22 "e:/startup_codes/atmega_midscale/atmega8_midscale_top/board.h"
extern void port_init(void) ;
extern void protocol_init();
extern void update_IO_port();
#line 16 "E:/startup_codes/Atmega_midscale/atmega8_midscale_TOP/Atmega8_midrange.c"
volatile int channelB =0x00;


void Read_Inputs();
void Read_Analogs();
void Digital_outputs();
void Task1();


void main()
{
extern int pulse_width;
protocol_init();
port_init();

 OCR2  = 100;
pulse_width =125;
while(1)
 {
 Task1();
 Read_Inputs();
 Read_Analogs();
 digital_outputs();

 }
}
#line 46 "E:/startup_codes/Atmega_midscale/atmega8_midscale_TOP/Atmega8_midrange.c"
void Read_Inputs()
{

 if( (((PIND) & (1 << (2)) ) ? 1 : 0) )
 {
  ((channelB) |= (1 << (7)) )  ;
 }
 else
 {
  ((channelB) &= ~ (1 << (7)) ) ;
 }
}
#line 61 "E:/startup_codes/Atmega_midscale/atmega8_midscale_TOP/Atmega8_midrange.c"
void Read_Analogs()
{
 if(  (ADC_Read( 0 )) * ( ( 5000f  / 1023f ) ) * ( 1f ) * ( ( ( 100f  + 100f ) / 100f  ) )  > 5000)
 {
  ((channelB) |= (1 << (6)) )  ;
 }
 else
 {
  ((channelB) &= ~ (1 << (6)) )  ;
 }

 if( ADC_Read(1) > 512)
 {
  ((channelB) |= (1 << (4)) )  ;
 }
 else
 {
  ((channelB) &= ~ (1 << (4)) )  ;
 }


}

void digital_outputs()
{
  ((channelB) |= (1 << (1)) )  ;


  ((DDRC) |= (1 << (5)) )  ;
  ((DDRC) |= (1 << (4)) )  ;

  ((PORTC) &= ~ (1 << (5)) )  ;
  ((PORTC) |= (1 << (4)) )  ;
}

void Task1()
{
 UART_Write_Text("char ");
  ((channelB) ^= 1 << 0) ;
 delay_ms(1000);
}
