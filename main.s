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

pauseTime .req r4
mov r4,#0x400

loop$:		/* loop label */

mov r0,#16
mov r1,#0
bl SetGpio

mov r0,r4
bl Sleep

mov r0,#16
mov r1,#1
bl SetGpio

mov r0,r4
bl Sleep

add r4,#0x400

b loop$		/* branch to loop label */

