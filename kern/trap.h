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
void T_HNDL_divide();
void T_HNDL_debug();
void T_HNDL_nmi();
void T_HNDL_brkpt();
void T_HNDL_oflow();
void T_HNDL_bound();
void T_HNDL_illop();
void T_HNDL_device();
void T_HNDL_dbl_flt();
void T_HNDL_tss();
void T_HNDL_segnp();
void T_HNDL_stack();
void T_HNDL_gpflt();
void T_HNDL_pgflt();
void T_HNDL_fperr();
void T_HNDL_align();
void T_HNDL_mchk();
void T_HNDL_simderr();

void T_HNDL_syscall();

void trap_init(void);
void trap_init_percpu(void);
void print_regs(struct PushRegs *regs);
void print_trapframe(struct Trapframe *tf);
void page_fault_handler(struct Trapframe *);
void backtrace(struct Trapframe *);

#endif /* JOS_KERN_TRAP_H */
