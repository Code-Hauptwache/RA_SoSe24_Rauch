.data
enterBase_str:
	.asciiz	"Enter Base n: "
enterExponent_str:
	.asciiz "Enter Exponent k: "
printExpIsNeg_str:
	.asciiz	"Exponent is negativ: "

.text
.globl main

# Main routine
main:
	# Promt and read in number for `n`
	la	$a0, enterBase_str
	li	$v0, 4
	syscall						# Print the content of enterBase_str
	li	$v0, 5
	syscall						# Read in intiger (base)
	move	$t0, $v0				# Save base in $t0
	
	# Promt and read in number for `k`
	la	$a0, enterExponent_str
	li	$v0, 4
	syscall						# Print the contet of enterExponent_str
	li	$v0, 5
	syscall						# Read in intiger (exponent)
	move	$t1, $v0				# Save exponent in $t1
	
	# If k < 0 goto kIsLessThanZero
	blt	$zero, $t1, exponentIsLessThanZero
	
	# Else calculate the Exponential number
	li	$t9, 1					# Initialize $t9 (result) = 1
calcExpNum_loop:
	beq	$zero, $t1, printResult

exponentIsLessThenZero:
	la	$a0, printExpIsNeg_str
	li	$v0, 4
	syscall						# Print content of printExpIsNeg_str
	
printResult:
	
main_end:
	li	$v0, 10
	syscall						# End program