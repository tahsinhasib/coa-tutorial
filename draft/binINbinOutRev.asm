.DATA
 INPUT DB 'ENTER BINAR INPUT: $'
 OUTPUT DB 0AH,0DH, 'YOU  HAVE ENTERED: $'
 REVERSE DB 0AH,0DH, 'IN REVERSED ORDER: $'

 .CODE 
  
 INPUT1 proc
      MOV AX,@DATA
    MOV DS,AX   
             
    MOV AH,9
    LEA DX, INPUT
    INT 21H 
    
    XOR BX,BX        
     MOV CX,16
     
    WHILE_:
    MOV AH,1
    INT 21H
    CMP AL,0DH
    JE ENDD 
    AND AL,0FH
    SHL BX,1
    OR BL,AL
    LOOP WHILE_
    ENDD: 
    ret
 endp
 
 OUTPUT1 PROC 
     
    MOV AH,9
    LEA DX, OUTPUT
    INT 21H
    
    MOV CX,16
    IF:
    ROL BX,1
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
    
   ret
 endp 
 
 REVERSE1 PROC
      ;REVERSED
       MOV CX,16
       
     REV:
     SHL BX,1
     RCR DX,1
     LOOP REV
     MOV BX,DX
    
    MOV AH,9
    LEA DX, REVERSE
    INT 21H
    
    MOV CX,16
    IFF:
    ROL BX,1
    JNC THENF
    
    MOV AH,2
    MOV DL,31H ;1
    INT 21H
    JMP DISPLAYF
    
    THENF:
    MOV AH,2
    MOV DL,30H ;0
    INT 21H
    JMP DISPLAYF
    
    DISPLAYF:
    LOOP IFF
    
    RET
 ENDP
 
 
 MAIN PROC
    MOV AX,@DATA
    MOV DS,AX   
             
    CALL INPUT1
    CALL OUTPUT1
    CALL REVERSE1 
   
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
    