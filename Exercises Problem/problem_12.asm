.MODEL SMALL
.STACK 100H

.DATA
;--------------------------- Variables ---------------------------

; Top and bottom row of the box
topBottomRow DB '* * * * * * * * * * *', 0DH, 0AH

; Middle rows (empty except middle one)
emptyRow DB '*                 *', 0DH, 0AH
middleRow DB '*      ???       *', 0DH, 0AH

; Prompt message
prompt DB 0DH, 0AH, 'Enter three initials: $'

; Newline and beep
newline DB 0DH, 0AH, '$'
beep DB 7                ; ASCII for system beep

; Variables to store initials
initial1 DB ' ', '$'
initial2 DB ' ', '$'
initial3 DB ' ', '$'

;------------------------------------------------------------------

.CODE
MAIN PROC
    ; -------------------- Data Segment Initialization --------------------
    MOV AX, @DATA
    MOV DS, AX

    ; -------------------- Prompt the User --------------------
    MOV AH, 9
    LEA DX, prompt
    INT 21H

    ; Read first initial
    MOV AH, 1
    INT 21H
    MOV initial1, AL          ; Store first initial

    ; Read second initial
    MOV AH, 1
    INT 21H
    MOV initial2, AL          ; Store second initial

    ; Read third initial
    MOV AH, 1
    INT 21H
    MOV initial3, AL          ; Store third initial

    ; -------------------- Update Middle Row --------------------
    ; Replace "???" in middleRow with user initials
    MOV AL, initial1
    MOV middleRow[8], AL      ; Update first initial in middle row

    MOV AL, initial2
    MOV middleRow[9], AL      ; Update second initial in middle row

    MOV AL, initial3
    MOV middleRow[10], AL     ; Update third initial in middle row

    ; -------------------- Display the Box --------------------
    ; Display top row
    MOV AH, 9
    LEA DX, topBottomRow
    INT 21H

    ; Display 5 empty rows
    MOV CX, 5
DisplayEmptyRows:
    LEA DX, emptyRow
    MOV AH, 9
    INT 21H
    LOOP DisplayEmptyRows

    ; Display middle row with initials
    LEA DX, middleRow
    MOV AH, 9
    INT 21H

    ; Display 5 more empty rows
    MOV CX, 5
DisplayEmptyRows2:
    LEA DX, emptyRow
    MOV AH, 9
    INT 21H
    LOOP DisplayEmptyRows2

    ; Display bottom row
    LEA DX, topBottomRow
    MOV AH, 9
    INT 21H

    ; -------------------- Beep the Computer --------------------
    MOV AH, 2
    MOV DL, beep
    INT 21H

    ; -------------------- Exit the Program --------------------
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
