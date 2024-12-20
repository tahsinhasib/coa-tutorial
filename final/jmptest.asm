.model small
.stack 100h
.data
.code

main proc
    mov ah,2
    mov cx,256
    mov dl,0
    printloop:
    int 21h
    inc dl
    dec  cx
    jnz printloop
    mov ah,4ch
    main endp
end main