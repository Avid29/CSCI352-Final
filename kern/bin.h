
#ifndef JOS_KERN_BIN_H
#define JOS_KERN_BIN_H

#include <inc/types.h>

// Just forward declaring this so it shows up in VS Code
extern uint8_t user_hello;
extern uint8_t user_buggyhello;
extern uint8_t user_buggyhello2;
extern uint8_t user_evilhello;
extern uint8_t user_testbss;
extern uint8_t user_divzero;
extern uint8_t user_breakpoint;
extern uint8_t user_softint;
extern uint8_t user_badsegment;
extern uint8_t user_faultread;
extern uint8_t user_faultreadkernel;
extern uint8_t user_faultwrite;
extern uint8_t user_faultwritekernel;

#endif // !JOS_KERN_ENV_H
