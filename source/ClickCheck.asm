;------------------------------------------ Macros for clicking an icon on the GUI of player1 -----------------------------------------------
moveToRightLabelofPlayer1 PROC near
    ; local notmov,movlabel,notADD,ADDabel,notADC,ADCLabel,notSUB,SUBLabel,notSBB,SBBlabel,notXOR,XORlabel,notAND,ANDlabel,notOR,ORlabel,notNOP,NOPlabel,notSHR,SHRlabel,notSHL,SHLlabel,notSAR,SARlabel,notCLC,CLClabel,notROR,RORlabel,notROL,ROLlabel,notRCL,RCLlabel,notRCR,RCRlabel,notPUSH,PUSHlabel,notPOP,POPlabel,notINC,INClabel,notDEC,DEClabel,notDiv,Divlabel,notIDiv,IDivlabel,notMUL,MULlabel,notIMUL,IMULlabel
    ; PUSH AX
    ; PUSH BX
    ; PUSH CX
    ; PUSH DX
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
    jump movlabelOfplayer1
    notmov:
    

    
    CMP AX,ADDCORDINATES[0]
    jl notADD
    cmp AX,ADDCORDINATES[2]
    jg notADD
    cmp bx,ADDCORDINATES[1]
    jl notADD
    cmp bx,ADDCORDINATES[3]
    jg noTADD
    jump ADDlabelOfPlayer1
    notADD:



    CMP AX,ADCCORDINATES[0]
    jl notADC
    cmp AX,ADCCORDINATES[2]
    jg notADC
    cmp bx,ADCCORDINATES[1]
    jl notADC
    cmp bx,ADCCORDINATES[3]
    jg notADC
    jump ADCLabelOfPlayer1
    notADC:




    CMP AX,SUBCORDINATES[0]
    jl notSUB
    cmp AX,SUBCORDINATES[2]
    jg notSUB
    cmp bx,SUBCORDINATES[1]
    jl notSUB
    cmp bx,SUBCORDINATES[3]
    jg notSUB
    jump SUBLabelOfPlayer1
    notSUB:




    CMP AX,SBBCORDINATES[0]
    jl notSBB
    cmp AX,SBBCORDINATES[2]
    jg notSBB
    cmp bx,SBBCORDINATES[1]
    jl notSBB
    cmp bx,SBBCORDINATES[3]
    jg notSBB
    jump SBBlabelOfPlayer1
    notSBB:




    CMP AX,XORCORDINATES[0]
    jl notXOR
    cmp AX,XORCORDINATES[2]
    jg notXOR
    cmp bx,XORCORDINATES[1]
    jl noTXOR
    cmp bx,XORCORDINATES[3]
    jg notXOR
    jump XORlabelOfPlayer1
    notXOR:



    CMP AX,ANDCORDINATES[0]
    jl notAND
    cmp AX,ANDCORDINATES[2]
    jg notAND
    cmp bx,ANDCORDINATES[1]
    jl notAND
    cmp bx,ANDCORDINATES[3]
    jg notAND
    jump ANDlabelOfPlayer1
    notAND:


    CMP AX,ORCORDINATES[0]
    jl notOR
    cmp AX,ORCORDINATES[2]
    jg notOR
    cmp bx,ORCORDINATES[1]
    jl notOR
    cmp bx,ORCORDINATES[3]
    jg notOR
    jump ORlabelOfPlayer1
    notOR:



    CMP AX,NOPCORDINATES[0]
    jl notNOP
    cmp AX,NOPCORDINATES[2]
    jg notNOP
    cmp bx,NOPCORDINATES[1]
    jl notNOP
    cmp bx,NOPCORDINATES[3]
    jg notNOP
    jump NOPlabelOfPlayer1
    noTNOP:



    CMP AX,SHRCORDINATES[0]
    jl notSHR
    cmp AX,SHRCORDINATES[2]
    jg notSHR
    cmp bx,SHRCORDINATES[1]
    jl notSHR
    cmp bx,SHRCORDINATES[3]
    jg notSHR
    jump SHRlabelOfPlayer1
    noTSHR:


    CMP AX,SHLCORDINATES[0]
    jl notSHL
    cmp AX,SHLCORDINATES[2]
    jg notSHL
    cmp bx,SHLCORDINATES[1]
    jl notSHL
    cmp bx,SHLCORDINATES[3]
    jg notSHL
    jump SHLlabelOfPlayer1
    noTSHL:



CMP AX,SARCORDINATES[0]
    jl notSAR
    cmp AX,SARCORDINATES[2]
    jg notSAR
    cmp bx,SARCORDINATES[1]
    jl notSAR
    cmp bx,SARCORDINATES[3]
    jg notSAR
    jump SARlabelOfPlayer1
    noTSAR:



CMP AX,CLCCORDINATES[0]
    jl notCLC
    cmp AX,CLCCORDINATES[2]
    jg notCLC
    cmp bx,CLCCORDINATES[1]
    jl notCLC
    cmp bx,CLCCORDINATES[3]
    jg notCLC
    jump CLClabelOfPlayer1
    noTCLC:



CMP AX,RORCORDINATES[0]
    jl notROR
    cmp AX,RORCORDINATES[2]
    jg notROR
    cmp bx,RORCORDINATES[1]
    jl notROR
    cmp bx,RORCORDINATES[3]
    jg notROR
    jump RORlabelOfPlayer1
    noTROR:

CMP AX,ROLCORDINATES[0]
    jl notROL
    cmp AX,ROLCORDINATES[2]
    jg notROL
    cmp bx,ROLCORDINATES[1]
    jl notROL
    cmp bx,ROLCORDINATES[3]
    jg notROL
    jump ROLlabelOfPlayer1
    noTROL:


CMP AX,RCLCORDINATES[0]
    jl notRCL
    cmp AX,RCLCORDINATES[2]
    jg notRCL
    cmp bx,RCLCORDINATES[1]
    jl notRCL
    cmp bx,RCLCORDINATES[3]
    jg notRCL
    jump RCLlabelOfPlayer1
    noTRCL:



CMP AX,RCRCORDINATES[0]
    jl notRCR
    cmp AX,RCRCORDINATES[2]
    jg notRCR
    cmp bx,RCRCORDINATES[1]
    jl notRCR
    cmp bx,RCRCORDINATES[3]
    jg notRCR
    jump RCRlabelOfPlayer1
    noTRCR:

CMP AX,PUSHCORDINATES[0]
    jl notPUSH
    cmp AX,PUSHCORDINATES[2]
    jg notPUSH
    cmp bx,PUSHCORDINATES[1]
    jl notPUSH
    cmp bx,PUSHCORDINATES[3]
    jg notPUSH
    jump PUSHlabelOfPlayer1
    noTPUSH:



CMP AX,POPCORDINATES[0]
    jl notPOP
    cmp AX,POPCORDINATES[2]
    jg notPOP
    cmp bx,POPCORDINATES[1]
    jl notPOP
    cmp bx,POPCORDINATES[3]
    jg notPOP
    jump POPlabelOfPlayer1
    noTPOP:



CMP AX,INCCORDINATES[0]
    jl notINC
    cmp AX,INCCORDINATES[2]
    jg notINC
    cmp bx,INCCORDINATES[1]
    jl notINC
    cmp bx,INCCORDINATES[3]
    jg notINC
    jump INClabelOfPlayer1
    noTINC:


CMP AX,DECCORDINATES[0]
    jl notDEC
    cmp AX,DECCORDINATES[2]
    jg notDEC
    cmp bx,DECCORDINATES[1]
    jl notDEC
    cmp bx,DECCORDINATES[3]
    jg notDEC
    jump DEClabelOfPlayer1
    noTDEC:


CMP AX,DivCORDINATES[0]
    jl notDiv
    cmp AX,DivCORDINATES[2]
    jg notDiv
    cmp bx,DivCORDINATES[1]
    jl notDiv
    cmp bx,DivCORDINATES[3]
    jg notDiv
    jump DivlabelOfPlayer1
    noTDiv:

CMP AX,IDivCORDINATES[0]
    jl notIDiv
    cmp AX,IDivCORDINATES[2]
    jg notIDiv
    cmp bx,IDivCORDINATES[1]
    jl notIDiv
    cmp bx,IDivCORDINATES[3]
    jg notIDiv
    jump IDivlabelOfPlayer1
    noTIDiv:

CMP AX,MULCORDINATES[0]
    jl notMUL
    cmp AX,MULCORDINATES[2]
    jg notMUL
    cmp bx,MULCORDINATES[1]
    jl notMUL
    cmp bx,MULCORDINATES[3]
    jg notMUL
    jump MULlabelOfPlayer1
    noTMUL:

CMP AX,IMULCORDINATES[0]
    jl notIMUL
    cmp AX,IMULCORDINATES[2]
    jg notIMUL
    cmp bx,IMULCORDINATES[1]
    jl notIMUL
    cmp bx,IMULCORDINATES[3]
    jg notIMUL
    jump IMULlabelOfPlayer1
    noTIMUL:

    ; POP DX
    ; POP CX
    ; POP BX
    ; POP AX    
ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;------------------------------------------ Macros for clicking an icon on the GUI of player 2 -----------------------------------------------
moveToRightLabelofPalyer1 PROC near
    ; local notmov,movlabel,notADD,ADDabel,notADC,ADCLabel,notSUB,SUBLabel,notSBB,SBBlabel,notXOR,XORlabel,notAND,ANDlabel,notOR,ORlabel,notNOP,NOPlabel,notSHR,SHRlabel,notSHL,SHLlabel,notSAR,SARlabel,notCLC,CLClabel,notROR,RORlabel,notROL,ROLlabel,notRCL,RCLlabel,notRCR,RCRlabel,notPUSH,PUSHlabel,notPOP,POPlabel,notINC,INClabel,notDEC,DEClabel,notDiv,Divlabel,notIDiv,IDivlabel,notMUL,MULlabel,notIMUL,IMULlabel
    ; PUSH AX
    ; PUSH BX
    ; PUSH CX
    ; PUSH DX
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
    jump movlabelOfplayer2
    notmov:
    

    
    CMP AX,ADDCORDINATES[0]
    jl notADD
    cmp AX,ADDCORDINATES[2]
    jg notADD
    cmp bx,ADDCORDINATES[1]
    jl notADD
    cmp bx,ADDCORDINATES[3]
    jg noTADD
    jump ADDlabelOfPlayer2
    notADD:



    CMP AX,ADCCORDINATES[0]
    jl notADC
    cmp AX,ADCCORDINATES[2]
    jg notADC
    cmp bx,ADCCORDINATES[1]
    jl notADC
    cmp bx,ADCCORDINATES[3]
    jg notADC
    jump ADCLabelOfPlayer2
    notADC:




    CMP AX,SUBCORDINATES[0]
    jl notSUB
    cmp AX,SUBCORDINATES[2]
    jg notSUB
    cmp bx,SUBCORDINATES[1]
    jl notSUB
    cmp bx,SUBCORDINATES[3]
    jg notSUB
    jump SUBLabelOfPlayer2
    notSUB:




    CMP AX,SBBCORDINATES[0]
    jl notSBB
    cmp AX,SBBCORDINATES[2]
    jg notSBB
    cmp bx,SBBCORDINATES[1]
    jl notSBB
    cmp bx,SBBCORDINATES[3]
    jg notSBB
    jump SBBlabelOfPlayer2
    notSBB:




    CMP AX,XORCORDINATES[0]
    jl notXOR
    cmp AX,XORCORDINATES[2]
    jg notXOR
    cmp bx,XORCORDINATES[1]
    jl noTXOR
    cmp bx,XORCORDINATES[3]
    jg notXOR
    jump XORlabelOfPlayer2
    notXOR:



    CMP AX,ANDCORDINATES[0]
    jl notAND
    cmp AX,ANDCORDINATES[2]
    jg notAND
    cmp bx,ANDCORDINATES[1]
    jl notAND
    cmp bx,ANDCORDINATES[3]
    jg notAND
    jump ANDlabelOfPlayer2
    notAND:


    CMP AX,ORCORDINATES[0]
    jl notOR
    cmp AX,ORCORDINATES[2]
    jg notOR
    cmp bx,ORCORDINATES[1]
    jl notOR
    cmp bx,ORCORDINATES[3]
    jg notOR
    jump ORlabelOfPlayer2
    notOR:



    CMP AX,NOPCORDINATES[0]
    jl notNOP
    cmp AX,NOPCORDINATES[2]
    jg notNOP
    cmp bx,NOPCORDINATES[1]
    jl notNOP
    cmp bx,NOPCORDINATES[3]
    jg notNOP
    jump NOPlabelOfPlayer2
    noTNOP:



    CMP AX,SHRCORDINATES[0]
    jl notSHR
    cmp AX,SHRCORDINATES[2]
    jg notSHR
    cmp bx,SHRCORDINATES[1]
    jl notSHR
    cmp bx,SHRCORDINATES[3]
    jg notSHR
    jump SHRlabelOfPlayer2
    noTSHR:


    CMP AX,SHLCORDINATES[0]
    jl notSHL
    cmp AX,SHLCORDINATES[2]
    jg notSHL
    cmp bx,SHLCORDINATES[1]
    jl notSHL
    cmp bx,SHLCORDINATES[3]
    jg notSHL
    jump SHLlabelOfPlayer2
    noTSHL:



CMP AX,SARCORDINATES[0]
    jl notSAR
    cmp AX,SARCORDINATES[2]
    jg notSAR
    cmp bx,SARCORDINATES[1]
    jl notSAR
    cmp bx,SARCORDINATES[3]
    jg notSAR
    jump SARlabelOfPlayer2
    noTSAR:



CMP AX,CLCCORDINATES[0]
    jl notCLC
    cmp AX,CLCCORDINATES[2]
    jg notCLC
    cmp bx,CLCCORDINATES[1]
    jl notCLC
    cmp bx,CLCCORDINATES[3]
    jg notCLC
    jump CLClabelOfPlayer2
    noTCLC:



CMP AX,RORCORDINATES[0]
    jl notROR
    cmp AX,RORCORDINATES[2]
    jg notROR
    cmp bx,RORCORDINATES[1]
    jl notROR
    cmp bx,RORCORDINATES[3]
    jg notROR
    jump RORlabelOfPlayer2
    noTROR:

CMP AX,ROLCORDINATES[0]
    jl notROL
    cmp AX,ROLCORDINATES[2]
    jg notROL
    cmp bx,ROLCORDINATES[1]
    jl notROL
    cmp bx,ROLCORDINATES[3]
    jg notROL
    jump ROLlabelOfPlayer2
    noTROL:


CMP AX,RCLCORDINATES[0]
    jl notRCL
    cmp AX,RCLCORDINATES[2]
    jg notRCL
    cmp bx,RCLCORDINATES[1]
    jl notRCL
    cmp bx,RCLCORDINATES[3]
    jg notRCL
    jump RCLlabelOfPlayer2
    noTRCL:



CMP AX,RCRCORDINATES[0]
    jl notRCR
    cmp AX,RCRCORDINATES[2]
    jg notRCR
    cmp bx,RCRCORDINATES[1]
    jl notRCR
    cmp bx,RCRCORDINATES[3]
    jg notRCR
    jump RCRlabelOfPlayer2
    noTRCR:

CMP AX,PUSHCORDINATES[0]
    jl notPUSH
    cmp AX,PUSHCORDINATES[2]
    jg notPUSH
    cmp bx,PUSHCORDINATES[1]
    jl notPUSH
    cmp bx,PUSHCORDINATES[3]
    jg notPUSH
    jump PUSHlabelOfPlayer2
    noTPUSH:



CMP AX,POPCORDINATES[0]
    jl notPOP
    cmp AX,POPCORDINATES[2]
    jg notPOP
    cmp bx,POPCORDINATES[1]
    jl notPOP
    cmp bx,POPCORDINATES[3]
    jg notPOP
    jump POPlabelOfPlayer2
    noTPOP:



CMP AX,INCCORDINATES[0]
    jl notINC
    cmp AX,INCCORDINATES[2]
    jg notINC
    cmp bx,INCCORDINATES[1]
    jl notINC
    cmp bx,INCCORDINATES[3]
    jg notINC
    jump INClabelOfPlayer2
    noTINC:


CMP AX,DECCORDINATES[0]
    jl notDEC
    cmp AX,DECCORDINATES[2]
    jg notDEC
    cmp bx,DECCORDINATES[1]
    jl notDEC
    cmp bx,DECCORDINATES[3]
    jg notDEC
    jump DEClabelOfPlayer2
    noTDEC:


CMP AX,DivCORDINATES[0]
    jl notDiv
    cmp AX,DivCORDINATES[2]
    jg notDiv
    cmp bx,DivCORDINATES[1]
    jl notDiv
    cmp bx,DivCORDINATES[3]
    jg notDiv
    jump DivlabelOfPlayer2
    noTDiv:

CMP AX,IDivCORDINATES[0]
    jl notIDiv
    cmp AX,IDivCORDINATES[2]
    jg notIDiv
    cmp bx,IDivCORDINATES[1]
    jl notIDiv
    cmp bx,IDivCORDINATES[3]
    jg notIDiv
    jump IDivlabelOfPlayer2
    noTIDiv:

CMP AX,MULCORDINATES[0]
    jl notMUL
    cmp AX,MULCORDINATES[2]
    jg notMUL
    cmp bx,MULCORDINATES[1]
    jl notMUL
    cmp bx,MULCORDINATES[3]
    jg notMUL
    jump MULlabelOfPlayer2
    noTMUL:

CMP AX,IMULCORDINATES[0]
    jl notIMUL
    cmp AX,IMULCORDINATES[2]
    jg notIMUL
    cmp bx,IMULCORDINATES[1]
    jl notIMUL
    cmp bx,IMULCORDINATES[3]
    jg notIMUL
    jump IMULlabelOfPlayer2
    noTIMUL:

    ; POP DX
    ; POP CX
    ; POP BX
    ; POP AX    
ENDP