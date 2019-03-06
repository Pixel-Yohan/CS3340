#  Write MIPS assembly for the following function. Assume N is passed to your function
#  in register $a0. Your output should be in register $v0 at the end of your function. Submit
#  your code and a screenshot that shows the registers with correct output value for N=4,
#  i.e., myFunction(4) = 6. Note: You must implement this function recursively and explain
#  each instruction. The purpose of this assignment is to learn how to manipulate the stack
#  correctly in MIPS. 

#  C code below :)
#  int myfunction (int N){
#  if (N==0) return 0;
#  if (N==1) return 1;
#  if (N==2) return 2;
#  return myfunction (N-1)+ myfunction (N-2)+ myfunction(N-3);} 


.text 
addi $a0, $zero, 4    	#a0 is going to have a value of 4
jal myFunction 		#call function myFunction
move $a0, $v0		#set $a0 to $v0 value since we'll have to load $v0 with code 1
li $v0, 1		#give v0 code 1 to print the result (1 is for integer)
syscall			#execute v0
j Exit			#j Exit will allows us to exit the program

myFunction:
  addi $sp, $sp, -24    #make space in the stack for 2 items
  sw $s3, 20($sp)	#(N-3)
  sw $s2, 16($sp)	#(N-2)
  sw $s1, 12($sp)	#(N-1)
  sw $s0, 8($sp)	#where we load our parameter N temporarily into
  sw $ra, 4($sp)        #save the return address
  sw $a0, 0($sp)        #save the parameter N
  move $s0, $a0		#move our parameter value into $s0
  
  beq $s0, 0, L1        #if(N==0)
  beq $s0, 1, L1        #if(N==1)
  beq $s0, 2, L1        #if(N==2)

  addi $a0, $s0, -1	#subtract 1 from a0
  jal myFunction	#recursion step
  move $s1, $v0		#s1 now has v0
  
  addi $a0, $s0, -2	#subtract 2 from our N
  jal myFunction	#recursive step
  move $s2, $v0		#s2 now has v0
  
  addi $a0, $s0, -3	#subtract 3 from our N
  jal myFunction	#recursive step
  move $s3, $v0		#s3 now has v0
  
  
  li $v0, 0 		#acc
  add $v0, $s1, $s2	#(n-1)+(n-2)
  add $v0, $v0, $s3	# ((n-1)+(n-2))+(n-3))
  
  lw $a0, 0($sp) 	#load the stored value of N from the stack pointer 
  lw $ra, 4($sp)     	#load the previous address
  lw $s3, 20($sp)	#load our N-3
  lw $s2, 16($sp)	#load our N-2
  lw $s1, 12($sp)	#load our N-1
  lw $s0, 8($sp)
  addi $sp, $sp, 24	#free space from the stack
  jr $ra		#jump back!

L1:                     #implement how we handle when we get to our base case : N=1,2,3 
  lw $a0, 0($sp) 	#load the stored value of N from the stack pointer 
  move $v0, $a0 	#a0 is now in v0 
  lw $ra, 4($sp)     	#load the previous address
  lw $s3, 20($sp)	#n-3
  lw $s2, 16($sp)	#n-2
  lw $s1, 12($sp)	#n-1
  lw $s0, 8($sp)	#temporary value
  addi $sp, $sp, 24	#free space from the stack
  jr $ra  
  
Exit:
  li $v0, 10		#load $v0 with code 10 in order to properly exit
  syscall		#execute $v0

addi $v0, $a0, 0      #if N = 2 return 2, if N=1 return 1, if N=2 return 2 essentially return N
addi $sp, $sp, 8      #this time pop from the stack instead of adding to the stack

sll 