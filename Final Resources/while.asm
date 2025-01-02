.MODEL SMALL
.STACK 100H

.DATA
newline DB 0DH, 0AH, '$'
result DB 0DH, 0AH, 'Total characters: $'
count DB ?  ; To store character count

.CODE
    MAIN PROC
        ; Initialize Data Segment
        MOV AX, @DATA
        MOV DS, AX

        ; Initialize character count to 0
        XOR DX, DX           ; DX = 0

        ; Read a character
    WHILE_:
        MOV AH, 1            ; Function to read a character
        INT 21H              ; Read input into AL

        CMP AL, 0DH          ; Check if carriage return
        JE END_WHILE         ; If yes, exit loop

        INC DX               ; Increment character count
        JMP WHILE_           ; Loop back

    END_WHILE:
        ; Display result
        MOV AH, 9            ; Print result string
        LEA DX, result
        INT 21H

        ; Display the count
        MOV AH, 2            ; Print single character
        ADD DL, '0'          ; Convert count to ASCII
        MOV DL, DL           ; Move count into DL
        INT 21H

        ; Print newline
        MOV AH, 9
        LEA DX, newline
        INT 21H

        ; Exit program
        MOV AH, 4CH
        INT 21H

    MAIN ENDP
END MAIN
