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
mDivN_str:
	.asciiz	"m/n: "
mModN_str:
	.asciiz	"m%n: "
mDivNHex_str:
	.asciiz	"m/n (hex): "
mModNHex_str:
	.asciiz	"m%n (hex): "
xWithColon_str:
	.asciiz	"x: "
yWithColon_str:
	.asciiz	"y: "
xDivY_str:
	.asciiz	"x/y: "
xIEEE_str:
	.asciiz	"x (IEEE 754): "
yIEEE_str:
	.asciiz "y (IEEE 754): "
xDivYIEEE_str:
	.asciiz	"x/y (IEEE 754): "
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
	move	$t0, $v0				# Save first number in $t0 (m)
	
	# Prompt, read in and save second number
	la	$a0, enterSecondNum_str
	li	$v0, 4
	syscall						# Print content of enterSecondNum_str
	li	$v0, 5
	syscall						# Read in a integer
	move	$t1, $v0				# Save second number in $t1 (n)

	# Load argument and call printStrNumInHex
	la	$a0, firstNumInHex_str
	move	$a1, $t0
	jal	printStrAndNumInHex			# Print string and first number in hex
	
	# Print comma and space
	jal	printCommaWithSpace

	# Load arguments and call printStrNumInHex
	la	$a0, secondNumInHex_str
	move	$a1, $t1
	jal	printStrAndNumInHex			# Print string and second number in Hex
	
	# Print newline
	jal	printNewline

	# Print solution of m/n
	div	$t0, $t1
	la	$a0, mDivN_str
	mflo	$a1
	jal	printStrAndNum				# Print given string and number
	
	# Print comma and space
	jal	printCommaWithSpace

	# Print solution of m/n in hex
	la	$a0, mDivNHex_str
	jal	printStrAndNumInHex			# Print given strig and number in hex
	
	# Print comma and space
	jal	printCommaWithSpace

	# Print solution of m%n
	div	$t0, $t1
	la	$a0, mModN_str
	mfhi	$a1
	jal	printStrAndNum				# Print given string and number
	
	# Print comma and space
	jal	printCommaWithSpace
	
	# Print solution of m%n in hex
	la	$a0, mModNHex_str
	jal	printStrAndNumInHex			# Print given string and number in hex
	
	# Print newline
	jal	printNewline
	
	# Move numbers to floating point registers
	mtc1	$t0, $f0
	mtc1	$t1, $f1
	
    	# Convert integers to floats
    	cvt.s.w	$f0, $f0				# Convert $f0 from integer to single-precision float
    	cvt.s.w	$f1, $f1				# Convert $f1 from integer to single-precision float
    
    	# Print first number as float
    	la	$a0, xWithColon_str
    	mov.s	$f12, $f0
    	jal	printStrAndFloatNum
	
	# Print comma and space
	jal	printCommaWithSpace
	
	# Print x in (IEEE 754) format
	la	$a0, xIEEE_str
	mfc1	$a1, $f0
	jal	printStrAndNumInHex

	# Print comma and space
	jal	printCommaWithSpace
	
	# Print second number as float
    	la	$a0, yWithColon_str
    	mov.s	$f12, $f1
    	jal	printStrAndFloatNum
    	
    	# Print comma and space
	jal	printCommaWithSpace
    	
	# Print y int (IEEE 754) format
	la	$a0, yIEEE_str
	mfc1	$a1, $f1
	jal	printStrAndNumInHex

	# Print newline
	jal	printNewline
	
	# Print x/y as float
	div.s	$f2, $f0, $f1
	la	$a0, xDivY_str
	mov.s	$f12, $f2
	jal	printStrAndFloatNum

	# Print comma and space
	jal	printCommaWithSpace

	# Print x/y int (IEEE 754) format
	la	$a0, xDivYIEEE_str
	mfc1	$a1, $f2
	jal	printStrAndNumInHex
	
	# End program
	li	$v0, 10
	syscall
	
# Subroutine printCommaWithSpace
printCommaWithSpace:
	la	$a0, comma_str
	li	$v0, 4
	syscall
	jr	$ra
	
# Subroutine printNewline
printNewline:
	lb	$a0, newline_char
	li	$v0, 11
	syscall	
	jr	$ra
	
# Subroutine printNumInHex(char *str, int num)
printStrAndNumInHex:
	# Initialize argumen in temporary Reigsters
	move	$t3, $a1

	# Print first number in hexadecimal
	li	$v0, 4
	syscall						# Print content of given string
	move	$a0, $t3
	li	$v0, 34
	syscall						# Print given number in hex
	jr	$ra
	
# Subroutine printStrAndNum(char *str, int num)
printStrAndNum:
	# Initialize argumen in temporary Reigsters
	move	$t3, $a1

	# Print number
	li	$v0, 4
	syscall						# Print content of given string
	move	$a0, $t3
	li	$v0, 1
	syscall						# Print given number
	jr	$ra

# Subroutine printStrAndNum(char *str, float num)
printStrAndFloatNum:
	li	$v0, 4
	syscall
	li	$v0, 2
	syscall	
	jr	$ra