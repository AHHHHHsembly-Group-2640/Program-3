# CS2640-01
# Group: AHHHH (Khushi Gupta, Remi Ong, Tam Dinh, Viet Nguyen)
# April 26, 2023
# Objective: Program 3 - Accessing Memory and File Handling - Task 1
# Write an Assembly program that will return a letter grade for each element in an array
# (e.g. test scores in an array of scores)
# Include:
# - a main label, a looping label, and an exit label
# - a loop counter
# - a separate case for grades above 100 (i.e. prints out "A with Extra Credit")
# - your name printed out after all the grades are read (and before the program exits)

#Macro to print out the string of 'gradePrint'
.macro theGrade
	li $v0, 4
	la $a0, gradePrint
	syscall
.end_macro 

#Macro to print out "is"
.macro printIs
	li $v0, 4
	la $a0, is
	syscall
.end_macro 

.data 
gradePrint: .asciiz "\nThe grade for "
is: .asciiz " is: "
array: .word 32, 56, 78, 66, 88, 90, 93, 100, 101, 82
bonus: .asciiz "A with Extra Credit"
exitPrint: .asciiz "\nThe program will now exit."

.text 
main: 
	theGrade
	
	#loading address of 'array' into $s0
	la $s0, array
	
	#initializing $t7 as loop counter
	move $t7, $zero
loop: 
	#get the current element of the array
	lw $t0, 0($s0)  #array starts at 0
	
	#print $t0 to user (current element)
	li $v0, 1
	move $a0, $t0
	syscall 
	
	printIs
	
	#A with bonus if greater than 100
	bgt $t0, 100, gradeBonus
	
	#Else A if greater than or equal to 90
    	bge $t0, 90, gradeA
    	
    	#Else B if score is greater or euqal to 80 
    	bge $t0, 80, gradeB
    	
    	#Else C if score is greater or euqal to 70
    	bge $t0, 70, gradeC
    	
    	#Else D if score is greater or euqal to 60
    	bge $t0, 60, gradeD
    	
    	#Else F if score is less or equal to 59
    	ble $t0, 59, gradeF
	
continue:

	#increment base addess by 4 (move to next element)
	addi $s0, $s0, 4 
	
	#increment the loop counter
	addi $t7, $t7, 1
	
	#branch if loop counters is greater than number of array elements
	beq $t7, 10, exit
	
	theGrade
	j loop #repeat/jump the loop

#label to print bonus grade
gradeBonus:
	li $v0, 4
	la $a0, bonus
	syscall 
	j continue

#label to print the Grade character as defined
gradeA:
	li $v0, 11
	li $a0, 'A'
	syscall
	j continue

gradeB:
	li $v0, 11
	li $a0, 'B'
	syscall
	j continue

gradeC:
	li $v0, 11
	li $a0, 'C'
	syscall
	j continue
gradeD:
	li $v0, 11
	li $a0, 'D'
	syscall
	j continue
gradeF:	
	li $v0, 11
	li $a0, 'F'
	syscall
	j continue

#exit program
exit:
	li $v0, 4
	la $a0, exitPrint
	syscall
	
	li $v0, 10
	syscall
