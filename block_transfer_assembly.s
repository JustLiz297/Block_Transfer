# Program By: Elizabeth (Liz) Boyle (10659314)
# Section: (B)
# This program takes a certain number of integers from one block and moves it to another

.data
	sblck: 	.asciiz "\nSource block: "
	inte: 	.asciiz "\nNumber of integers copied: "
	dblck: 	.asciiz "\nDestination block: "
	spc: 	.asciiz " "

	sblock: 	.word 1 1 2 3 5 8
	dblock: 	.space 24
	csize:	.word 6

.text

.globl main

main:
	la $t1, sblock	#t1 is source block
	la $t2, dblock	#t2 is the destination block
	lw $t3, csize	#t3 is number of integers

blockcopy:	beq $t9, $t3, ptReset	#loop to move each element in t1 to t2
	lw $t4, 0($t1)	
	sw $t4, 0($t2)	
	addi $t1, $t1, 4
	addi $t2, $t2, 4
	addi $t9, $t9, 1
	j blockcopy		

ptReset:	beq $t3, $t7, print	#resets pointers back to start address of t1 and t2
	addi $t2, $t2, -4
	addi $t1, $t1, -4
	addi $t7, $t7, 1
	j ptReset

print:	li $v0, 4		
	la $a0, sblck
	syscall		#output sblck text
	
sbLoop:	beq $t5, $t3, next
	li $v0, 1
	lw $a0, 0($t1)
	syscall		#output sblock/t1
	li $v0, 4
	la $a0, spc
	syscall		#output space between numbers
	addi $t1, $t1, 4
	addi $t5, $t5, 1
	j sbLoop

next:	li $v0, 4
	la $a0, inte
	syscall		#output inte text
	li $v0, 1
	la $a0, ($t3)
	syscall		#output t3
	li $v0, 4
	la $a0, dblck
	syscall		#output dblck text

dbLoop:	beq $t6, $t3, exit
	li $v0, 1
	lw $a0, 0($t2)
	syscall		#output dblock/t2
	li $v0, 4
	la $a0, spc
	syscall		#output space between numbers
	addi $t2, $t2, 4
	addi $t6, $t6, 1
	j dbLoop

exit:	li $v0, 10
	syscall		#10 exit system call