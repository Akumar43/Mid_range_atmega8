
_port_init:

;board.c,13 :: 		void port_init(void)
;board.c,15 :: 		DDRC=0x00;
	LDI        R27, 0
	OUT        DDRC+0, R27
;board.c,16 :: 		DDRB=0xFF;
	LDI        R27, 255
	OUT        DDRB+0, R27
;board.c,17 :: 		DDRD=0xE0;         //1110 0000
	LDI        R27, 224
	OUT        DDRD+0, R27
;board.c,18 :: 		PORTC=0x00;
	LDI        R27, 0
	OUT        PORTC+0, R27
;board.c,19 :: 		PORTB=0x00;
	LDI        R27, 0
	OUT        PORTB+0, R27
;board.c,20 :: 		}
L_end_port_init:
	RET
; end of _port_init

_protocol_init:

;board.c,23 :: 		void protocol_init()
;board.c,25 :: 		InitTimer1();
	CALL       _InitTimer1+0
;board.c,26 :: 		Port_init();
	CALL       _port_init+0
;board.c,27 :: 		Adc_init();
	CALL       _ADC_Init+0
;board.c,28 :: 		Pwm_Start();
	CALL       _Pwm_Start+0
;board.c,29 :: 		UART1_Init(9600);
	IN         R27, U2X_bit+0
	SBR        R27, BitMask(U2X_bit+0)
	OUT        U2X_bit+0, R27
	LDI        R27, 12
	OUT        UBRRL+0, R27
	LDI        R27, 0
	OUT        UBRRH+0, R27
	CALL       _UART1_Init+0
;board.c,31 :: 		}
L_end_protocol_init:
	RET
; end of _protocol_init

_update_IO_port:

;board.c,33 :: 		void update_IO_port()
;board.c,37 :: 		}
L_end_update_IO_port:
	RET
; end of _update_IO_port

_Pwm_Start:

;board.c,39 :: 		void Pwm_Start()                   // TIMER2 USED FOR PWM
;board.c,41 :: 		SREG_I_bit = 1;
	IN         R27, SREG_I_bit+0
	SBR        R27, BitMask(SREG_I_bit+0)
	OUT        SREG_I_bit+0, R27
;board.c,42 :: 		TCCR2=(1<<WGM21)|(1<<WGM20)|(1<<COM21)|(1<<CS20)| (1<<CS21)| (1<<CS22)  ;
	LDI        R27, 111
	OUT        TCCR2+0, R27
;board.c,43 :: 		OCR2= 10;
	LDI        R27, 10
	OUT        OCR2+0, R27
;board.c,44 :: 		}
L_end_Pwm_Start:
	RET
; end of _Pwm_Start

board____?ag:

L_end_board___?ag:
	RET
; end of board____?ag
