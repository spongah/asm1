.section .init  /* tell asm where to put code */
.globl _start  	/* these next two lines are  */ 
_start:		/* to stop a warning message */

pinNum .req r0
pinFunc .req r1
mov pinNum,#16
mov pinFunc,#1
bl SetGpioFunction
.unreq pinNum
.unreq pinFunc

loop$:		/* loop label */

mov r0,#16
mov r1,#0
bl SetGpio

bl pause

mov r0,#16
mov r1,#1
bl SetGpio

bl pause

b loop$		/* branch to loop label */
		/* this keeps the processor happy in an infinite loop */

.globl pause
pause:
mov r2,#0x3F0000
wait1$:
	sub r2,#1
	cmp r2,#0
	bne wait1$
mov pc,lr
