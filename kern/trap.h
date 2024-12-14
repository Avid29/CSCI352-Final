/* See COPYRIGHT for copyright information. */

#ifndef JOS_KERN_TRAP_H
#define JOS_KERN_TRAP_H
#ifndef JOS_KERNEL
# error "This is a JOS kernel header; user programs should not #include it"
#endif

#include <inc/trap.h>
#include <inc/mmu.h>

/* The kernel's interrupt descriptor table */
extern struct Gatedesc idt[];
extern struct Pseudodesc idt_pd;

// Trap handlers (see trapentry.S)
void T_div_err();
void T_debug();
void T_nmskint();
void T_brkpnt();
void T_overflow();
void T_bound_range_exc();
void T_invalid_opcode();
void T_device_na();
void T_double_fault();
void T_coproc_seg_overrun();
void T_invalid_tss();
void T_seg_not_found();
void T_stack_fault();
void T_general_protect();
void T_page_fault();
void T_x87_float_error();
void T_align_check();
void T_machine_check();
void T_simd_exc();

void T_unknown_trap();

void trap_init(void);
void trap_init_percpu(void);
void print_regs(struct PushRegs *regs);
void print_trapframe(struct Trapframe *tf);
void page_fault_handler(struct Trapframe *);
void backtrace(struct Trapframe *);

#endif /* JOS_KERN_TRAP_H */
