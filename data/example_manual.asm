# Hand scheduled version with delay slots filled
start:
    li $t0, 0
    li $t1, 10
    li $s0, 0
loop:
    addi $t0, $t0, 1
    beq $t0, $t1, exit
    add $s0, $s0, $t0       # delay slot
    j loop
    addi $s0, $s0, 1        # delay slot for jump
exit:
    add $v0, $s0, $zero
