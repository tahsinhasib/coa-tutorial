.MODEL SMALL
.STACK 100H

.DATA
;--------------------------- Variables ---------------------------

; Prompt message
prompt DB 'Enter two decimal digits whose sum is less than 10: $'
displaySum DB 0DH, 0AH, 'The digits and their sum are: $'
newline DB 0DH, 0AH, '$'

; Variables to store user input and results
digit1 DB ?, '$'
digit2 DB ?, '$'
sum DB ?, '$'

; Error message
errorMessage DB 0DH, 0AH, 'Error: Sum exceeds 9. Please try again.$'

;------------------------------------------------------------------

.CODE
MAIN PROC
    ; -------------------- Data Segment Initialization --------------------
    MOV AX, @DATA
    MOV DS, AX

    ; -------------------- Prompt the user for input --------------------
    ; Display "?"
    MOV AH, 2
    MOV DL, '?'
    INT 21H

    ; New line
    MOV AH, 9
    LEA DX, newline
    INT 21H

    ; Display prompt message
    MOV AH, 9
    LEA DX, prompt
    INT 21H

    ; Read first digit
    MOV AH, 1
    INT 21H
    SUB AL, '0'               ; Convert ASCII to decimal
    MOV digit1, AL

    ; New line
    MOV AH, 9
    LEA DX, newline
    INT 21H

    ; Read second digit
    MOV AH, 1
    INT 21H
    SUB AL, '0'               ; Convert ASCII to decimal
    MOV digit2, AL

    ; Calculate sum
    MOV AL, digit1
    ADD AL, digit2
    MOV sum, AL

    ; Check if sum < 10
    CMP AL, 10
    JAE Error

    ; Display digits and their sum
    MOV AH, 9
    LEA DX, newline
    INT 21H

    MOV AH, 9
    LEA DX, displaySum
    INT 21H

    ; Display first digit
    MOV AH, 2
    MOV DL, digit1
    ADD DL, '0'               ; Convert decimal back to ASCII
    INT 21H

    ; Display " + "
    MOV AH, 2
    MOV DL, ' '
    INT 21H
    MOV DL, '+'
    INT 21H
    MOV DL, ' '
    INT 21H

    ; Display second digit
    MOV AH, 2
    MOV DL, digit2
    ADD DL, '0'
    INT 21H

    ; Display " = "
    MOV AH, 2
    MOV DL, ' '
    INT 21H
    MOV DL, '='
    INT 21H
    MOV DL, ' '
    INT 21H

    ; Display sum
    MOV AH, 2
    MOV DL, sum
    ADD DL, '0'
    INT 21H

    JMP ExitProgram

Error:
    ; Display error message
    MOV AH, 9
    LEA DX, errorMessage
    INT 21H

ExitProgram:
    ; -------------------- Exit the program --------------------
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
