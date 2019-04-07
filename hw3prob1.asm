#YOHAN FLORES 
.data
array: .space 16 	#save 12 bytes because 4 integers * 4 bytes/integer = 12 bytes
space_val: .asciiz " " 	#store a space to be used for printing.
.text

addi $s0,$s0, 8 	# s0 = 8
addi $s1, $s1, 12	# s1 = 12
addi $s2, $s2, 5	# s2 = 5
addi $s3, $s3, 2	# s3 = 2

addi $s5, $zero,0       # t0 is index of array, index=0
sw $s0, array($s4) 	# save s0 into first element
addi $s4, $zero, 4	# index of array, index = 1
sw $s1, array($s4) 	# save s1 into second element
addi $s4, $zero, 8	# index of array, index = 2
sw $s2, array($s4) 	# save s2 into third element 
addi $s4, $zero, 12 	# index of array, index = 3
sw $s3, array($s4) 	# save s3 into fourth element

add $s0, $zero, 0 	# reset back to 0
add $s1, $zero, 0 	# reset back to 0
add $s2, $zero, 0 	# reset back to 0
add $s3, $zero, 0 	# reset back to 0


addi $s1, $zero, 4 	# s1 = n, is the size of the array, 
addi $s0, $s0, 0 	# s0 = c, always start at 0

forloop1: 
addi $t1, $s1, -1	# n-1 
slt $t0,$s0,$t1		# if c<n-1
beq $t0, 0, EXIT	# if c>=n-1 OUT OF BOUNDS
add $s2, $zero, $s0	# position = c
add $s3, $zero, $s2	# d = c
addi $s3, $s3, 1	# d = c+1
j forloop2

forloop2:
slt $t0, $s3, $s1 	# if d<n
beq $t0, 0, decision  	# if d>=n OUT OF BOUNDS continue with forloop 1 procedure
sll $t0, $s2, 2 	# t0 = 4 * position to get correct address (MIPS arrays go up by four)
lw $t1, array($t0)	# t1 = array[position]
sll $t2, $s3, 2		# t2 = 4 * d to get correct address (MIPS arrays go up by four)
lw $t3, array($t2)	# t3 = array[d]
slt $t4, $t3, $t1	# if array[d] < array[position]
beq $t4, 1, sub2	# if array[d] < array[position] -> position = d
addi $s3, $s3, 1	# d++
j forloop2		# loop again


sub1: 			# if(position != c)
sll $t0, $s0, 2 	# t0 = c = 4 * c to get correct address (MIPS arrays go up by four)
lw $t1, array($t0)	# t1 = swap = array[c]
sll $t2, $s2, 2 	# t2 = position = 4 * position to get correct address (MIPS arrays go up by four)
lw $t3, array($t2)	# t3 = array[position]
sw $t3, array($t0)	# array[c] = array[position]
sw $t1 , array($t2)	# array[position] = swap
addi $s0, $s0, 1 	# increment c before looping again
j forloop1		# call loop 1 again



sub2:
add $s2, $zero, $s3	# position = d
addi $s3, $s3,1		# d++
j forloop2		# loop again

decision:
bne $s2, $s0, sub1	# if c!=position
			# else
addi $s0, $s0, 1	# c++
j forloop1			# call for loop 1 again



EXIT:
li $v0, 1 		#print integer
addi $t1, $zero, 0	
lw $t0, array($t1)	#access array[0]
add $a0, $t0, $zero	#a0 = a[0]
syscall

li $a0, 32		#print 
li $v0, 11  		#print character
syscall


li $v0, 1 		#print integer
addi $t1, $zero, 4
lw $t0, array($t1)	#access array[1]	
add $a0, $t0, $zero	#a0 = a[0]
syscall

li $a0, 32 		#get a blank space
li $v0, 11  		#print character
syscall

li $v0, 1		#print integer
addi $t1, $zero, 8
lw $t0, array($t1)	#access array[2]
add $a0, $t0, $zero	#a0 = a[2]	
syscall

li $a0, 32
li $v0, 11  # syscall number for printing character
syscall

li $v0, 1		#print integer
addi $t1, $zero, 12
lw $t0, array($t1)	#access array[2]
add $a0, $t0, $zero	#a0 = a[2]	
syscall

li $a0, 32
li $v0, 11  # syscall number for printing character
syscall

li $v0, 10		#exit program
syscall
