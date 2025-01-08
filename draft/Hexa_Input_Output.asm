.MODEL SMALL
.STACK 100

.CODE
    mov bx, 0
    mov cl, 4
    mov ah, 1
    
    for1:
    int 21h
    cmp al, 0Dh
    je Output
    CMP AL, 41H ; 41H = A
    JGE letter
    and al, 0Fh
    ;sub al, 30h  ; if input = 6 then 36h -30h = 6h
    jmp shift
    
    letter: 
    sub al, 37h ; 41h - 37h = 10(A)
    
    shift:
    
    shl bx, cl  ; create space
    or bl, al
    jmp for1
    
     
    
    Output:  
    mov ah,2 
    mov dl, 0Dh  
    int 21h
    mov dl, 0AH
    int 21h
    
    mov cx, 4
    mov ah, 2
    
    for2:
    
    mov dl, bh
    shr dl, 4
    ROL BX, 4
    CMP DL, 10
    JGE outputLetter 
    
    ;jmp End_Loop2
    ;loop for2
    
    add dl, 48
    int 21h   
    jmp Exit2
    
    
    outputLetter:
    add dl, 55
    int 21h
    
    Exit2:
    loop for2
    
    
   
    mov ah, 4ch
    int 21h
    