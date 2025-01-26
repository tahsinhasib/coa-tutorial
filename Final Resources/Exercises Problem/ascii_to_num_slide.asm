.MODEL SMALL
.STACK 100H

.DATA
input DB 0DH, 0AH, "input: $"
output DB 0DH, 0AH, "output: $"

.CODE
    MAIN PROC
        ; Initialize Data Segment
        MOV AX, @DATA
        MOV DS, AX 
        
        MOV AH, 9
        LEA DX, input
        INT 21H

        MOV AH, 1            ; Function to read a character
        INT 21H              ; Read input into AL
        
        ;SUB AL, 30H
        ;AND AL, 0FH
        
        MOV AH, 9
        LEA DX, output
        INT 21H
        
        MOV AH, 2H
        MOV DL, AL
        INT 21H
        
        ; Exit program
        MOV AH, 4CH          ; Terminate program
        INT 21H

    MAIN ENDP
END MAIN
