//--only one timer is used, there were problem with other timers so was removed.
//-- it can be added dependent on project specific requirement
 //--------------------------------------------------------------------------------------------------
int i=0;
int pulse_width =175;
 
//Prescaler 1:1; TMR1 Preload = 64536; Actual Interrupt Time : 500 us  2000 Hz-
//Place/Copy this part in declaration section  PWM Generation-
void InitTimer1(){
  SREG_I_bit = 1;
  TCCR1A = 0x00;
  TCCR1B = 0x09;
  OCR1AH = 0x0F;
  OCR1AL = 0x9F;
  OCIE1A_bit = 1;
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