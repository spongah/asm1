.globl GetGpioAddress	/* make GetGpioAddress accessible to all files  */
GetGpioAddress:		/* function label */
ldr r0,=0x20200000	/* put GPIO address in return register */
mov pc,lr		/* return to next line of code after function called */
			/* move value from lr to pc, link register to program */
			/* counter synonymous with ip, instruction pointer */

