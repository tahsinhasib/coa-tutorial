.MODEL SMALL
.STACK 100H   

.DATA                                           ; Start of data segment
msg DB 0DH,0AH, "UPPERCASE LETTER: $"           ; Message for uppercase letter
msgInvalid DB 0DH,0AH, "Not valid input!$"      ; Message for invalid input
countMsg DB 0DH,0AH, "Number of characters: $"  ; Message for character count

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Initialize counter
    MOV CX, 0              ; Counter for number of characters

READ_LOOP:
    ; Read a character from user
    MOV AH, 01H            ; Function to read a single character
    INT 21H                ; DOS interrupt to read character
    CMP AL, 0DH            ; Check if character is carriage return (Enter key)
    JE DISPLAY_COUNT       ; If Enter, jump to display count
    INC CX                 ; Increment counter
    JMP READ_LOOP          ; Repeat reading loop

DISPLAY_COUNT:
    ; Display the message for character count
    LEA DX, countMsg
    MOV AH, 09H            ; Function to display string
    INT 21H

    ; Convert and display the counter value
    MOV AX, CX             ; Move counter to AX
    ADD AX, '0'            ; Convert to ASCII
    MOV DL, AL             ; Move ASCII value to DL for display
    MOV AH, 02H            ; Function to display a single character
    INT 21H                ; Display the character

    ; Exit program
    MOV AH, 4CH            ; Function to terminate program
    INT 21H

MAIN ENDP
END MAIN
MAIN
