/* See COPYRIGHT for copyright information. */

#include <inc/mmu.h>
#include <inc/memlayout.h>
#include <inc/trap.h>



###################################################################
# exceptions/interrupts
###################################################################

/* TRAPHANDLER defines a globally-visible function for handling a trap.
 * It pushes a trap number onto the stack, then jumps to _alltraps.
 * Use TRAPHANDLER for traps where the CPU automatically pushes an error code.
 *
 * You shouldn't call a TRAPHANDLER function from C, but you may
 * need to _declare_ one in C (for instance, to get a function pointer
 * during IDT setup).  You can declare the function with
 *   void NAME();
 * where NAME is the argument passed to TRAPHANDLER.
 */
#define TRAPHANDLER(name, num)						\
	.globl name;		/* define global symbol for 'name' */	\
	.type name, @function;	/* symbol type is function */		\
	.align 2;		/* align function definition */		\
	name:			/* function starts here */		\
	pushl $(num);							\
	jmp _alltraps

/* Use TRAPHANDLER_NOEC for traps where the CPU doesn't push an error code.
 * It pushes a 0 in place of the error code, so the trap frame has the same
 * format in either case.
 */
#define TRAPHANDLER_NOEC(name, num)					\
	.globl name;							\
	.type name, @function;						\
	.align 2;							\
	name:								\
	pushl $0;							\
	pushl $(num);							\
	jmp _alltraps

.text

TRAPHANDLER(	T_HNDL_divide, 	T_DIVIDE)
TRAPHANDLER(	T_HNDL_debug, 	T_DEBUG)
TRAPHANDLER(	T_HNDL_nmi, 	T_NMI)
TRAPHANDLER(	T_HNDL_brkpt, 	T_BRKPT)
TRAPHANDLER(	T_HNDL_oflow, 	T_OFLOW)
TRAPHANDLER(	T_HNDL_bound, 	T_BOUND)
TRAPHANDLER(	T_HNDL_illop, 	T_ILLOP)
TRAPHANDLER(	T_HNDL_device, 	T_DEVICE)
TRAPHANDLER(	T_HNDL_dbl_flt, T_DBLFLT)
TRAPHANDLER(	T_HNDL_tss, 	T_TSS)
TRAPHANDLER(	T_HNDL_segnp, 	T_SEGNP)
TRAPHANDLER(	T_HNDL_stack, 	T_STACK)
TRAPHANDLER(	T_HNDL_gpflt, 	T_GPFLT)
TRAPHANDLER(	T_HNDL_pgflt, 	T_PGFLT)
TRAPHANDLER(	T_HNDL_fperr, 	T_FPERR)
TRAPHANDLER(	T_HNDL_align, 	T_ALIGN)
TRAPHANDLER(	T_HNDL_mchk, 	T_MCHK)
TRAPHANDLER(	T_HNDL_simderr, T_SIMDERR)

TRAPHANDLER_NOEC(T_HNDL_syscall, T_SYSCALL)

_alltraps:
	pushl	%ds
	pushl	%es
	pushal

	movw	$GD_KD, %ax
	movw	%ax, %ds
	movw	%ax, %es
	pushl	%esp
	pushl	$0
	jmp 	trap
