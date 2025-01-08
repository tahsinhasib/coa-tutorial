.model small
.stack 100h

.data
input db "Enter Input: $"
output db 0Dh, 0Ah,"Output: $"



.code

mov ax, @data
mov ds, ax

mov ah, 09h
lea dx, input
int 21h

xor bx, bx
mov cx, 16 

UserInput:

mov ah, 01h
int 21h
cmp al, 0Dh
je Output_
and al, 0Fh

; if user press 1 as input, the ascii value of 1- 31h will be stored.
; But we need the value 01h. The Binary of 31h and 01h = 0011 0001, 0000 0001 

;That means if we clear 4 bit from the Left side we will get 0000 0001
; So the mask is 0000 1111b or 0Fh. 

shl bx,1
or bl, al
loop UserInput

Output_:
mov ah, 09h
lea  dx, output
int 21h 

mov cx, 16

OutputChecking:
shl bx,1
jnc Zero

mov dl, 49
mov ah,2
int 21h
jmp Exit 

Zero: 
mov ah,2
mov dl, 48
int 21h 
        
Exit:
loop OutputChecking 
mov ah, 4ch
int 21h
 
