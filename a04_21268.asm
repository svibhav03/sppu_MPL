%macro scall 4
mov rax, %1
mov rdi, %2
mov rsi, %3
mov rdx, %4
syscall
%endmacro

%macro exit 0
mov rax,60
mov rdx,0
syscall
%endmacro


section .data
arr dq 000000000000005h,000000000000002h
n equ 2

msg db 10d,13d,"----------MENU----------"
db 10d,13d,"1. Addition: "
db 10d,13d,"2. Substraction: "
db 10d,13d,"3. Multiplication: "
db 10d,13d,"4. Division: "
db 10d,13d,"5. Exit"
db 10d,13d,"Enter your choice: "
msglen equ $-msg

msgi db 10d,13d,"The numbers are 000000000000005 and 000000000000002"
msgilen equ $-msgi

msg1 db 10d,13d,"The Addition is: "
msglen1 equ $-msg1

msg2 db 10d,13d,"The Subtraction is: "
msglen2 equ $-msg2

msg3 db 10d,13d,"The Multiplaction is: "
msglen3 equ $-msg3

msg4 db 10d,13d,"The Division is: "
msglen4 equ $-msg4

section .bss
answer resb 16
choice resb 2 

section .text
global _start

_start :
scall 1,1,msgi,msgilen
up:
scall 1,1,msg,msglen
scall 0,0,choice,2

   
    cmp byte[choice],'1'
    je case1
   
    cmp byte[choice],'2'
    je case2
   
    cmp byte[choice],'3'
    je case3
   
    cmp byte[choice],'4'
    je case4
   
    cmp byte[choice],'5'
    je case5
   
    case1:
    scall 1,1,msg1,msglen1
    call addition
    jmp up
   
    case2:
    scall 1,1,msg2,msglen2
    call substraction
    jmp up
   
    case3:
    scall 1,1,msg3,msglen3
    call multiplication
    jmp up
   
    case4:
    scall 1,1,msg4,msglen4
    call division
    jmp up
   
    case5:
    exit
   
addition:
        mov rcx,n
        dec rcx
        mov rsi,arr
        mov rax,[rsi]
up1:    add rsi,8
        mov rbx,[rsi]
        add rax,rbx
        loop up1
        CALL display
ret


substraction:

        mov rcx,n
        dec rcx
        mov rsi,arr
        mov rax,[rsi]
up2:    add rsi,8
        mov rbx,[rsi]
        sub rax,rbx
        loop up2
        call display
ret


multiplication:
        mov rcx,n
        dec rcx
        mov rsi,arr
        mov rax,[rsi]
up3:    add rsi,8
        mov rbx,[rsi]
        mul rbx
        loop up3
        call display
ret

division:
        mov rcx,n
        dec rcx

        mov rsi,arr
        mov rax,[rsi]
up4:    add rsi,8
        mov rbx,[rsi]
        mov rdx,0
        div rbx
        loop up4
        call display
ret

or:
        mov rcx,n
        dec rcx
        mov rsi,arr
        mov rax,[rsi]
up6:    add rsi,8
        mov rbx,[rsi]
        or rax,rbx
        loop up6
        call display
ret

xor:
        mov rcx,n
        dec rcx
        mov rsi,arr
        mov rax,[rsi]
up7:    add rsi,8
        mov rbx,[rsi]
        xor rax,rbx
        loop up7
        call display
ret

and:
        mov rcx,n
        dec rcx
        mov rsi,arr
        mov rax,[rsi]
up8:    add rsi,8
        mov rbx,[rsi]
        and rax,rbx
        loop up8
        call display
ret


display:
        mov rsi,answer+15
        mov rcx,16

cnt:    mov rdx,0
        mov rbx,16
        div rbx
        cmp dl,09h
        jbe add30
        add dl,07h
       
add30:  add dl,30h
        mov [rsi],dl
        dec rsi
        dec rcx
        jnz cnt
        scall 1,1,answer,16
ret
      exit
