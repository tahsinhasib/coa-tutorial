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
    
    XOR BX, BX     ; Clear BX register (BX = 0)
    MOV BL, AL     ; Copy input character from AL to BL

READ_DIGIT:
    MOV AH, 01H       ; Function to read a character
    INT 21H           ; DOS interrupt to read character

    CMP AL, 0DH       ; Check if Enter is pressed
    JE CONVERT        ; Jump to conversion if Enter is pressed

    


CONVERT:

    ; Display message for ASCII code output
    LEA DX, msg2   ; Load address of msg2 into DX
    MOV AH, 09H    ; Function to display string in DOS
    INT 21H        ; Call DOS interrupt to display msg2
    
    

    ; Display message for binary output
    LEA DX, msg3   ; Load address of msg3 into DX
    MOV AH, 09H    ; Function to display string in DOS
    INT 21H        ; Call DOS interrupt to display msg3

    ; Initialize loop variables
    MOV CX, 16      ; Set loop counter to 8 (for 8 bits)
    MOV BH, 0      ; Clear BH to use as bit count

    BINARY:             ; Start of loop to process each bit
    SHL BL, 1      ; Shift BL left by 1 bit (CF gets the leftmost bit)
    JNC ZERO       ; Jump to ZERO if CF = 0 (no carry means bit is 0)
    INC BH         ; Increment BH (count of 1 bits) if CF = 1
    MOV DL, 31H    ; Set DL to ASCII '1' for display
    JMP DISPLAY    ; Jump to DISPLAY to show the bit

    ZERO:               ; Handle case where CF = 0
        MOV DL, 30H    ; Set DL to ASCII '0' for display

        MOV CX, 16        ; Binary output is 16 bits
        XOR DX, DX        ; Clear DX for storing each bit

    PRINT_BINARY:
        SHL BX, 1         ; Shift left to bring MSB into CF
        JC PRINT_ONE      ; Jump to PRINT_ONE if carry flag is set
        MOV DL, '0'       ; Move '0' to DL
        JMP DISPLAY       ; Jump to DISPLAY



MAIN ENDP             ; End of main procedure
END MAIN              ; End of program