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
    	lb 	$t3, ($a0)  				# Load the current byte (character) of str into $t3
	
	beq	$t3, $zero, end				# If $t3 == '\0' jump to end

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

end:
	jr	$ra					# Return from subroutine

# Subroutine strTurnAround(cahr*)
strTurnAround:
	