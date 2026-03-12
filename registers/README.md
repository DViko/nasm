# Cheat Sheet: x86-64 General Purpose Registers (NASM)
<br>

## General Purpose Registers


| Purpose                         | Register(bit) | Subregisters(bit)             | Call Convention        |
| :------------------------------ | :------------ | :---------------------------- | :--------------------- |
| accumulator, return value       | RAX(64)       | EAX(32), AX(16), AH(8), AL(8) | caller-saved           |
| base register                   | RBX(64)       | EBX(32), BX(16), BH(8), BL(8) | callee-saved           |
| counter, 4th argument           | RCX(64)       | ECX(32), CX(16), CH(8), CL(8) | caller-saved           |
| data, 3rd argument              | RDX(64)       | EDX(32), DX(16), DH(8), DL(8) | caller-saved           |
| source index, 2nd argument      | RSI(64)       | ESI(32), SI(16), SIL(8)       | caller-saved           |
| destination index, 1st argument | RDI(64)       | EDI(32), DI(16), DIL(8)       | caller-saved           |
| stack base pointer              | RBP(64)       | EBP(32), BP(16), BPL(8)       | callee-saved           |
| stack pointer                   | RSP(64)       | ESP(32), SP(16), SPL(8)       | callee-saved / special |
| argument 5                      | R8(64)        | R8D(32), R8W(16), R8B(8)      | caller-saved           |
| argument 6                      | R9(64)        | R9D(32), R9W(16), R9B(8)      | caller-saved           |
| temporary                       | R10(64)       | R10D(32), R10W(16), R10B(8)   | caller-saved           |
| temporary                       | R11(64)       | R11D(32), R11W(16), R11B(8)   | caller-saved           |
| general purpose                 | R12(64)       | R12D(32), R12W(16), R12B(8)   | callee-saved           |
| general purpose                 | R13(64)       | R13D(32), R13W(16), R13B(8)   | callee-saved           |
| general purpose                 | R14(64)       | R14D(32), R14W(16), R14B(8)   | callee-saved           |
| general purpose                 | R15(64)       | R15D(32), R15W(16), R15B(8)   | callee-saved           |


### Important rule (x86-64):

### Writing to a 32-bit subregister (EAX, EBX, ECX, etc.) automatically zero-extends the corresponding 64-bit register. This behavior exists only in x86-64

### Example:

```asm

    Initial:

        RAX = 0x12345678ABCDEF00

    Instruction:

        mov eax, 5

    Result:

        RAX = 0x0000000000000005

    ; The top half has disappeared

```

### If we write to a 16-bit or 8-bit register, the behavior is different

#### Write to AX:

```asm
    Initial:

        RAX = 0x12345678ABCDEF00

    Instruction: 

        mov ax, 5

    Result:

        RAX = 0x12345678ABCD0005

    ;Only the lower 16 bits are changed.
```

#### Write to AL:

```asm
    Instruction:

        mov al, 5

    Result:

        RAX = 0x12345678ABCDEF05

    ; Only the lower 8 bits are changed.
```

### Behavior Table

>
>| Writing    | Result                        |
>| :--------- | :---------------------------- |
>| mov rax, X | all 64 bits are changed       |
>| mov eax, X | the upper 32 bits are cleared |
>| mov ax, X  | only 16 bits are changed      |
>| mov al, X  | only 8 bits are changed       |
>

### Writing to a 32-bit register clears the upper 32 bits, but writing to 16-bit or 8-bit registers does not
---

## Special Registers

>
>| Purpose             | Register(bit) | Subregisters(bit)     | Call Convention          | Note                                           |
>| :------------------ | :------------ | :-------------------- | :----------------------- | :--------------------------------------------- |
>| instruction pointer | RIP(64)       | none                  | next instruction address | cannot be written directly                     |
>| processor flags     | RFLAGS(64)    | EFLAGS(32), FLAGS(16) | CPU condition flags      | set/cleared by arithmetic/logical instructions |
>| segment register    | FS(64)        | none                  | OS / TLS usage           | points to thread-local storage                 |
>| segment register    | GS(64)        | none                  | OS / TLS usage           | points to kernel structures                    |
>

---

## Linux x86-64 Function Arguments

>### Function argument transfer registers. Return value: RAX
>
>| Order | Register |
>| :---- | :------- |
>| 1     | RDI      |
>| 2     | RSI      |
>| 3     | RDX      |
>| 4     | RCX      |
>| 5     | R8       |
>| 6     | R9       |
>| 7+    | stack    |
>

---

## Caller saved and Callee saved x86-64 Linux (System V ABI)

>
>| Caller-saved | Callee-saved |
>| :----------- | :----------- |
>| RAX          | RBX          |
>| RCX          | RBP          |
>| RDX          | R12          |
>| RSI          | R13          |
>| RDI          | R14          |
>| R8           | R15          |
>| R9           |              |
>| R10          |              |
>| R11          |              |
>

## Rules

### `Caller-saved (volatile)` – registers the calling function must save if it wants to use them after calling another function. Typically used for temporary values and arguments

### `Callee-saved (non-volatile)` – registers the called function must save and restore if it uses them. Used to store long-term data between calls

### `Special case: RSP` – always saved/restored by the stack; it cannot be considered caller/callee

## Examples

### Caller should save if needed:

```asm
    Instruction:

        push rax    ; save temporary register

        call some_func 

        pop rax     ; restore
```

### Callee should save:

```asm
    some_func:

        push r12    ; save callee-saved

        ; ... use r12

        pop r12     ; restore before return

        ret
```

## Arguments and Relationships

### Function Arguments: RDI, RSI, RDX, RCX, R8, R9. Return Value: RAX

### All registers used for arguments except RAX are caller-saved, which is logical: the caller must be prepared to change them

## A Quick Cheat Sheet

### Temporary / Caller-Saved: RAX, RCX, RDX, RSI, RDI, R8-R11 (temporary, volatile)

### Retained / Callee-Saved: RBX, RBP, R12-R15 (reliable, storable)

### We can mentally differentiate between "who is responsible for maintaining the register" - the caller or the callee

---
