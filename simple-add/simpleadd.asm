%define SYS_WRITE     1
%define SYS_EXIT      60

section .data
    

section .bss
    buf resb 20

section .text
    global _start

    _start: