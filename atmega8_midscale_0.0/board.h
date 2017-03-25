//
// FYI---to save code space floats can be removed with hardcode int values
//

//1                PORTC6        RESET/OUTPUT-        //15        PORTC5        OUTPUT
//2                PORTD0        RX                        -        //16        PORTC4        OUTPUT
//3                PORTD1        TX                        -        //17        PORTC3        ANALOG-3
//4                PORTD2        INPUTS                -        //18        PORTC2        ANALOG-2
//5                PORTD3        INPUTS                -        //19        PORTC1        ANALOG-1
//6                PORTD4        INPUTS                -        //20        PORTC0        ANALOG-0
//7                VCC                                        -        //21        GND
//8                GND                                        -        //22        AREF
//9                PORTB6        OUTPUT-7SEG        -        //23        VCC
//10        PORTB7        OUTPUT-7SEG        -        //24        PORTB5        OUTPUT-7SEG
//11        PORTD5        OUTPUT-7SEG -        //25        PORTB4        OUTPUT-7SEG
//12        PORTD6        OUTPUT-7SEG        -        //26        PORTB3        OUTPUT-7SEG
//13        PORTD7         OUTPUT-7SEG        -        //27        PORTB2        OUTPUT-7SEG
//14        PORTB0        OUTPUT-7SEG        -        //28        PORTB1        OUTPUT-7SEG



extern void port_init(void) ;
extern void protocol_init();
#ifndef BOARD_H
#define BOARD_H


//-------------------Hardware Mappings-------------------//

//-------------------MCU PIN Mappings-------MCU_DEPENDENT------------//
#define MCU_OPER_VOLT                        5000f                        // voltage in millivolt
#define MCU_ADC_RANGE                        1023f                        // 10 bit adc

#define BUTTON()                                    (TEST_BIT(PIND,1))

#define VOLT_DIV_CH1                                    0        //ADC_PIN
#define VOLT_OPAMP_CH1                                    1        //ADC_PIN

#define BUT_LED_TEST_PIN                            6
#define BUT_LED_TEST_PORT                            port_a

#define ADC_LED_TEST_PIN                            2         
#define ADC_LED_TEST_PORT                            port_a

//----------------HARDWARE_CONNECTION-------ELECTRICAL DEPENDENT------------

#define R1_CH1                                100f                                // resistance must be in ohm
#define R_SENSE_CH1                        100f                                // resistance must be in ohm
#define CORRECTION_X_CH1                1f

#define RF_CH1                                1000f                        // resistance must be in ohm
#define R1_OPM_CH1                        1000f                        // resistance must be in ohm

//----------------PORT_UPDATES----------MCU INDEPENDENT---------
#define BUT_LED_TEST(BUT_FLAG)            \
                                                 {\
                                                        if (BUT_FLAG)\
                                                        {\
                                                         SET_BIT(BUT_LED_TEST_PORT,BUT_LED_TEST_PIN);\
                                                        }\
                                                        else\
                                                        {\
                                                        CLEAR_BIT(BUT_LED_TEST_PORT,BUT_LED_TEST_PIN);\
                                                        }        \
                                                }

#define ADC_LED_TEST(ADC_FLAG)            \
                                                {\
                                                        if (ADC_FLAG)\
                                                        {\
                                                            SET_BIT(ADC_LED_TEST_PORT,ADC_LED_TEST_PIN);\
                                                        }\
                                                        else\
                                                        {\
                                                            CLEAR_BIT(ADC_LED_TEST_PORT,ADC_LED_TEST_PIN);\
                                                        }        \
                                                }

//----------------ELECTRICAL_CALCULATION---------mcU INDEPENDENT---------
#define ELEC_FACTOR_CH1                                ( (R_SENSE_CH1 + R1_CH1) / R_SENSE_CH1 )
#define MCU_FACTOR                                ( MCU_OPER_VOLT / MCU_ADC_RANGE)

#define        OP_AMP_FACTOR_CH1                                (1+(RF_CH1/R1_OPM_CH1)

#define VOLT_DIV_MEASURE_CH1()                (ADC_Read(VOLT_DIV_CH1/*0*/))  *  (MCU_FACTOR) * (CORRECTION_X_CH1) * (ELEC_FACTOR_CH1)
#define VOLT_OPAMP_MEASURE_CH1()        (ADC_Read(VOLT_OPAMP_CH1)) * (OP_AMP_FACTOR_CH1) * (MCU_FACTOR) *         (CORRECTION_X_OPAMP)

//---------------------------------------------------------


#endif