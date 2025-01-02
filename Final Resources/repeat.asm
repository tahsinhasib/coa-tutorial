.MODEL SMALL
.STACK 100H

.DATA

.CODE
    MAIN PROC
        ; Initialize Data Segment
        MOV AX, @DATA
        MOV DS, AX

    REPEAT:
        MOV AH, 1            ; Function to read a character
        INT 21H              ; Read input into AL
        CMP AL, 20H          ; Compare AL with blank space (' ')
        JNE REPEAT           ; If not blank space, repeat

        ; Exit program
        MOV AH, 4CH          ; Terminate program
        INT 21H

    MAIN ENDP
END MAIN
