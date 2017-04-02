
_InitTimer1:

;interrupt.c,11 :: 		void InitTimer1(){
;interrupt.c,12 :: 		OCIE1A_bit = 1;
	IN         R27, OCIE1A_bit+0
	SBR        R27, BitMask(OCIE1A_bit+0)
	OUT        OCIE1A_bit+0, R27
;interrupt.c,13 :: 		SREG_I_bit = 1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;interrupt.c,14 :: 		TCCR1A = 0x00;            //0x80 will enable   OC1A PWM put it zero
	LDI        R27, 0
	OUT        TCCR1A+0, R27
;interrupt.c,15 :: 		TCCR1B = 0x0A;            // Used for prescaling timer, has to be taken from timer genrator, 4th bit can be
	LDI        R27, 10
	OUT        TCCR1B+0, R27
;interrupt.c,16 :: 		OCR1AH = 0x30;
	LDI        R27, 48
	OUT        OCR1AH+0, R27
;interrupt.c,17 :: 		OCR1AL = 0xD3;
	LDI        R27, 211
	OUT        OCR1AL+0, R27
;interrupt.c,18 :: 		OCIE1A_bit = 1;
	IN         R27, OCIE1A_bit+0
	SBR        R27, BitMask(OCIE1A_bit+0)
	OUT        OCIE1A_bit+0, R27
;interrupt.c,19 :: 		}
L_end_InitTimer1:
	RET
; end of _InitTimer1

_Timer1Overflow_ISR:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;interrupt.c,21 :: 		void Timer1Overflow_ISR() org IVT_ADDR_TIMER1_COMPA
;interrupt.c,23 :: 		TOGGLE_BIT(channelB,5);                      //the timer value  must be more than the main delay routine
	LDS        R16, _channelB+0
	LDS        R17, _channelB+1
	LDI        R27, 32
	EOR        R16, R27
	LDI        R27, 0
	EOR        R17, R27
	STS        _channelB+0, R16
	STS        _channelB+1, R17
;interrupt.c,24 :: 		PORTB = channelB;
	LDS        R16, _channelB+0
	OUT        PORTB+0, R16
;interrupt.c,26 :: 		}
L_end_Timer1Overflow_ISR:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Timer1Overflow_ISR

interrupt____?ag:

L_end_interrupt___?ag:
	RET
; end of interrupt____?ag
