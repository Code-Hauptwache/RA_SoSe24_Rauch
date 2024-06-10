	.data
str:	.asciiz	"TEST String!"

main:
	# Call subroutine	
	la	$a0, str			# load adress of str
	jal	strToLower			# Jump and link to subroutine "strToLower"
	
	# Subroutine to turn letters to lower case
strToLower:
	slt	