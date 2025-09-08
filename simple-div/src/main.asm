
%define SYS_EXIT 60

section .data
    num1 dq 20
    num2 dq 5

section .bss
    buffer resb 20


section .text
    global _start
    extern int_to_string
    extern print_string
    extern print_newline

    _start:
        xor rdx, rdx
        mov rax, [num1]
        mov rcx, [num2]
        div rcx

        mov rdi, buffer
        add rdi, 19 

        call int_to_string
        call print_string
        call print_newline

        mov rax, SYS_EXIT
        xor rdi, rdi
        syscall
