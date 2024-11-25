.MODEL SMALL
.STACK 100H
.DATA
 
 MSG1 DB 'ENTER INITIAL: $'  
 
 char DB 0AH, 0DH ?, '$';

 
.CODE
MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,9;               FOR SHOWING STRING
    LEA DX,MSG1;
    INT 21H
    
    MOV AH,1;               TAKING INPUT WITHOUT NEXT LINE
    INT 21H
    
        
        
    ;STORING IN A VARIABLE    
    MOV BL,AL;              
    MOV char, BL; 
    
    
    
    ;DISPLAY THE VARIABLE VALUE
    MOV AH, 2;
    MOV DL, char;
    INT 21H

    
    
    
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
END MAIN