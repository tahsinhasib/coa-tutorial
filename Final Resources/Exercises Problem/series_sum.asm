.MODEL SMALL
.STACK 100H

.DATA

.CODE
    MAIN PROC
        ; Initialize Data Segment
        MOV AX, @DATA
        MOV DS, AX

        ; Initialize sum in AX to 0
        MOV AX, 0

        ; Set initial term to 100
        MOV BX, 100          ; BX will hold the current term

        ; Set CX to the number of loops needed (19 loops)
        MOV CX, 19

    SUM_LOOP:
        ADD AX, BX           ; Add current term (BX) to AX
        SUB BX, 5            ; Decrement current term by 5
        LOOP SUM_LOOP        ; Decrement CX and loop if CX != 0
        
        
        ; Exit program
        MOV AH, 4CH
        INT 21H

    MAIN ENDP
END MAIN
