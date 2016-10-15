.globl GetGpioAddress	/* make GetGpioAddress accessible to all files  */
GetGpioAddress:		/* function label */
ldr r0,=0x20200000	/* put GPIO address in return register */
mov pc,lr		/* return to next line of code after function called */
			/* move value from lr to pc, link register to program */
			/* counter synonymous with ip, instruction pointer */

.globl SetGpioFunction	/* make this function available to all files */
SetGpioFunction:	/* branch label */
cmp r0,#53		/* compare r0 to 53 */
cmpls r1,#7		/* if r0 less then 53 compare r1 to 7 */
movhi pc,lr		/* return if r0 more than 53, or r1 more than 7 */
push {lr} 		/* push link register to the stack */
mov r2,r0		/* move input value r0 to r2 */
bl GetGpioAddress	/* puts GPIO address in r0, should use call */
functionLoop$:		/* loop label */
	cmp r2,#9	/* compare r2 to 9 */
	subhi r2,#10	/* if higher than 9, subtract 10 */
	addhi r0,#4	/* if higher than 9, add 4 to r0, gpio address */
			/* this is because each 4 bytes is 10 pins */
	bhi functionLoop$	/* if higher than 9, loop back to label */
add r2, r2,lsl #1	/* mult by 3 in disguise, adds r2 times 2 to r2 */
			/* r2,lsl #1 logical shift left by 1 doubles value */
lsl r1,r2		/* left shift r1 by r2 which has been mult by 3 */
			/* this is because there are 3 bits per pin */
str r1,[r0]		/* store r1 in r0, r1 is pin function value */
			/* r0 is gpio controller address plus 4 per 10 pins */
pop {pc}		/* pop lr off stack and place in pc, program counter */


.globl SetGpio		/* make function available to all */
SetGpio:		/* branch label */
pinNum .req r0		/* set register alias for pin number */
pinVal .req r1		/* set register alias for pin value */
cmp pinNum,#53		/* compare pin number to 53 */
movhi pc,lr		/* if higher than 53, return, break, abort */
push {lr}		/* push link register to the stack */
mov r2,pinNum		/* move pinNum to r2 */
.unreq pinNum		/* remove alias from r0 */
pinNum .req r2		/* attach register alias for pin number to r2 */
bl GetGpioAddress	/* get GPIO address in r0 */
gpioAddr .req r0	/* set register alias for gpio address to r0 */
pinBank .req r3		/* set register alias for pin bank to r3 */
lsr pinBank,pinNum,#5	/* divide pin number by 32, place result in pinbank */
			/* right shift by 5 divides by 32 */
lsl pinBank,#2		/* multiply pinbank by 4, shift left 2 */
add gpioAddr,pinBank	/* adds pinBank to GPIO address */
			/* each 4 bytes represents a bank of up to 32 pins */
.unreq pinBank		/* remove alias pinBank from r3 */
and pinNum,#31		/* gets remainder of pinNum divided by 32 */
			/* puts remainder in pinNum, 31 is 11111 */
setBit .req r3		/* set register alias setBit to r3 */
mov setBit,#1		/* put a 1 in setBit */
lsl setBit,pinNum	/* left shift setBit by pinNum */
.unreq pinNum		/* detach pinNum alias from r2 */
teq pinVal,#0		/* compare pinVal to 0 */
.unreq pinVal		/* remove pinVal alias from r1 */
streq setBit,[gpioAddr,#40]	/* if 0 store setBit in gpio + 40 - OFF */
strne setBit,[gpioAddr,#28]	/* if 1 store setBit in gpio + 28 - ON */
.unreq setBit		/* remove setBit alias from r3 */
.unreq gpioAddr		/* remove gpioAddr alias from r0 */
pop {pc}		/* return */

