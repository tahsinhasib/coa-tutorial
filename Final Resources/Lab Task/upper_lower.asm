;Write a program to display a prompt message asking the user to enter a character. 
;The program should then read the input character and check if it is a letter. 
;If the input character is a letter, the program should convert it to uppercase 
;if it is in lowercase, or convert it to lowercase if it is in uppercase. 
;The program should then display the converted character. If the input character is not a letter, 
;the program should display an error message. The program should then exit. Use the provided 
;variables and messages. Do not forget to include the necessary code to define the variables and messages.

.model small
.stack 100h

.data
    prompt db 0dh, 0ah, "Enter a character: $"
    msg_upper db 0dh, 0ah, "Converted to uppercase: $"
    msg_lower db 0dh, 0ah, "Converted to lowercase: $"
    msg_not_letter db 0dh, 0ah, "Input is not a letter! $"
    input_char db ?

.code
    main proc
        
        mov ax, @data
        mov ds, ax
        
        ;print prompt
        mov ah, 9
        lea dx, prompt
        int 21h
        
        ;read input character
        mov ah, 1
        int 21h
        mov bl, al; save input character
        
        ;check if input is a letter
        cmp bl, 'A'
        jb not_letter
        cmp bl, 'Z'
        jbe upper_case
        cmp bl, 'a'
        jb not_letter
        cmp bl, 'z'
        ja not_letter
        

        lower_case:
            ;convert to upper case
            and bl, 11011111b
            ;print result
            mov ah, 9
            lea dx, msg_upper
            int 21h
            mov ah, 2
            mov dl, bl
            int 21h
            
            jmp exit_program
        
        upper_case:
            ;convert to lower case
            or bl, 00100000b
            ;print result
            mov ah, 9
            lea dx, msg_lower
            int 21h
            mov ah, 2
            mov dl, bl
            int 21h
            
            jmp exit_program

        not_letter:
            ;print error message
            mov ah, 9
            lea dx, msg_not_letter
            int 21h
        
        exit_program:
            ;exit program
            mov ah, 4ch
            int 21h
        
    main endp
end main
