; main.asm
;
; A simple boot sector that prints a string to the screen.
; This serves as a basic bootloader simulation.
;
; Assemble with: nasm -f bin main.asm -o main.bin
; Run with: qemu-system-i386 main.bin

times 510-($-$$) db 0
dw 0xAA55

section .text
    global _start

_start:
    ; Set up data segment
    xor ax, ax
    mov ds, ax
    mov es, ax

    ; Pointer to string
    mov si, msg

print_loop:
    mov al, [si]
    cmp al, 0
    je done
    mov ah, 0x0E
    int 0x10
    inc si
    jmp print_loop

done:
    ; Halt the CPU
    cli
    hlt

section .data
    msg db 'Hello, NASM!', 0
