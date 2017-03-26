
_InitTimer1:

;interrupt.c,9 :: 		void InitTimer1(){
;interrupt.c,10 :: 		SREG_I_bit = 1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;interrupt.c,11 :: 		TCCR1A = 0x00;
	LDI        R27, 0
	OUT        TCCR1A+0, R27
;interrupt.c,12 :: 		TCCR1B = 0x09;
	LDI        R27, 9
	OUT        TCCR1B+0, R27
;interrupt.c,13 :: 		OCR1AH = 0x0F;
	LDI        R27, 15
	OUT        OCR1AH+0, R27
;interrupt.c,14 :: 		OCR1AL = 0x9F;
	LDI        R27, 159
	OUT        OCR1AL+0, R27
;interrupt.c,15 :: 		OCIE1A_bit = 1;
	IN         R27, OCIE1A_bit+0
	SBR        R27, BitMask(OCIE1A_bit+0)
	OUT        OCIE1A_bit+0, R27
;interrupt.c,16 :: 		}
L_end_InitTimer1:
	RET
; end of _InitTimer1

_Timer1Overflow_ISR:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;interrupt.c,18 :: 		void Timer1Overflow_ISR() org IVT_ADDR_TIMER1_COMPA {
;interrupt.c,19 :: 		i=i++;
	LDS        R16, _i+0
	LDS        R17, _i+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _i+0, R18
	STS        _i+1, R19
;interrupt.c,20 :: 		if(i<pulse_width)
	LDS        R16, _pulse_width+0
	LDS        R17, _pulse_width+1
	CP         R18, R16
	CPC        R19, R17
	BRLT       L__Timer1Overflow_ISR11
	JMP        L_Timer1Overflow_ISR0
L__Timer1Overflow_ISR11:
;interrupt.c,21 :: 		PORTB |= 1 << 5;  //setting a bit
	IN         R27, PORTB+0
	SBR        R27, 32
	OUT        PORTB+0, R27
	JMP        L_Timer1Overflow_ISR1
L_Timer1Overflow_ISR0:
;interrupt.c,23 :: 		else if((i>=pulse_width) && (i< 255))
	LDS        R18, _i+0
	LDS        R19, _i+1
	LDS        R16, _pulse_width+0
	LDS        R17, _pulse_width+1
	CP         R18, R16
	CPC        R19, R17
	BRGE       L__Timer1Overflow_ISR12
	JMP        L__Timer1Overflow_ISR8
L__Timer1Overflow_ISR12:
	LDS        R18, _i+0
	LDS        R19, _i+1
	LDI        R16, 255
	LDI        R17, 0
	CP         R18, R16
	CPC        R19, R17
	BRLT       L__Timer1Overflow_ISR13
	JMP        L__Timer1Overflow_ISR7
L__Timer1Overflow_ISR13:
L__Timer1Overflow_ISR6:
;interrupt.c,24 :: 		PORTB &= ~(1 << 5);
	IN         R16, PORTB+0
	ANDI       R16, 223
	OUT        PORTB+0, R16
	JMP        L_Timer1Overflow_ISR5
;interrupt.c,23 :: 		else if((i>=pulse_width) && (i< 255))
L__Timer1Overflow_ISR8:
L__Timer1Overflow_ISR7:
;interrupt.c,27 :: 		i=0;
	LDI        R27, 0
	STS        _i+0, R27
	STS        _i+1, R27
L_Timer1Overflow_ISR5:
L_Timer1Overflow_ISR1:
;interrupt.c,28 :: 		}
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
