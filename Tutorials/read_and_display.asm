.MODEL small
.STACK 100h


.DATA

.CODE
    MAIN PROC
        ;display promt
        MOV AH, 2;          display character function
        MOV DL, '?';        character is '?'
        INT 21H;            display character
        
        ;input a character
        MOV AH, 1;          input key function
        INT 21H;            ASCII Code in AL
        MOV BL, AL;         save it in BL

        ;go to a new line
        MOV AH, 2;          display character function
        MOV DL, 0DH;        carriage return
        INT 21H;            execute
        MOV DL, 0AH;        line feed
        INT 21H;            execute

        ;display character
        MOV DL, BL;
        INT 21H;

        ;return to dos
        MOV AH, 4CH;
        INT 21H;

    MAIN ENDP
END MAIN