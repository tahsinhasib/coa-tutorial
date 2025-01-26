
.MODEL SMALL
.STACK 100H

.DATA
prompt DB 0DH, 0AH, 'Enter a letter: $'
display DB 0DH, 0AH, 'You entered: $'
msg DB 0DH, 0AH, 'Not y or Y$'

.CODE
    MAIN PROC

        ; Initialize Data Segment
        MOV AX, @DATA
        MOV DS, AX

        MOV AH, 9               ; For displaying prompt
        LEA DX, prompt
        INT 21H

        MOV AH, 1               ; Wait for user input
        INT 21H
        MOV BL, AL

        CMP BL, 'y'
        JE THEN

        CMP BL, 'Y'
        JE THEN

        JMP ELSE

        THEN:
            MOV AH, 9               ; For displaying string
            LEA DX, display
            INT 21H

            MOV AH, 2               ; Display the character
            MOV DL, BL
            INT 21H
            JMP END_PROGRAM

        ELSE:
            MOV AH, 9               ; For displaying string
            LEA DX, msg
            INT 21H

        END_PROGRAM:
            MOV AH, 4CH             ; Exit the program
            INT 21H

    MAIN ENDP
END MAIN
