BITS 64
default rel

section .text

global int_to_string

int_to_string:

    mov rbx, 10
    xor rcx, rcx

.loop:
    xor rdx, rdx
    div rbx

    add dl, '0'
    dec rdi
    mov byte [rdi], dl

    inc rcx
    test rax, rax
    jnz .loop

    ret