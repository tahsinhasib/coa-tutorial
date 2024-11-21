.MODEL SMALL
.STACK 100H

.DATA

MSG1 DB 0DH, 0AH, 'ENTER A LOWER CASE LETTER: $'
MSG2 DB 0DH, 0AH, 'CONVERTED TO UPPER CASE: $'
PROMPT_DONE DB 0DH, 0AH, 'PROCESSING COMPLETED. $'

CHAR1 DB ?, '$'
CHAR2 DB ?, '$'
CHAR3 DB ?, '$'

.CODE

MAIN PROC
    ; Initialize Data Segment
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt for the first letter
    LEA DX, MSG1
    MOV AH, 9
    INT 21H

    ; Input first character
    MOV AH, 1
    INT 21H
    SUB AL, 20H ; Convert to upper case
    MOV CHAR1, AL

    ; Prompt for the second letter
    LEA DX, MSG1
    MOV AH, 9
    INT 21H

    ; Input second character
    MOV AH, 1
    INT 21H
    SUB AL, 20H ; Convert to upper case
    MOV CHAR2, AL

    ; Prompt for the third letter
    LEA DX, MSG1
    MOV AH, 9
    INT 21H

    ; Input third character
    MOV AH, 1
    INT 21H
    SUB AL, 20H ; Convert to upper case
    MOV CHAR3, AL

    ; Display the converted characters one by one
    LEA DX, MSG2
    MOV AH, 9
    INT 21H

    LEA DX, CHAR1
    MOV AH, 9
    INT 21H

    LEA DX, CHAR2
    MOV AH, 9
    INT 21H

    LEA DX, CHAR3
    MOV AH, 9
    INT 21H

    ; Display processing completed message
    LEA DX, PROMPT_DONE
    MOV AH, 9
    INT 21H

    ; Exit the program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
