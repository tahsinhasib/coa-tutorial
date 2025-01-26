.MODEL SMALL
.STACK 100H   ; Set stack size to 256 bytes

.DATA         ; Start of data segment
msg DB 0DH,0AH, "UPPERCASE LETTER: $"  ; Message for uppercase letter
msgInvalid DB 0DH,0AH, "Not valid input!$" ; Message for invalid input

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Read a character from user
    MOV AH, 01H            ; Function to read a single character
    INT 21H                ; DOS interrupt to read character

    ; Check if character is uppercase ('A' <= character <= 'Z')
    CMP AL, 'A'            ; Compare character with 'A'
    JL NOT_VALID           ; If less than 'A', not valid
    CMP AL, 'Z'            ; Compare character with 'Z'
    JG NOT_VALID           ; If greater than 'Z', not valid

    ; Display message for uppercase letter
    LEA DX, msg
    MOV AH, 09H            ; Function to display string
    INT 21H

    ; Display the uppercase character
    MOV DL, AL             ; Load character into DL for display
    MOV AH, 2           ; Function to display single character
    INT 21H                ; Display the character
    JMP END_PROGRAM        ; End program

NOT_VALID:
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
