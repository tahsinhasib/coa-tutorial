.MODEL SMALL
.STACK 100H

.DATA
;-------------------------------------Variables are here

; messgae with initialization
msg DB 'Hello, world!$';

; new line before message
msg1 DB 0DH, 0AH, 'This text comes in new line$';

; new line with no text
newline DB 0DH, 0AH, '$';

; new line with text
newlinewithtext DB 0DH, 0AH, 'comes after two new line$';

; prompt message
inputmessage DB 0DH, 0AH, 'Input here: $';
displayinput DB 0DH, 0AH, 'Your input: $';

; variables with no initialization
var1 DB ?, '$';
var2 DB ?, '$';
;-------------------------------------------------------

.CODE
    MAIN PROC
        
        ; ----------------------------This part is mandatory when printing message
        ; Initialize Data Segment           
        MOV AX, @DATA;
        MOV DS, AX;
        ;-------------------------------------------------------------------------
          
          
          
          
          
          
          
        
        ; PRINTING A CHARACTER          AL DL 2 required
        MOV AH, 2;                      (mandatory) set function to 2 (Display character)
        MOV DL, 'A';                    load ASCII code of 'A' into DL
        INT 21H;
               
               
        
        ; MANUAL NEW LINE               
        MOV AH, 2;                      display character function
        MOV DL, 0DH;                    carriage return
        INT 21H;                        execute
        MOV DL, 0AH;                    line feed
        INT 21H;                        execute
        
        
       
        ; PRINTING A STRING             AH DX 9 required
        MOV AH, 9;                      (mandatory) set function to 9 (Display string)
        LEA DX, msg;                    load address of the string into DX (MESSAGE)
        INT 21H;                        (mandatiry) Trigger DOS interrupt to print the string (PRINT)
        
        

        

        ; NEW LINE WITH MESSAGE
        MOV AH, 9;
        LEA DX, msg1;
        INT 21H;
        
          
        ;---NOTE------------------------- NEW LINE WITH MESSAGE (AH sequence doesn't matter)
        ;LEA DX, msg1
        ;MOV AH, 9
        ;INT 21H
        ;----------------------------------------------------------------------------------
           
         
         
        ; NEW LINE
        LEA DX, newline;
        MOV AH, 9;
        INT 21H;
        
        ; NEW LINE WITH TEXT
        LEA DX, newlinewithtext;
        MOV AH, 9;
        INT 21H;
        
        
        ; NEW LINE
        LEA DX, newline;
        MOV AH, 9;
        INT 21H;
        
         
         
        
        LEA DX, inputmessage;
        MOV AH, 9;
        INT 21H;
        
        
        ; USER INPUT
        MOV AH, 1;                        Input first character
        INT 21H;
        
        LEA DX, displayinput;
        MOV AH, 9;
        INT 21H;                          display input character
        
        
        
        
        
        ; -----------------------------Exit the program
        MOV AH, 4CH;
        INT 21H;
        ;----------------------------------------------
        
    MAIN ENDP
END MAIN