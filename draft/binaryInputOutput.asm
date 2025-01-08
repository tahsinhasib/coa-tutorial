.DATA
 INPUT DB 'ENTER BINAR INPUT: $'
 OUTPUT DB 0AH,0DH, 'YOU  HAVE ENTERED: $'
 .CODE 
  
 INPUT1 proc
      MOV AX,@DATA
    MOV DS,AX   
             
    MOV AH,9
    LEA DX, INPUT
    INT 21H
    ret
    endp
 
 MAIN PROC
    MOV AX,@DATA
    MOV DS,AX   
             
    call INPUT1
    
     XOR BX,BX        
     MOV CX,16
     
    WHILE_:
    MOV AH,1
    INT 21H
    CMP AL,0DH
    JE FOR
    AND AL,0FH
    SHL BX,1
    OR BL,AL
    LOOP WHILE_
     
    
    
    FOR:
    MOV AH,9
    LEA DX, OUTPUT
    INT 21H
    
    MOV CX,16
    IF:
    SHL BX,1
    JNC THEN
    
    MOV AH,2
    MOV DL,31H ;1
    INT 21H
    JMP DISPLAY
    
    THEN:
    MOV AH,2
    MOV DL,30H ;0
    INT 21H
    JMP DISPLAY
    
    DISPLAY:
    LOOP IF
    
    END_WHILE_:
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
    