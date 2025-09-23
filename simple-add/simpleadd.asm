%define SYS_WRITE     1
%define SYS_EXIT      60

section .data

    num1 dq 7
    num2 dq 5
    new_line db 10 

section .bss

    buffer resb 20

section .text

    global _start

    _start:
        mov rax, [num1]
        add rax, [num2]

        