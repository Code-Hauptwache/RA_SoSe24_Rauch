.data

runAgainPrompt_str:
    .asciiz "Run again? [0 to exit]: "
enterFractionalNum_str:
	.asciiz	"Please enter two number for a fractional number."
enterNumerator_str:
	.asciiz	"\nNumerator: "
enterDenominator_str:
	.asciiz	"Denominator: "
numerator:
	.word	0
denominator:
	.word	0

.text
.globl main

# Main routine
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
	lw	$a0, numerator				# int numerator
	lw	$a1, denominator			# int denominator
	la	$a2, numerator				# int *numerator
	la	$a3, denominator			# int *denominator
	jal	reduceFraction
	
askAgain:
	# Prompt if user wants to rerun the program
	la	$a0, runAgainPrompt_str
	li	$v0, 4
	syscall
	
	# Read in input
	li	$v0, 5
	syscall
	
	beq	$v0, $zero, main_end			# If input == 0 branch to main_end
	li	$t0, 1					# Else load 1 to $t0
	
	beq	$v0, $t0, main				# If input == 1 branch to main
	j	askAgain				# Els jump to askAgain
	
	# End program
main_end:
	li	$v0, 10
	syscall
	
# Subroutine int reduceFraction(int numerator, int denominator, int *numeratorPtr, int *denominatorPtr)
reduceFraction:
	# Preserve retun address
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	beq	$a1, $zero, printError			# If $a1 (denominator) == 0 goto printError
	
	# Call getGCD which returns the the greatest common divisor of the fraction in $v0
	la	$t0, getGCD				# Load the address fo getGCD
	jalr	$t0					# Jump to getGCD and link return address
	
	move	$t0, $a0				# Copy $a0 (numerator) to $t0
	move	$t1, $a1				# Copy $a1 (denominator) to $t1
	move	$t2, $v0				# Copy $v0 (gcd) to $t2
	
	# Reduce fraction
	div	$t0, $t2				# Calculate numerator / gcd
	mflo	$t0					# Copy quotient to $t0
	
	div	$t1, $t2				# Calculate denominator / gcd
	mflo	$t1					# Copy quotient to $t1
	
	# Print result
	la	$a0, reducedFractionResult_str
	li	$v0, 4
	syscall						# Print content of reducedFractionResult_str
	
	move	$a0, $t0				# Copy reduced numerator to $a0
	li	$v0, 1
	syscall						# Print reduced numerator
	
	lb	$a0, division_char
	li	$v0, 11
	syscall						# Print division_char
	
	move	$a0, $t1				# Copy reduced denominator to $a0
	li	$v0, 1
	syscall						# Print reduced denominator
	
	la	$a0, fractionGCDResult_str
	li	$v0, 4
	syscall						# Print content of fractionGCDResult_str
	
	move	$a0, $t2				# Copy GCD of fraction
	li	$v0, 1
	syscall						# Print GCD of fraction
	
	lb	$a0, newLine_char
	li	$v0, 11
	syscall						# Print newLine_char
	
	la	$t3, reduceFraction_end
	jr	$t3

	.data
reducedFractionResult_str:
	.asciiz	"Reduced representation "
division_char:
	.byte	'/'
fractionGCDResult_str:
	.asciiz	" gcd "
newLine_char:
	.byte	'\n'
	
	.text
printError:
	la	$a0, errorMessageDivisorEqualZero_str
	li	$v0, 4
	syscall						# Print content of errorMessageDivisorEqualZero_str

	.data
errorMessageDivisorEqualZero_str:
	.asciiz	"Error: denominator = 0\n"

	.text
reduceFraction_end:
	# Restore return adress
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	
	# Return to caller
	jr	$ra
	
# Subroutine to calculate GCD
getGCD:
	# Preserve $a0 and $a1 by moving their values to temporary registers
	move	$t1, $a0				# Copy $a0 to $t1
	move	$t2, $a1				# Copy $a1 to $t2

	# Check for base cases
	beq	$t1, $zero, storeGCD			# If $t1 == 0, go to storeGCD (store $t2 as the GCD)
	beq	$t2, $zero, storeGCD			# If $t2 == 0, go to storeGCD (store $t1 as the GCD)

calcGCD:
	beq	$t2, $zero, storeGCD			# If $t2 == 0, go to storeGCD
	slt	$t0, $t2, $t1				# Set $t0 to 1 if $t2 < $t1
	beq	$t0, $zero, sub_t2_t1			# If $t2 >= $t1, go to sub_t2_t1
	sub	$t1, $t1, $t2				# $t1 = $t1 - $t2
	j	calcGCD					# Jump back to calcGCD

sub_t2_t1:
	sub	$t2, $t2, $t1				# $t2 = $t2 - $t1
	j	calcGCD					# Jump back to calcGCD

storeGCD:
	# Store the non-zero value of $t1 or $t2 as the GCD
	or	$t0, $t1, $t2				# $t0 = $t1 | $t2 (will be non-zero)
	move	$v0, $t0				# Store the GCD in $v0
	jr	$ra					# Return to caller
