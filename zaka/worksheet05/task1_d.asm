main:
    # Initialize arguments and Call the subroutine
    ori     $4, $0, 25       	# Initialize r4 to 17
    ori     $5, $0, 30		# Initialize r5 to 51
    jal     getGCD           	# Jump and link to subroutine "getGCD"

    # Initialize arguments and Call the subroutine
    ori     $4, $0, 210       	# Initialize r4 to 17
    ori     $5, $0, 28		# Initialize r5 to 51
    jal     getGCD           	# Jump and link to subroutine "getGCD"

    # Initialize arguments and Call the subroutine
    ori     $4, $0, 49       	# Initialize r4 to 17
    ori     $5, $0, 42		# Initialize r5 to 51
    jal     getGCD           	# Jump and link to subroutine "getGCD"

    # Initialize arguments and Call the subroutine
    ori     $4, $0, 17       	# Initialize r4 to 17
    ori     $5, $0, 3		# Initialize r5 to 51
    jal     getGCD           	# Jump and link to subroutine "getGCD"

    # Initialize arguments and Call the subroutine
    ori     $4, $0, 17       	# Initialize r4 to 17
    ori     $5, $0, 51		# Initialize r5 to 51
    jal     getGCD           	# Jump and link to subroutine "getGCD"

    # End of program
end:
    j       end              	# Infinite loop to end the program


# Subroutine to calculate GCD
getGCD:    
    or	    $2, $0, $5    	# Initialize r2 with the value in r5
    beq     $4, $0, end      	# If r4 == 0, go to end (loop)
    beq     $5, $0, storeGCD 	# If r5 == 0, go to storeGCD

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
    addu    $2, $0, $4       	# Store the GCD in r2
    jr      $ra              	# Return to caller
