.data 
str_a:	.asciiz	"TEST Wort!" 

.text
main:	
	la	$a0, str_a
	jal	strtolower
	
	
# subroutine strtolower(char*)
strtolower:		
	li	$t0, 'A'		# intialisierung 
	li	$t1, 'a'
	li	$t6, 'Z'
	sub	$t2, $t1, $t0		# differenz von $t1 - $t0 wird in $t2 gespeichert
loop:
	lb	$t3, ($a0)		# aktuelle char von str_a wird in $t3 gespeichert
	beq	$t3, $zero, end		# $t3 == \0 goto end
	slt	$t4, $t3, $t0		# if $t3 < 'A'rd wird $t4 zu 1
	slt	$t5, $t6, $t3		# if $t3 > 'Z'rd wird zu 1
	beq	$t4, $t5, lowercase
	j	next

						
lowercase:
	add	$t3, $t3, $t2
	sb	$t3, ($a0)
	
next:
	addi 	$a0, $a0, 1
	j	loop	
end:
	jr	$ra
