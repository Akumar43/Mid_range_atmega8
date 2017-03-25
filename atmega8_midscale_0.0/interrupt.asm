
_InitTimer2:

;interrupt.c,16 :: 		void InitTimer2(){
;interrupt.c,17 :: 		SREG_I_bit = 1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;interrupt.c,18 :: 		OCR2 = 77;                                  // timer not working properly
	LDI        R27, 77
	OUT        OCR2+0, R27
;interrupt.c,19 :: 		TCCR2 = 0x28;
	LDI        R27, 40
	OUT        TCCR2+0, R27
;interrupt.c,20 :: 		TCCR2 |= 0x07;
	IN         R16, TCCR2+0
	ORI        R16, 7
	OUT        TCCR2+0, R16
;interrupt.c,21 :: 		OCIE2_bit = 1;
	IN         R27, OCIE2_bit+0
	SBR        R27, BitMask(OCIE2_bit+0)
	OUT        OCIE2_bit+0, R27
;interrupt.c,22 :: 		}
L_end_InitTimer2:
	RET
; end of _InitTimer2

_InitTimer1:

;interrupt.c,26 :: 		void InitTimer1(){
;interrupt.c,27 :: 		SREG_I_bit = 1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;interrupt.c,28 :: 		TCCR1A = 0x80;
	LDI        R27, 128
	OUT        TCCR1A+0, R27
;interrupt.c,29 :: 		TCCR1B = 0x09;
	LDI        R27, 9
	OUT        TCCR1B+0, R27
;interrupt.c,30 :: 		OCR1AH = 0x0F;
	LDI        R27, 15
	OUT        OCR1AH+0, R27
;interrupt.c,31 :: 		OCR1AL = 0x9F;
	LDI        R27, 159
	OUT        OCR1AL+0, R27
;interrupt.c,32 :: 		OCIE1A_bit = 1;
	IN         R27, OCIE1A_bit+0
	SBR        R27, BitMask(OCIE1A_bit+0)
	OUT        OCIE1A_bit+0, R27
;interrupt.c,33 :: 		}
L_end_InitTimer1:
	RET
; end of _InitTimer1

_Timer2Overflow_ISR:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;interrupt.c,36 :: 		void Timer2Overflow_ISR() org IVT_ADDR_TIMER2_COMP
;interrupt.c,39 :: 		}
L_end_Timer2Overflow_ISR:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Timer2Overflow_ISR

_Timer1Overflow_ISR:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;interrupt.c,41 :: 		void Timer1Overflow_ISR() org IVT_ADDR_TIMER1_COMPA {
;interrupt.c,42 :: 		i=i++;
	LDS        R16, _i+0
	LDS        R17, _i+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _i+0, R18
	STS        _i+1, R19
;interrupt.c,43 :: 		if(i<pulse_width)
	LDS        R16, _pulse_width+0
	LDS        R17, _pulse_width+1
	CP         R18, R16
	CPC        R19, R17
	BRLT       L__Timer1Overflow_ISR13
	JMP        L_Timer1Overflow_ISR0
L__Timer1Overflow_ISR13:
;interrupt.c,44 :: 		PORTB |= 1 << 5;  //setting a bit
	IN         R27, PORTB+0
	SBR        R27, 32
	OUT        PORTB+0, R27
	JMP        L_Timer1Overflow_ISR1
L_Timer1Overflow_ISR0:
;interrupt.c,46 :: 		else if((i>=pulse_width) && (i< 255))
	LDS        R18, _i+0
	LDS        R19, _i+1
	LDS        R16, _pulse_width+0
	LDS        R17, _pulse_width+1
	CP         R18, R16
	CPC        R19, R17
	BRGE       L__Timer1Overflow_ISR14
	JMP        L__Timer1Overflow_ISR8
L__Timer1Overflow_ISR14:
	LDS        R18, _i+0
	LDS        R19, _i+1
	LDI        R16, 255
	LDI        R17, 0
	CP         R18, R16
	CPC        R19, R17
	BRLT       L__Timer1Overflow_ISR15
	JMP        L__Timer1Overflow_ISR7
L__Timer1Overflow_ISR15:
L__Timer1Overflow_ISR6:
;interrupt.c,47 :: 		PORTB &= ~(1 << 5);
	IN         R16, PORTB+0
	ANDI       R16, 223
	OUT        PORTB+0, R16
	JMP        L_Timer1Overflow_ISR5
;interrupt.c,46 :: 		else if((i>=pulse_width) && (i< 255))
L__Timer1Overflow_ISR8:
L__Timer1Overflow_ISR7:
;interrupt.c,50 :: 		i=0;
	LDI        R27, 0
	STS        _i+0, R27
	STS        _i+1, R27
L_Timer1Overflow_ISR5:
L_Timer1Overflow_ISR1:
;interrupt.c,51 :: 		}
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
