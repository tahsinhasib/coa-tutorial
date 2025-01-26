.MODEL SMALL
.STACK 100H   ; Set stack size to 256 bytes

.DATA         ; Start of data segment
msg DB 0DH,0AH, "Enter a single ASCII digit: $" ; Prompt for ASCII digit
msgResult DB 0DH,0AH, "The numeric value is: $" ; Message for numeric value
msgInvalid DB 0DH,0AH, "Not a valid ASCII digit!$" ; Message for invalid input

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Display prompt message
    LEA DX, msg
    MOV AH, 09H            ; Function to display string
    INT 21H

    ; Read a character from user
    MOV AH, 01H            ; Function to read a single character
    INT 21H                ; DOS interrupt to read character
    MOV BL, AL             ; Store the input character in BL

    ; Check if the character is a valid ASCII digit ('0' <= character <= '9')
    CMP BL, '0'            ; Compare with '0'
    JL INVALID_INPUT       ; If less than '0', not a valid digit
    CMP BL, '9'            ; Compare with '9'
    JG INVALID_INPUT       ; If greater than '9', not a valid digit

    ; Convert ASCII digit to numeric value
    SUB BL, '0'            ; Subtract ASCII value of '0' to get numeric value

    ; Display the result message
    LEA DX, msgResult
    MOV AH, 09H            ; Function to display string
    INT 21H

    ; Display the numeric value
    MOV DL, BL             ; Load numeric value into DL
    ADD DL, '0'            ; Convert back to ASCII for display
    MOV AH, 02H            ; Function to display single character
    INT 21H                ; Display the numeric value
    JMP END_PROGRAM        ; Exit program

INVALID_INPUT:
    ; Display invalid input message
    LEA DX, msgInvalid
    MOV AH, 09H            ; Function to display string
    INT 21H

END_PROGRAM:
    ; Exit program
    MOV AH, 4CH            ; Function to terminate program
    INT 21H

MAIN ENDP
END MAIN
