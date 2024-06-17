main:
	ori $4,$0,0
	ori $5,$0,0
	
	jal gcd

			
end:
	j	end
							
				
# Unterprogramm zur Berechnung des GGT
gcd:
    	add $2, $5,$0   			# r2 <-- r5
loop_sub:
    	beq $4, $0, end_sub 		# if(r4 == 0) goto end_sub
    	beq $5, $0, set_sub_r2 		# if(r5 == 0) goto set_sub_r2
   	beq $5, $4, sub_sub_r4  	# if(r4 > r5) goto sub_sub_r4
    	sub $5, $5, $4        		# r5 <-- r5 - r4
    	j loop_sub               	# goto loop_sub

sub_sub_r4:
    	sub $4, $4, $5        		# r4 <-- r4 - r5
    	j loop_sub               	# goto loop_sub

set_sub_r2:
   	add $2, $4,$0           		# r2 <-- r4

end_sub:
    	jr $ra                  		# Rückkehr zum Aufrufer