.MODEL SMALL
.STACK 100H
.DATA
 
 MSG1 DB 'THE SUM OF $'
 MSG2 DB ' AND $'
 MSG3 DB ' IS $'
 
.CODE
MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,2
    MOV DL,'?'
    INT 21H
    
    MOV AH,1
    INT 21H
    MOV BL,AL
    
    INT 21H
    MOV BH,AL
    
    MOV AH,2
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    
    MOV AH,2
    MOV DL,BH
    INT 21H 
    
    MOV AH,9 
    LEA DX,MSG3
    INT 21H
    
    
    MOV AH,2   
    ADD BH,BL
    SUB BH,48
    MOV DL,BH
    INT 21H
     
    
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN