.MODEL SMALL
.STACK 100H
.DATA
INPUT DB 'ENTER HEX NUMBER: $'
OUTPUT DB 0AH,0DH, 'YOU HAVE ENTERED : $'
BINARY_OUTPUT DB 0AH,0DH, 'BINARY RESULT: $'
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    ; Display input prompt
    MOV AH,9
    LEA DX,INPUT
    INT 21H
    
    ; Read user input (hex digit)
    XOR BX,BX          ; Clear BX to store result
    MOV AH,1
    INT 21H            ; Read character into AL
    
    CMP AL, 41H        ; Check if character is 'A'
    JE SHOW_BINARY_10  ; Jump to show binary result for 'A'
    
    CMP AL, 30H        ; Check if character is '0'
    JL INVALID_INPUT   ; Invalid if less than '0'
    CMP AL, 39H        ; Check if character is '9'
    JLE HEX_DIGIT      ; If valid hex digit, process it
    
    CMP AL, 41H        ; Check if character is 'A'
    JL INVALID_INPUT   ; Invalid if less than 'A'
    CMP AL, 46H        ; Check if character is 'F'
    JG INVALID_INPUT   ; Invalid if greater than 'F'
    
HEX_DIGIT:
    CMP AL, 41H        ; Check if it's a letter A-F
    JGE LETTER
    AND AL, 0FH        ; Convert '0'-'9' to numeric value
    JMP SHIFT
    
LETTER:
    SUB AL, 37H        ; Convert 'A'-'F' to numeric value
    
SHIFT:
    SHL BX, 4          ; Shift BX left by 4 bits
    OR BL, AL          ; OR AL with BX to store digit
    
    ; Print output
    MOV AH,9
    LEA DX,OUTPUT
    INT 21H
    MOV DL,AL
    ADD DL,48
    MOV AH,2
    INT 21H
    JMP EXIT

SHOW_BINARY_10:
    ; Display binary result for 10 ('A')
    MOV AH,9
    LEA DX,BINARY_OUTPUT
    INT 21H
    
    MOV CX,16          ; 16 bits to display
    MOV BX,10          ; Binary value of 10
    
PRINT_BINARY:
    ROL BX, 1          ; Rotate BX left to get MSB in carry
    MOV DL, '0'        ; Assume bit is 0
    JC SET_ONE         ; If carry is set, bit is 1
    INT 21H
    LOOP PRINT_BINARY
    JMP EXIT
    
SET_ONE:
    MOV DL, '1'
    INT 21H
    LOOP PRINT_BINARY

INVALID_INPUT:
    MOV AH,9
    LEA DX, BINARY_OUTPUT
    DB 0AH,0DH,'INVALID INPUT! $'
    INT 21H

EXIT:
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
