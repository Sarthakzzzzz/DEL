section .data
    msg db "ALP to display the length of a string enterd by the user",10
    msg_len equ $ - msg
    
    msg1 db 10, "String entered by the user is : ",10
    msg1_len equ $ - msg1
    
    msgop db 10, 10,"Length of the string is : " , 10
    msgop_len equ $ - msgop

section .bss
    string resb 50                      
    strl equ $-string 
    
    result resb 50
    
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
    
    write msg, msg_len
    write msg1, msg1_len
    
    mov rax, 0
    mov rdi, 0
    mov rsi, string
    mov rdx, 200
    syscall
    
    call disp

    mov rax, 60
    mov rdi, 0
    syscall
    
disp:

    mov rbx,rax ;store number in rbx 
    mov rdi, result ;point rdi to result variable
    mov cx,16 ;load count of rotation in cl
up1:
    rol rbx,04 ;rotate number left by four bits
    mov al,bl ;move lower byte in dl
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
    write string, 50
    write msgop,msgop_len
    
    write result,16 ;call to macro
    ret

