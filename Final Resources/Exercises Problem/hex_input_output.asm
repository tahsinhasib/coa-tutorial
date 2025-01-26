.MODEL SMALL
.STACK 100H
.DATA
INPUT DB 'ENTER HEX NUMBER: $'
OUTPUT DB 0AH,0DH, 'YOU HAVE ENTERED : $'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,9
    LEA DX,INPUT
    INT 21H
    
    XOR BX,BX
    MOV CL,4
    MOV AH,1
    
    FOR:    
    INT 21H
    
    CMP AL, 0DH
    JE PRINT
    CMP AL, 41H  ;A
    JGE LETTER
    AND AL,0FH
    JMP SHIFT
    
    LETTER:
    SUB AL,37H
    
    SHIFT:
    SHL BX, CL
    OR BL,AL 
    JMP FOR
    
    PRINT:
    MOV AH,9
    LEA DX,OUTPUT
    INT 21H
    
    MOV CX,4
    MOV AH,2
    
    AGAIN:    
    MOV DL,BH
    SHR DL,4
    ROL BX, 4
    CMP DL,10
    JGE LETTEROUT
    
    ADD DL,48
    INT 21H
    JMP EXIT
    
    LETTEROUT:
    ADD DL,55
    INT 21H 
    
    EXIT:
    LOOP AGAIN
    
    
    
    



