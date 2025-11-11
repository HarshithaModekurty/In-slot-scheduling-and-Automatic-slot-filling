# Example program without manual delay slots
start:
    li $t0, 0
    li $t1, 10
    li $s0, 0
loop:
    addi $t0, $t0, 1
    beq $t0, $t1, exit
    nop
    add $s0, $s0, $t0
    j loop
    nop
exit:
    add $v0, $s0, $zero
