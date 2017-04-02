//#define SET_BIT                                  1
#ifndef LIB_CODE
#define LIB_CODE

#define SET_BIT_1               1
#define CLEAR_BIT_0             0

//#define CLEAR_BIT                                0
#define BIT_MASK(bit)             (1 << (bit))
#define SET_BIT(value,bit)        ((value) |= BIT_MASK(bit))
#define CLEAR_BIT(value,bit)      ((value) &= ~BIT_MASK(bit))
#define TEST_BIT(value,bit)       (((value) & BIT_MASK(bit)) ? 1 : 0)
#define TOGGLE_BIT(value,bit)       ((value) ^= 1 << bit)

#endif