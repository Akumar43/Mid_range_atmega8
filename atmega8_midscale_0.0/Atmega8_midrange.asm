
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;Atmega8_midrange.c,14 :: 		void main()
;Atmega8_midrange.c,17 :: 		protocol_init();
	PUSH       R2
	CALL       _protocol_init+0
;Atmega8_midrange.c,18 :: 		port_init();
	CALL       _port_init+0
;Atmega8_midrange.c,20 :: 		while(1)
L_main0:
;Atmega8_midrange.c,22 :: 		pulse_width =130;                                                // setting the pusle width here
	LDI        R27, 130
	STS        _pulse_width+0, R27
	LDI        R27, 0
	STS        _pulse_width+1, R27
;Atmega8_midrange.c,23 :: 		TOGGLE_BIT(port_a,0);                                          // blink check
	LDS        R16, _port_a+0
	LDS        R17, _port_a+1
	LDI        R27, 1
	EOR        R16, R27
	LDI        R27, 0
	EOR        R17, R27
	STS        _port_a+0, R16
	STS        _port_a+1, R17
;Atmega8_midrange.c,24 :: 		delay_ms(100);
	LDI        R17, 130
	LDI        R16, 222
L_main2:
	DEC        R16
	BRNE       L_main2
	DEC        R17
	BRNE       L_main2
	NOP
;Atmega8_midrange.c,26 :: 		if(BUTTON())       // using PORTA.f3 MCLR latched pin / this PIn cannot be used for output
	IN         R16, PIND+0
	SBRS       R16, 1
	JMP        L_main4
; ?FLOC___main?T2 start address is: 16 (R16)
	LDI        R16, 1
; ?FLOC___main?T2 end address is: 16 (R16)
	JMP        L_main5
L_main4:
; ?FLOC___main?T2 start address is: 16 (R16)
	LDI        R16, 0
; ?FLOC___main?T2 end address is: 16 (R16)
L_main5:
; ?FLOC___main?T2 start address is: 16 (R16)
	TST        R16
	BRNE       L__main19
	JMP        L_main6
L__main19:
; ?FLOC___main?T2 end address is: 16 (R16)
;Atmega8_midrange.c,28 :: 		BUT_LED_TEST(SET_BIT_1);
	LDS        R27, _port_a+0
	SBR        R27, 64
	STS        _port_a+0, R27
L_main8:
;Atmega8_midrange.c,29 :: 		}
	JMP        L_main9
L_main6:
;Atmega8_midrange.c,32 :: 		BUT_LED_TEST(CLEAR_BIT_0);
L_main10:
	LDS        R16, _port_a+0
	LDS        R17, _port_a+1
	ANDI       R16, 191
	ANDI       R17, 255
	STS        _port_a+0, R16
	STS        _port_a+1, R17
;Atmega8_midrange.c,33 :: 		}
L_main9:
;Atmega8_midrange.c,35 :: 		if( VOLT_DIV_MEASURE_CH1() > 5000)   // value in milli volts
	CLR        R2
	CALL       _ADC_Read+0
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
	LDI        R20, 26
	LDI        R21, 103
	LDI        R22, 156
	LDI        R23, 64
	CALL       _float_fpmul1+0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 0
	LDI        R23, 64
	CALL       _float_fpmul1+0
	LDI        R20, 0
	LDI        R21, 64
	LDI        R22, 156
	LDI        R23, 69
	CALL       _float_op_big+0
	OR         R0, R0
	LDI        R27, 0
	BREQ       L__main20
	LDI        R27, 1
L__main20:
	MOV        R16, R27
	TST        R16
	BRNE       L__main21
	JMP        L_main12
L__main21:
;Atmega8_midrange.c,37 :: 		ADC_LED_TEST(1) ;
	LDS        R16, _port_a+0
	LDS        R17, _port_a+1
	ORI        R16, 4
	ORI        R17, 0
	STS        _port_a+0, R16
	STS        _port_a+1, R17
L_main14:
;Atmega8_midrange.c,38 :: 		}
	JMP        L_main15
L_main12:
;Atmega8_midrange.c,41 :: 		ADC_LED_TEST(0) ;
L_main16:
	LDS        R16, _port_a+0
	LDS        R17, _port_a+1
	ANDI       R16, 251
	ANDI       R17, 255
	STS        _port_a+0, R16
	STS        _port_a+1, R17
;Atmega8_midrange.c,42 :: 		}
L_main15:
;Atmega8_midrange.c,43 :: 		update_IO_porta();
	CALL       _update_IO_porta+0
;Atmega8_midrange.c,44 :: 		}
	JMP        L_main0
;Atmega8_midrange.c,45 :: 		}
L_end_main:
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_update_IO_porta:

;Atmega8_midrange.c,48 :: 		void update_IO_porta()
;Atmega8_midrange.c,51 :: 		PORTB = port_a;
	LDS        R16, _port_a+0
	OUT        PORTB+0, R16
;Atmega8_midrange.c,53 :: 		}
L_end_update_IO_porta:
	RET
; end of _update_IO_porta
