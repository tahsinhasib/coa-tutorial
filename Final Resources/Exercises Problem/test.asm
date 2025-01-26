.MODEL SMALL
.STACK 100H                                 ; Set stack size to 256 bytes

.DATA                                       ; Start of data segment
msg DB 0DH,0AH, "Enter a number: $"         ; Prompt for number
msgEven DB 0DH,0AH, "The number is even.$"  ; Message for even number
msgOdd DB 0DH,0AH, "The number is odd.$"    ; Message for odd number

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Display prompt message
    LEA DX, msg
    MOV AH, 09H            ; Function to display string
    INT 21H

    ; Read a character from user
    MOV AH, 01H            ; Function to read a single character
    INT 21H                ; DOS interrupt to read character
    MOV AL, AL             ; Store the input character in AL

    ; Check if the input is even or odd
    TEST AL, 1             ; Mask the least significant bit
    JZ EVEN                ; Jump to EVEN if zero (even number)

ODD:
    ; Display odd message
    LEA DX, msgOdd
    MOV AH, 09H            ; Function to display string
    INT 21H
    JMP END_PROGRAM        ; Exit program

EVEN:
    ; Display even message
    LEA DX, msgEven
    MOV AH, 09H            ; Function to display string
    INT 21H

END_PROGRAM:
    ; Exit program
    MOV AH, 4CH            ; Function to terminate program
    INT 21H

MAIN ENDP
END MAIN