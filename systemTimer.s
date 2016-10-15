.globl Sleep		/* make available to all */
Sleep:			/* branch label */

push {r4,r5}		/* push r4 and r5 on to the stack so i can use them */
mov r2,r0		/* move input value to r2 */
sleepTime .req r2	/* set register alias sleepTime to r2 */

ldr r3,=0x20003004	/* set r3 to memory register for timer */
counterAddress .req r3	/* set register alias for counterAddress */

ldrd r4,[counterAddress] 	/* load lower 4 bytes of counter */
startCounter .req r4	/* set register alias for start value */

loop$:			/* loop label */
	ldrd r0,[counterAddress]	/* load new counter from address */
	elapsed .req r1			/* alias elapsed to r1 */
	sub elapsed,r0,startCounter	/* subtract start from new counter */
	cmp elapsed,sleepTime		/* compare elapsed to sleeptime */
	.unreq elapsed			/* remove elapsed alias */
	bls loop$			/* if less then loop again */

pop {r4,r5}		/* put r4 and r5 back */
mov pc,lr		/* return */

