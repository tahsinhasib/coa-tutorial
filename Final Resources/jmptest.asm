.MODEL SMALL            ; Define the memory model as small
.STACK 100H             ; Define the stack size

.DATA                   ; Begin data segment

.CODE                   ; Begin code segment

MAIN PROC               ; Start of main procedure

    MOV AH, 2           ; Set AH register to 2 (function to output character to console)
    MOV CX, 256         ; Set CX register to 256 (loop counter)
    MOV DL, 0           ; Set DL register to 0 (character to print)

    PRINTLOOP:          ; Label for the loop
        INT 21H         ; Interrupt 21H (DOS function call)
        INC DL          ; Increment DL (next character)
        DEC CX          ; Decrement CX (loop counter)
        JNZ PRINTLOOP   ; Jump to PRINTLOOP if CX is not zero

    MOV AH, 4CH         ; Set AH register to 4CH (function to terminate program)

    MAIN ENDP           ; End of main procedure
END MAIN                ; End of program