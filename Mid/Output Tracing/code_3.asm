; Step 1: Move the value at memory address 1100h to AX
MOV AX, [1100h]

; Step 2: Move the value at memory address 1102h to BX
MOV BX, [1102h]

; Step 3: Store the value 111h at memory address 1100h
MOV [1100h], 111h

; Step 4: Store the value 1004h at memory address 1102h
MOV [1102h], 1004h

; Step 5: Move the updated value at memory address 1102h to BX
MOV BX, [1102h]

; Step 6: Add the values in AX and BX, store the result in AX
ADD AX, BX

; Step 7: Move the value in AX to memory address 1200h
MOV [1200h], AX
