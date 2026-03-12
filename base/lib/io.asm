BITS 64
default rel

%include "include/syscalls.inc"

section .data
newline db 10

section .text

global print_string
global print_newline

print_string:

    mov rax, SYS_WRITE
    mov rsi, rdi
    mov rdi, 1
    mov rdx, rcx
    syscall
    ret

print_newline:

    mov rax, SYS_WRITE
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    ret