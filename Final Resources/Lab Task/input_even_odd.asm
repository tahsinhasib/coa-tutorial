.MODEL SMALL           ; Define the memory model as small

.STACK 100H            ; Define the stack size

.DATA                  ; Start of data segment

    msg1 DB 'Enter a number:', '$'  ; Message to prompt user for input
    msg2 DB 'The number is even.', '$'  ; Message to display if number is even
    msg3 DB 'The number is odd.', '$'   ; Message to display if number is odd
    input DB ?          ; Variable to store user input

.CODE                  ; Start of code segment
    MAIN PROC          ; Start of main procedure
        MOV AX, @DATA  ; Initialize data segment
        MOV DS, AX

        ; Display message asking for input
        MOV AH, 09H    ; Function to display string
        LEA DX, msg1   ; Load address of msg1 into DX
        INT 21H        ; DOS interrupt to display string

        ; Read input character
        MOV AH, 01H    ; Function to read character from standard input
        INT 21H        ; DOS interrupt to read character
        MOV BL, AL     ; Store input character in BL


        ; Check if input character is a number
        MOV AH, 00H    ; Clear AH
        MOV AL, BL     ; Move input character to AL
        AND AL, 0FH    ; Mask upper 4 bits to get the number
        CMP AL, 9      ; Compare with 9
        JA not_number  ; Jump if input is not a number
        
        ; Check if the number is odd or even
        TEST BL, 01H   ; Test if the least significant bit is set
        JZ even_number ; Jump if the number is even
        
        ; Display message for odd number
        MOV AH, 09H    ; Function to display string
        LEA DX, msg3   ; Load address of msg3 into DX
        INT 21H        ; DOS interrupt to display string
        JMP exit_program  ; Jump to exit program
        
        even_number:
        ; Display message for even number
        MOV AH, 09H    ; Function to display string
        LEA DX, msg2   ; Load address of msg2 into DX
        INT 21H        ; DOS interrupt to display string
        JMP exit_program  ; Jump to exit program
        
        not_number:
        ; Display error message for non-numeric input
        MOV AH, 09H    ; Function to display string
        LEA DX, msg1   ; Load address of msg1 into DX
        INT 21H        ; DOS interrupt to display string
        
        exit_program:
        MOV AH, 4CH     ; Function to terminate program
        INT 21H         ; DOS interrupt to terminate program
    MAIN ENDP           ; End of main procedure

END MAIN               ; End of program