.MODEL SMALL
.STACK 100H   ; Set stack size to 256 bytes (100H in hexadecimal)

.DATA         ; Start of data segment
msg1 DB 0DH,0AH, "ENTER A STRING AND HIT ENTER: $"  ; Prompt message
msg2 DB 0DH,0AH, "REVERSED OUTPUT: $" ; Message before reversed output

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Display prompt message
    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    ; Read characters until carriage return and push onto stack
    MOV CX, 0              ; Initialize counter for string length
READ_LOOP:
    MOV AH, 01H            ; Function to read a character
    INT 21H                ; Read character
    CMP AL, 0DH            ; Compare with carriage return
    JE END_READ            ; If carriage return, end input
    PUSH AX                ; Push character onto stack
    INC CX                 ; Increment string length
    JMP READ_LOOP          ; Repeat input loop
END_READ:

    ; Display reversed output message
    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    ; Pop characters from stack and display them
POP_LOOP:
    POP AX                 ; Pop character from stack
    MOV DL, AL             ; Move character to DL for display
    MOV AH, 02H            ; Function to display a single character
    INT 21H                ; Display the character
    LOOP POP_LOOP          ; Repeat until stack is empty

    ; Exit program
    MOV AH, 4CH            ; Function to terminate program
    INT 21H

MAIN ENDP
END MAIN
