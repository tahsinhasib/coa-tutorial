.MODEL SMALL
.STACK 100H
.DATA
    INPUT  DB 'ENTER HEX NUMBER: $'
    OUTPUT DB 0AH,0DH, 'YOU HAVE ENTERED : $'
    BIN_MSG DB 0AH,0DH, 'BINARY REPRESENTATION : $'
    BITS   DB 16 DUP('$')  ; Storage for binary output
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; Display input prompt
    MOV AH, 9
    LEA DX, INPUT
    INT 21H
    
    XOR BX, BX         ; Clear BX to store result
    MOV CL, 4          ; Shift count for hexadecimal conversion
    MOV AH, 1          ; Function to read character
    
    ; Read user input
    FOR:    
        INT 21H
        CMP AL, 0DH    ; Check if Enter key is pressed
        JE PRINT
        CMP AL, 41H    ; Check if input is 'A'
        JGE LETTER
        AND AL, 0FH    ; Convert numeric hex input to binary
        JMP SHIFT
        
    LETTER:
        SUB AL, 37H    ; Convert 'A'-'F' to 10-15
        
    SHIFT:
        SHL BX, CL     ; Shift BX left by 4 bits
        OR BL, AL      ; Combine input digit with BX
        JMP FOR
    
    PRINT:
        ; Display output message
        MOV AH, 9
        LEA DX, OUTPUT
        INT 21H
        
        ; Display the entered hex value
        MOV CX, 4
        MOV AH, 2
        
    AGAIN:    
        MOV DL, BH
        SHR DL, 4
        ROL BX, 4
        CMP DL, 10
        JGE LETTEROUT
        
        ADD DL, 48
        INT 21H
        JMP EXIT
        
    LETTEROUT:
        ADD DL, 55
        INT 21H 
        
    EXIT:
        LOOP AGAIN
        
        ; Display binary representation message
        MOV AH, 9
        LEA DX, BIN_MSG
        INT 21H
        
        ; Convert BX to binary and store in BITS
        MOV CX, 16
        MOV SI, OFFSET BITS
        
    BIN_LOOP:
        SHL BX, 1              ; Shift BX left to get MSB
        MOV AL, '0'
        JNC SKIP
        MOV AL, '1'            ; Set '1' if carry is set
        
    SKIP:
        MOV [SI], AL           ; Store binary digit
        INC SI
        LOOP BIN_LOOP
        
        ; Null terminate BITS and display it
        MOV BYTE PTR [SI], '$' ; Add string terminator
        MOV AH, 9
        LEA DX, BITS
        INT 21H
    
    ; End program
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
