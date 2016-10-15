.section .init  	/* tell asm where to put code */
.globl _start  		/* these next two lines are  */ 
_start:			/* to stop a warning message */

pinNum .req r0		/* set pinNum alias to r0 */
pinFunc .req r1		/* set pinFunc alias to r1 */
mov pinNum,#16		/* set pinNum to 16 */
mov pinFunc,#1		/* set pinFunc to 1 */
bl SetGpioFunction	/* call function to set pin 16 to output */
.unreq pinNum		/* remove alias from r0 */
.unreq pinFunc		/* remove alias from r1 */

pauseTime .req r4	/* set pauseTime alias to r4 */
mov pauseTime,#0x400	/* set pauseTime to 1024 */

loop$:			/* loop label */

mov r0,#16		/* set r0, pinNum to 16 */
mov r1,#0		/* set r1, pinVal to 0 */
bl SetGpio		/* call SetGpio function, sets pin 16 to off */
			/* setting 16 to off turns on the OK LED */
mov r0,pauseTime	/* set r0, sleepTime to pauseTime */ 
bl Sleep		/* calls sleep function for pauseTime microseconds */

mov r0,#16		/* set r0, pinNum to 16 */
mov r1,#1		/* set r1, pinVal to 1 */
bl SetGpio		/* call SetGpio function, sets pin 16 to on */
			/* setting 16 to on turns OK LED off */
mov r0,pauseTime	/* set r0, sleepTime to pauseTime */
bl Sleep		/* calls sleep function */

add pauseTime,#0x400	/* add 1024 to pausetime to slow down blinking */ 

b loop$			/* branch to loop label */

