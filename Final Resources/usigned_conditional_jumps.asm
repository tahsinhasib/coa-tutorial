.MODEL SMALL

.STACK 100H


.DATA
; Define the message to be displayed
jg_msg DB 0DH, 0AH, "jump if greater than$";                            ZF = 0, SF = OF
jnle_msg DB 0DH, 0AH, "jump if not less than or equal$";                ZF = 0, SF = OF   
jge_msg DB 0DH, 0AH, "jump if greater than or equal$";                  SF = OF
jnl_msg DB 0DH, 0AH, "jump if not less than$";                          SF = OF
jl_msg DB 0DH, 0AH, "jump if less than$";                              SF <> OF
jnge_msg DB 0DH, 0AH, "jump if not greater than or equal$";            SF <> OF
jle_msg DB 0DH, 0AH, "jump if less than or equal$";                    ZF = 1, SF <> OF
jng_msg DB 0DH, 0AH, "jump if not greater than$";                      ZF = 1, SF <> OF
ja_msg DB 0DH, 0AH, "jump if above$";                                  CF = 0, ZF = 0
jnbe_msg DB 0DH, 0AH, "jump if not below or equal$";                   CF = 0, ZF = 0
jae_msg DB 0DH, 0AH, "jump if above or equal$";                        CF = 0
jnb_msg DB 0DH, 0AH, "jump if not below$";                             CF = 0
jb_msg DB 0DH, 0AH, "jump if below$";                                  CF = 1
jnae_msg DB 0DH, 0AH, "jump if not above or equal$";                   CF = 1
jbe_msg DB 0DH, 0AH, "jump if below or equal$";                       CF = 1, ZF = 1
jna_msg DB 0DH, 0AH, "jump if not above$";                            CF = 1, ZF = 1


.CODE

    MAIN PROC
    ; Initialize the data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Initialize the registers
    MOV AX, 5
    MOV BX, 10
    
    CMP AX, BX

    ; Jump labels
    JG JG_LABEL
    JNLE JNLE_LABEL
    JGE JGE_LABEL
    JNL JNL_LABEL
    JL JL_LABEL
    JNGE JNGE_LABEL
    JLE JLE_LABEL
    JNG JNG_LABEL
    JA JA_LABEL
    JNBE JNBE_LABEL
    JAE JAE_LABEL
    JNB JNB_LABEL
    JB JB_LABEL
    JNAE JNAE_LABEL
    JBE JBE_LABEL
    JNA JNA_LABEL

    JG_LABEL:
        MOV AH, 9
        LEA DX, jg_msg
        INT 21H
    JNLE_LABEL:
        MOV AH, 9
        LEA DX, jnle_msg
        INT 21H
    JGE_LABEL:
        MOV AH, 9
        LEA DX, jge_msg
        INT 21H
    JNL_LABEL:
        MOV AH, 9
        LEA DX, jnl_msg
        INT 21H
    JL_LABEL:
        MOV AH, 9
        LEA DX, jl_msg
        INT 21H
    JNGE_LABEL:
        MOV AH, 9
        LEA DX, jnge_msg
        INT 21H
    JLE_LABEL:
        MOV AH, 9
        LEA DX, jle_msg
        INT 21H
    JNG_LABEL:
        MOV AH, 9
        LEA DX, jng_msg
        INT 21H
    JA_LABEL:
        MOV AH, 9
        LEA DX, ja_msg
        INT 21H
    JNBE_LABEL:
        MOV AH, 9
        LEA DX, jnbe_msg
        INT 21H
    JAE_LABEL:
        MOV AH, 9
        LEA DX, jae_msg
        INT 21H
    JNB_LABEL:
        MOV AH, 9
        LEA DX, jnb_msg
        INT 21H
    JB_LABEL:
        MOV AH, 9
        LEA DX, jb_msg
        INT 21H
    JNAE_LABEL:
        MOV AH, 9
        LEA DX, jnae_msg
        INT 21H
    JBE_LABEL:
        MOV AH, 9
        LEA DX, jbe_msg
        INT 21H
    JNA_LABEL:
        MOV AH, 9
        LEA DX, jna_msg
        INT 21H

    MAIN ENDP

END MAIN


