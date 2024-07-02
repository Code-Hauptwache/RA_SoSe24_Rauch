.eqv	INT_SIZE,	4

.data

enterTwoNums_str:
	.asciiz	"Please enter two number."
enterFirstNum_str:
	.asciiz	"First number: "
enterSecondNum_str:
	.asciiz	"Second number:"

.text
.globl main

# Main subroutine
main:

# Subroutine int reduceFraction(int z, int n, int *z1, int *n1)
reduceFraction:
	# Promt user to enter two numbers
	la	$a0, enterTwoNums_str
	li	$v0, 4
	syscall
	
	# Read in first number
	