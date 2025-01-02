.MODEL SMALL
.STACK 100H

.DATA
star DB '*'
newline DB 0DH, 0AH, '$'

.CODE
    MAIN PROC

        ; Initialize Data Segment
        MOV AX, @DATA
        MOV DS, AX

        ; Initialize counter (CX) to 80
        MOV CX, 80

    DISPLAY_LOOP:
        ; Display '*'
        MOV AH, 2            ; Function to display a character
        MOV DL, star         ; Load '*' into DL
        INT 21H              ; Display the character

        LOOP DISPLAY_LOOP    ; Decrement CX and jump if not zero

        ; Print a newline at the end
        MOV AH, 9            ; Function to display string
        LEA DX, newline      ; Load newline address
        INT 21H              ; Print the newline

        ; Exit the program
        MOV AH, 4CH          ; Exit function
        INT 21H

    MAIN ENDP
END MAIN
