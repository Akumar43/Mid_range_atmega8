int i=0;
int pulse_width =175;

//Timer0
//Prescaler 1:8; TMR0 Preload = 6; Actual Interrupt Time : 1 ms
/*void InitTimer0(){                 // timer 0 has no compare vector table
  SREG_I_bit = 1;                  // only overflow vector table
  TCNT0 = 124;        //OCR0
  TCCR0 = 0x28;
  TCCR0 |= 0x03;
  TOIE0_bit =1; //OCIE0_bit = 1;
}         */

//Timer2 Prescaler = 32; Preload = 249; Actual Interrupt Time = 10 ms

void InitTimer2(){
  SREG_I_bit = 1;
  OCR2 = 77;                                  // timer not working properly
  TCCR2 = 0x28;
  TCCR2 |= 0x07;
  OCIE2_bit = 1;
}

//Prescaler 1:1; TMR1 Preload = 64536; Actual Interrupt Time : 500 us  2000 Hz-
//Place/Copy this part in declaration section  PWM Generation-
void InitTimer1(){
    SREG_I_bit = 1;
  TCCR1A = 0x80;
  TCCR1B = 0x09;
  OCR1AH = 0x0F;
  OCR1AL = 0x9F;
  OCIE1A_bit = 1;
}

//---------------------Interrupt Routines------------------------------
void Timer2Overflow_ISR() org IVT_ADDR_TIMER2_COMP
{
    //PORTB.f4=~PORTB.f4;
}

void Timer1Overflow_ISR() org IVT_ADDR_TIMER1_COMPA {
    i=i++;
    if(i<pulse_width)
        PORTB |= 1 << 5;  //setting a bit
        
    else if((i>=pulse_width) && (i< 255))
       PORTB &= ~(1 << 5);
        
    else
        i=0;
  }

