main:
    	ori	$4,$0,25      		# r4 <-- 25
    	ori	$5,$0,35       		# r5 <-- 35
    	jal	gcd           		# Aufruf des Unterprogramms
    					# Prüfen Sie den Rückgabewert in r2
    					   
    					# Wiederholen für andere Zahlenpaare
    	ori	$4,$0,210
    	ori	$5,$0,28
   	jal	gcd
   	
   	ori	$4,$0,49
   	ori	$5,$0,42
   	jal	gcd
   	
   	ori	$4,$0,17
   	ori	$5,$0,3
   	jal 	gcd
   	
   	ori	$4,$0,17
   	ori	$5,$0,51
   	jal	gcd
   	
end_main:
    	j	end_main       		# Endlosschleife
    	
gcd:
    	add	$2, $5,$0   		# r2 <-- r5
loop_sub:
    	beq	$4, $0, end_sub 		# if(r4 == 0) goto end_sub
    	beq	$5, $0, set_sub_r2 		# if(r5 == 0) goto set_sub_r2
   	beq	$5, $4, sub_sub_r4  	# if(r4 > r5) goto sub_sub_r4
    	sub	$5, $5, $4        		# r5 <-- r5 - r4
    	j 	loop_sub               	# goto loop_sub

sub_sub_r4:
    	sub	$4, $4, $5        		# r4 <-- r4 - r5
    	j	loop_sub               	# goto loop_sub

set_sub_r2:
   	add	$2, $4,$0           	# r2 <-- r4

end_sub:
    	jr	$ra                  	# Rückkehr zum Aufrufer
