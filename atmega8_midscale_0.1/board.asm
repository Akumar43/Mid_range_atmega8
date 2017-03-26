
_port_init:

;board.c,26 :: 		void port_init(void)
;board.c,28 :: 		DDRC=0x00;
	LDI        R27, 0
	OUT        DDRC+0, R27
;board.c,29 :: 		DDRB=0xFF;
	LDI        R27, 255
	OUT        DDRB+0, R27
;board.c,30 :: 		DDRD=0xE0;         //1110 0000
	LDI        R27, 224
	OUT        DDRD+0, R27
;board.c,31 :: 		PORTC=0x00;
	LDI        R27, 0
	OUT        PORTC+0, R27
;board.c,32 :: 		PORTB=0x00;
	LDI        R27, 0
	OUT        PORTB+0, R27
;board.c,35 :: 		}
L_end_port_init:
	RET
; end of _port_init

_protocol_init:

;board.c,37 :: 		void protocol_init()
;board.c,39 :: 		InitTimer1();
	CALL       _InitTimer1+0
;board.c,40 :: 		Port_init();
	CALL       _port_init+0
;board.c,41 :: 		Adc_init();
	CALL       _ADC_Init+0
;board.c,42 :: 		Pwm_Start();
	CALL       _Pwm_Start+0
;board.c,43 :: 		}
L_end_protocol_init:
	RET
; end of _protocol_init

_update_IO_port:

;board.c,45 :: 		void update_IO_port()
;board.c,47 :: 		PORTB = channel1;
	LDS        R16, _channel1+0
	OUT        PORTB+0, R16
;board.c,49 :: 		}
L_end_update_IO_port:
	RET
; end of _update_IO_port

_Pwm_Start:

;board.c,51 :: 		void Pwm_Start()     // TIMER2 USED FOR PWM
;board.c,53 :: 		SREG_I_bit = 1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;board.c,54 :: 		TCCR2=(1<<WGM21)|(1<<WGM20)|(1<<COM21)|(1<<CS20)| (1<<CS21)| (1<<CS22)  ;
	LDI        R27, 111
	OUT        TCCR2+0, R27
;board.c,55 :: 		OCR2= 10;
	LDI        R27, 10
	OUT        OCR2+0, R27
;board.c,57 :: 		}
L_end_Pwm_Start:
	RET
; end of _Pwm_Start

board____?ag:

L_end_board___?ag:
	RET
; end of board____?ag
