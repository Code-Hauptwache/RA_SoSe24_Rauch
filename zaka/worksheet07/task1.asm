.eqv	BUFFER_SIZE, 128				# Define BUFFER_SIZE as 128
.eqv	BYTE_SIZE, 2					# Define BYTE_SIZE as 1

.data

enterStr:
	.asciiz	"\nPlease enter a string: "
enterChar:
	.asciiz	"Please enter a single character: "
charCountOutput:
	.asciiz	"\nCharacter count: "
askRunAgainStr:
	.asciiz	"\nAgain (y)? "
str:	.space	BUFFER_SIZE				
char:	.space	BYTE_SIZE

.text							# Code section
.globl main						# Declare main as global for the linker

main:
	# Print user to enter a string
	la	$a0, enterStr				# Load the adress of enterStr into $a0
	li	$v0, 4					# Load the syscall code for printing a string
	syscall						# Make the syscall
	
	# Get a string from user input
	la	$a0, str				# Load the address of str into $a0
	li	$a1, BUFFER_SIZE			# Load the value of BUFFER_SIZE into $a1
	li	$v0, 8					# Load the syscall code for reading a string into $v0
	syscall						# Make the syscall
	
	#Print user to enter a char
	la	$a0, enterChar				# Load the adress of enterChar into $a0
	li	$v0, 4					# Load the syscall code for printing a string
	syscall						# Make the syscall

	# Get a char from user input
	li	$v0, 12					# Load the syscall code for reading a char
	syscall						# Make the syscall
	sb	$v0, char				# Store the read character in the address of char
	
	# Load arguments and call ncStr
	la	$a0, str				# Load the adress of str into $a0
	la	$a1, char				# Load the adress of char into $a1
	jal	ncStr					# Jump and linke to subroutine ncStr
	
	# Print the number of character `char` found in str
	move	$t0, $v0
	
	la	$a0, charCountOutput
	li	$v0, 4
	syscall
	
	move	$a0, $t0				# Move the count from $t0 to $a0
	li	$v0, 1					# Load the syscall code for printing an integer
	syscall
	
	# Ask whether the program should be run again
askAgain:
	la	$a0, askRunAgainStr
	li	$v0, 4
	syscall
	
	li	$v0, 12
	syscall
	
	li	$t0, 'y'				#  Load the ASCII value of 'y' into $t0
	li	$t1, 'n'				# Load the ASCII value of 'n' into $t1
	
	beq	$v0, $t0, main				# If the input character is 'y', branch to main
	beq	$v0, $t1, end_main			# If the input character is 'n', branch to end_main
	j	askAgain				# Else repeat askAgain
	
end_main:
	li	$v0, 10					# Load the syscall code for exiting the program into $v0
	syscall						# Make the syscall to exit the program

# Subroutine ncStr(cahr *str, char c)
ncStr:
	move	$t0, $a0				# (str_prt) : $t0 = adress of the given string
	lb	$t1, ($a1)				# Load the byte that should be checked for occurrence in the given string
	move	$t2, $zero				# (charCount) : $t2 = 0 Initialize counter to 0
	
# Loop to count the number of `c` in the given string
countCharInStr:
	lb	$t3, ($t0)				# Load current byte of given string into $t3
	
	beq	$t3, $zero, ncStr_end			# If $t3 == '\0' goto ncStr_end
	
	beq	$t3, $t1, incrementCount		# If current byte == `c` goto incrementCount
	j	nextChar_ncStr				# Else goto nextChar_ncStr
	
incrementCount:
	addi	$t2, $t2, 1				# Increment charCounter by one
	j	nextChar_ncStr				# Jump to nextChar_ncStr
	
nextChar_ncStr:
	addi	$t0, $t0, 1				# Set str_ptr to point at the next char
	j	countCharInStr				# Jump to countCharInStr
	
ncStr_end:
	move	$v0, $t2				# Return charCount
	jr	$ra					# Return from subroutine ncStr
