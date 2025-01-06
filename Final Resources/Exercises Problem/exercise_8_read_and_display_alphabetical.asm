.MODEL SMALL
.STACK 100H

.DATA
    LETTER1 DB 0        ; Variable to store the first letter
    LETTER2 DB 0        ; Variable to store the second letter
    MSG1    DB '?', '$' ; Message to display "?"
    NEWLINE DB 0DH, 0AH, '$' ; Newline for output

.CODE
    MAIN PROC
        ; Initialize Data Segment
        MOV AX, @DATA
        MOV DS, AX

        ; Display "?"
        LEA DX, MSG1
        MOV AH, 09H
        INT 21H

        ; Read first letter
        MOV AH, 01H
        INT 21H
        MOV LETTER1, AL    ; Store first letter in LETTER1

        ; Read second letter
        MOV AH, 01H
        INT 21H
        MOV LETTER2, AL    ; Store second letter in LETTER2

        ; Compare letters and swap if necessary
        MOV AL, LETTER1    ; Load LETTER1 into AL
        MOV BL, LETTER2    ; Load LETTER2 into BL
        CMP AL, BL
        JBE NOSWAP         ; If AL <= BL, no swap needed

        ; Swap the contents of AL and BL
        XCHG AL, BL        ; Swap AL and BL

        ; Store the swapped values back to LETTER1 and LETTER2
        MOV LETTER1, AL    ; Store new LETTER1
        MOV LETTER2, BL    ; Store new LETTER2

    NOSWAP:
        ; Display newline
        LEA DX, NEWLINE
        MOV AH, 09H
        INT 21H

        ; Display LETTER1
        MOV DL, LETTER1
        MOV AH, 02H
        INT 21H

        ; Display LETTER2
        MOV DL, LETTER2
        MOV AH, 02H
        INT 21H

        ; Terminate program
        MOV AH, 4CH
        INT 21H

    MAIN ENDP
END MAIN
