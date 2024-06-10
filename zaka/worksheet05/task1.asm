    ori     $4, $0, 17		# Initialize r4 to 30
    ori     $5, $0, 51		# Initialize r5 to 25
    or      $2, $0, $5		# Initialize r2 to r5
    beq     $4, $0, end		# If r4 == 0, go to end (loop)
    
getGCD:
    beq     $5, $0, GCD		# If r5 == 0, go to GCD
    slt     $1, $5, $4		# Set $1 to 1 if r5 < r4
    beq     $1, $0, sub_r5_r4	# If r5 >= r4, go to sub_r5_r4
    sub     $4, $4, $5		# r4 = r4 - r5
    j       getGCD		# Jump back to getGCD

sub_r5_r4:
    sub     $5, $5, $4		# r5 = r5 - r4
    j       getGCD		# Jump back to getGCD

GCD:
    addu    $2, $0, $4		# Store the GCD in r2 (r4 will be the GCD when r5 == 0)

end:
    j       end			# Infinite loop to end the program
    