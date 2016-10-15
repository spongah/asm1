.section .init  /* tell asm where to put code */
.globl _start  	/* these next two lines are  */ 
_start:					/* to stop a warning message */

ldr r0,=0x20200000 /* put GPIO controller address in r0 */

mov r1,#1  			/* start with 1 in r1 */
lsl r1,#18			/* logical shift left 18 which is 3 bits times 6 */
str r1,[r0,#4]	/* place r1 in r0 plus 4 bytes which is pin 10-19 */

mov r1,#1 			/* start with 1 in r1 */
lsl r1,#16			/* logical shift left 16 */
str r1,[r0,#40]	/* place r1 in r0 + 40 bytes which is turn off pin section */

loop$:					/* loop label */
b loop$					/* branch to loop label */
								/* this keeps the processor happy in an infinite loop */
