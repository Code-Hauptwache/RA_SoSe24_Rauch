.data

.text							# Code section
.globl main						# Declare main as global for the linker

main:


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