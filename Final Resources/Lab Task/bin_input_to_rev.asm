.DATA

INPUT DB 'ENTER BINAR INPUT: $'         ; Prompt message for binary input
OUTPUT DB 0AH,0DH, 'YOU  HAVE ENTERED: $' ; Message to display entered binary input
REVERSE DB 0AH,0DH, 'IN REVERSED ORDER: $' ; Message to display reversed binary input

.CODE 

INPUT1 proc
    MOV AX,@DATA                        ; Initialize data segment
    MOV DS,AX                           ; Move data segment address to DS
    
    MOV AH,9                            ; DOS function to display string
    LEA DX, INPUT                       ; Load address of INPUT message
    INT 21H                             ; Call DOS interrupt to display message
    
    XOR BX,BX                           ; Clear BX register
    MOV CX,16                           ; Set loop counter to 16 (for 16-bit binary input)
    
    WHILE_:
    MOV AH,1                            ; DOS function to read character
    INT 21H                             ; Call DOS interrupt to read character
    CMP AL,0DH                          ; Compare AL with carriage return (Enter key)
    JE ENDD                             ; If Enter key is pressed, jump to ENDD
    AND AL,0FH                          ; Mask upper nibble to get binary digit
    SHL BX,1                            ; Shift BX left by 1 bit
    OR BL,AL                            ; OR BX with AL to store binary digit
    LOOP WHILE_                         ; Loop until CX is 0
    ENDD: 
    ret                                 ; Return from procedure
endp

OUTPUT1 PROC 

    MOV AH,9                            ; DOS function to display string
    LEA DX, OUTPUT                      ; Load address of OUTPUT message
    INT 21H                             ; Call DOS interrupt to display message
    
    MOV CX,16                           ; Set loop counter to 16
    IF:
    ROL BX,1                            ; Rotate BX left by 1 bit
    JNC THEN                            ; If no carry, jump to THEN
    
    MOV AH,2                            ; DOS function to display character
    MOV DL,31H                          ; Load DL with ASCII '1'
    INT 21H                             ; Call DOS interrupt to display character
    JMP DISPLAY                         ; Jump to DISPLAY
    
    THEN:
    MOV AH,2                            ; DOS function to display character
    MOV DL,30H                          ; Load DL with ASCII '0'
    INT 21H                             ; Call DOS interrupt to display character
    JMP DISPLAY                         ; Jump to DISPLAY
    
    DISPLAY:
    LOOP IF                             ; Loop until CX is 0
    
    ret                                 ; Return from procedure
endp 

REVERSE1 PROC
    ;REVERSED
    MOV CX,16                           ; Set loop counter to 16
    
    MOV AH,9                            ; DOS function to display string
    LEA DX, REVERSE                     ; Load address of REVERSE message
    INT 21H                             ; Call DOS interrupt to display message
    
    MOV CX,16                           ; Set loop counter to 16
    IFF:
    ROR BX,1                            ; Rotate BX right by 1 bit
    JNC THENF                           ; If no carry, jump to THENF
    
    MOV AH,2                            ; DOS function to display character
    MOV DL,31H                          ; Load DL with ASCII '1'
    INT 21H                             ; Call DOS interrupt to display character
    JMP DISPLAYF                        ; Jump to DISPLAYF
    
    THENF:
    MOV AH,2                            ; DOS function to display character
    MOV DL,30H                          ; Load DL with ASCII '0'
    INT 21H                             ; Call DOS interrupt to display character
    JMP DISPLAYF                        ; Jump to DISPLAYF
    
    DISPLAYF:
    LOOP IFF                            ; Loop until CX is 0
    
    RET                                 ; Return from procedure
ENDP

MAIN PROC
    MOV AX,@DATA                        ; Initialize data segment
    MOV DS,AX                           ; Move data segment address to DS
    
    CALL INPUT1                         ; Call INPUT1 procedure to get binary input
    CALL OUTPUT1                        ; Call OUTPUT1 procedure to display entered binary input
    CALL REVERSE1                       ; Call REVERSE1 procedure to display reversed binary input
    
    MOV AH,4CH                          ; DOS function to terminate program
    INT 21H                             ; Call DOS interrupt to terminate program
MAIN ENDP
END MAIN                                ; End of program
