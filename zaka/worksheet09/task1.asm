.data
enterFirstNum_str:
	.asciiz	"q: "
enterSecondNum_str:
	.asciiz	"p: "
solutionCount_str:
	.asciiz	" solution/s\n"
solution_str:
	.asciiz	"solution"
colon_str:
	.asciiz	": "
firstNum_double:
	.double	0
secondNum_double:
	.double	0

.text
.globl	main

# Main routine
main:
	# Promt and read in first number
	la	$a0, enterFirstNum_str
	li	$v0, 4
	syscall						# Print content of enterFirstNum_str
	
	li	$v0, 7
	syscall						# Get double form user
	
	s.d	$f0, firstNum_double			# Store input in firstNum_double
	
	# Promt and read in second number
	la	$a0, enterSecondNum_str
	li	$v0, 4
	syscall						# Print content of enterSecondNum_str
	
	li	$v0, 7
	syscall						# Get double form user
	
	s.d	$f0, secondNum_double			# Store input in secondNum_double
	
	# Load argument and call quadSolve
	# TODO
	
	# End program
	li	$v0, 10
	syscall
	
# Subroutine unsigned int quadSolve(double p, double q)
quadSolve:
	# TODO