.MODEL SMALL            
.STACK 100H            

.DATA     

case_1 DB 0DH, 0AH, 'negative executed$';
case_2 DB 0DH, 0AH, 'zero executed$';
case_3 DB 0DH, 0AH, 'positive executed$';
   

.CODE                   

MAIN PROC
    
    ; Initialize Data Segment           
    MOV AX, @DATA;
    MOV DS, AX;              
    
    MOV AH, 9               ; For displaying string
    
    MOV DL, -3
    MOV AL, DL
    
    CMP AL, 0
    
    JL NEGATIVE
    JE ZERO
    JG POSITIVE
    
    NEGATIVE:
        LEA DX, case_1
        INT 21H
        MOV BX, -1
        JMP END_CASE
    ZERO:
        LEA DX, case_2
        MOV BX, 0
        JMP END_CASE
    POSITIVE:
        LEA DX, case_3
        INT 21H
        MOV BX, 1
        JMP END_CASE

    
    
    END_CASE:

    MOV AH, 4CH         

    MAIN ENDP       
END MAIN              
