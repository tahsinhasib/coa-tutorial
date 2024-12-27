.MODEL SMALL            
.STACK 100H            

.DATA                   

.CODE                   

MAIN PROC              
    
    
    MOV CX, 4           ; This will count the number of times the program will print
    MOV DL, '1'         ; Set DL register to ASCII value of '1'

    PRINTLOOP:          
        MOV AH, 2
        INT 21H
        ;INT 21H        ; The more INT will be added the more the number will be repeated     
        INC DL      
        DEC CX        
        JNZ PRINTLOOP   

    MOV AH, 4CH         

    MAIN ENDP       
END MAIN              
