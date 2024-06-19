.data

str_a:	.asciiz "TEST String!"
str_b:	.asciiz "in situ"

.text							# Code section
.globl main						# Declare main as global for the linker

main:
    	# Load the address of str_a into $a0 and call strToLower
    	la 	$a0, str_a 
    	jal 	strToLower  				
	
	# Load the adress of str_b into $a0 and call strTurnAround
	la	$a0, str_b
	jal	strTurnAround

    	# Exit program
	li	$v0, 10
	syscall

# Subroutine strToLower(char*)
strToLower:
	li	$t0, 'A'				# Load ASCII value of 'A' into $t0
	li	$t1, 'a'				# Load ASCII value of 'a' into $t1
	sub	$t2, $t1, $t0				# Load difference between 'a' and 'A' into $t2
	
# Loop to turn every capital letter in a string to lowercase
loop:
    	lb 	$t3, ($a0)  				# Load the current byte (character) of string into $t3
	
	beq	$t3, $zero, strToLower_end		# If $t3 == '\0' jump to strToLower_end

	slt	$t4, $t3, $t0 				# If $t3 < 'A' set $t4 to 1
    	slt	$t5, $t1, $t3 				# If $t3 > 'Z' set $t5 to 1
    	
	# If capital letter jumpt to lowercase ($t4 and $t5 == 0)
	bne	$t4, $t5, nextChar			# If current char is not capital jump to nextChar
	j	lowercase				# Else jump to lowercase
	
lowercase:
	add	$t3, $t3, $t2				# Turn capital letter to lowercase
	sb	$t3, ($a0)

nextChar:
	addi	$a0, $a0, 1				# Increment adress of str to point to the next char in string
	j	loop	

strToLower_end:
	jr	$ra					# Return from subroutine

# Subroutine strTurnAround(char*)

strTurnAround:

    move    $t3, $a0           # $t3 = address of the string (start_ptr)

    li      $t0, 0             # $t0 = string length counter (initially 0)



# Loop to get the length of the given string

getStrLen:

    lb      $t4, 0($t3)        # Load byte from address $t3 into $t4

    beq     $t4, $zero, turnAround # If current char == '\0' goto turnAround

    addi    $t0, $t0, 1        # Increment string length count

    addi    $t3, $t3, 1        # Move to the next character

    j       getStrLen          # Jump to getStrLen



turnAround:

    subu    $t1, $t3, 1        # Set $t1 to point at the last character ($t3 points at '\0')

    move    $t2, $a0           # $t2 = start_ptr for swapping

    

# Loop to swap characters

swapLoop:

    bge     $t2, $t1, strTurnAround_end # If start_ptr >= end_ptr, end the loop

    

    lb      $t4, 0($t2)        # Load byte from start_ptr into $t4

    lb      $t5, 0($t1)        # Load byte from end_ptr into $t5

    sb      $t5, 0($t2)        # Store byte from $t5 into start_ptr

    sb      $t4, 0($t1)        # Store byte from $t4 into end_ptr

    

    addi    $t2, $t2, 1        # Increment start_ptr

    subi    $t1, $t1, 1        # Decrement end_ptr

    j       swapLoop           # Jump to swapLoop



strTurnAround_end:

    jr      $ra                # Return from subroutine
