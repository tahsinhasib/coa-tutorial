.MODEL SMALL            
.STACK 100H            

.DATA     

msg DB 0DH, 0AH, 'exited$';              

.CODE                   

MAIN PROC
    
    ; Initialize Data Segment           
    MOV AX, @DATA;
    MOV DS, AX;              
    
    MOV AH, 2               ; For displaying character
    MOV CX, 5           
    MOV DL, '1'         

    
    TOP:
        INT 21H
        INC DL
        DEC CX            ; Depends on the loop counter
        
        JNZ BOTTOM        ; keep looping till CX > 0
        JMP EXIT

    BOTTOM:
        JMP TOP
    
    EXIT:
        MOV AH, 9           ; For displaying string
        LEA DX, msg
        INT 21H


    MOV AH, 4CH         

    MAIN ENDP       
END MAIN              
