	ori	$4,$0,25
	ori	$5,$0,35
	or 	$2,$0,$5
	beq	$4,$0,end
loop:
	beq	$5,$0,result
	slt 	$1,$5,$4
	beq	$1,$0,sub_r5_r4
	sub	$4,$4,$5
	j	loop
	
sub_r5_r4:
	sub	$5,$5,$4
	j	loop
result:	
	addu 	$2,$0,$4
	
end:
	j	end
	