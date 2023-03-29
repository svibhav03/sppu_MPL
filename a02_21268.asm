;Vibhav Sahasrabudhe, Roll no: 21268, Assignment 02
;Write an X86/64 ALP to accept a string and to display its length.

section .data
	prompt1 db 10,"Enter string: "
	len1 equ $-prompt1
	prompt2 db 10,13,"String lenght: "
	len2 equ $-prompt2

section .bss
	str1 resb 200
	result resb 200

section .text
	global _start

_start:
	;display
	mov Rax,1
	mov Rdi,1
	mov Rsi,prompt1
	mov Rdx,len1
	syscall
	
	;input
	mov rax,0
	mov rdi,0
	mov rsi,str1
	mov rdx,16
	syscall
	
	;store result lenght in rbx
	dec rax
	mov rbx,rax
	mov rdi,result
	
	mov rcx,16
	
	loop1:
	rol rbx,04
	mov al,bl
	and al,0fh
	cmp al,09h
	jg loop2
	add al,30h
	jmp l1
	
loop2:	add al,37h
l1:		mov [rdi],al
		inc rdi
		dec cx
		jnz loop1
		
	;display
	mov Rax,1
	mov Rdi,1
	mov Rsi,prompt2
	mov Rdx,len2
	syscall
	
	;display
	mov Rax,1
	mov Rdi,1
	mov Rsi,result
	mov Rdx,16
	syscall

mov rax ,60
mov rdi,0
syscall
