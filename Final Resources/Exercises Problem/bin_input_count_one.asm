.DATA
    INPUT DB 'ENTER BINAR INPUT: $'    ; Define input prompt string
    OUTPUT DB 0AH,0DH, 'YOU  HAVE ENTERED: $' ; Define output prompt string with new line and carriage return
    displaycount DB 0AH,0DH, 'NUMBER OF 1s: $'
    count DB 0
.CODE 

INPUT1 proc
    MOV AX,@DATA    ; Load data segment address into AX
    MOV DS,AX       ; Move data segment address from AX to DS
             
    MOV AH,9        ; Set function number for displaying string
    LEA DX, INPUT   ; Load effective address of INPUT string into DX
    INT 21H         ; Call DOS interrupt to display string
    ret             ; Return from procedure
endp
 
MAIN PROC
    MOV AX,@DATA    ; Load data segment address into AX
    MOV DS,AX       ; Move data segment address from AX to DS
             
    call INPUT1     ; Call INPUT1 procedure to display input prompt
    
    XOR BX,BX       ; Clear BX register (set to 0)
    MOV CX,16       ; Set loop counter to 16 (for 16-bit binary input)
     
WHILE_:
    MOV AH,1        ; Set function number for reading a character from input
    INT 21H         ; Call DOS interrupt to read character
    CMP AL,0DH      ; Compare input character with carriage return (Enter key)
    JE FOR          ; If Enter key is pressed, jump to FOR label

    AND AL,0FH      ; Mask upper nibble of AL to get binary digit
    SHL BX,1        ; Shift BX left by 1 bit
    OR BL,AL        ; OR BX with AL to add binary digit to BX
    
    LOOP WHILE_     ; Loop until CX is 0
     
FOR:
    MOV AH,9        ; Set function number for displaying string
    LEA DX, OUTPUT  ; Load effective address of OUTPUT string into DX
    INT 21H         ; Call DOS interrupt to display string
    
    MOV CX,16       ; Set loop counter to 16 (for 16-bit binary output)
    MOV count,0
IF:
    SHL BX,1        ; Shift BX left by 1 bit
    JNC THEN        ; If no carry, jump to THEN label
    
    INC count
    MOV AH,2        ; Set function number for displaying character
    MOV DL,31H      ; Load '1' character into DL
    INT 21H         ; Call DOS interrupt to display character
    JMP DISPLAY     ; Jump to DISPLAY label
    
THEN:
    MOV AH,2        ; Set function number for displaying character
    MOV DL,30H      ; Load '0' character into DL
    INT 21H         ; Call DOS interrupt to display character
    JMP DISPLAY     ; Jump to DISPLAY label
    
DISPLAY:
    LOOP IF         ; Loop until CX is 0
    
    MOV AH,9        ; Set function number for displaying string
    LEA DX, displaycount  ; Load effective address of OUTPUT string into DX
    INT 21H         ; Call DOS interrupt to display string
    ADD count,30H
    MOV AH,2        ; Set function number for displaying character
    MOV DL,count
    INT 21H         ; Call DOS interrupt to display character
END_WHILE_:
    
    MOV AH,4CH      ; Set function number for program termination
    INT 21H         ; Call DOS interrupt to terminate program
MAIN ENDP
END MAIN            ; End of program
