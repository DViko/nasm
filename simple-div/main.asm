%define SYS_EXIT 60

section .data
    num1 dq 20
    num2 dq 5
    newline db 10

section .bss

section .text
    global _start
    extern print_string

    _start:
        xor rdx, rdx
        mov rax, [num1]
        mov rcx, [num2]
        div rcx

        call print_string

        mov rax, SYS_EXIT
        xor rdi, rdi
        syscall
