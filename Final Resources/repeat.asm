.MODEL SMALL
.STACK 100H

.DATA

.CODE
    MAIN PROC
        ; Initialize Data Segment
        MOV AX, @DATA
        MOV DS, AX

        MOV AH, 1            ; Function to read a character
        INT 21H              ; Read input into AL
    
        REPEAT:

            INT 21H              ; Read input into AL
            CMP AL, ''    
            
            JNE REPEAT           ; Loop back

        ; Exit program
        MOV AH, 4CH
        INT 21H

    MAIN ENDP
END MAIN
