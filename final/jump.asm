


MOV AX, 1234H;
MOV BX, 3456H;

; If jump is comment out then the program will go in a loop state after executing the last line
JMP DEF

MOV CX, 3456H;

XYZ: MOV DX, 5678;
JKL: MOV DX, 5678;

DEF: MOV DX, 5678H;

;Reusing the same 15 line would cause error
;DEF: MOV DX, 5678H;    



ABC: MOV DX, 5678;