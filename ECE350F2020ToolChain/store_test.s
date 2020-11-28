.text

addi $r1, $r2, 17
blt $r1, $r1, NotEqual
add $r3, $r1, $r1
add $r3, $r1, $r1
add $r4, $r1, $r1
add $r3, $r1, $r1

NotEqual:
	sw $r1, 32($r2)
	lw $r3, 32($r2)
	sll $r4, $r3, 15
	sw $r4, 0($r1)
	lw $r5, 0($r1)