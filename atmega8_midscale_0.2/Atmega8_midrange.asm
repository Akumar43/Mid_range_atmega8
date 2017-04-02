
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;Atmega8_midrange.c,25 :: 		void main()
;Atmega8_midrange.c,28 :: 		protocol_init();
	CALL       _protocol_init+0
;Atmega8_midrange.c,29 :: 		port_init();
	CALL       _port_init+0
;Atmega8_midrange.c,31 :: 		INT_PWM_DUTY = 100;
	LDI        R27, 100
	OUT        OCR2+0, R27
;Atmega8_midrange.c,32 :: 		pulse_width =125;     // setting the pusle width here        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	LDI        R27, 125
	STS        _pulse_width+0, R27
	LDI        R27, 0
	STS        _pulse_width+1, R27
;Atmega8_midrange.c,33 :: 		while(1)
L_main0:
;Atmega8_midrange.c,35 :: 		Task1();
	CALL       _Task1+0
;Atmega8_midrange.c,36 :: 		Read_Inputs();
	CALL       _Read_Inputs+0
;Atmega8_midrange.c,37 :: 		Read_Analogs();
	CALL       _Read_Analogs+0
;Atmega8_midrange.c,38 :: 		digital_outputs();
	CALL       _Digital_outputs+0
;Atmega8_midrange.c,40 :: 		}
	JMP        L_main0
;Atmega8_midrange.c,41 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_Read_Inputs:

;Atmega8_midrange.c,46 :: 		void Read_Inputs()
;Atmega8_midrange.c,49 :: 		if(TEST_BIT(PIND,2))       // checked for all pin d0-d4
	IN         R16, PIND+0
	SBRS       R16, 2
	JMP        L_Read_Inputs2
; ?FLOC___Read_Inputs?T1 start address is: 16 (R16)
	LDI        R16, 1
; ?FLOC___Read_Inputs?T1 end address is: 16 (R16)
	JMP        L_Read_Inputs3
L_Read_Inputs2:
; ?FLOC___Read_Inputs?T1 start address is: 16 (R16)
	LDI        R16, 0
; ?FLOC___Read_Inputs?T1 end address is: 16 (R16)
L_Read_Inputs3:
; ?FLOC___Read_Inputs?T1 start address is: 16 (R16)
	TST        R16
	BRNE       L__Read_Inputs15
	JMP        L_Read_Inputs4
L__Read_Inputs15:
; ?FLOC___Read_Inputs?T1 end address is: 16 (R16)
;Atmega8_midrange.c,51 :: 		SET_BIT(channelB,7) ;
	LDS        R27, _channelB+0
	SBR        R27, 128
	STS        _channelB+0, R27
;Atmega8_midrange.c,52 :: 		}
	JMP        L_Read_Inputs5
L_Read_Inputs4:
;Atmega8_midrange.c,55 :: 		CLEAR_BIT(channelB,7);
	LDS        R16, _channelB+0
	LDS        R17, _channelB+1
	ANDI       R16, 127
	ANDI       R17, 0
	STS        _channelB+0, R16
	STS        _channelB+1, R17
;Atmega8_midrange.c,56 :: 		}
L_Read_Inputs5:
;Atmega8_midrange.c,57 :: 		}
L_end_Read_Inputs:
	RET
; end of _Read_Inputs

_Read_Analogs:

;Atmega8_midrange.c,61 :: 		void Read_Analogs()
;Atmega8_midrange.c,63 :: 		if( VOLT_DIV_AN0() > 5000)   // value in milli volts
	PUSH       R2
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
	BREQ       L__Read_Analogs17
	LDI        R27, 1
L__Read_Analogs17:
	MOV        R16, R27
	TST        R16
	BRNE       L__Read_Analogs18
	JMP        L_Read_Analogs6
L__Read_Analogs18:
;Atmega8_midrange.c,65 :: 		SET_BIT(channelB,6) ;
	LDS        R27, _channelB+0
	SBR        R27, 64
	STS        _channelB+0, R27
;Atmega8_midrange.c,66 :: 		}
	JMP        L_Read_Analogs7
L_Read_Analogs6:
;Atmega8_midrange.c,69 :: 		CLEAR_BIT(channelB,6) ;
	LDS        R16, _channelB+0
	LDS        R17, _channelB+1
	ANDI       R16, 191
	ANDI       R17, 255
	STS        _channelB+0, R16
	STS        _channelB+1, R17
;Atmega8_midrange.c,70 :: 		}
L_Read_Analogs7:
;Atmega8_midrange.c,72 :: 		if( ADC_Read(1) > 512)   // value in milli volts
	LDI        R27, 1
	MOV        R2, R27
	CALL       _ADC_Read+0
	LDI        R18, 0
	LDI        R19, 2
	CP         R18, R16
	CPC        R19, R17
	BRLO       L__Read_Analogs19
	JMP        L_Read_Analogs8
L__Read_Analogs19:
;Atmega8_midrange.c,74 :: 		SET_BIT(channelB,4) ;
	LDS        R16, _channelB+0
	LDS        R17, _channelB+1
	ORI        R16, 16
	ORI        R17, 0
	STS        _channelB+0, R16
	STS        _channelB+1, R17
;Atmega8_midrange.c,75 :: 		}
	JMP        L_Read_Analogs9
L_Read_Analogs8:
;Atmega8_midrange.c,78 :: 		CLEAR_BIT(channelB,4) ;
	LDS        R16, _channelB+0
	LDS        R17, _channelB+1
	ANDI       R16, 239
	ANDI       R17, 255
	STS        _channelB+0, R16
	STS        _channelB+1, R17
;Atmega8_midrange.c,79 :: 		}
L_Read_Analogs9:
;Atmega8_midrange.c,82 :: 		}
L_end_Read_Analogs:
	POP        R2
	RET
; end of _Read_Analogs

_digital_outputs:

;Atmega8_midrange.c,84 :: 		void digital_outputs()
;Atmega8_midrange.c,86 :: 		SET_BIT(channelB,1)    ;       //PORTB1 as output
	LDS        R27, _channelB+0
	SBR        R27, 2
	STS        _channelB+0, R27
;Atmega8_midrange.c,89 :: 		SET_BIT(DDRC,5)    ;
	IN         R16, DDRC+0
	ORI        R16, 32
	OUT        DDRC+0, R16
;Atmega8_midrange.c,90 :: 		SET_BIT(DDRC,4)    ;
	ORI        R16, 16
	OUT        DDRC+0, R16
;Atmega8_midrange.c,92 :: 		CLEAR_BIT(PORTC,5)   ;
	IN         R16, PORTC+0
	ANDI       R16, 223
	OUT        PORTC+0, R16
;Atmega8_midrange.c,93 :: 		SET_BIT(PORTC,4)    ;
	ORI        R16, 16
	OUT        PORTC+0, R16
;Atmega8_midrange.c,94 :: 		}
L_end_digital_outputs:
	RET
; end of _digital_outputs

_Task1:

;Atmega8_midrange.c,96 :: 		void Task1()
;Atmega8_midrange.c,98 :: 		UART_Write_Text("char ");
	PUSH       R2
	PUSH       R3
	LDI        R27, #lo_addr(?lstr1_Atmega8_midrange+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr1_Atmega8_midrange+0)
	MOV        R3, R27
	CALL       _UART_Write_Text+0
;Atmega8_midrange.c,99 :: 		TOGGLE_BIT(channelB,0);
	LDS        R16, _channelB+0
	LDS        R17, _channelB+1
	LDI        R27, 1
	EOR        R16, R27
	LDI        R27, 0
	EOR        R17, R27
	STS        _channelB+0, R16
	STS        _channelB+1, R17
;Atmega8_midrange.c,100 :: 		delay_ms(1000);
	LDI        R18, 6
	LDI        R17, 19
	LDI        R16, 174
L_Task110:
	DEC        R16
	BRNE       L_Task110
	DEC        R17
	BRNE       L_Task110
	DEC        R18
	BRNE       L_Task110
	NOP
	NOP
;Atmega8_midrange.c,101 :: 		}
L_end_Task1:
	POP        R3
	POP        R2
	RET
; end of _Task1
