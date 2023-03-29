;Vibhav Sahasrabudhe, Roll no: 21268, Assignment 01
;Write an X86/64 ALP to accept five 64 bit Hexadecimal numbers from user and store them in an array and display the accepted numbers.


section .data
	msg1 db 10,13,"Enter 5 64 bit numbers: ",0xA,0xD
	len1 equ $-msg1
	msg2 db 10,13,"The numbers you entered: ",0xA,0xD
	len2 equ $-msg2

section .bss
	array resd 200
	counter resb 1
	
section .text
	global _start
	_start:

mov Rax,1
mov Rdi,1
mov Rsi,msg1
mov Rdx,len1
syscall

mov byte[counter],05
mov rbx,00

	inloop:
		mov rax,0
		mov rdi,0
		mov rsi,array
		add rsi,rbx
		mov rdx,17
		syscall
			add rbx,17
		dec byte[counter]
		JNZ inloop

;display
	mov Rax,1
	mov Rdi,1
	mov Rsi,msg2
	mov Rdx,len2
	syscall

mov byte[counter],05
mov rbx,00
		loop2: 
			mov rax,1
			mov rdi, 1
			mov rsi, array
			add rsi,rbx
			mov rdx,17           
			syscall
			add rbx,17
			dec byte[counter]
			JNZ loop2


mov rax ,60
mov rdi,0
syscall





	
