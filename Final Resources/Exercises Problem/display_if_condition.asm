.MODEL SMALL
.STACK 100H

.DATA
msg1 DB 0DH, 0AH, "Display: $"

.CODE
    MAIN PROC
        ; Initialize Data Segment
        MOV AX, @DATA
        MOV DS, AX

        ; Read a character from keyboard
        MOV AH, 1
        INT 21H

        ; Compare AL with ASCII codes of '1', '2', '3', and '4'
        CMP AL, '1'
        JE ODD  
        CMP AL, '3'
        JE ODD
        CMP AL, '2'
        JE EVEN
        CMP AL, '4'
        JE EVEN
    
        JMP END_CASE 
        
        ODD:
            MOV AH, 9
            LEA DX, msg1
            INT 21H
            
            MOV AH, 2
            MOV DL, 'O'
            JMP DISPLAY
    
        EVEN:
            MOV AH, 9
            LEA DX, msg1
            INT 21H
            
            MOV AH, 2
            MOV DL, 'E'
            JMP DISPLAY
        
        DISPLAY:
            INT 21H
            JMP END_CASE

        ; Exit program
        END_CASE:
            MOV AH, 4CH
            INT 21H

    MAIN ENDP
END MAIN
