.MODEL SMALL
.STACK 100H   ; Set stack size to 256 bytes

.DATA         ; Start of data segment
msg1 DB 0DH,0AH, "FIRST CHARACTER: $"
msg2 DB 0DH,0AH, "SECOND CHARACTER: $"
msgResult DB 0DH,0AH, "CHARACTER THAT COMES FIRST: $"

.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Load two example characters into AL and BL
    MOV AL, 0C1H   ; Example: Extended ASCII character 'Á' 
    MOV BL, 0B2H   ; Example: Extended ASCII character '²'
    
    ; Compare AL and BL
    CMP AL, BL
    JL AL_COMES_FIRST    ; If AL < BL, jump to display AL
    JE EQUAL_CHARACTERS  ; If AL == BL, they are equal

BL_COMES_FIRST:
    ; Display BL
    LEA DX, msg2
    MOV AH, 09H
    INT 21H
    MOV DL, BL           ; Load BL into DL for display
    MOV AH, 02H          ; Function to display character
    INT 21H
    JMP END_PROGRAM      ; Exit program

AL_COMES_FIRST:
    ; Display AL
    LEA DX, msg1
    MOV AH, 09H
    INT 21H
    MOV DL, AL           ; Load AL into DL for display
    MOV AH, 02H          ; Function to display character
    INT 21H
    JMP END_PROGRAM      ; Exit program

EQUAL_CHARACTERS:
    ; Display equality message
    LEA DX, msgResult
    MOV AH, 09H
    INT 21H
    MOV DL, AL           ; Display either AL or BL as they are equal
    MOV AH, 02H
    INT 21H
    JMP END_PROGRAM      ; Exit program

END_PROGRAM:
    ; Exit program
    MOV AH, 4CH          ; Function to terminate program
    INT 21H

MAIN ENDP
END MAIN
