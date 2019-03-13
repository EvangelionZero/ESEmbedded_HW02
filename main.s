.syntax unified

.word 0x20000100
.word _start

.global _start
.type _start, %function
_start:
	//
	//mov # to reg
	//
	movs	r0,	#000
	movs	r1,	#100
	movs	r2,	#200
	movs	r3,	#300

	//
	//push 
	//
	push	{r0,r1,r2,r3}
	
	//
	//pop
	//
	pop	{r4}
	pop	{r5}
	pop	{r6}
	pop	{r7}

	//result:r0 at the bottom

	//
	//push
	//
	push	{r0}
	push	{r1}
	push	{r2}
	push	{r3}

	//
	//pop
	//
	pop 	{r4,r5,r6,r7}
	
	//result:r4 at the bottom

	nop

	//
	//branch w/o link
	//
	bl	label01

label01:
	nop

	//
	//branch w/ link
	//
	bx	lr	

sleep:
	nop
	b	sleep
