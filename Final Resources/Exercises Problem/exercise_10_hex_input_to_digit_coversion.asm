.MODEL SMALL
.STACK 100H

.DATA
    PROMPT1  DB 0DH, 0AH, 'ENTER A HEX DIGIT: $'
    PROMPT2  DB 0DH, 0AH, 'IN DECIMAL IT IS $'
    PROMPT3  DB 0DH, 0AH, 'DO YOU WANT TO DO IT AGAIN? $'
    ILLEGAL  DB 0DH, 0AH, 'ILLEGAL CHARACTER - ENTER 0 .. 9 OR A .. F: $'
    NEWLINE  DB 0DH, 0AH, '$'

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX

    REPEAT_LOOP:
        ; Display "ENTER A HEX DIGIT:"
        LEA DX, PROMPT1
        MOV AH, 09H
        INT 21H

        ; Read user input
        MOV AH, 01H
        INT 21H
        MOV BL, AL           ; Store hex digit in BL

        ; Check if input is valid (0-9 or A-F or a-f)
        CMP BL, '0'
        JB INVALID_INPUT      ; If less than '0', invalid input
        CMP BL, '9'
        JBE VALID_INPUT       ; If between '0' and '9', valid input

        CMP BL, 'A'
        JB INVALID_INPUT      ; If less than 'A', invalid input
        CMP BL, 'F'
        JBE VALID_INPUT       ; If between 'A' and 'F', valid input

        CMP BL, 'a'
        JB INVALID_INPUT      ; If less than 'a', invalid input
        CMP BL, 'f'
        JBE INVALID_INPUT       ; If between 'a' and 'f', invalid input

    INVALID_INPUT:
        ; Display illegal character message
        LEA DX, ILLEGAL
        MOV AH, 09H
        INT 21H
        JMP REPEAT_LOOP       ; Prompt again

    VALID_INPUT:
        ; Convert hex to decimal
        CMP BL, '9'
        JBE DIGIT_TO_DEC      ; If BL <= '9', convert directly
        CMP BL, 'F'
        JBE HEX_TO_DEC        ; If BL <= 'F', convert to decimal
        
        
        

    DIGIT_TO_DEC:
        SUB BL, '0'           ; Convert '0'-'9' directly to decimal

        MOV AH, 9H
        LEA DX, PROMPT2         ; Display "IN DECIMAL IT IS"
        INT 21H
        
        ; Display the decimal value in BL
        MOV DL, BL            ; Move decimal result to DL
        ADD DL, '0'           ; Convert to ASCII
        MOV AH, 02H
        INT 21H

        ; Display newline
        LEA DX, NEWLINE
        MOV AH, 09H
        INT 21H

        JMP ASK_REPEAT
        
    HEX_TO_DEC:
        MOV AH, 9H
        LEA DX, PROMPT2         ; Display "IN DECIMAL IT IS"
        INT 21H

        MOV AH, 2             ; FROM A TO F 1 IS ALWAYS CONSTANT
        MOV DL, 031H
        INT 21H
        
        SUB BL, 17              ; Substract 17 for conversion between A - F
        MOV AH, 2
        MOV DL, BL
        INT 21H
    
        ; Display newline
        LEA DX, NEWLINE
        MOV AH, 09H
        INT 21H
    
        JMP ASK_REPEAT
    
    ASK_REPEAT:
        ; Ask user if they want to repeat
        LEA DX, PROMPT3
        MOV AH, 09H
        INT 21H

        ; Read user's response
        MOV AH, 01H
        INT 21H
        CMP AL, 'y'
        JE REPEAT_LOOP
        CMP AL, 'Y'
        JE REPEAT_LOOP

        ; Terminate program
        MOV AH, 4CH
        INT 21H

    MAIN ENDP
END MAIN
