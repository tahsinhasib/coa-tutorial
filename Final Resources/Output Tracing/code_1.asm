.MODEL SMALL
.STACK 100H

.DATA

M1 DB 0DH, 0AH, "THANK YOU$"

.CODE

MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 2
    MOV CX, 3

    JMP LABEL_3

    LABEL_0:
    MOV DL, 'B'
    INT 21H
    
    JMP LABEL_5
    
    LABEL_1:
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H
    
    JMP LABEL_0
    
    LABEL_2:
    MOV DL, 'Y'
    INT 21H
    
    JMP LABEL_6
    
    LABEL_3:
    MOV DL, '*'
    INT 21H
    DEC CX
    
    JNZ LABEL_3
    JMP LABEL_1
    
    LABEL_4:
    MOV DL, 'R'
    INT 21H
    INT 21H
    
    JMP LABEL_2
    
    LABEL_5:
    MOV DL, 'E'
    INT 21H
    MOV CX, 2
    
    JMP LABEL_4
    
    LABEL_6:
    MOV AH, 9
    LEA DX, M1
    INT 21H
    
    MAIN ENDP
    
END MAIN
    