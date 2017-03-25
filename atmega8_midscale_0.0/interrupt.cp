#line 1 "E:/startup_codes/atmega8_midscale/interrupt.c"
int i=0;
int pulse_width =175;
#line 16 "E:/startup_codes/atmega8_midscale/interrupt.c"
void InitTimer2(){
 SREG_I_bit = 1;
 OCR2 = 77;
 TCCR2 = 0x28;
 TCCR2 |= 0x07;
 OCIE2_bit = 1;
}



void InitTimer1(){
 SREG_I_bit = 1;
 TCCR1A = 0x80;
 TCCR1B = 0x09;
 OCR1AH = 0x0F;
 OCR1AL = 0x9F;
 OCIE1A_bit = 1;
}


void Timer2Overflow_ISR() org IVT_ADDR_TIMER2_COMP
{

}

void Timer1Overflow_ISR() org IVT_ADDR_TIMER1_COMPA {
 i=i++;
 if(i<pulse_width)
 PORTB |= 1 << 5;

 else if((i>=pulse_width) && (i< 255))
 PORTB &= ~(1 << 5);

 else
 i=0;
 }
