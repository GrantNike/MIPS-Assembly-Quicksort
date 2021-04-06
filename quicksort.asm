#Grant Nike
#6349302
#Nov 29
#Quick Sort 
	.data
array:	.word 76, 32, 21, 44, 21, 90, 1, 11, 61, 81, 92, 3, 5, 2, 8, 38, 63
length: .word 17 
delimeter:  .asciiz ","
newLine:.asciiz "\n"

	.text
	#load in length of array
	lw $s1, length
	
	la $t1, array #t1 points at first element in array
	#loop counter starts at 0
	li $t2, 0
#prints the arrays
print_0:
	#continue while counter is less than array size
	bge $t2,$s1, print_1
	lw $a0,($t1)
	addi $t1,$t1,4
	addi $t2,$t2,1
	li $v0, 1
	syscall		#print array entry
	li $v0,4
	la $a0,delimeter
	syscall 	#print delimeter
	b print_0
print_1:
	#set up dummy AR
	move $fp,$sp
	addi $sp,$sp,-12
	
	#print a new line char
	lb $a0, newLine
	li $v0, 11
	syscall
	
	la $a0, array #parameter 1, the array
	li $a1,0 #parameter 2, the left index of the array
	addi $s2,$s1,-1
	move $a2,$s2 #parameter 3, the right index of the array
	jal quickSort_0
	
	#load in length of array
	#lw $s1, length
	la $t1, array #t1 points at first element in array
	#loop counter starts at 0
	li $t2, 0
#prints the array(now sorted)
printAgain_0:
	#continue while counter is less than array size
	bge $t2,$s1, printAgain_1
	lw $a0,($t1)
	addi $t1,$t1,4
	addi $t2,$t2,1
	li $v0, 1
	syscall		#print array entry
	li $v0,4
	la $a0,delimeter
	syscall 	#print delimeter
	b printAgain_0
printAgain_1:

#terminate program
	li $v0, 10
	syscall
	
#########################################################################
#QuickSort Procedure, sorts an array of integers 
quickSort_0:
	#save return address
	sw $ra,($fp)
	li $t1, 1
	
	#t1 is i, t2 is j
	move $t1, $a1
	move $t2, $a2
	
	#pivot = array[(right+left)/2]
	add $t3,$t1,$t2
	div $t3,$t3,2 
	mul $t3,$t3,4
	add $t4, $a0,$t3 #t4 is address of start of array plus offset to pivot
	lw $t3,($t4) #t3 is pivot
	#do{
quickSort_1:
	mul $t4,$t1,4
	add $t4, $a0,$t4 #t4 is address of start of array plus offset
	lw $t4,($t4) #t4 is data[i]
	# while ((data[i] < pivot) && (i < right)
	bge $t4,$t3,quickSort_2
	bge $t1,$a2,quickSort_2
	addi $t1,$t1,1 #i=i+1
	b quickSort_1	
quickSort_2:
	mul $t4,$t2,4
	add $t4, $a0,$t4 #t4 is address of start of array plus offset
	lw $t4,($t4) #t4 is data[j]
	# while ((pivot < data[j]) && (j > left))
	bge $t3,$t4,quickSort_3
	ble $t2,$a1,quickSort_3
	addi $t2,$t2,-1 #j=j-1
	b quickSort_2
quickSort_3:
	#if (i<=j)
	bgt $t1,$t2,quickSort_4
	#temp = data[i]
	mul $t4,$t1,4
	add $t4, $a0,$t4 #t4 is address of start of array plus offset of i
	lw $t5,($t4) #t5 is data[i]
	
	mul $t6,$t2,4
	add $t6,$a0,$t6 #t6 is address of start of array plus offset of j 
	lw $t7,($t6) #t7 is data[j]
	
	sw $t7,($t4) #data[i] = data[j]
	sw $t5,($t6) #data[j] = temp
	addi $t1,$t1,1 #i=i+1
	addi $t2,$t2,-1 #j=j-1
quickSort_4:

	ble $t1,$t2,quickSort_1 # while(i<=j) 
	
	#if(left < j)
	bge $a1,$t2,quickSort_5
		#quicksort(data,left,j);
	#set up AR
	sw $a0,($sp)
	sw $a1,4($sp)
	sw $a2,8($sp)
	addi $sp,$sp,-28
	sw $fp,20($sp)
	sw $t1,16($sp)
	sw $t2,12($sp)
	addi $fp,$sp,24
	#third parameter is now j 
	move $a2,$t2
	jal quickSort_0
	#unwind AR
	lw $a0,4($fp)
	lw $a1,8($fp)
	lw $a2,12($fp)
	lw $t1, -8($fp)
	lw $t2,-12($fp)
	addi $sp,$sp,28
	lw $fp,-4($fp)
quickSort_5:	
	
	#if (i < rite) 
	bge $t1,$a2,quickSort_6
		#qs(data, i, rite);
	#set up AR
	sw $a0,($sp)
	sw $a1,4($sp)
	sw $a2,8($sp)
	addi $sp,$sp,-28
	sw $fp,20($sp)
	sw $t1,16($sp)
	sw $t2,12($sp)
	addi $fp,$sp,24 
	#second parameter is now i
	move $a1,$t1
	jal quickSort_0
	#unwind AR
	lw $a0,4($fp)
	lw $a1,8($fp)
	lw $a2,12($fp)
	lw $t1, -8($fp)
	lw $t2,-12($fp)
	addi $sp,$sp,28
	lw $fp,-4($fp)
quickSort_6:
	#load return address back
	lw $ra,($fp)
	jr $ra
