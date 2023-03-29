;Vibhav Sahasrabudhe, Roll no: 21268, Assignment 03
;Write an X86/64 ALP to find the largest of the given BYTE/WORD/DWORD/64 bit numbers

section .data
	prompt1 db 10, "The array elements are: ",10
	len1 equ $-prompt1
	prompt2 db 10, "The largest element is: "
	len2 equ $-prompt2
	newline db 10
	
	array db 0000000000000055h,0000000000000080h,0000000000000044h,0000000000000023h,11h
	
section .bss
	counter resb 1
	result resb 16
	
%macro write 2
	mov rax,1
    mov rdi,1
    mov rsi,%1
    mov rdx,%2
    syscall
%endmacro

section .text
	global _start
	
_start:
	write prompt1 , len1
	
	mov byte[counter], 05
	mov rsi, array

next: 
	mov al,[rsi]
	push rsi
	call disp
	pop rsi
	inc rsi
	dec byte[counter]
	jnz next	

	write prompt2 , len2
	
	mov byte[counter],05
	mov rsi, array
	mov al, 0
repeat: 
	cmp al,[rsi]
	ja skip
	mov al,[rsi]
skip:
	inc rsi
	dec byte[counter]
	jnz repeat
    
	call disp	
	
mov rax ,60
mov rdi,0
syscall

disp:
        mov rbx,rax
        mov rdi, result
        mov cx,16
up1:
        rol rbx,04
        mov al,bl
        and al,0fh
        cmp al,09h
        ja add_37
        add al,30h
        jmp skip1
        
add_37: add al,37h

skip1:  mov [rdi],al
        inc rdi
        dec cx
        jnz up1
        
        write result , 16
        write newline , 1
        
        ret

