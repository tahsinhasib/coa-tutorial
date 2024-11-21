; segment registers keep memory address



.MODEL SMALL
.STACK 100H

.DATA

MSG1 DB 0DH, 0AH, '* * * * * * * * * *';
CHAR DB ?, '$';


.CODE

    MAIN PROC
        
        ;INITIALIZE
        MOV AX, @DATA;
        MOV DS, AX;
        
        
        ;PRINT USER PROMT
        LEA DX, MSG1;
        MOV AH, 9;
        INT 21H;
        
        ;PRINT USER PROMT
        LEA DX, MSG1;
        MOV AH, 9;
        INT 21H;
        
        
        ;PRINT USER PROMT
        LEA DX, MSG1;
        MOV AH, 9;
        INT 21H;
        
        
        ;PRINT USER PROMT
        LEA DX, MSG1;
        MOV AH, 9;
        INT 21H;
        
        
        ;PRINT USER PROMT
        LEA DX, MSG1;
        MOV AH, 9;
        INT 21H;
        
        ;PRINT USER PROMT
        LEA DX, MSG1;
        MOV AH, 9;
        INT 21H;
        
        ;PRINT USER PROMT
        LEA DX, MSG1;
        MOV AH, 9;
        INT 21H;
        
        ;PRINT USER PROMT
        LEA DX, MSG1;
        MOV AH, 9;
        INT 21H;
        
        ;PRINT USER PROMT
        LEA DX, MSG1;
        MOV AH, 9;
        INT 21H;
        
        ;PRINT USER PROMT
        LEA DX, MSG1;
        MOV AH, 9;
        INT 21H;
        
        
        
        
        ;DOS EXIT
        MOV AH, 4CH;
        INT 21H;
        
    MAIN ENDP
END MAIN
    
    
