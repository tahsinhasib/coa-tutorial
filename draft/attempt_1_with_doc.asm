.MODEL SMALL              ; Define small memory model
.STACK 100H               ; Set stack size to 100H
.DATA
    INPUT  DB 'ENTER HEX NUMBER: $'   ; Prompt message for user to enter hex number
    OUTPUT DB 0AH,0DH, 'YOU HAVE ENTERED : $'   ; Message to display entered value
    BIN_MSG DB 0AH,0DH, 'BINARY REPRESENTATION : $' ; Message to display binary representation
    BITS   DB 16 DUP('$')  ; Storage for binary output (16 bytes for binary representation)

.CODE
MAIN PROC
    MOV AX, @DATA          ; Load data segment address into AX
    MOV DS, AX             ; Move AX value to DS to set the data segment
    
    ; Display input prompt
    MOV AH, 9              ; DOS function 9 (display string)
    LEA DX, INPUT          ; Load address of INPUT message into DX
    INT 21H                ; Call interrupt to display the message
    
    XOR BX, BX             ; Clear BX register to store the result
    MOV CL, 4              ; Set shift count for hexadecimal conversion (4 bits per hex digit)
    MOV AH, 1              ; DOS function 1 (read character from input)
    
    ; Read user input
    FOR:
        INT 21H            ; Call interrupt to read a character from input
        CMP AL, 0DH        ; Compare the entered character with carriage return (Enter key)
        JE PRINT            ; If Enter key is pressed, jump to PRINT
        CMP AL, 41H        ; Compare the entered character with ASCII value of 'A'
        JGE LETTER          ; If input >= 'A', jump to LETTER for alphabet conversion
        AND AL, 0FH         ; Convert numeric hex input (0-9) to binary by ANDing with 0FH
        JMP SHIFT           ; Jump to SHIFT for shifting and combining digits
        
    LETTER:
        SUB AL, 37H         ; Convert 'A'-'F' to values 10-15 by subtracting 37H (ASCII offset)
        
    SHIFT:
        SHL BX, CL          ; Shift BX left by 4 bits to make room for the next hex digit
        OR BL, AL           ; Combine the lower nibble (AL) with BL in BX register
        JMP FOR             ; Loop back to read the next character
    
    PRINT:
        ; Display output message
        MOV AH, 9           ; DOS function 9 (display string)
        LEA DX, OUTPUT      ; Load address of OUTPUT message into DX
        INT 21H             ; Call interrupt to display the message
        
        ; Display the entered hex value
        MOV CX, 4           ; Set the counter to 4 (for 4 hex digits)
        MOV AH, 2           ; DOS function 2 (display character)
        
    AGAIN:    
        MOV DL, BH          ; Move the high byte of BX into DL for processing
        SHR DL, 4           ; Shift DL by 4 bits to get the most significant hex digit
        ROL BX, 4           ; Rotate the BX register to the left to prepare for the next digit
        CMP DL, 10          ; Compare the value of DL with 10 (check if it's a numeric value)
        JGE LETTEROUT       ; If DL >= 10, jump to LETTEROUT for letter conversion
        
        ADD DL, 48          ; Convert numeric value (0-9) to ASCII by adding 48
        INT 21H             ; Call interrupt to display the character
        JMP EXIT            ; Jump to EXIT after printing the character
        
    LETTEROUT:
        ADD DL, 55          ; Convert value 10-15 to 'A'-'F' by adding 55 to DL
        INT 21H             ; Call interrupt to display the character
        
    EXIT:
        LOOP AGAIN           ; Loop to print the remaining hex digits (loop counter CX decrements)
        
        ; Display binary representation message
        MOV AH, 9           ; DOS function 9 (display string)
        LEA DX, BIN_MSG     ; Load address of BIN_MSG into DX
        INT 21H             ; Call interrupt to display the message
        
        ; Convert BX to binary and store in BITS
        MOV CX, 16          ; Set the counter to 16 (for 16 bits of binary)
        MOV SI, OFFSET BITS ; Load address of BITS array into SI
        
    BIN_LOOP:
        SHL BX, 1           ; Shift BX left by 1 to move the MSB into carry flag
        MOV AL, '0'         ; Set AL to '0' (default binary value)
        JNC SKIP            ; If carry is not set, jump to SKIP (stay '0')
        MOV AL, '1'         ; If carry is set, change AL to '1'
        
    SKIP:
        MOV [SI], AL        ; Store the binary digit (either '0' or '1') at the current SI location
        INC SI              ; Increment SI to point to the next position in BITS
        LOOP BIN_LOOP       ; Loop until all 16 bits are processed
        
        ; Null terminate BITS and display it
        MOV BYTE PTR [SI], '$' ; Add string terminator ('$') to BITS
        MOV AH, 9           ; DOS function 9 (display string)
        LEA DX, BITS        ; Load address of BITS into DX
        INT 21H             ; Call interrupt to display the binary string
    
    ; End program
    MOV AH, 4CH           ; DOS function 4C (terminate program)
    INT 21H               ; Call interrupt to terminate the program
MAIN ENDP
END MAIN
