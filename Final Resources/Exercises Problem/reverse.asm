.MODEL SMALL
.STACK 100H   ; Set stack size to 256 bytes

.DATA         ; Start of data segment
msg DB 0DH,0AH, "Resulting value in BL: $" ; Message to display result

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Load AL with 11011100 (binary)
    MOV AL, 11011100B
    XOR BL, BL              ; Clear BL to store the result

    MOV CL, 8               ; Set loop counter for 8 bits
SHIFT_LOOP:
    SHL AL, 1               ; Shift left AL, moving MSB into CF
    RCR BL, 1               ; Rotate right BL, moving CF into LSB of BL
    LOOP SHIFT_LOOP         ; Repeat for 8 bits
    ;MOV AL, BL
    ; Display the result message
    LEA DX, msg
    MOV AH, 09H             ; Function to display string
    INT 21H

    ; Display the resulting value in BL
    MOV DL, BL              ; Move BL value to DL
    MOV AH, 02H             ; Function to display single character
    INT 21H

    ; Exit program
    MOV AH, 4CH             ; Function to terminate program
    INT 21H

MAIN ENDP
END MAIN
