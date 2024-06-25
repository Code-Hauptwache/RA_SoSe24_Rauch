.data 
str_a:	.asciiz	"TEST Wort!" 
str_b:	.asciiz "in situ"

.text
main:	
	la	$a0, str_a
	jal	strtolower
	
	# str_b 
	la	$a0, str_b
	jal	strturnaround
	

	
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
	
#subroutine strturnaround(char*)
strturnaround:
	move	$t3, $a0	# $t3 == aktuelle char von adresse str_b
	li	$t0, 0
# Länge des str bestimmen
strlänge:
	lb	$t4, $t3		# lb von adresse $t3 in $t4 
	beq	$t4, $zero,turn		# $t4 == 0 goto turn	
	addi	$t3, $t3, 1		# char um 1 erhöhen
	j	strlänge
	
turn:
	
		
end:
	
