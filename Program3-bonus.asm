# CS2640-01
# Group: AHHHH (Khushi Gupta, Remi Ong, Tam Dinh, Viet Nguyen)
# April 26, 2023
# Objective: Program 3 - Accessing Memory and File Handling - Bonus part
# Write a program in Assembly that takes creates a file and writes to it (use .txt files). 

.data 
askInput: .asciiz "\nPlease name a file (use .txt): "
fileName: .space 30
fileNameSpace: .word 29
writting: .asciiz "\nPlease write to the file: "
extension: .asciiz ".txt"
content: .space 200
contentSpace: .word 199
.text 
main:	
	#Print string ask for user input
	li $v0, 4
	la $a0, askInput
	syscall
	
	#Take user input and load to fileName
	li $v0, 8
	la $a0, fileName
	lw $a1, fileNameSpace
	syscall
	
	#!!!Have some trouble here, file is created with a tail of "?" 
	#create a file named by user input
	li $v0, 13		#open file
	la $a0, fileName	#file name
	li $a1, 1		#1 to create and write
	li $a2, 0		#ignored
	syscall
	move $s0, $v0		#store file descriptor in $s0
	
	#Print string to get content from user input
	li $v0, 4
	la $a0, writting
	syscall
	
	li $v0, 8
	la $a0, content
	lw $a1, contentSpace
	syscall
	
	#write to file using inBuffer
	li $v0, 15
	move $a0, $s0
	la $a1, content
	li $a2, 200
	syscall
	
	#close file
	li $v0, 16
	move $a0, $s0
	syscall
	
exit:
	li $v0, 10		#exit program
	syscall