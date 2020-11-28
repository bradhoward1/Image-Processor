.text

###
##
#       ECE350 Fall 2020: Sample MIPS file
#       Note: the code doesn't test any kind of functionality; it serves to
#             illustrate the syntax of instructions supported
##
###

setx 	100
bex 	10
here:
	addi    $r3, $r2, 50000
	addi	$r1, $r2, 50000
mul		$r2, $r3, $r1
sra		$r2, $r1, 5
sll		$r1, $r2, 5
addi	$r5, $r0, 100
addi	$r6, $r0, 50
sub     $r4, $r5, $r6
and     $r7, $r5, $r6
or      $r10, $r11, $r12
sw      $r1, 10($r0)
lw      $r9, 10($r0)
bne     $r0, $r1, here
j       there
add 	$r3, $r2, $r1
add $r1, $r2, $r3
there:
	mul $r1, $r2, $r3