.MODEL SMALL
.STACK 100H

.DATA
;--------------------------- Variables ---------------------------

promptInput DB 'ENTER THREE DIGITS: $'
nameMessage DB 0DH, 0AH, 'YOUR NAME: MR. JOHN$', 0DH, 0AH
idMessage DB 0DH, 0AH, 'YOUR ID: 11-22222-', '$'
ageMessage DB 0DH, 0AH, 'YOUR AGE: 20$', 0DH, 0AH
newline DB 0DH, 0AH, '$'

; To store user input digits
digit1 DB '?'
digit2 DB '?'
digit3 DB '?'

;------------------------------------------------------------------

.CODE
MAIN PROC
    ; -------------------- Data Segment Initialization --------------------
    MOV AX, @DATA
    MOV DS, AX

    ; -------------------- Prompt for Input --------------------
InputDigits:
    MOV AH, 9                ; Display prompt
    LEA DX, promptInput
    INT 21H

    ; Read first digit
    MOV AH, 1                ; Input character
    INT 21H
    MOV digit1, AL           ; Store first digit
    

    ; Read second digit
    MOV AH, 1
    INT 21H
    MOV digit2, AL           ; Store second digit
   

    ; Read third digit
    MOV AH, 1
    INT 21H
    MOV digit3, AL           ; Store third digit
    

    ; -------------------- Display Information --------------------
    ; Display name
    MOV AH, 9
    LEA DX, nameMessage
    INT 21H

    ; Display ID
    MOV AH, 9
    LEA DX, idMessage
    INT 21H

    ; Display the entered digits
    MOV AH, 2
    MOV DL, digit1           ; Display first digit
    INT 21H

    MOV DL, digit2           ; Display second digit
    INT 21H

    MOV DL, digit3           ; Display third digit
    INT 21H

    ; Newline after ID
    MOV AH, 9
    LEA DX, newline
    INT 21H

    ; Display age
    MOV AH, 9
    LEA DX, ageMessage
    INT 21H

    ; -------------------- Exit the Program --------------------
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
