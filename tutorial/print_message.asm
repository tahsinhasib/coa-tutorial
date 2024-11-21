.MODEL small
.STACK 100h


.DATA

MSG DW "Welcome$";

.CODE
    MAIN PROC
        ;initialize data segment
        MOV AX, @DATA;
        MOV DS, AX
        
        ;display message
        LEA DX, MSG;            get message
        MOV AH, 09;             display string function
        INT 21h;                display message
        
        
        ;return to DOS
        MOV AH, 4ch;
        INT 21h;                dos exit
        
    MAIN ENDP
END MAIN    

        