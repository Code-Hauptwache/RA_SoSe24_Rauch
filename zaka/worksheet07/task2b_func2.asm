func2:  addi 	$t0, $zero, 1
p:      addi	$v0, $zero, -1
q:      and	$t1, $a0, $t0
r:      addi	$v0, $v0, 1
s:      sll	$t0, $t0, 1
t:      bne	$t1, $zero, q
u:      jr	$ra