HW02
===
##1.實驗題目
撰寫簡易組語觀察pop與push多個暫存器時順序有無分別

##2.實驗步驟
 1.先將資料夾 gnu-mcu-eclipse-qemu 完整複製到 ESEmbedded_HW02 資料夾中
 2.利用lab02裡面的第二個practice,照著pop與push的寫法配合自己的方法寫改在main.s中
 3.設計測試程式 main.s ，從 _start 開始後依序執行,目標是比較預先存入的值,得知語法裡暫存器的
   先後是否有影響
main.s:
*_start:
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

	//result:r3 at the top

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
	
	//result:r4 at the top

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
*	b	sleep
4.將 main.s 編譯並以 qemu 模擬， `$ make clean `, `$ make` , `$ make qemu `開啟另一 Terminal 連線` $ arm-none-eabi-gdb `，再輸入 `target remote localhost:1234` 連接，輸入兩次的 `ctrl + x `再輸入 `2`, 開啟 暫存器以及指令，並且輸入` si `單步執行觀察。當執行到`0x12`時,會一次`push`四個暫存器`({r0,r1,r2,r3})`的值到ram中,在`0x14,0x16,0x18,0x1a`時依序`pop`到`r4~r7`中，發現`r4`的值等同`r0,r5`的值等同`r1`,代表`push{}`的順序裡,越前者是越晚被加入stack中，而觀察`pop{}`的方式也類似,在`0x16,0x18,0x20,0x22`時依序`push r0~r3`,再一次`pop({r4,r5,r6,r7}`)出來,發現`r4`的值等同`r3,r5`的值等同`r2`,代表`pop{}`的順序裡,越前者越早離開stack中

##3.結果與討論
 1.`push{ra,rb,rc,rd}`時,`push`的順序為`rd,rc,rb,ra`
 2.`pop{ra,rb,rc,rd}`時,`pop`的順序為`ra,rb,rc,rd`
--------------------

- [x] **If you volunteer to give the presentation next week, check this.**

--------------------

Please take your note here.
