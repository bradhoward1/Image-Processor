.text


DefinitionOfValues:
	addi $r10, $r1, 2748
	addi $r11, $r1, 495
	addi $r12, $r1, 291
	addi $r13, $r1, 1
	addi $r14, $r1, 4000
	addi $r15, $r1, 0
	sw $r10, 0($r1)
	sw $r11, 1($r1)
	sw $r12, 2($r1)
	sw $r13, 3($r1)
	sw $r14, 4($r1)
	sw $r15, 5($r1)
	addi $r29, $r29, 4096
	add $r0, $r0, $r0
	add $r0, $r0, $r0
	add $r0, $r0, $r0
	add $r0, $r0, $r0
	add $r0, $r0, $r0
	addi $r30, $r30, 3

GrayScale:
	lw $r2, 0($r1)
	sra $r3, $r2, 8
	sra $r4, $r2, 4
	sll $r4, $r4, 28
	sra $r4, $r4, 28
	sll $r5, $r2, 28
	sra $r5, $r5, 28
	add $r6, $r3, $r4
	add $r7, $r5, $r6
	div $r8, $r7, $r30
	sll $r9, $r8, 4
	sll $r10, $r8, 8
	add $r11, $r8, $r9
	add $r12, $r10, $r11
	sw $r12, 0($r1)
	lw $r13, 0($r1)
	addi $r1, $r1, 1
	bne $r1, $r29, GrayScale