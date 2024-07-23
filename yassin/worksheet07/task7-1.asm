	.data
some_string: 
	.asciiz "comeme los cojones"
	
	
	.text

main:
	la	$a0,some_string
	li	$t3, 0		#zähler für c
	jal	ncstr	

	#subroutine int ncstr(char *str, char c)
loop:
	lb	$t2,($a0)
	li	$t1, 'c'
	beq	$t2, $t3, 
	beq	$t2, $zero, end
	beq 	$t2, $t1, anzahlc	# c anzahl um 1 erhöhen	
	

next:
	addi 	$a0, $a0, 1
	j	ncstr
	
anzahlc:
	
	
end:
	j 	$ra
