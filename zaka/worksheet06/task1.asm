.data

str1:	.asciiz	"Lager"
str2:	.asciiz	"Regal"
str3:	.space	10
	.byte	0
	.byte	0xff
	.byte	0xff

.text							# Code section
.globl main						# Declare main as global for the linker

main:
	# Convert str1 to lowercase
	la	$a0, str1
	jal	strToLower

	# Convert str2 to lowercase
	la	$a0, str2
	jal	strToLower

	# Reverse str1
	la	$a0, str1
   	jal	strTurnAround

	# Reverse str2
	la	$a0, str2
	jal	strTurnAround

	# Concatenate str1 and str2 into str3
	la	$a0, str1
	la	$a1, str2
	la	$a2, str3
	jal	strCat

	# Check if str3 is a palindrome
	la	$a0, str3
	jal	strIsPalindorm

	# Exit program
	li	$v0, 10
	syscall

# Subroutine strToLower(char* str)
strToLower:
	li	$t0, 'A'				# Load ASCII value of 'A' into $t0
	li	$t1, 'a'				# Load ASCII value of 'a' into $t1
	sub	$t2, $t1, $t0				# Load difference between 'a' and 'A' into $t2
	li	$t6, 'Z'				# Load ASCII value of 'Z' into $t6
	
# Loop to turn every capital letter in a string to lowercase
loop:
    	lb 	$t3, ($a0)  				# Load the current byte (character) of string into $t3
	
	beq	$t3, $zero, strToLower_end		# If $t3 == '\0' jump to strToLower_end

	slt	$t4, $t3, $t0 				# If $t3 < 'A' set $t4 to 1
    	slt	$t5, $t6, $t3 				# If $t3 > 'Z' set $t5 to 1
    	
	# If capital letter jumpt to lowercase ($t4 and $t5 == 0)
	bne	$t4, $t5, nextCharTL			# If current char is not capital jump to nextCharTL
	j	lowercase				# Else jump to lowercase
	
lowercase:
	add	$t3, $t3, $t2				# Turn capital letter to lowercase
	sb	$t3, ($a0)

nextCharTL:
	addi	$a0, $a0, 1				# Increment adress of str to point to the next char in string
	j	loop	

strToLower_end:
	jr	$ra					# Return from subroutine strToLower

# Subroutine strTurnAround(char* str)
strTurnAround:
	move    $t3, $a0				# $t3 = address of the string (start_ptr)
	li      $t0, 0					# $t0 = string length counter (initially 0)

# Loop to get the length of the given string
getStrLenTA:
	lb      $t4, ($t3)				# Load byte from address $t3 into $t4
	beq     $t4, $zero, turnAround			# If current char == '\0' goto turnAround
	addi    $t0, $t0, 1				# Increment string length count
	addi    $t3, $t3, 1				# Move to the next character
	j       getStrLenTA				# Jump to getStrLenTA

turnAround:
	subi    $t1, $t3, 1				# Set $t1 to point at the last character ($t3 points at '\0')
	move    $t2, $a0				# $t2 = start_ptr for swapping

# Loop to swap characters
swapLoop:
	bge     $t2, $t1, strTurnAround_end		# If start_ptr >= end_ptr, end the loop

	lb      $t4, ($t2)				# Load byte from start_ptr into $t4
	lb      $t5, ($t1)				# Load byte from end_ptr into $t5
	sb      $t5, ($t2)				# Store byte from $t5 into start_ptr
	sb      $t4, ($t1)				# Store byte from $t4 into end_ptr

	addi    $t2, $t2, 1				# Increment start_ptr
	subi    $t1, $t1, 1				# Decrement end_ptr
	j       swapLoop				# Jump to swapLoop

strTurnAround_end:
	jr      $ra					# Return from subroutine strTurnAround

# Subroutine strIsPalindorm(char* str)
strIsPalindorm:
	move	$t0, $a0				# Move adress of the given string into $t0
	li	$t1, 0					# $t0 = string length counter (initially 0)
	
# Loop to get the length of the given string
getStrLenPA:
	lb      $t2, ($t0)				# Load byte from address $t0 into $t2
	beq     $t2, $zero, checkPalindorm		# If current char == '\0' goto checkPalindrom
	addi    $t1, $t1, 1				# Increment string length count
	addi    $t0, $t0, 1				# Move to the next character
	j       getStrLenPA				# Jump to getStrLenPA
	
checkPalindorm:
	subi	$t0, $t0, 1				# Set $t0 (end_ptr) to point at the last char (was pointing at '\0'
	move	$t3, $a0				# Set $t3 (start_ptr) to point at the first char of the given string
	
# Loop to check for Palindrom
checkPalindrom_loop:
	bge	$t3, $t0, returnIsPalindrom		# If start_ptr >= end_ptr, returnIsPalindrom the loop
	
	lb	$t4, ($t3)				# Load byte from start_ptr into $t4
	lb	$t5, ($t0)				# Load byte form end_ptr into $t5
	
	beq	$t4, $t5, nextCharPA			# If char at start_prt == char at end_prt goto nextCharPA
	j	returnIsNotPalindorm
	
nextCharPA:
	addi    $t3, $t3, 1				# Increment start_ptr
	subi    $t0, $t0, 1				# Decrement end_ptr
	
returnIsPalindrom:
	addi	$v0, $zero, 1				# set $v0 to true
	jr	$ra					# Return form subroutine strIsPalindorm

returnIsNotPalindorm:
	move	$v0, $zero				# set $v0 to false
	jr	$ra					# Return form subroutine strIsPalindorm

# Subroutine strCat(cahr* result, char* str1, char* str3)
strCat:
	move	$t0, $a0				# Move adress of the first given string into $t0 (str1_ptr)
	move	$t1, $a1				# Move adress of the second given string into $t1 (str2_ptr)
	move	$t2, $a2				# Move adress of the third given string into $t2 (str3_ptr)
	
catStr1Loop:
	lb	$t3, ($t0)				# Load current byte from str1_ptr into $t3
	beq	$t3, $zero, catStr2Loop			# If $t3 == '0' goto catStr2Loop
	
	sb	$t3, ($t2)				# Store current byte in str3
	
	addi	$t0, $t0, 1				# Increment str1_ptr to point at the next char
	addi	$t2, $t2, 1				# Increment str3_ptr to point at the next space
	
	j	catStr1Loop				# Jump to catStr1Loop
	
catStr2Loop:
	lb	$t3, ($t1)				# Load current byte from str2_ptr into $t3
	beq	$t3, $zero, strCat_end			# If $t3 == '0' goto strCat_end
	
	sb	$t3, ($t2)				# Store current byte in str3
	
	addi	$t1, $t1, 1				# Increment str2_ptr to point at the next char
	addi	$t2, $t2, 1				# Increment str3_ptr to point at the next space
	
	j	catStr2Loop				# Jump to catStr2Loop

strCat_end:
	jr	$ra					# Return form subroutine strCat