;Vibhav Sahasrabudhe, Roll no: 21268, Assignment 03
;Write a switch case driven X86/64 ALP to perform 64-bit hexadecimal arithmetic operations (+,-,*, /) using suitable macros. 
;Define procedure for each operation.

section .data
	n1 dq 0x06
	n2 dq 0x03

	menu db 10,10,"1.ADD",10,"2.SUB",10,"3.MUL",10,"4.DIV",10,"5.EXIT",10,13
	len1 equ $-menu

	choice db 10,"Enter your choice: "
	len2 equ $-choice
	
	m1 db "ADD",10,13
	l1 equ $-m1
	m2 db "SUB",10,13
	l2 equ $-m2
	m3 db "MUL",10,13
	l3 equ $-m3
	m4 db "DIV",10,13
	l4 equ $-m4

section .bss
	cnt resb 2
	choose resb 2
	ans resb 16

%macro inout 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro

section .text
	global _start
	_start:
		
	_menu:
		inout 1,1,menu,len1
		
		inout 1,1,choice,len2
		inout 0,0,choose,2
		
		cmp byte[choose],'1'
		je case1
		
		cmp byte[choose],'2'
		je case2
		
		cmp byte[choose],'3'
		je case3
		
		cmp byte[choose],'4'
		je case4
		
		cmp byte[choose],'5'
		je case5
		
	case1: 
		inout 1,1,m1,l1
		call addition
		jmp _menu
	case2: 
		inout 1,1,m2,l2
		call subtraction
		jmp _menu
	case3: 
		inout 1,1,m3,l3
		call multiplication
		jmp _menu
	case4: 
		inout 1,1,m4,l4
		call division
		jmp _menu
	case5: 
		mov rax,60
		mov rdx,0
		syscall
	
	 addition: 
		mov al,[n1]
		mov bl,[n2]
		add al,bl
		call hextoascii
		ret
	
	subtraction: 
		mov al,[n1]
		mov bl,[n2]
		sub al,bl
		call hextoascii
		ret
	
	multiplication:
		mov al,[n1]
		mov bl,[n2]
		mul bl
		call hextoascii
		ret
		
	division:
		mov al,[n1]
		mov bl,[n2]
		div bl
		call hextoascii
		ret
	
	hextoascii:
		mov bl, al
	
		mov rdi, ans
		mov cx, 10H
	up:
		rol rax, 4
		mov bl, al
		and bl, 0FH
		cmp bl, 09H
		JBE r1
		add bl, 07H

	r1: 
		add bl, 30H
		mov byte[rdi], bl
		inc rdi
		dec cx
		jnz up

		mov rax, 01
		mov rdi, 01
		mov rsi, ans
		mov rdx, 10H
		syscall

		ret
