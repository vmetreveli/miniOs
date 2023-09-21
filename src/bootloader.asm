; Bootloader code that prints "Hello, world! From Mini OS =))" to the screen.

; Set the origin point for the program in memory.
org 0x7C00

; Declare that this code is 16-bit assembly.
bits 16

; Define a newline character.
%define ENDL 0x0D, 0x0A

; Entry point of the bootloader.
start:
    jmp main

;
; Prints a string to the screen.
;
; Parameters:
;   - ds:si points to the string
;
puts:
    ; Save registers we will modify.
    push si
    push ax
    push bx

.loop:
    lodsb            ; Load the next character into al.
    or al, al        ; Check if the next character is null (end of the string).
    jz .done

    mov ah, 0x0E     ; Call BIOS interrupt to print the character.
    mov bh, 0        ; Set page number to 0.
    int 0x10

    jmp .loop

.done:
    pop bx
    pop ax
    pop si
    ret

main:
    ; Setup data segments.
    mov ax, 0        ; Initialize ax (can't set ds/es directly).
    mov ds, ax
    mov es, ax

    ; Setup the stack.
    mov ss, ax
    mov sp, 0x7C00   ; Set the stack pointer (stack grows downwards).

    ; Print the "Hello, world! From Mini OS =))" message.
    mov si, msg_hello
    call puts

    hlt             ; Halt the system.

.halt:
    jmp .halt

; Define the "Hello, world! From Mini OS =))" message.
msg_hello: db 'Hello world! From Mini OS =))', ENDL, 0

; Fill the remaining space in the bootloader sector with zeros.
times 510-($-$$) db 0

; Boot signature (0xAA55) to indicate a bootable device.
dw 0xAA55