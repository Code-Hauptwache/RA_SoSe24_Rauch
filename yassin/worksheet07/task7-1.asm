	.data
some_string: 
	.asciiz "comeme los cojones"
	
	
	.text

main:
	la	$a0,some_string
	jal	ncstr	

#subroutine int ncstr(char *str, char c)
ncstr:
	li	$t1, 'c'
	lb	$t2,($a0)
	beq	$t2, $zero, end
	beq 	$t2, $t1, anzahlc	# c anzahl um 1 erhöhen	
	
anzahlc:
	
	
end:
	j 	$ra