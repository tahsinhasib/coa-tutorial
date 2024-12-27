.MODEL SMALL            
.STACK 100H            

.DATA                   

.CODE                   

MAIN PROC              
    
    MOV AH, 2
    MOV CX, 5           
    MOV DL, '1'         

    
    TOP:
        INT 21H
        DEC CX             ; Program goes to infinite loop and prints 255 ascii characters
        INC DL
        ;DEC CX            ; Depends on the loop counter
        JNZ TOP
        ;INT 21H



    MOV AH, 4CH         

    MAIN ENDP       
END MAIN              
