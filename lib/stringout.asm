section .data
    newline db 10

section .bss

section .text
    global print_string
    global print_newline
    global int_to_string

    int_to_string:
        mov rbx, 10
        mov rcx, 0
        
        .loop:
            xor rdx, rdx
            div rbx
            add dl, '0'
            dec rdi
            mov [rdi], dl
            inc rcx
            test rax, rax
            jnz .loop
            ret
    
    print_string:
        mov rax, 1
        mov rsi, rdi
        mov rdi, 1
        mov rdx, rcx
        syscall
        ret
    
    print_newline:
        mov rax, 1
        mov rdi, 1
        mov rsi, newline
        mov rdx, 1
        syscall
        ret
