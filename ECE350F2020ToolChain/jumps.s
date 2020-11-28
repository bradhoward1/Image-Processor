.text

addi $r1, $r2, 17
jal 17
add $r2, $r1, $r1
add $r0, $r0, $r0
add $r0, $r0, $r0
add $r0, $r0, $r0
add $r0, $r0, $r0
add $r0, $r0, $r0
add $r0, $r0, $r0
add $r0, $r0, $r0
add $r0, $r0, $r0
add $r0, $r0, $r0
add $r0, $r0, $r0
addi $r3, $r2, 17
addi $r1, $r7, 17
blt $r23, $r1, End
add $r3, $r1, $r1
add $r3, $r1, $r1
add $r4, $r1, $r1
add $r3, $r1, $r1
add $r0, $r0, $r0
add $r0, $r0, $r0

NotEqual:


	add $r15, $r4, $r4
	sw $r31, 32($r0)
	add $r4, $r3, $r1
	lw $r6, 32($r0)
	mul $r11, $r15, $r15
	sw $r4, 0($r1)
	lw $r5, 0($r1)
	setx 100
	setx 55
	bex 33
	or $r10, $r1, $r3
	sra $r11, $r10, 6
	addi $r20, $r21, 2
	sub $r22, $r1, $r20
	div $r27, $r22, $r20
	sw $r27, 0($r27)
	jr $r22

End:
	bne $r2, $r2, NotEqual
	add $r1, $r13, $r1
	sll $r29, $r1, 4