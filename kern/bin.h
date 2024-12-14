
#ifndef JOS_KERN_BIN_H
#define JOS_KERN_BIN_H

#include <inc/types.h>

extern uint8_t _binary_obj_user_hello_start;
extern uint8_t _binary_obj_user_buggyhello_start;
extern uint8_t _binary_obj_user_buggyhello2_start;
extern uint8_t _binary_obj_user_evilhello_start;
extern uint8_t _binary_obj_user_testbss_start;
extern uint8_t _binary_obj_user_divzero_start;
extern uint8_t _binary_obj_user_breakpoint_start;
extern uint8_t _binary_obj_user_softint_start;
extern uint8_t _binary_obj_user_badsegment_start;
extern uint8_t _binary_obj_user_faultread_start;
extern uint8_t _binary_obj_user_faultreadkernel_start;
extern uint8_t _binary_obj_user_faultwrite_start;
extern uint8_t _binary_obj_user_faultwritekernel_start;

#endif // !JOS_KERN_ENV_H
