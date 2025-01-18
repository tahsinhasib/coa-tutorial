.MODEL SMALL
.STACK 100H   ; Set stack size to 256 bytes (100H in hexadecimal)

.DATA         ; Start of data segment
msg1 DB 0DH,0AH, "ENTER 3 CHARACTERS: $"  ; Prompt message
msg2 DB 0DH,0AH, "REVERSED OUTPUT: $"     ; Message before reversed output

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Display prompt message
    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    ; Read 3 characters and push onto stack
    MOV CX, 3          ; Set counter to 3 (for 3 characters)
READ_LOOP:
    MOV AH, 01H        ; Function to read a character
    INT 21H            ; DOS interrupt to read character
    PUSH AX            ; Push the character onto stack
    LOOP READ_LOOP     ; Decrement CX and repeat loop

    ; Display reversed output message
    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    ; Pop characters from stack and display them
    MOV CX, 3          ; Set counter to 3 (for 3 characters)
DISPLAY_LOOP:
    POP AX             ; Pop character from stack
    MOV DL, AL         ; Move character to DL for display
    MOV AH, 02H        ; Function to display a single character
    INT 21H            ; Display the character
    LOOP DISPLAY_LOOP  ; Decrement CX and repeat loop

    ; Exit program
    MOV AH, 4CH        ; Function to terminate program
    INT 21H

MAIN ENDP
END MAIN
