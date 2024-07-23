.data 
str_a:	.asciiz	"TEST Wort!" 
str_b:	.asciiz "in situ"
str3:	.space	10
	.byte	0
	.byte	0xff
	.byte	0xff

.text
.globl main

main:	
	la	$a0, str_a
	jal	strtolower
	
	la	str_b
	jal	strtolower
	
	# str_b umkehren
	la	$a0, str_b
	jal	strturnaround
	
	# umkehren str_a
	la	$a0, str_a
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
	addi	$t0, $t0, 1		# erhöhen von strlänge um 1
	addi	$t3, $t3, 1		# char um 1 erhöhen
	j	strlänge
	
turn:
	subi	$t1, $t3, 1		
	move	$t2, $a0
	
swap:
	bge	$t2, $t1, strturnaround
	
	lb	$t4, ($t2)
	lb	$t5, ($t1)
	sb	$t5, ($t2)
	sb	$t4, ($t1)
	
	addi	$t2, $t2, 1
	subi	$t1, $t1, 1
	j	swap

strlänge_end:
	jr	$ra
	
strispalindrom:
	move	$t0, $a0
	li	$t1, 0
	
strlängePA:
	lb	$t2, ($t0)
	beq	$t2, $zero, checkPA
	addi	$t1, $t1, 1
	addi	$t0, $t0, 1
	j	strlängePA
		
checkPA:
	subi	$t0, $t0, 1
	move	$t3, $a0
	
checkPAloop:

	
	
