.MODEL SMALL                ; Define the memory model as small
.STACK 100H                 ; Define the stack size

.DATA                       ; Start of data segment

.CODE                       ; Start of code segment

MAIN PROC                   ; Start of main procedure
    MOV CX, 127             ; Initialize CX with the starting ASCII value (127)
    MOV BL, 0               ; Initialize BL to 0 (used for counting characters per line)
    
PRINT:
    MOV AH, 2               ; Set AH to 2 (DOS function to display character)
    INC CX                  ; Increment CX to get the next ASCII character
    CMP CX, 255             ; Compare CX with 255 (end of ASCII table)
    JA EXIT                 ; If CX > 255, jump to EXIT
    MOV DX, CX              ; Move the current ASCII value to DX
    INT 21H                 ; Call DOS interrupt to print the character
    MOV DX, 32D             ; Move ASCII value of space (32) to DX
    INT 21H                 ; Call DOS interrupt to print the space
    
    JMP GO                  ; Jump to GO label
    
GO:
    INC BL                  ; Increment BL (character count per line)
    CMP BL, 10              ; Compare BL with 10 (10 characters per line)
    JE NL                   ; If BL == 10, jump to NL (new line)
    JMP PRINT               ; Otherwise, jump back to PRINT
    
NL:
    MOV AH, 2               ; Set AH to 2 (DOS function to display character)
    MOV DL, 0DH             ; Move carriage return (CR) to DL
    INT 21H                 ; Call DOS interrupt to print CR
    MOV DL, 0AH             ; Move line feed (LF) to DL
    INT 21H                 ; Call DOS interrupt to print LF
    
    MOV BL, 0               ; Reset BL to 0 (start new line)
    JMP PRINT               ; Jump back to PRINT
    
EXIT:
    ; End of program (no operation here, just a label for exit)
