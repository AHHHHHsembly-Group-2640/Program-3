# CS2640-01
# Group: AHHHH (Khushi Gupta, Remi Ong, Tam Dinh, Viet Nguyen)
# April 26, 2023
# Objective: Program 3 - Accessing Memory and File Handling - Task 3
# Write an Assembly program that takes practiceFile.txt file and appends to it.
# Appending with answer for, "What have you enjoyed most about the class so far?"

.data
fileName: .asciiz "practiceFile.txt"
outBuffer: .space 200		#200 bytes
inBuffer: .asciiz "\nThing I have enjoyed most about the class so far is the doable workload and reasonable tests. -T I honestly just like coding -R"

.text
main:
	#open a file using flag value 9
	li $v0, 13		#open file
	la $a0, fileName	#file name
	li $a1, 9		#0 is flag to read from file, 9 is different flag to append file?
	li $a2, 0		#ignored
	syscall
	move $s0, $v0		#store file descriptor in $s0
	
	#write to file using inBuffer
	li $v0, 15
	move $a0, $s0
	la $a1, inBuffer
	li $a2, 200
	syscall
	
	#read from practiceFile.txt
	li $v0, 14		#read file
	move $a0, $s0		#loading in file descriptor from previous code
	la $a1, outBuffer		#load buffer into address a1
	li $a2, 500		#500 bytes of space
	syscall
	move $s1, $v0
	
	#print out the buffer
	li $v0, 4		#print out string
	la $a0, outBuffer		#load in buffer into address a0
	syscall
	
	#close file
	li $v0, 16
	move $a0, $s0
	syscall
	
exit:
	li $v0, 10		#exit program
	syscall
