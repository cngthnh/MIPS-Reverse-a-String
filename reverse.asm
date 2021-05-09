.data

input: .space 64
yeuCauNhap: .asciiz "Nhap chuoi ki tu ban muon dao nguoc: "
ketQua: .asciiz "Chuoi dao nguoc: "

.text

main:
	li $v0, 4
	la $a0, yeuCauNhap
	syscall
	
	li $v0, 8
	la $a0, input
	li $a1, 64
	syscall

	li $t0, 0
	
	sw $0, 0($sp)
	subi $sp, $sp, 4
	
	j pushStack
	
	jal exit
	
pushStack:
	add $t2, $a0, $t0 
	lb $t1, 0($t2) # $t1 = input[i]
	beq $t1, $0, printStack
	sw $t1, 0($sp)
	addi $sp, $sp, -4
	addi $t0, $t0, 1 # i++
	j pushStack

printStack:
	li $v0, 4
	la $a0, ketQua
	syscall
	j popStack

popStack:
	addi $sp, $sp, 4
	lw $t0, 0($sp) # $t0 = input[i]
	beq $t0, $0, exit
	move $a0, $t0
	li $v0, 11
	syscall
	j popStack
	
exit:
	li $v0, 10
	syscall	
