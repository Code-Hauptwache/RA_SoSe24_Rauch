.data
enterFirstNum_str:
	.asciiz	"p: "
enterSecondNum_str:
	.asciiz	"q: "
solutionCount_str:
	.asciiz	" solution(s)\n"
solution_str:
	.asciiz	"solution "
colon_str:
	.asciiz	": "
newline_char:
	.byte	'\n'
firstNum_double:
	.double	0
secondNum_double:
	.double	0
const4_double:
	.double	4
const2_double:
	.double	2
const0_double:
	.double	0
constNeg1_double:
	.double -1


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
	
	move	$t0, $v0				# Copy $v0 (solutionCount) to $t0
	
	# Print number of solutions
	move	$a0, $t0
	li	$v0, 1
	syscall						# Print solutionCount
	la	$a0, solutionCount_str
	li	$v0, 4
	syscall						# Print content of solutionCount_str
	
	li	$t1, 1
	li	$t2, 2
	beq	$t0, $t1, printSolutionOne		# If solutionCount == 1 goto printSolutionOne
	seq	$t3, $t0, $t2				# If solutionCount == 2 set $t3 (checkIfTwoSolutions) == 1
	beq	$t3, $t1, printSolutionOne		# If $t3 (checkIfTwoSolutions) == 1 goto printSolutionOne
	j	main_end				# Else goto main_end
	
printSolutionOne:
	# Print first solution
	jal	printSolution_str			# Print content of solution_str
	li	$a0, 1
	li	$v0, 1
	syscall						# Print 1
	jal	printColon_str				# Print content of colon_str
	mov.d	$f12, $f0
	li	$v0, 3
	syscall						# Print content of f1:f0
	
	beq	$t3, $t1, printSolutionTwo		# If $t3 (checkIfTwoSolutions) == 1 (true) goto printSolutionTwo
	j	main_end				# Else goto main_end
	

printSolutionTwo:
	# Print a newline
	lb	$a0, newline_char
	li	$v0, 11
	syscall
	
	# Print second solution
	jal	printSolution_str			# Print content of solution_str
	li	$a0, 2
	li	$v0, 1
	syscall						# Print 2
	jal	printColon_str				# Print content fo colon_str
	mov.d	$f12, $f2
	li	$v0, 3
	syscall						# Print content of f3:f2

	# End program	
main_end:
	li	$v0, 10
	syscall
	
# Subroutine quadSolve(double p, double q)
quadSolve:
	# Initialize registers for results
	l.d	$f0, const0_double			# $f0 (solutionOne) == 0
	l.d	$f2, const0_double			# $f2 (solutionTwo) == 0
	li	$v0, 0					# $v0 (solutionCount) == 0
	
	# Initialize constans for calculations
	l.d	$f6, const4_double
	l.d	$f8, const2_double
	l.d	$f10, const0_double
	l.d	$f16, constNeg1_double
	
	# Calculate the amount of solutions (Diskremante: D = p²/4 - q)
	mul.d	$f4, $f12, $f12				# $f4 = p²
	div.d	$f4, $f4, $f6				# $f4 = p²/4
	sub.d	$f4, $f4, $f14				# $f4 = p²/4 - q
	
	c.lt.d	$f4, $f10				# Compare if $f4 < 0
	bc1t	zeroSolutions				# If D < 0 goto zeroSolution
	c.eq.d	$f4, $f10				# Compare if $f4 == 0
	bc1t	oneSolution				# If D == 0 goto oneSolution
	j	twoSolutions				# Else goto twoSolutions
	
zeroSolutions:
	li	$v0, 0					# Set $v0 (solutionCount) == 0
	
	j	quadSolve_end

oneSolution:
	li	$v0, 1					# Set $v0 (solutionCount) == 1
	
	# Calculate the solution
	div.d	$f4, $f12, $f8				# $f4 = p/2
	mul.d	$f0, $f4, $f16				# $f0 = -(p/2) ($f0 = solution)

	j	quadSolve_end	

twoSolutions:
	li	$v0, 2					# Set $v0 (solutionCount) == 2
	
	# Initialize $f18 = sqrt(D)
	sqrt.d	$f18, $f4
	
	# Initialize $f4 = -(p/2)
	div.d	$f4, $f12, $f8
	mul.d	$f4, $f4, $f16				
	
	
	sub.d	$f0, $f4, $f18				# Calculate first solution: $f0 = -(p/2) - sqrt(D)	
	add.d	$f2, $f4, $f18				# Calculate second solution: $f2 = -(p/2) + sqrt(D)

quadSolve_end:
	jr	$ra
	
# Subroutine to print content of solution_str
printSolution_str:
	la	$a0, solution_str
	li	$v0, 4
	syscall
	jr	$ra

# Subroutine to print content of colon_str
printColon_str:
	la	$a0, colon_str
	li	$v0, 4
	syscall
	jr	$ra
	
