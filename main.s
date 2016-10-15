.section .init  /* tell asm where to put code */
.globl _start  	/* these next two lines are  */ 
_start:					/* to stop a warning message */

ldr r0,=0x20200000 /* put GPIO controller address in r0 */

mov r1,#1  			/* start with 1 in r1 */
lsl r1,#18			/* logical shift left 18 which is 3 bits times 6 */
str r1,[r0,#4]	/* place r1 in r0 plus 4 bytes which is pin 10-19 */

loop$:					/* loop label */

mov r1,#1 			/* start with 1 in r1 */
lsl r1,#16			/* logical shift left 16 */

str r1,[r0,#40]	/* place r1 in r0 + 40 bytes which is turn off pin section */

mov r2,#0x3F0000 	/* put large number in r2 */
wait1$:					/* set loop label */
sub r2,#1 			/* subtract 1 from r2 */
cmp r2,#0 			/* compare r2 to 0 */
bne wait1$			/* branch back to wait if not equal */

str r1,[r0,#28] /* place r1 in r0 + 28 bytes which is turn on pin section */

mov r2,#0x3F0000 	/* put large number in r2 */
wait2$:					/* set loop label */
sub r2,#1 			/* subtract 1 from r2 */
cmp r2,#0 			/* compare r2 to 0 */
bne wait2$			/* branch back to wait if not equal */

b loop$					/* branch to loop label */
								/* this keeps the processor happy in an infinite loop */
