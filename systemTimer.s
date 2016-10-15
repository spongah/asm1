.globl Sleep
Sleep:

push {r4,r5}
mov r2,r0		/* move input value to r2 */
sleepTime .req r2	/* set register alias sleepTime to r2 */

ldr r3,=0x20003004
counterAddress .req r3

ldrd r4,[r3]
startCounter .req r4

loop$:
	ldrd r0,[r3]
	elapsed .req r1
	sub elapsed,r0,startCounter
	cmp elapsed,sleepTime
	.unreq elapsed
	bls loop$

pop {r4,r5}
mov pc,lr

