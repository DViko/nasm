BITS 64
default rel

%include "include/syscalls.inc"
%include "include/macros.inc"

extern print_string
extern print_newline
extern int_to_string

section .data
num1 dq 7
num2 dq 5

section .bss
buffer resb 32

section .text
global _start

_start:

    mov rax, [num1]
    add rax, [num2]

    mov rdi, buffer
    add rdi, 32

    call int_to_string
    call print_string
    call print_newline

    exit 0
