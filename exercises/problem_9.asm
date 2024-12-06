.MODEL SMALL
.STACK 100H

.DATA
;--------------------------- Variables ---------------------------

; Prompt message
prompt DB 'Enter your first, middle, and last initials (e.g., ABC): $'
newline DB 0DH, 0AH, '$'

; Message to display initials
displayMessage DB 0DH, 0AH, 'Your initials are: $'

; Variables to store initials
initial1 DB ?, '$'
initial2 DB ?, '$'
initial3 DB ?, '$'

;------------------------------------------------------------------

.CODE
MAIN PROC
    ; -------------------- Data Segment Initialization --------------------
    MOV AX, @DATA
    MOV DS, AX

    ; -------------------- Prompt the user for input --------------------
    ; Display prompt message
    MOV AH, 9
    LEA DX, prompt
    INT 21H

    ; -------------------- Read First Initial --------------------
    MOV AH, 1                ; Input single character
    INT 21H
    MOV initial1, AL         ; Store first initial

    ; -------------------- Read Middle Initial --------------------
    MOV AH, 1
    INT 21H
    MOV initial2, AL         ; Store middle initial

    ; -------------------- Read Last Initial --------------------
    MOV AH, 1
    INT 21H
    MOV initial3, AL         ; Store last initial

    ; -------------------- Display the initials --------------------
    ; Display message
    MOV AH, 9
    LEA DX, displayMessage
    INT 21H

    ; Display first initial
    MOV AH, 2
    MOV DL, initial1
    INT 21H

    ; New line
    MOV AH, 9
    LEA DX, newline
    INT 21H

    ; Display middle initial
    MOV AH, 2
    MOV DL, initial2
    INT 21H

    ; New line
    MOV AH, 9
    LEA DX, newline
    INT 21H

    ; Display last initial
    MOV AH, 2
    MOV DL, initial3
    INT 21H

    ; -------------------- Exit the program --------------------
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
