#  Write a MIPS assembly program to store register $s0 in the first element of an array,          #
#  register $s1 in the second element of the array, and register $s2 in the third element of the  #
#  array (Assume $s0=10, $ s1=12, $s2=14). Using a loop, read the elements of the array           #
#  and calculate sum of the elements. Submit your code and a screenshot that shows sum of         #
#  the elements.                                                                                  #


.data
array: .space 12 #save 12 bytes because 3 integers * 4 bytes/integer = 12 bytes
space_val: .asciiz " " #store a space to be used for printing.

.text 
addi $s0, $zero, 10 #s0 register now holds value of 10
addi $s1, $zero, 12 #s1 register now holds value of 12
addi $s2, $zero, 14 #s2 register now holds value of 14

addi $t0, $zero, 0 # t0 will function as our index for the array

sw $s0, array($t0) #save s0 into array
addi $t0, $zero, 4 #add 4 to go to next position
sw $s1, array($t0) #save s1 into array
addi $t0, $zero, 8 #add 4 to go to next position
sw $s2, array($t0) #save s2 into array

addi $t1, $zero, 0 #t1 will function as our counter inside the for loop

addi $s3, $zero, 0 #s3 will function as our variable where sum is stored.

#loop wil read the elements of the array and calculate the sum of the array
loop: slti $t2, $t1, 12 #checks to see if t1 is less than 16. if less than t2 is 1, else t2 is 0. 
beq $t2, 0, Exit #if we are at 16 exit because that would mean we would go into our 4th index
lw $t4, array($t1) #load word from the current index
add $s3, $s3, $t4 #update sum variable 

#print out sum
li $v0,1 
move $a0, $s3
syscall 

#print out a space character
li $v0, 4
la $a0, space_val
syscall

addi $t1, $t1, 4 #add to end of loop to keep looping until we hit four 

j loop

Exit:
li $v0, 10
syscall