main:
    # Initialize arguments
    ori     $4, $0, 0       	# Initialize r4 to 17
    ori     $5, $0, 0			# Initialize r5 to 51

    # Call the subroutine
	jal     getGCD           	# Jump and link to subroutine "getGCD"

    # End of program
end:
    j       end              	# Infinite loop to end the program


# Subroutine to calculate GCD
getGCD:
    beq     $4, $0, storeGCD 	# If r4 == 0, go to storeGCD (store r5 as the GCD)
    beq     $5, $0, storeGCD 	# If r5 == 0, go to storeGCD (store r4 as the GCD)

calcGCD:
    beq     $5, $0, storeGCD 	# If r5 == 0, go to storeGCD
    slt     $1, $5, $4       	# Set $1 to 1 if r5 < r4
    beq     $1, $0, sub_r5_r4 	# If r5 >= r4, go to sub_r5_r4
    sub     $4, $4, $5       	# r4 = r4 - r5
    j       calcGCD          	# Jump back to calcGCD

sub_r5_r4:
    sub     $5, $5, $4       	# r5 = r5 - r4
    j       calcGCD          	# Jump back to calcGCD

storeGCD:
    # Store the non-zero value of r4 or r5 as the GCD
    or      $1, $4, $5       	# $1 = r4 | r5
    addu    $2, $0, $1       	# Store the GCD in r2
    jr      $ra              	# Return to caller
