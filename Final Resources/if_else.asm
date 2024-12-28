.MODEL SMALL            
.STACK 100H            

.DATA     

if_msg DB 0DH, 0AH, 'If block executed$';
else_msg DB 0DH, 0AH, 'Else block executed$';
value DB 0DH, 0AH, 'Value: $';               

.CODE                   

MAIN PROC
    
    ; Initialize Data Segment           
    MOV AX, @DATA;
    MOV DS, AX;              
    
    MOV AH, 9               ; For displaying string
            

    MOV AL, 5               ; AL = 5
    MOV BL, 10              ; BL = 10
    
    CMP AL, BL              ; Compare AL and BL

    JNBE ELSE_BLOCK         ; If AL is not below or equal to BL, jump to ELSE_BLOCK

    LEA DX, if_msg          ; Load address of if_msg to DX
    INT 21H                 ; Display the message
    LEA DX, value           ; Load address of value to DX
    INT 21H                 ; Display the message
    
    MOV DL, AL              ; DL = AL
    

    JMP DISPLAY

    ELSE_BLOCK:
        LEA DX, else_msg        ; Load address of else_msg to DX
        INT 21H                 ; Display the message
        LEA DX, value           ; Load address of value to DX
        INT 21H                 ; Display the message

        MOV DL, BL          ; DL = BL

    DISPLAY:
        MOV AH, 2               ; For displaying character
        INT 21H             ; Display the value of DL

    
    MOV AH, 4CH         

    MAIN ENDP       
END MAIN              
