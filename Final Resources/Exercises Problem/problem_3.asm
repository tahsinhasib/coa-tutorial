.MODEL SMALL
.STACK 100H

.DATA
output db 0DH, 0AH, "The digit is: $"
digit db 0

.CODE
    MAIN PROC
        ; Initialize Data Segment
        MOV AX, @DATA
        MOV DS, AX

    REPEAT:
        MOV AH, 1            ; Function to read a character
        INT 21H              ; Read input into AL
        
        CMP AL, '0'          ; Check if input is a digit (>= '0')
        JL NOT_DIGIT         ; If less, it's not a digit
        CMP AL, '9'          ; Check if input is a digit (<= '9')
        JG NOT_DIGIT         ; If greater, it's not a digit

        SUB AL, 30H          ; Convert ASCII to numeric value (0-9)
        
        MOV AH, 9            ; Function to print a string
        LEA DX, output       ; Load the string to print
        INT 21H              ; Print the string
        MOV digit, AL        ; Store the digit
        
        MOV AH, 2           ; Function to print a character
        MOV DL, digit        ; Load the digit to DL
        INT 21H              ; Print the digit

    NOT_DIGIT:
        CMP AL, 20H          ; Compare AL with blank space (' ')
        JNE REPEAT           ; If not blank space, repeat

        ; Exit program
        MOV AH, 4CH          ; Terminate program
        INT 21H

    MAIN ENDP
END MAIN
