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

TRAPHANDLER(	T_div_err, 				 0)
TRAPHANDLER(	T_debug, 				 1)
TRAPHANDLER(	T_nmskint, 				 2)
TRAPHANDLER(	T_brkpnt, 				 3)
TRAPHANDLER(	T_overflow, 			 4)
TRAPHANDLER(	T_bound_range_exc, 		 5)
TRAPHANDLER(	T_invalid_opcode, 		 6)
TRAPHANDLER(	T_device_na, 			 7)
TRAPHANDLER(	T_double_fault, 		 8)
TRAPHANDLER(	T_coproc_seg_overrun,	 9)
TRAPHANDLER(	T_invalid_tss, 			10)
TRAPHANDLER(	T_seg_not_found, 		11)
TRAPHANDLER(	T_stack_fault, 			12)
TRAPHANDLER(	T_general_protect, 		13)

TRAPHANDLER(	T_page_fault, 			14)
TRAPHANDLER(	T_x87_float_error, 		16)
TRAPHANDLER(	T_align_check, 			17)
TRAPHANDLER(	T_machine_check, 		18)
TRAPHANDLER(	T_simd_exc, 			19)

TRAPHANDLER(	T_unknown_trap, 		15)

_alltraps:
	pushal
	movw	$GD_KD, %ax
	movw	%ax, %ds
	movw	%ax, %es
	pushl	%esp
	call trap