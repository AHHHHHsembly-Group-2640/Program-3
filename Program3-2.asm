# CS2640-01
# Group: AHHHH (Khushi Gupta, Remi Ong, Tam Dinh, Viet Nguyen)
# April 26, 2023
# Objective: Program 3 - Accessing Memory and File Handling - Task 2
# Write an Assembly program that takes in a programmer-defined filename
# - Open file
# - Read file and print to user
# - Close file

.data 
fileName: .asciiz "practiceFile.txt"
buffer: .space 500		#500 bytes of space, aka 500 characters

.text 
main:
	#open a file
	li $v0, 13		#open file
	la $a0, fileName	#file name
	li $a1, 0		#read file
	li $a2, 0		#ignored
	syscall
	move $s0, $v0		#store file descriptor in $s0
	
	#read file
	li $v0, 14		#read file
	move $a0, $s0		#loading in file descriptor from previous code
	la $a1, buffer		#load buffer into address a1
	li $a2, 500		#500 bytes of space
	syscall
	move $s1, $v0
	
	#print out the buffer
	li $v0, 4		#print out string
	la $a0, buffer		#load in buffer into address a0
	syscall
	
	#close file
	li $v0, 16
	move $a0, $s0
	syscall
	
exit:
	li $v0, 10		#exit program
	syscall
