.data
enterFirstNum_str:
	.asciiz	"p: "
enterSecondNum_str:
	.asciiz	"q: "
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
const4_double:
	.double	4.0
const2_double:	
	.double	2.0

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
	l.d	$f12, firstNum_double			# $f12 == p (firstNum_double)
	l.d	$f14, secondNum_double			# $f14 == q (secondNum_double)
	jal	quadSolve
	
	# End program
	li	$v0, 10
	syscall
	
# Subroutine quadSolve(double p, double q)
quadSolve:
	l.d	$f0, 0					# $f0 (solutionOne) == 0
	l.d	$f2, 0					# $f1 (solutionTwo) == 0
	li	$v0, 0					# $v0 (solutionCount) == 0
	
	# Calculate the amount of solutions (Diskremante: D = p²/4 - q)
	mul.d	$f4, $f12, $f12				# $f4 = p²
	l.d	$f6, const4_double			# Load 4.0 into $f6
	div.d	$f4, $f4, $f6				# $f4 = p²/4
	sub.d	$f4, $f4, $f14				# $f4 = p²/4 - q
	
	blt	$f4, 0, setSolutionCountZero		# If D < 0 goto setSolutionCountZero
	# If D = 0 goto setSolutionCountOne
	# Else set $t0 (solutionCount) == 0
	
setSolutionCountZero:

setSolutionCountOne: