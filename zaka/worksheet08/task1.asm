.data

enterFractionalNum_str:
	.asciiz	"Please enter two number for a fractional number."
enterNumerator_str:
	.asciiz	"\nNumerator: "
enterDenominator_str:
	.asciiz	"Denominator:"
numerator:
	.word	0
denominator:
	.word	0

.text
.globl main

# Main subroutine
main:
	# Prompt user to enter a fractional number
	la	$a0, enterFractionalNum_str		# Load the adress of enterFractionalNum_str into $a0
	li	$v0, 4					# Load the syscall code to print a string
	syscall						# Make the syscall
		
	# Prompt, read in and save input in numerator
	la	$a0, enterNumerator_str			# Load the adresss of enterNumerator_str
	li	$v0, 4
	syscall
	
	li	$v0, 5					# Load the code to read an integer
	syscall	
	
	sw	$v0, numerator				# Store input in numerator
	
	# Prompt user, read in and save input in denominator
	la	$a0, enterDenominator_str		# Load the adress of enterDenominator_str
	li	$v0, 4
	syscall
	
	li	$v0, 5
	syscall
	
	sw	$v0, denominator			# Store input in denominator
	
	# Load the argument and call reduceFraction
	lw	$a0, numerator
	lw	$a1, denominator
	la	$a2, numerator
	la	$a3, denominator
	jal	reduceFraction
	
# Subroutine int reduceFraction(int numerator, int denominator, int *numeratorPtr, int *denominatorPtr)
reduceFraction: