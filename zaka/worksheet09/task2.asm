.data
enterFirstNum_str:
	.asciiz	"m: "
enterSecondNum_str:
	.asciiz	"n: "
comma_str:
	.asciiz	", "
firstNumInHex_str:
	.asciiz	"m (hex): "
secondNumInHex_str:
	.asciiz	"n (hex): "
newline_char:
	.byte	'\n'

.text
.globl main

# Main routine
main:
	# Prompt, read in and save first number
	la	$a0, enterFirstNum_str
	li	$v0, 4
	syscall						# Print content of enterFirstNum_str
	li	$v0, 5
	syscall						# Read in a integer
	move	$t0, $v0				# Save first number in $t0
	
	# Prompt, read in and save second number
	la	$a0, enterSecondNum_str
	li	$v0, 4
	syscall						# Print content of enterSecondNum_str
	li	$v0, 5
	syscall						# Read in a integer
	move	$t1, $v0				# Save second number in $t1
	
	# Load argument and call printTwoNumsinHex
	li	$a0, $t0
	jal	printTwoNumsInHex

	# Load argument and call printTwoNumsinHex
	li	$a0, $t1
	jal	printTwoNumsInHex
# TODO		
	# Load arguments and call 
	
# Subroutine printTwoNumsInHex(int num1, int num2)
printNumInHex:
	# Initialize argumen in temporary Reigsters
	move	$t0, $a0

# TODO
	# Print first number in hexadecimal
	la	$a0, firstNumInHex_str
	li	$v0, 4
	syscall						# Print content of firstNumberInHex_str
	move	$a0, $t0
	li	$v0, 34
	syscall						# Print number in hex
	
# Subroutine printCommaWithSpace
printCommaWithSpace:
	la	$a0, comma_str
	li	$v0, 4
	syscall
	
# Subroutine printNewline
printNewline:
	lb	$a0, newline_char
	li	$v0, 11
	syscall	