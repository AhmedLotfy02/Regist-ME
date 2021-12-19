;------------------------------------------ Macros for clicking an icon on the GUI -----------------------------------------------
moveToRightLabel PROC near
    local noTADD,noTCLC,noTDEC,noTINC,noTNOP,noTPOP,noTPUSH,noTRCL,noTRCR,noTROL,noTROR,notSAR,notSBB,notSHL,notSHR,notSUB,notXOR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    GETMOUSEPOSITION MOUSEPOSITION_X,MOUSEPOSITION_Y
    MOV AX,MOUSEPOSITION_X
    MOV BX,MOUSEPOSITION_Y
    



    CMP AX,MOVCORDINATES[0]
    jl notmov
    cmp AX,MOVCORDINATES[2]
    jg notmov
    cmp bx,MOVCORDINATES[1]
    jl notmov
    cmp bx,MOVCORDINATES[3]
    jg notmov
    jump movlabel
    notmov:
    

    
    CMP AX,ADDCORDINATES[0]
    jl notADD
    cmp AX,ADDCORDINATES[2]
    jg notADD
    cmp bx,ADDCORDINATES[1]
    jl notADD
    cmp bx,ADDCORDINATES[3]
    jg noTADD
    jump ADDabel
    notADD:



    CMP AX,ADCCORDINATES[0]
    jl notADC
    cmp AX,ADCCORDINATES[2]
    jg notADC
    cmp bx,ADCCORDINATES[1]
    jl notADC
    cmp bx,ADCCORDINATES[3]
    jg notADC
    jump ADCLabel
    notADC:




    CMP AX,SUBCORDINATES[0]
    jl notSUB
    cmp AX,SUBCORDINATES[2]
    jg notSUB
    cmp bx,SUBCORDINATES[1]
    jl notSUB
    cmp bx,SUBCORDINATES[3]
    jg notSUB
    jump SUBLabel
    notSUB:




    CMP AX,SBBCORDINATES[0]
    jl notSBB
    cmp AX,SBBCORDINATES[2]
    jg notSBB
    cmp bx,SBBCORDINATES[1]
    jl notSBB
    cmp bx,SBBCORDINATES[3]
    jg notSBB
    jump SBBlabel
    notSBB:




    CMP AX,XORCORDINATES[0]
    jl notXOR
    cmp AX,XORCORDINATES[2]
    jg notXOR
    cmp bx,XORCORDINATES[1]
    jl noTXOR
    cmp bx,XORCORDINATES[3]
    jg notXOR
    jump XORlabel
    notXOR:



    CMP AX,ANDCORDINATES[0]
    jl notAND
    cmp AX,ANDCORDINATES[2]
    jg notAND
    cmp bx,ANDCORDINATES[1]
    jl notAND
    cmp bx,ANDCORDINATES[3]
    jg notAND
    jump ANDlabel
    notAND:


    CMP AX,ORCORDINATES[0]
    jl notOR
    cmp AX,ORCORDINATES[2]
    jg notOR
    cmp bx,ORCORDINATES[1]
    jl notOR
    cmp bx,ORCORDINATES[3]
    jg notOR
    jump ORlabel
    notOR:



    CMP AX,NOPCORDINATES[0]
    jl notNOP
    cmp AX,NOPCORDINATES[2]
    jg notNOP
    cmp bx,NOPCORDINATES[1]
    jl notNOP
    cmp bx,NOPCORDINATES[3]
    jg notNOP
    jump NOPlabel
    noTNOP:



    CMP AX,SHRCORDINATES[0]
    jl notSHR
    cmp AX,SHRCORDINATES[2]
    jg notSHR
    cmp bx,SHRCORDINATES[1]
    jl notSHR
    cmp bx,SHRCORDINATES[3]
    jg notSHR
    jump SHRlabel
    noTSHR:


    CMP AX,SHLCORDINATES[0]
    jl notSHL
    cmp AX,SHLCORDINATES[2]
    jg notSHL
    cmp bx,SHLCORDINATES[1]
    jl notSHL
    cmp bx,SHLCORDINATES[3]
    jg notSHL
    jump SHLlabel
    noTSHL:



CMP AX,SARCORDINATES[0]
    jl notSAR
    cmp AX,SARCORDINATES[2]
    jg notSAR
    cmp bx,SARCORDINATES[1]
    jl notSAR
    cmp bx,SARCORDINATES[3]
    jg notSAR
    jump SARlabel
    noTSAR:



CMP AX,CLCCORDINATES[0]
    jl notCLC
    cmp AX,CLCCORDINATES[2]
    jg notCLC
    cmp bx,CLCCORDINATES[1]
    jl notCLC
    cmp bx,CLCCORDINATES[3]
    jg notCLC
    jump CLClabel
    noTCLC:



CMP AX,RORCORDINATES[0]
    jl notROR
    cmp AX,RORCORDINATES[2]
    jg notROR
    cmp bx,RORCORDINATES[1]
    jl notROR
    cmp bx,RORCORDINATES[3]
    jg notROR
    jump RORlabel
    noTROR:

CMP AX,ROLCORDINATES[0]
    jl notROL
    cmp AX,ROLCORDINATES[2]
    jg notROL
    cmp bx,ROLCORDINATES[1]
    jl notROL
    cmp bx,ROLCORDINATES[3]
    jg notROL
    jump ROLlabel
    noTROL:


CMP AX,RCLCORDINATES[0]
    jl notRCL
    cmp AX,RCLCORDINATES[2]
    jg notRCL
    cmp bx,RCLCORDINATES[1]
    jl notRCL
    cmp bx,RCLCORDINATES[3]
    jg notRCL
    jump RCLlabel
    noTRCL:



CMP AX,RCRCORDINATES[0]
    jl notRCR
    cmp AX,RCRCORDINATES[2]
    jg notRCR
    cmp bx,RCRCORDINATES[1]
    jl notRCR
    cmp bx,RCRCORDINATES[3]
    jg notRCR
    jump RCRlabel
    noTRCR:

CMP AX,PUSHCORDINATES[0]
    jl notPUSH
    cmp AX,PUSHCORDINATES[2]
    jg notPUSH
    cmp bx,PUSHCORDINATES[1]
    jl notPUSH
    cmp bx,PUSHCORDINATES[3]
    jg notPUSH
    jump PUSHlabel
    noTPUSH:



CMP AX,POPCORDINATES[0]
    jl notPOP
    cmp AX,POPCORDINATES[2]
    jg notPOP
    cmp bx,POPCORDINATES[1]
    jl notPOP
    cmp bx,POPCORDINATES[3]
    jg notPOP
    jump POPlabel
    noTPOP:



CMP AX,INCCORDINATES[0]
    jl notINC
    cmp AX,INCCORDINATES[2]
    jg notINC
    cmp bx,INCCORDINATES[1]
    jl notINC
    cmp bx,INCCORDINATES[3]
    jg notINC
    jump INClabel
    noTINC:


CMP AX,DECCORDINATES[0]
    jl notDEC
    cmp AX,DECCORDINATES[2]
    jg notDEC
    cmp bx,DECCORDINATES[1]
    jl notDEC
    cmp bx,DECCORDINATES[3]
    jg notDEC
    jump DEClabel
    noTDEC:

    POP DX
    POP CX
    POP BX
    POP AX    
ENDP