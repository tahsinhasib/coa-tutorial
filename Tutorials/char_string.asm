.MODEL SMALL
.STACK 100H

.DATA


.CODE
    MAIN PROC

        MOV AH, 2;
        MOV DL, 'A';
        INT 21H;
        
    END ENDP
END MAIN