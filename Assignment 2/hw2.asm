
	.data
getszs:	.asciiz	"Please enter size of the array: "
getnums:.asciiz	"Plese enter the target number: "
getarrs:.asciiz	"Plese enter the elements of the array: "
resstr:	.asciiz	"Result is: "
str1:	.asciiz	"are the elements gives summation. Possible!"
str2:	.asciiz	"Not possible!"
spc:	.asciiz	" "
	
	.text
	.globl main
main:	
	#cout << "Please enter size of the array: ";
	li	$v0, 4
	la	$a0, getszs
	syscall
	

	#cin >> arraySize;
	li 	$v0, 5
	syscall
	move	$s0, $v0 		 	# s0 becomes length of array.
	
	
	#cout << "Plese enter the target number: ";
	li	$v0, 4
	la	$a0, getnums
	syscall
	
	
	#cin >> num;
	li	$v0, 5
	syscall
	move 	$s1, $v0 			# s1 becomes target number.
	
	
	#int* arr = new int[num]; // bonus
	li	$v0, 9
	sll	$a0, $s0, 2			# size * 4 
	syscall
	la 	$s2, ($v0)			# s2 adress of dynamic array
	
	
	#for(int i=0; i<arraySize; i++);
	li	$t0, 0				# t0 become counter for "for loop".
	li	$t2, 0				# t2 become counter for arr address
	la	$t3, ($s2)			# t3 temp adress of array
inloop:	slt	$t1, $t0, $s0
	beq 	$t1, $zero, loopexit
	
	#cin >> arr[i];
	li 	$v0, 5
	syscall
	add	$t3, $s2, $t2	
	sw	$v0, 0($t3)
	
	addi	$t0, $t0, 1
	addi	$t2, $t2, 4
	j	inloop


loopexit:
	#end of loop
	
	
	#cout << "Result is: ";
	li	$v0, 4
	la	$a0, resstr
	syscall
	
	
	#int returnVal = CheckSumPossibility( num, arr, arraySize);
	move	$a0, $s1
	move	$a2, $s0
	la	$a1, ($s2)
	jal	checkSum
	move 	$s7, $v0			# s7 is returnVal for main procedure
	
	
	
	
	#if(returnVal == 1)
	beq	$s7, $zero, fail
	
	
	#cout << "are the elements gives summation. Possible!" << endl;
	li	$v0, 4
	la	$a0, str1
	syscall
	j	halt
	
	
	
	#else cout << "Not possible!" << endl;
fail:	li	$v0, 4
	la	$a0, str2
	syscall
	
	
	# return 0;
halt:	li	$v0, 10
	li	$a0, 0
	syscall	
#end of procedure	

	
	
	
#procedure
checkSum:
	addi 	$sp, $sp, -24
	sw	$s0, 0($sp)			#s0 for num
	sw	$s1, 4($sp)			#s1 for arr address
	sw	$s2, 8($sp)			#s2 for size
	sw	$s3, 12($sp)			#s3 for curr
	sw	$s4, 16($sp)			#s4 for returnValue
	sw	$ra, 20($sp)			#return pointer
	
	move	$s0, $a0
	la	$s1, ($a1)
	move	$s2, $a2
	
	
	#if(num == 0) return 1
	li	$v0, 1
	beq	$s0, $zero, fixAndReturn
	
	
	#if(size == 0) return 0
	li	$v0, 0
	beq	$s2, $zero, fixAndReturn
	
	
	#if( num < 0) return 0
	slt	$t1, $zero, $s0
	beq	$t1, $zero, fixAndReturn
	
	
	# int curr = arr[size-1]
	addi	$t1, $s2, -1
	sll	$t1, $t1, 2
	add	$t1, $s1, $t1 
	lw	$s3, 0($t1) 
	#sw	$s3, 12($sp)				#storing s3 to stack for curr
	
	# if(curr > num)
	sgt	$t1, $s3, $s0
	beq	$t1, $zero, cont
	
	
	# return CheckSumPossibility(num, arr, size-1)
	move	$a0, $s0
	la	$a1, ($s1)
	addi	$t1, $s2, -1
	move	$a2, $t1
	jal	checkSum
	j	fixAndReturn
	
	
	
	
	
	#int returnValue = CheckSumPossibility(num-curr, arr, size-1);
cont:	sub 	$t1, $s0, $s3
	move	$a0, $t1  
	la	$a1, ($s1)
	addi	$t1, $s2, -1
	move	$a2, $t1
	jal	checkSum
	move	$s4, $v0				
	sw	$s4, 16($sp)				#storing s4 to stack for returnValue
	
	
	#if(returnValue == 0 )
	beq	$s4, $zero, ifin
	
	#cout << curr
	li 	$v0, 1
	move	$a0, $s3
	syscall
	li	$v0, 4
	la	$a0, spc
	syscall
	
	
	#return returnValue;
cont2:	move	$v0, $s4
	j 	fixAndReturn
	
	
	#returnValue = CheckSumPossibility(num, arr, size-1);
ifin:	move	$a0, $s0
	la	$a1, ($s1)
	addi	$t1, $s2, -1
	move	$a2, $t1
	jal	checkSum
	move	$s4, $v0
	j	cont2
		
	
	
	#return;
fixAndReturn:
	lw	$s0, 0($sp)		#s0 for num
	lw	$s1, 4($sp)		#s1 for arr address
	lw	$s2, 8($sp)		#s2 for size
	lw	$s3, 12($sp)		#s3 for curr
	lw	$s4, 16($sp)		#s4 for returnValue
	lw	$ra, 20($sp)		#return pointer
	addi 	$sp, $sp, 24
	jr	$ra
	
	
#end of procedure	
	
	
	
	
	
	
	
	
	
	
	
