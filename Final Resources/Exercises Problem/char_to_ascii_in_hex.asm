.MODEL SMALL
.STACK 100H
.DATA
PROMPT DB 'TYPE A CHARACTER: $'
OUTPUT DB 0AH,0DH, 'THE ASCII CODE OF $'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    AGAIN:
    ; Display the prompt
    MOV AH,9
    LEA DX,PROMPT
    INT 21H

    ; Read a character from the user
    MOV AH,1
    INT 21H
    CMP AL, 0DH
    JE EXIT

    ; Store the character in DL
    MOV DL, AL

    ; Display the output message
    MOV AH,9
    LEA DX,OUTPUT
    INT 21H

    ; Print the character
    MOV AH,2
    INT 21H

    ; Print " IN HEX IS "
    MOV DL, ' '
    INT 21H
    MOV DL, 'I'
    INT 21H
    MOV DL, 'N'
    INT 21H
    MOV DL, ' '
    INT 21H
    MOV DL, 'H'
    INT 21H
    MOV DL, 'E'
    INT 21H
    MOV DL, 'X'
    INT 21H
    MOV DL, ' '
    INT 21H
    MOV DL, 'I'
    INT 21H
    MOV DL, 'S'
    INT 21H
    MOV DL, ':'
    INT 21H
    MOV DL, ' '
    INT 21H

    ; Convert the character to hex and print
    MOV DL, AL
    SHR DL, 4
    ADD DL, 30H
    CMP DL, 3AH
    JB PRINT_HEX
    ADD DL, 7
    PRINT_HEX:
    MOV AH, 2
    INT 21H

    MOV DL, AL
    AND DL, 0FH
    ADD DL, 30H
    CMP DL, 3AH
    JB PRINT_HEX2
    ADD DL, 7
    PRINT_HEX2:
    MOV AH, 2
    INT 21H

    ; Print new line
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H

    JMP AGAIN

    EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
