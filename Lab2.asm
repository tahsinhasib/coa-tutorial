; segment registers keep memory address



.MODEL SMALL
.STACK 100H

.DATA

MSG1 DB 0DH, 0AH, 'ENTER A LOWER CASE LETTER: $';
MSG2 DB 0DH, 0AH, 'IT IS IN UPPER CASE: $';
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
        
        
        ;INPUT A CHARACTER
        MOV AH, 1;
        INT 21H;
        
        
        ;INPUT A CHARACTER
        ;MOV AH, 1;
        ;INT 21H;
        ;step wise line executes
        
        
        ;CONVERT TO UPPER CASE
        SUB AL, 20H;
        MOV CHAR, AL;
        
        
        ;DISPLAY ON THE NEXT LINE
        LEA DX, MSG2;
        MOV AH, 9;
        INT 21H;
        
        LEA DX, CHAR;
        MOV AH, 9;
        INT 21H;
        
        
        ;DOS EXIT
        MOV AH, 4CH;
        INT 21H;
        
    MAIN ENDP
END MAIN
    
    
