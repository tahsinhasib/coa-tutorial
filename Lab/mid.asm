.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'ENTER A DOUBLE-DIGIT NUMBER: $'
    MSG2 DB 0AH, 0DH, 'THE NUMBER IS: $'
    NUMBER DB '00$', '$'                            ; Variable to store the double-digit number as a string
.CODE
MAIN PROC

    MOV AX, @DATA
    MOV DS, AX

    ; Display the prompt message
    MOV AH, 9
    LEA DX, MSG1
    INT 21H

    ; Take the first digit
    MOV AH, 1
    INT 21H
    MOV NUMBER[0], AL ; Store the first digit in the first position of NUMBER

    ; Take the second digit
    MOV AH, 1
    INT 21H
    MOV NUMBER[1], AL ; Store the second digit in the second position of NUMBER

    ; Display the result message
    MOV AH, 9
    LEA DX, MSG2
    INT 21H

    ; Display the double-digit number
    MOV AH, 9
    LEA DX, NUMBER
    INT 21H

    ; Exit the program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
