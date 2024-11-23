.MODEL SMALL
.STACK 100H
.DATA
 
 MSG1 DB 0AH,0DH,'*********** $'
 MSG2 DB 0AH,0DH,'****$'
 MSG3 DB '****$'

 
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
    INT 21H 
    
    MOV CL,AL
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    LEA DX,MSG2;LINE NO.6
    INT 21H
    
    MOV AH,2
    MOV DL,BL
    INT 21H
    MOV DL,BH
    INT 21H
    MOV DL,CL
    INT 21H
    
    MOV AH,9
    LEA DX,MSG3
    INT 21H 
    
    LEA DX,MSG1
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    INT 21H
    
    MOV AH,2
    MOV DL,7
    INT 21H
    
    
    
    
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN