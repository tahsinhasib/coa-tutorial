.MODEL SMALL          ; Define the memory model as small
.STACK 100H           ; Define the stack size

.DATA                 ; Start of data segment

MSG1 DB 0DH,0AH, "ENTER A HEX NUMBER (1 TO 4 DIGITS): $"  ; Message to prompt user for input
MSG2 DB 0DH,0AH, "THE BINARY EQUIVALENT IS: $"           ; Message to display binary equivalent
MSG3 DB 0DH,0AH, "INVALID HEX NUMBER!$"                  ; Message for invalid input

.CODE                 ; Start of code segment

MAIN PROC             ; Main procedure
    MOV AX, @DATA     ; Initialize data segment
    MOV DS, AX        ; Move data segment address to DS

INPUT:
    ; PROMPT USER FOR INPUT
    MOV AH, 09H       ; Function to display string
    LEA DX, MSG1      ; Load address of MSG1 into DX
    INT 21H           ; DOS interrupt to display string

    ; INITIALIZE REGISTERS
    ;XOR BX, BX       ; Clear BX (to store binary result)
    MOV CX, 2         ; Maximum of 4 hex digits (2 bytes)

READ_DIGIT:
    MOV AH, 01H       ; Function to read a character
    INT 21H           ; DOS interrupt to read character

    CMP AL, 0DH       ; Check if Enter is pressed
    JE CONVERT        ; Jump to conversion if Enter is pressed

    ; VALIDATE THE INPUT CHARACTER
    CMP AL, '0'       ; Compare with '0'
    JB INVALID        ; Jump to INVALID if below '0'
    CMP AL, '9'       ; Compare with '9'
    JBE VALID_DIGIT   ; Jump to VALID_DIGIT if between '0' and '9'
    CMP AL, 'A'       ; Compare with 'A'
    JB INVALID        ; Jump to INVALID if below 'A'
    CMP AL, 'F'       ; Compare with 'F'
    JBE VALID_DIGIT   ; Jump to VALID_DIGIT if between 'A' and 'F'
    CMP AL, 'a'       ; Compare with 'a'
    JB INVALID        ; Jump to INVALID if below 'a'
    CMP AL, 'f'       ; Compare with 'f'
    JA INVALID        ; Jump to INVALID if above 'f'

VALID_LETTER:
    ; CONVERT LOWERCASE LETTERS TO UPPERCASE
    SUB AL, 20H       ; Convert 'a'-'f' to 'A'-'F'

VALID_DIGIT:
    ; CONVERT HEX DIGIT TO NUMERIC VALUE
    CMP AL, '9'       ; Compare with '9'
    JBE STORE_NUMERIC ; Jump to STORE_NUMERIC if between '0' and '9'
    SUB AL, 'A' - 10  ; Convert 'A'-'F' to 10-15
    JMP STORE_VALUE   ; Jump to STORE_VALUE

STORE_NUMERIC:
    SUB AL, '0'       ; Convert '0'-'9' to 0-9

STORE_VALUE:
    SHL BX, 4         ; Shift existing value left by 4 bits
    OR BL, AL         ; Add new digit to BX

    LOOP READ_DIGIT   ; Loop to read next digit

CONVERT:
    ; OUTPUT BINARY RESULT
    MOV AH, 09H       ; Function to display string
    LEA DX, MSG2      ; Load address of MSG2 into DX
    INT 21H           ; DOS interrupt to display string

    MOV CX, 16        ; Binary output is 16 bits
    XOR DX, DX        ; Clear DX for storing each bit

PRINT_BINARY:
    SHL BX, 1         ; Shift left to bring MSB into CF
    JC PRINT_ONE      ; Jump to PRINT_ONE if carry flag is set
    MOV DL, '0'       ; Move '0' to DL
    JMP DISPLAY       ; Jump to DISPLAY

PRINT_ONE:
    MOV DL, '1'       ; Move '1' to DL

DISPLAY:
    MOV AH, 02H       ; Function to display character
    INT 21H           ; DOS interrupt to display character
    LOOP PRINT_BINARY ; Loop to print next bit

EXIT:
    MOV AH, 4CH       ; Function to terminate program
    INT 21H           ; DOS interrupt to terminate program

INVALID:
    MOV AH, 09H       ; Function to display string
    LEA DX, MSG3      ; Load address of MSG3 into DX
    INT 21H           ; DOS interrupt to display string
    JMP EXIT          ; Jump to EXIT

MAIN ENDP             ; End of main procedure
END MAIN              ; End of program