.MODEL SMALL
.STACK 100H   ; Set stack size to 256 bytes (100H in hexadecimal)

.DATA         ; Start of data segment

msg1 DB 0DH,0AH, "TYPE A CHARACTER: $" ; Message to prompt user for input, includes carriage return and line feed
msg2 DB 0DH,0AH, "THE ASCII CODE OF $" ; Message to display before the character
msg3 DB " IN BINARY IS "               ; Message to display before binary output
msg4 DB 0DH,0AH, "THE NUMBER OF 1 BITS IN THE ASCII CODE IS $" ; Message to display before the count of 1 bits

.CODE         ; Start of code segment

MAIN PROC     ; Main procedure starts

    ; Initialize data segment
    MOV AX, @DATA  ; Load address of data segment into AX
    MOV DS, AX     ; Move address from AX to DS to set up the data segment
    
    ; Display prompt message to user
    LEA DX, msg1   ; Load address of msg1 into DX
    MOV AH, 09H    ; Function to display string in DOS
    INT 21H        ; Call DOS interrupt to display msg1

    ; Read a character from user input
    MOV AH, 01H    ; Function to read a character from standard input
    INT 21H        ; Call DOS interrupt to get character in AL
    
    XOR BX, BX     ; Clear BX register (BX = 0)
    MOV BL, AL     ; Copy input character from AL to BL

    ; Display message for ASCII code output
    LEA DX, msg2   ; Load address of msg2 into DX
    MOV AH, 09H    ; Function to display string in DOS
    INT 21H        ; Call DOS interrupt to display msg2

    ; Display the ASCII character
    MOV DL, BL     ; Move character to DL for display
    MOV AH, 02H    ; Function to display a single character
    INT 21H        ; Call DOS interrupt to display the character

    ; Display message for binary output
    LEA DX, msg3   ; Load address of msg3 into DX
    MOV AH, 09H    ; Function to display string in DOS
    INT 21H        ; Call DOS interrupt to display msg3

    ; Initialize loop variables
    MOV CX, 8      ; Set loop counter to 8 (for 8 bits)
    MOV BH, 0      ; Clear BH to use as bit count

BINARY:             ; Start of loop to process each bit
    SHL BL, 1      ; Shift BL left by 1 bit (CF gets the leftmost bit)
    JNC ZERO       ; Jump to ZERO if CF = 0 (no carry means bit is 0)
    INC BH         ; Increment BH (count of 1 bits) if CF = 1
    MOV DL, 31H    ; Set DL to ASCII '1' for display
    JMP DISPLAY    ; Jump to DISPLAY to show the bit

ZERO:               ; Handle case where CF = 0
    MOV DL, 30H    ; Set DL to ASCII '0' for display

DISPLAY:            ; Display the current bit
    MOV AH, 02H    ; Function to display a single character
    INT 21H        ; Call DOS interrupt to display the bit
    
    LOOP BINARY     ; Decrement CX and repeat loop until CX = 0

    ; Convert bit count to ASCII and display it
    ADD BH, 30H    ; Convert bit count in BH to ASCII by adding 30H ('0')

    ; Display message for 1-bit count
    LEA DX, msg4   ; Load address of msg4 into DX
    MOV AH, 09H    ; Function to display string in DOS
    INT 21H        ; Call DOS interrupt to display msg4
    
    ; Display the number of 1 bits
    MOV DL, BH     ; Move bit count (now ASCII) to DL for display
    MOV AH, 02H    ; Function to display a single character
    INT 21H        ; Call DOS interrupt to display the bit count

MAIN ENDP           ; End of main procedure
END MAIN            ; End of program
