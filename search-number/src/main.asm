section .bss
    buffer resb 20

section .text
    global _start
    extern print_string
    extern print_newline
    extern int_to_string

    

_start:
    mov rax, 42
    mov rdi, buffer
    add rdi, 19
    call int_to_string
    call print_string
    call print_newline

    mov rax, 60
    xor rdi, rdi
    syscall

