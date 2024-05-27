# Initialization
	addi	$8, $0, 0		# $8 = 0
	addi	$9, $0, 11		# $9 = 11
	addi	$10, $0, 0x1000		# $10 = 0x1000
	addi	$11, $0, -1     	# $11 = -1
	addi	$12, $0, -0x8000	# $12 = -0x8000
	ori	$13, $0, 0x8000		# $13 = 0x8000
	lui	$14, 0xffff       	# $14 = 0xffff0000
	ori	$15, $0, 0xffff   	# $15 = 0xffff
	lui	$15, 0x7fff       	# $15 = 0x7fff0000
	addi	$24, $0, 5322    	# $24 = 5322
	addi	$25, $0, 75      	# $25 = 75

# Arithmetic Operations
	add	$2, $10, $9       	# $2 = $10 + $9
	sub	$3, $10, $9       	# $3 = $10 - $9
	add	$4, $9, $10       	# $4 = $9 + $10
	addi	$4, $4, 1        	# $4 = $4 + 1

# Logical Operations
	nor	$9, $0, $9        	# $9 = ~(0 | $9)

# Shift Operations
	sll	$5, $13, 5        	# $5 = $13 << 5
	sra	$6, $13, 5        	# $6 = $13 >> 5 (arithmetic)
	sra	$7, $12, 5        	# $7 = $12 >> 5 (arithmetic)
	srl	$16, $12, 5       	# $16 = $12 >> 5 (logical)
	srlv	$17, $13, $9      	# $17 = $13 >> $9 (logical variable)

# Division
	div	$24, $25          	# $24 / $25
	mflo	$18               	# $18 = LO (result of division)
	mfhi	$19               	# $19 = HI (remainder of division)

# Other Operations
	addiu	$20, $15, 1      	# $20 = $15 + 1 (unsigned)
	addi	$21, $15, 1      	# $21 = $15 + 1
	clo	$22, $11         	# Count leading ones in $11, result in $22
	clo	$23, $14         	# Count leading ones in $14, result in $23
