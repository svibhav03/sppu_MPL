section .data

    msg dw "The array elements are: ",10
    msg_len equ $ - msg
   
    array dq 7222222211111111h,-1111111100000000h,-7999999999999999h,7FFFFFFFFFFFFFFFh,-1111111106789000h
   
    msg_pos dw 10,10, "The count of positive numbers is : " ,10
    msg_pos_len equ $ - msg_pos
     
    msg_neg dw 10 , 10, "The count of negative numbers is : ", 10
    msg_neg_len equ $ - msg_neg
   
section .bss
    result resb 100
    pos_count resq 1
    neg_count resq 1
    counter resb 1
   
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
         mov cx,05
         mov rbx,0      ;stores positive count
         mov rdx,0      ;stores negative count
         mov rsi,array
         
repeat:
         mov rax,[rsi]
         shl rax,1
         jc negative
         inc rbx
         jmp next
       
negative:inc rdx
         
next:    add rsi,8
         loop repeat
         
         mov [pos_count],rbx
         mov [neg_count],rdx
         
        write msg , msg_len
		mov byte[counter], 05
		mov rsi, array

	new: 
		mov rax,[rsi]
		push rsi
		call disp
		pop rsi
		inc rsi
		dec byte[counter]
		jnz new
         
         write msg_pos , msg_pos_len
         mov rax, [pos_count]
         call disp

         write msg_neg , msg_neg_len
         mov rax, [neg_count]
         call disp
         
         mov rax,60
         mov rdi,0
         syscall

disp:
        mov rbx,rax
        mov rdi, result
        mov cx,16
up1:
    rol rbx,04 ;rotate number left by four bits
    mov al,bl ;move lower byte in al
    and al,0fh ; get only LSB
    cmp al,09h ;compare with 39h
    jg add_37 ;if grater than 39h skip add 37
    add al,30h
    jmp skip ;else add 30
add_37 : add al,37h
skip:mov [rdi],al ;store ascii code in result variable
    inc rdi ;point to next byte
    dec cx ;decrement the count of digits to display
    jnz up1 ;if not zero jump to repeat
    write result,16 ;call to macro
    ret
