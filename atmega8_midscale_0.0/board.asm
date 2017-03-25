
_port_init:

;board.c,21 :: 		void port_init(void)
;board.c,23 :: 		DDRC=0x00;
	LDI        R27, 0
	OUT        DDRC+0, R27
;board.c,24 :: 		DDRB=0xFF;
	LDI        R27, 255
	OUT        DDRB+0, R27
;board.c,25 :: 		DDRD=0xE0;         //1110 0000
	LDI        R27, 224
	OUT        DDRD+0, R27
;board.c,27 :: 		PORTC=0x00;
	LDI        R27, 0
	OUT        PORTC+0, R27
;board.c,28 :: 		PORTB=0x00;
	LDI        R27, 0
	OUT        PORTB+0, R27
;board.c,35 :: 		}
L_end_port_init:
	RET
; end of _port_init

_protocol_init:

;board.c,37 :: 		void protocol_init()
;board.c,38 :: 		{        InitTimer2();
	CALL       _InitTimer2+0
;board.c,40 :: 		InitTimer1();
	CALL       _InitTimer1+0
;board.c,41 :: 		Port_init();
	CALL       _port_init+0
;board.c,42 :: 		Adc_init();
	CALL       _ADC_Init+0
;board.c,43 :: 		}
L_end_protocol_init:
	RET
; end of _protocol_init

board____?ag:

L_end_board___?ag:
	RET
; end of board____?ag
