;--------------------------- Procedures ------------------------------------------------------------
    CONVERT PROC NEAR  
        CMP inputValueSize,1
        JA TWO1
        Jmp TWO2 
            TWO1:
                JMP FAR PTR TWO
                
            TWO2: 
            readtwodigitss 0
            MOV AL,TEMP 
            MOV BYTE PTR NUMBER[0],AL
            JMP FIN
        TWO:
        READFOURDIGITs
        FIN:
            RET
    CONVERT ENDP

    CHECKINPUTVALUESIZE PROC NEAR
                            
        ;CALL CHECKISNUM
        cmp inputValueString[1], 0
        jz  setInvalid   

        cmp inputValueString[1], 1
        jz convertToByte

        cmp inputValueString[1], 2
        jz setByte
        
        cmp inputValueString[1], 3
        jz convertToWord

        cmp inputValueString[1], 4
        jz setWord
        convertToByte:
            mov bl, inputValueString[2]
            mov inputValueString[3], bl
            mov inputValueString[2], '0'

        setByte: mov inputValueSize, 1
                jmp endCheck
        convertToWord:
            mov bl, inputValueString[4]
            mov inputValueString[5], bl
            mov bl, inputValueString[3]
            mov inputValueString[4], bl
            mov bl, inputValueString[2]
            mov inputValueString[3], bl
            mov inputValueString[2], '0'
        setWord: mov inputValueSize, 2
        jmp endCheck
        setInvalid: mov inputValueSize, 0
        endCheck:
        ret
    CHECKINPUTVALUESIZE ENDP

    readAdress PROC NEAR
        call CLR
        call Fixed
        movCursor 5,2
        Print_Msg enterMemAdress
        movCursor 5,3
        CMP PLAYERTURN,0
        JNZ PLAYER2TURNREADADDRESS
        readonedgit Player2_Data_Register[19]
        JMP CONTINUEREADADRESS
        PLAYER2TURNREADADDRESS:
        readonedgit Player1_Data_Register[19]
        CONTINUEREADADRESS:
        CMP DESTORSRC, 0
        JNZ SRC
        MOV dest_index_val,18
        MOV DEST_INDEX_REG,17
        MOV COUNT_BIT_1,1
        RET 
        ;CALL SHOW_2ND_OPERAND
        SRC:
            MOV SRC_index_val,18
            MOV SRC_INDEX_REG,17
            MOV COUNT_BIT_2,1 
        RET
    readAdress ENDP

    readValue  PROC NEAR
        call CLR
        call Fixed
        movCursor 5,2
        Print_Msg enterValue
        movCursor 5,3
        readString inputValueString
        CALL CHECKINPUTVALUESIZE  
        CALL CONVERT 
        
        CMP INPUTVALUESIZE,1
        jnz WORDLABEL
        MOV AX, NUMBER
        CMP PLAYERTURN ,0
        JNZ PLAYER2TURNREADVALUE
        mov PLAYER2_DATA_REGISTER[16], 0
        MOV PLAYER2_DATA_REGISTER[17],aL
        JMP CONTINUE1
        PLAYER2TURNREADVALUE:
        mov PLAYER1_DATA_REGISTER[16], 0
        MOV PLAYER1_DATA_REGISTER[17],aL
        CONTINUE1:MOV COUNT_BIT_2,1
        mov SRC_INDEX_VAL, 17
        RET
        WORDLABEL:
        MOV AX,NUMBER
        CMP PLAYERTURN ,0
        JNZ PLAYER2TURNREADVALUE2

        MOV PLAYER2_DATA_REGISTER[16],aH
        MOV PLAYER2_DATA_REGISTER[17],aL
        JMP CONTINUE2
        PLAYER2TURNREADVALUE2:
        MOV PLAYER1_DATA_REGISTER[16],aH
        MOV PLAYER1_DATA_REGISTER[17],aL
        CONTINUE2:
        MOV COUNT_BIT_2,2
        mov SRC_INDEX_VAL, 16
        ret
    readValue endp

    memoryOrReg PROC NEAR
        clickOnRight:
        GETMOUSEPOSITION y,x
        mov ax,x
        mov bx,y
        CMP Ax,word ptr MOVCORDINATES[0]
        jb NOTMEMORY
        cmp AX,word ptr MOVCORDINATES[4]
        ja NOTMEMORY
        cmp BX,word ptr MOVCORDINATES[2]
        jb NOTMEMORY
        cmp BX,word ptr MOVCORDINATES[6]
        ja NOTMEMORY
        MOV ADDRESS_MODE,1
        call FIRSTSCREEN
        JMP far ptr RETURNMEMREG
        
        NOTMEMORY:
        CMP AX,word ptr ADDCORDINATES[0]
        jl NOTREGISTER
        cmp AX,word ptr ADDCORDINATES[4]
        jg NOTREGISTER
        cmp bx,word ptr ADDCORDINATES[2]
        jl NOTREGISTER
        cmp bx,word ptr ADDCORDINATES[6]
        jg noTREGISTER
        CALL SHOW_REGISTERS_CHOICE
        Jmp far ptr RETURNMEMREG
        NOTREGISTER:
        jmp far ptr clickOnRight
        RETURNMEMREG:
        RET
    memoryOrReg ENDP

    memoryOrRegORVALUE PROC NEAR
        clickOnRight1:
        GETMOUSEPOSITION y,x
        mov ax,x
        mov bx,y
        CMP Ax,word ptr MOVCORDINATES[0]
        jb NOTMEM
        cmp AX,word ptr MOVCORDINATES[4]
        ja NOTMEM
        cmp BX,word ptr MOVCORDINATES[2]
        jb NOTMEM
        cmp BX,word ptr MOVCORDINATES[6]
        ja NOTMEM
        MOV ADDRESS_MODE2,1
        call FIRSTSCREEN
    
        JMP far ptr RETURNmemoryOrRegORVALUE
        NOTMEM:


        CMP AX,word ptr ADDCORDINATES[0]
        jl NOTREG
        cmp AX,word ptr ADDCORDINATES[4]
        jg NOTREG
        cmp bx,word ptr ADDCORDINATES[2]
        jl NOTREG
        cmp bx,word ptr ADDCORDINATES[6]
        jg noTREG
        CALL SHOW_REGISTERS_CHOICE
        JMP far ptr RETURNmemoryOrRegORVALUE
        NOTREG:


        CMP AX,word ptr SUBCORDINATES[0]
        jl NOTVALUE
        cmp AX,word ptr SUBCORDINATES[4]
        jg NOTVALUE
        cmp bx,word ptr SUBCORDINATES[2]
        jl NOTVALUE
        cmp bx,word ptr SUBCORDINATES[6]
        jg noTVALUE
        MOV SRC_INDEX_REG,17
        CALL readValue
        jmp far ptr RETURNmemoryOrRegORVALUE
        NOTVALUE:
        jmp far ptr clickOnRight1
        RETURNmemoryOrRegORVALUE:
        RET
    memoryOrRegORVALUE ENDP

    VALUE_OR_REG PROC NEAR
        clickRight:
        GETMOUSEPOSITION y,x
        mov ax,x
        mov bx,y
        CMP Ax,WORD PTR MOVCORDINATES[0]             
        jb NOTVAL
        cmp AX,WORD PTR MOVCORDINATES[4]
        ja NOTVAL
        cmp BX,WORD PTR MOVCORDINATES[2]
        jb NOTVAL
        cmp BX,WORD PTR MOVCORDINATES[6]
        ja NOTVAL
        CALL readAdress
        Jmp far ptr RETURNVALUE_OR_REG
        NOTVAL:

        CMP AX,WORD PTR ADDCORDINATES[0]
        jB NOTREGS
        cmp AX,WORD PTR ADDCORDINATES[4]
        jA NOTREGS
        cmp bx,WORD PTR ADDCORDINATES[2]
        jB NOTREGS
        cmp bx,WORD PTR ADDCORDINATES[6]
        jA noTREGS
        CALL SHOW_REGISTERS_ADRESSES_CHOICE
        Jmp far ptr RETURNVALUE_OR_REG
        NOTREGS:
        jmp far ptr clickRight

        RETURNVALUE_OR_REG:RET
    VALUE_OR_REG ENDP

; ;description
    SHOW_REGISTERS_ADRESSES_CHOICE PROC NEAR
        CALL CLR
        CALL FIXED

        movCursor 5,2
        PRINT_STRING_2DIGIT BX_REG
        movCursor 12,2
        PRINT_STRING_2DIGIT DI_REG

        movCursor 5,5
        PRINT_STRING_2DIGIT SI_REG

        ;;DRAWING REC AROUND THEM
        ;;AL REC
        DrawRec 25,30,50,70
        ;AH REC
        DrawRec 25,90,50,130
        ;;BL REC
        DrawRec 75,30,100,70
        CMP DESTORSRC, 1
        JZ SRCADDRESS_TEMP
        jmp DESTADDRESS
        SRCADDRESS_TEMP: 
            JMP FAR PTR SRCADDRESS

        DESTADDRESS:
            CickedMEMORYRegister DEST_INDEX_REG,DEST_INDEX_VAL,COUNT_BIT_1
            MOV COUNT_BIT_1,1
            RET

        SRCADDRESS:
            CickedMEMORYRegister SRC_INDEX_REG,SRC_INDEX_VAL,COUNT_BIT_2
            MOV COUNT_BIT_2,1
            RET
    SHOW_REGISTERS_ADRESSES_CHOICE ENDP

    FIRSTSCREEN PROC NEAR
        CALL CLR
        CALL FIXED
        movCursor 5,2
        PRINT_STRING_3DIGIT VALUE
        movCursor 12,2
        PRINT_STRING_3DIGIT REGISTER
        DrawRec 25,30,50,70
       
        DrawRec 25,90,50,130
        CALL VALUE_OR_REG
        RET
    FIRSTSCREEN ENDP
    
    CLR proc NEAR
        mov al, 12h ; Video mode number
        mov ah, 0h
        int 10h
        ret
    CLR endp

    SHOW_2ND_OPERAND PROC NEAR
        CALL CLR
        CALL FIXED
        MOV DESTORSRC,1
        movCursor 5,2
        PRINT_STRING_3DIGIT ADDRESS_CHOICE
        movCursor 12,2
        PRINT_STRING_3DIGIT REGISTER_CHOICE
        ;;ADDRESS_CHOICE REC
        DrawRec 25,30,50,70
        ;;REGISTER_CHOICE REC
        DrawRec 25,90,50,130

        movCursor 5,5
        PRINT_STRING_3DIGIT VALUE_CHOICE
        ;;;;VALUE_CHOICE REC
        DrawRec 75,30,100,70
        call memoryOrRegORVALUE
        ret
    SHOW_2ND_OPERAND endp

    moveToRightLabelofPlayer1 PROC NEAR 
        CHECKCLICK:    
            GETMOUSEPOSITION y,x
            mov ax,x
            mov bx,y
            CMP Ax,word ptr MOVCORDINATES[0]
            jb notmov
            cmp AX,word ptr MOVCORDINATES[4]
            ja notmov
            cmp BX,word ptr MOVCORDINATES[2]
            jb notmov
            cmp BX,word ptr MOVCORDINATES[6]
            ja notmov
            call MOVPLAYER1PR
            jmp far ptr RETURNmovlabelOfplayer1
            notmov:


            
            CMP AX,word ptr ADDCORDINATES[0]
            jl notADD
            cmp AX,word ptr ADDCORDINATES[4]
            jg notADD
            cmp bx,word ptr ADDCORDINATES[2]
            jl notADD
            cmp bx,word ptr ADDCORDINATES[6]
            jg noTADD
            CALL ADDPLAYER1PR
            jmp far ptr RETURNmovlabelOfplayer1
            notADD:

            CMP AX,word ptr SUBCORDINATES[0]
            jl notSUB
            cmp AX,word ptr SUBCORDINATES[4]
            jg notSUB
            cmp bx,word ptr SUBCORDINATES[2]
            jl notSUB
            cmp bx,word ptr SUBCORDINATES[6]
            jg notSUB
            CALL SUBPLAYER1PR 
            jmp far ptr RETURNmovlabelOfplayer1
            notSUB:

            CMP AX,word ptr XORCORDINATES[0]
            jl notXOR
            cmp AX,word ptr XORCORDINATES[4]
            jg notXOR
            cmp bx,word ptr XORCORDINATES[2]
            jl noTXOR
            cmp bx,word ptr XORCORDINATES[6]
            jg notXOR
            CALL MULPLAYER1PR 
            jmp far ptr RETURNmovlabelOfplayer1
            notXOR:

            CMP AX,word ptr ANDCORDINATES[0]
            jb notAND
            cmp AX,word ptr ANDCORDINATES[4]
            ja notAND
            cmp bx,word ptr ANDCORDINATES[2]
            jb notAND
            cmp bx,word ptr ANDCORDINATES[6]
            ja notAND
            CALL SALPLAYER1PR
            jmp far ptr RETURNmovlabelOfplayer1
            notAND:
            CMP AX,word ptr ORCORDINATES[0]
            jl notOR
            cmp AX,word ptr ORCORDINATES[4]
            jg notOR
            cmp bx,word ptr ORCORDINATES[2]
            jl notOR
            cmp bx,word ptr ORCORDINATES[6]
            jg notOR
            CALL SARPLAYER1PR
            jmp far ptr RETURNmovlabelOfplayer1
            notOR:
            CMP AX,word ptr NOPCORDINATES[0]
            jl notNOP
            cmp AX,word ptr NOPCORDINATES[4]
            jg notNOP
            cmp bx,word ptr NOPCORDINATES[2]
            jl notNOP
            cmp bx,word ptr NOPCORDINATES[6]
            jg notNOP

            jmp far ptr RETURNmovlabelOfplayer1
            noTNOP:
            CMP AX,word ptr SHRCORDINATES[0]
            jl notSHR
            cmp AX,word ptr SHRCORDINATES[4]
            jg notSHR
            cmp bx,word ptr SHRCORDINATES[2]
            jl notSHR
            cmp bx,word ptr SHRCORDINATES[6]
            jg notSHR
            CALL SHRPLAYER1PR
            jmp far ptr RETURNmovlabelOfplayer1
            noTSHR:
            CMP AX,word ptr SHLCORDINATES[0]
            jl notSHL
            cmp AX,word ptr SHLCORDINATES[4]
            jg notSHL
            cmp bx,word ptr SHLCORDINATES[2]
            jl notSHL
            cmp bx,word ptr SHLCORDINATES[6]
            jg notSHL
            CALL SHLPLAYER1PR
            jmp far ptr RETURNmovlabelOfplayer1
            noTSHL:

            CMP AX,word ptr RORCORDINATES[0]
            jl notROR
            cmp AX,word ptr RORCORDINATES[4]
            jg notROR
            cmp bx,word ptr RORCORDINATES[2]
            jl notROR
            cmp bx,word ptr RORCORDINATES[6]
            jg notROR
            CALL RORPLAYER1PR
            jmp far ptr RETURNmovlabelOfplayer1
            noTROR:

            CMP AX,word ptr ROLCORDINATES[0]
            jl notROL
            cmp AX,word ptr ROLCORDINATES[4]
            jg notROL
            cmp bx,word ptr ROLCORDINATES[2]
            jl notROL
            cmp bx,word ptr ROLCORDINATES[6]
            jg notROL
            CALL ROLPLAYER1PR
            jmp far ptr RETURNmovlabelOfplayer1
            noTROL:

            CMP AX,word ptr INCCORDINATES[0]
            jl notINC
            cmp AX,word ptr INCCORDINATES[4]
            jg notINC
            cmp bx,word ptr INCCORDINATES[2]
            jl notINC
            cmp bx,word ptr INCCORDINATES[6]
            jg notINC
            CALL INCPLAYER1PR  
            jmp far ptr RETURNmovlabelOfplayer1
            noTINC:


            CMP AX,word ptr DECCORDINATES[0]
            jl notDEC
            cmp AX,word ptr DECCORDINATES[4]
            jg notDEC
            cmp bx,word ptr DECCORDINATES[2]
            jl notDEC
            cmp bx,word ptr DECCORDINATES[6]
            jg notDEC
            CALL DECPLAYER1PR
            jmp far ptr RETURNmovlabelOfplayer1
            noTDEC:
            CMP AX,word ptr DivCORDINATES[0]
            jl notDiv
            cmp AX,word ptr DivCORDINATES[4]
            jg notDiv
            cmp bx,word ptr DivCORDINATES[2]
            jl notDiv
            cmp bx,word ptr DivCORDINATES[6]
            jg notDiv
            CALL DIVPLAYER1PR  
            jmp far ptr RETURNmovlabelOfplayer1
            noTDiv:

            CMP AX,word ptr IDivCORDINATES[0]
            jl notIDiv
            cmp AX,word ptr IDivCORDINATES[4]
            jg notIDiv
            cmp bx,word ptr IDivCORDINATES[2]
            jl notIDiv
            cmp bx,word ptr IDivCORDINATES[6]
            jg notIDiv
            CALL IDIVPLAYER1PR 
            jmp far ptr RETURNmovlabelOfplayer1
            noTIDiv:


            CMP AX,word ptr IMULCORDINATES[0]
            jl notIMUL
            cmp AX,word ptr IMULCORDINATES[4]
            jg notIMUL
            cmp bx,word ptr IMULCORDINATES[2]
            jl notIMUL
            cmp bx,word ptr IMULCORDINATES[6]
            jg notIMUL
            CALL IMULPLAYER1PR 
            jmp RETURNmovlabelOfplayer1
            noTIMUL:
            JMP CHECKCLICK
            RETURNmovlabelOfplayer1: RET
    moveToRightLabelofPlayer1 ENDP

    moveToRightLabelofPlayer2 PROC NEAR 
        GETMOUSEPOSITION y,x
        mov ax,x
        mov bx,y
        CMP Ax,word ptr MOVCORDINATES[0]
        jb notmov2
        cmp AX,word ptr MOVCORDINATES[4]
        ja notmov2
        cmp BX,word ptr MOVCORDINATES[2]
        jb notmov2
        cmp BX,word ptr MOVCORDINATES[6]
        ja notmov2
        CALL MOVPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        notmov2:
        
        CMP AX,word ptr ADDCORDINATES[0]
        jl notADD2
        cmp AX,word ptr ADDCORDINATES[4]
        jg notADD2
        cmp bx,word ptr ADDCORDINATES[2]
        jl notADD2
        cmp bx,word ptr ADDCORDINATES[6]
        jg noTADD2
        CALL ADDPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        notADD2:

        CMP AX,word ptr SUBCORDINATES[0]
        jl notSUB2
        cmp AX,word ptr SUBCORDINATES[4]
        jg notSUB2
        cmp bx,word ptr SUBCORDINATES[2]
        jl notSUB2
        cmp bx,word ptr SUBCORDINATES[6]
        jg notSUB2
        CALL SUBPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        notSUB2:

        CMP AX,word ptr XORCORDINATES[0]
        jl notXOR2
        cmp AX,word ptr XORCORDINATES[4]
        jg notXOR2
        cmp bx,word ptr XORCORDINATES[2]
        jl noTXOR2
        cmp bx,word ptr XORCORDINATES[6]
        jg notXOR2
        CALL MULPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        notXOR2:
        CMP AX,word ptr ANDCORDINATES[0]
        jb notAND2
        cmp AX,word ptr ANDCORDINATES[4]
        ja notAND2
        cmp bx,word ptr ANDCORDINATES[2]
        jb notAND2
        cmp bx,word ptr ANDCORDINATES[6]
        ja notAND2
        CALL SALPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        notAND2:

        CMP AX,word ptr ORCORDINATES[0]
        jl notOR2
        cmp AX,word ptr ORCORDINATES[4]
        jg notOR2
        cmp bx,word ptr ORCORDINATES[2]
        jl notOR2
        cmp bx,word ptr ORCORDINATES[6]
        jg notOR2
        CALL SARPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        notOR2:

        CMP AX,word ptr NOPCORDINATES[0]
        jl notNOP2
        cmp AX,word ptr NOPCORDINATES[4]
        jg notNOP2
        cmp bx,word ptr NOPCORDINATES[2]
        jl notNOP2
        cmp bx,word ptr NOPCORDINATES[6]
        jg notNOP2
        jmp far ptr RETmoveToRightLabelofPlayer2
        noTNOP2:

        CMP AX,word ptr SHRCORDINATES[0]
        jl notSHR2
        cmp AX,word ptr SHRCORDINATES[4]
        jg notSHR2
        cmp bx,word ptr SHRCORDINATES[2]
        jl notSHR2
        cmp bx,word ptr SHRCORDINATES[6]
        jg notSHR2
        CALL SHRPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        noTSHR2:


        CMP AX,word ptr SHLCORDINATES[0]
        jl notSHL2
        cmp AX,word ptr SHLCORDINATES[4]
        jg notSHL2
        cmp bx,word ptr SHLCORDINATES[2]
        jl notSHL2
        cmp bx,word ptr SHLCORDINATES[6]
        jg notSHL2
        CALL SHLPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        noTSHL2:

        CMP AX,word ptr RORCORDINATES[0]
        jl notROR2
        cmp AX,word ptr RORCORDINATES[4]
        jg notROR2
        cmp bx,word ptr RORCORDINATES[2]
        jl notROR2
        cmp bx,word ptr RORCORDINATES[6]
        jg notROR2
        CALL RORPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        noTROR2:
        CMP AX,word ptr ROLCORDINATES[0]
        jl notROL2
        cmp AX,word ptr ROLCORDINATES[4]
        jg notROL2
        cmp bx,word ptr ROLCORDINATES[2]
        jl notROL2
        cmp bx,word ptr ROLCORDINATES[6]
        jg notROL2
        CALL ROLPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        noTROL2:
        CMP AX,word ptr INCCORDINATES[0]
        jl notINC2
        cmp AX,word ptr INCCORDINATES[4]
        jg notINC2
        cmp bx,word ptr INCCORDINATES[2]
        jl notINC2
        cmp bx,word ptr INCCORDINATES[6]
        jg notINC2
        CALL INCPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        noTINC2:
        CMP AX,word ptr DECCORDINATES[0]
        jl notDEC2
        cmp AX,word ptr DECCORDINATES[4]
        jg notDEC2
        cmp bx,word ptr DECCORDINATES[2]
        jl notDEC2
        cmp bx,word ptr DECCORDINATES[6]
        jg notDEC2
        CALL DECPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        noTDEC2:


        CMP AX,word ptr DivCORDINATES[0]
        jl notDiv2
        cmp AX,word ptr DivCORDINATES[4]
        jg notDiv2
        cmp bx,word ptr DivCORDINATES[2]
        jl notDiv2
        cmp bx,word ptr DivCORDINATES[6]
        jg notDiv2
        CALL DIVPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        noTDiv2:

        CMP AX,word ptr IDivCORDINATES[0]
        jl notIDiv2
        cmp AX,word ptr IDivCORDINATES[4]
        jg notIDiv2
        cmp bx,word ptr IDivCORDINATES[2]
        jl notIDiv2
        cmp bx,word ptr IDivCORDINATES[6]
        jg notIDiv2
        CALL IDIVPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        noTIDiv2:

        CMP AX,word ptr IMULCORDINATES[0]
        jl notIMUL2
        cmp AX,word ptr IMULCORDINATES[4]
        jg notIMUL2
        cmp bx,word ptr IMULCORDINATES[2]
        jl notIMUL2
        cmp bx,word ptr IMULCORDINATES[6]
        jg notIMUL2
        CALL IMULPLAYER2PR
        jmp far ptr RETmoveToRightLabelofPlayer2
        noTIMUL2:

        RETmoveToRightLabelofPlayer2: RET
    moveToRightLabelofPlayer2 ENDP

    DRAW_REGISTER_NAMES PROC NEAR
    mov x1, 30
    mov y1, 540
    mov x2, 45
    mov y2, 570 
    movCursor 68,2 

    DrawButtonMessage mess 
    DrawRec x1,y1,x2,y2
    movCursor 68,4 

    add x1, 32
    add x2, 32


    DrawButtonMessage mess1 
    DrawRec x1,y1,x2,y2
    
    movCursor 68,6 

    add x1, 32
    add x2, 32

    DrawButtonMessage mess2 
    DrawRec x1, y1, x2,y2

    add x1, 32
    add x2, 32
    movCursor 68,8 
    DrawButtonMessage mess3 
    DrawRec x1, y1, x2,y2


    add x1, 32
    add x2, 32
    movCursor 68,10 
    DrawButtonMessage mess4 
    DrawRec x1, y1, x2,y2

    add x1, 32
    add x2, 32
    movCursor 68,12
    DrawButtonMessage mess5 
    DrawRec x1, y1, x2,y2


    add x1, 32
    add x2, 32
    movCursor 68,14
    DrawButtonMessage mess6 
    DrawRec x1, y1, x2,y2

    add x1, 32
    add x2, 32
    movCursor 68,16
    DrawButtonMessage mess7 
    DrawRec x1, y1, x2,y2


    movCursor 70,1 
    mov dx, offset player1_name+2 
    mov ah, 9h 
    int 21h 
    
    ret 
    DRAW_REGISTER_NAMES endp

    DRAW_REGISTER_NAMES2 PROC NEAR
    mov x1, 32
    mov y1, 410
    mov x2, 45
    mov y2, 440 
    movCursor 52,2 
    
    DrawButtonMessage mess 
    DrawRec x1,y1,x2,y2
    movCursor 52,4 

    add x1, 32
    add x2, 32


    DrawButtonMessage mess1 
    DrawRec x1,y1,x2,y2
    
    movCursor 52,6 

    add x1, 32
    add x2, 32

    DrawButtonMessage mess2 
    DrawRec x1, y1, x2,y2
    
    add x1, 32
    add x2, 32
    movCursor 52,8 
    DrawButtonMessage mess3 
    DrawRec x1, y1, x2,y2


    add x1, 32
    add x2, 32
    movCursor 52,10 
    DrawButtonMessage mess4 
    DrawRec x1, y1, x2,y2

    add x1, 32
    add x2, 32
    movCursor 52,12
    DrawButtonMessage mess5 
    DrawRec x1, y1, x2,y2


    add x1, 32
    add x2, 32
    movCursor 52,14
    DrawButtonMessage mess6 
    DrawRec x1, y1, x2,y2

    add x1, 32
    add x2, 32
    movCursor 52,16
    DrawButtonMessage mess7 
    DrawRec x1, y1, x2,y2


    movCursor 55,1
    mov dx, offset player2_name+2
    mov ah, 9h 
    int 21h 
    
    ret 
    DRAW_REGISTER_NAMES2 endp

    HIDE_POWER_UP PROC NEAR
        CALL FIXED
        ret
    HIDE_POWER_UP endp


    SHOW_POWER_UP PROC NEAR
        movCursor 65,18

        mov dx, offset POWER_BUTTON
        mov ah, 9h
        int 21h

        DrawRec 280,515,310,600

        ret
    SHOW_POWER_UP endp

    SHOW_INSTRUCTION_BUTTON PROC NEAR

        movCursor 5,2
        mov dx, offset INSTRUCTION_BUTTON
        mov ah, 9h
        int 21h
        DrawRec 20,30,60,140

        ret
    SHOW_INSTRUCTION_BUTTON endp

    SHOW_INSTRUCTIONS PROC NEAR
    
        CMP selected_level,'1'
        JNZ LEVEL2_LABEL2

        CALL FIXED
        JMP CONT01002
        LEVEL2_LABEL2:
        CALL FIXED_LEVEL_TWO

        CONT01002:
        movCursor 5,2
        PRINT_STRING_3DIGIT MOV_INS
        movCursor 12,2
        PRINT_STRING_3DIGIT ADD_INS

        movCursor 5,5
        PRINT_STRING_3DIGIT SUB_INS
        movCursor 12,5
        PRINT_STRING_3DIGIT DIV_INS

        movCursor 5,8
        PRINT_STRING_3DIGIT XOR_INS
        movCursor 12,8
        PRINT_STRING_3DIGIT AND_INS


        movCursor 5,11
        PRINT_STRING_3DIGIT SHR_INS
        movCursor 12,11
        PRINT_STRING_3DIGIT NOP_INS



        movCursor 5,14
        PRINT_STRING_3DIGIT SHL_INS
        movCursor 12,14
        PRINT_STRING_3DIGIT ROR_INS



        movCursor 5,17
        PRINT_STRING_3DIGIT ROL_INS
        movCursor 12,17
        PRINT_STRING_3DIGIT INC_INS



        movCursor 5,20
        PRINT_STRING_3DIGIT DEC_INS
        movCursor 12,20
        PRINT_STRING_3DIGIT OR_INS



        movCursor 5,23
        PRINT_STRING_4DIGIT IMUL_INS
        movCursor 12,23
        PRINT_STRING_4DIGIT IDIV_INS



        ;;DRAWING REC AROUND THEM
        ;;MOV REC
        DrawRec 25,30,50,70
        ;ADD REC
        DrawRec 25,90,50,130
        ;;SUB REC
        DrawRec 75,30,100,70
        ;;DIV REC
        DrawRec 75,90,100,130
        ;;XOR REC
        DrawRec 125,30,150,70
        ;;AND
        DrawRec 125,90,150,130
        ;;SHR
        DrawRec 175,30,200,70
        ;;NOP
        DrawRec 175,90,200,130
        ;;SHL REC
        DrawRec 220,30,250,70
        ;;ROR REC 
        DrawRec 220,90,250,130
        ;;ROL REC
        DrawRec 270,30,295,70
        ;;INC REC
        DrawRec 270,90,295,130
        ;;DEC REC
        DrawRec 315,30,345,70
        ;;OR REC
        DrawRec 315,90,345,130
        ;; IMUL REC
        DrawRec 360,30,385,80

        ;;IDIV REC
        DrawRec 360,90,385,140

        ret
    SHOW_INSTRUCTIONS endp

;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BEGIN_GAME PROC NEAR
        CALL SHOW_INSTRUCTION_BUTTON
        CALL SHOW_POWER_UP
        CALL FIXED
        ret
    BEGIN_GAME endp

     BEGIN_GAME_LEVEL_TWO PROC NEAR
    CALL SHOW_INSTRUCTION_BUTTON
    CALL SHOW_POWER_UP
    CALL FIXED_LEVEL_TWO  

    ret
    BEGIN_GAME_LEVEL_TWO endp
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    SHOW_1ST_OPERAND PROC NEAR
        call CLR
        CALL FIXED
        MOV DESTORSRC,0
        movCursor 5,2
        PRINT_STRING_3DIGIT ADDRESS_CHOICE
        movCursor 12,2

        PRINT_STRING_3DIGIT REGISTER_CHOICE
        ;;ADDRESS_CHOICE REC
        DrawRec 25,30,50,70
        ;REGISTER_CHOICE REC
        DrawRec 25,90,50,130

        call memoryOrReg
        
        ret
    SHOW_1ST_OPERAND endp
;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    SHOW_REGISTERS_CHOICE PROC NEAR
        CALL CLR    
        CALL FIXED

        movCursor 5,2
        PRINT_STRING_2DIGIT AL_REG
        movCursor 12,2
        PRINT_STRING_2DIGIT AH_REG

        movCursor 5,5
        PRINT_STRING_2DIGIT BL_REG
        movCursor 12,5
        PRINT_STRING_2DIGIT BH_REG

        movCursor 5,8
        PRINT_STRING_2DIGIT CL_REG
        movCursor 12,8
        PRINT_STRING_2DIGIT CH_REG


        movCursor 5,11
        PRINT_STRING_2DIGIT DL_REG
        movCursor 12,11
        PRINT_STRING_2DIGIT DH_REG



        movCursor 5,14
        PRINT_STRING_2DIGIT AX_REG
        movCursor 12,14
        PRINT_STRING_2DIGIT BX_REG



        movCursor 5,17
        PRINT_STRING_2DIGIT CX_REG
        movCursor 12,17
        PRINT_STRING_2DIGIT DX_REG



        movCursor 5,20
        PRINT_STRING_2DIGIT SI_REG
        movCursor 12,20
        PRINT_STRING_2DIGIT DI_REG



        movCursor 5,23
        PRINT_STRING_2DIGIT BP_REG
        movCursor 12,23
        PRINT_STRING_2DIGIT SP_REG



        ;;DRAWING REC AROUND THEM
        ;;AL REC
        DrawRec 25,30,50,70
        ;AH REC
        DrawRec 25,90,50,130
        ;;BL REC
        DrawRec 75,30,100,70
        ;;BH REC
        DrawRec 75,90,100,130
        ;;CL REC
        DrawRec 125,30,150,70
        ;;CH
        DrawRec 125,90,150,130
        ;;DL
        DrawRec 175,30,200,70
        ;;DH
        DrawRec 175,90,200,130
        ;;AX REC
        DrawRec 220,30,250,70
        ;;BX REC 
        DrawRec 220,90,250,130
        ;;CX REC
        DrawRec 270,30,295,70
        ;;DX REC
        DrawRec 270,90,295,130
        ;;SI REC
        DrawRec 315,30,345,70
        ;;DI REC
        DrawRec 315,90,345,130
        ;; BP REC
        DrawRec 360,30,385,70

        ;;SP REC
        DrawRec 360,90,385,130

        CMP DESTORSRC,1
        JNZ DEST_bridge
        jmp CLICKJump
        DEST_bridge: jmp far ptr DEST
        
        CLICKJump:CickedRegister SRC_INDEX_REG,SRC_INDEX_VAL,COUNT_BIT_2
        RET
        DEST:
        CickedRegister DEST_INDEX_REG,DEST_INDEX_VAL,COUNT_BIT_1
        ret
    SHOW_REGISTERS_CHOICE endp


    SHOW_POWER_UP_6 PROC NEAR
        movCursor 75,23
        PRINT_STRING_2DIGIT P6_VAR
        DrawRec 360,594,385,630
        RET
    SHOW_POWER_UP_6 ENDP

    SHOW_POWER_UPS_CHOICE PROC NEAR
        CMP selected_level,'1'
        JNZ LEVEL2_LABEL1
        CALL FIXED
        JMP CONT01001
        LEVEL2_LABEL1:
        CALL FIXED_LEVEL_TWO
        CALL SHOW_POWER_UP_6
        CONT01001:
        movCursor 62,20
        PRINT_STRING_2DIGIT POWER_UP_1ST
        movCursor 69,20
        PRINT_STRING_2DIGIT POWER_UP_2ST
        movCursor 62,23
        PRINT_STRING_2DIGIT POWER_UP_3ST
        movCursor 69,23
        PRINT_STRING_2DIGIT POWER_UP_5ST

        ;;P1 REC
        DrawRec 315,480,345,520
        ;;P2 REC
        DrawRec 315,540,345,580
        ;; P3 REC
        DrawRec 360,480,385,520

        ;;P5 REC
        DrawRec 360,540,385,580
        ret
    SHOW_POWER_UPS_CHOICE endp

    SHOW_PLAYER_ONE_NAME PROC NEAR
        movCursor 66,15
        mov dx, offset PLAYER_ONE_NAME
        mov ah, 9h
        int 21h
        ret
    SHOW_PLAYER_ONE_NAME endp

    SHOW_PLAYER_TWO_NAME PROC NEAR
        movCursor 66,15
        mov dx, offset PLAYER_TWO_NAME
        mov ah, 9h
        int 21h
        ret
    SHOW_PLAYER_TWO_NAME endp

    DRAW_CHAT_LINE PROC NEAR

        mov cx,0;Column
        mov dx,400 ;Row
        mov si,640
        mov al,5 ;Pixel color
        mov ah,0ch ;Draw Pixel Command
        back: int 10h
        inc cx
        dec si
        cmp si,0
        jnz back

        ret
    DRAW_CHAT_LINE endp

    DRAW_VERTICAL_LINE PROC NEAR

        mov cx, 400;Column
        mov dx,0 ;Row
        mov si,400
        mov al,0ah ;Pixel color
        mov ah,0ch ;Draw Pixel Command
        back0: int 10h
        inc dx
        cmp dx, 400
        jne back0
        
        ;;;;;;;;Data Segment Vertical Lines
        mov cx, 350;Column
        mov dx,0 ;Row
        mov si,400
        mov al,0ah ;Pixel color
        mov ah,0ch ;Draw Pixel Command
        back01: int 10h
        inc dx
        cmp dx, 400
        jne back01
        ;;;;;;;;;;;;;;;;;;;;;
        mov cx, 300;Column
        mov dx,0 ;Row
        mov si,400
        mov al,0ah ;Pixel color
        mov ah,0ch ;Draw Pixel Command
        back02: int 10h
        inc dx
        cmp dx, 400
        jne back02
        ;;;;;;;;;;;;;;;;;;;
        mov cx, 250;Column
        mov dx,0 ;Row
        mov si,400
        mov al,0ah ;Pixel color
        mov ah,0ch ;Draw Pixel Command
        back03: int 10h
        inc dx
        cmp dx, 400
        jne back03
        ;;;;;;;;;;;;;;
        mov cx, 200;Column
        mov dx,0 ;Row
        mov si,400
        mov al,0ah ;Pixel color
        mov ah,0ch ;Draw Pixel Command
        back04: int 10h
        inc dx
        cmp dx, 400
        jne back04
        ret
    DRAW_VERTICAL_LINE endp

    SHOW_PLAYERS_NAMES_ON_CHAT PROC NEAR
        movCursor 2,26
        mov dx, offset PLAYER_ONE_TITLE
        mov ah, 9h
        int 21h
        movCursor 2,28
        mov dx, offset PLAYER_TWO_TITLE
        mov ah, 9h
        int 21h
        ret
    SHOW_PLAYERS_NAMES_ON_CHAT endp


    SHOW_CHAT PROC NEAR
        CALL DRAW_CHAT_LINE
        CALL SHOW_PLAYERS_NAMES_ON_CHAT
        ret
    SHOW_CHAT endp

    SECONDSCREEN PROC NEAR
        CALL FIXED
        movCursor 14,9
        DrawButtonMessage VALUE
        DrawRec 130,90,170,190
        
        movCursor 14,14
        DrawButtonMessage REGISTER
        DrawRec 210,90,250,190

        movCursor 14,19
        DrawButtonMessage ADDRESS
        DrawRec 290,90,330,190

        RET
    SECONDSCREEN ENDP

    beginGame PROC NEAR
        call CLR
        movCursor 25,7
        print message1 
        movCursor 25,12
        print message2
        movCursor 25,17
        print message3
        loo:
        getKeyPressed
        cmp ah,1
        jne notscape
        jmp endoffile
        notscape:
        cmp ah,59
        jne notf1
        jmp begin
        notf1:
        cmp ah,60
        jne loo   
        ;jmp chat
        jmp loo
    beginGame ENDP

    CLEAR_SCREEN PROC NEAR	
		mov ax,0600h
        mov bh, 00h  ;set the color for the background
        mov cx,0
        mov dx,184fh
        int 10h
        RET
    CLEAR_SCREEN ENDP

    FIXED_LEVEL_TWO PROC NEAR
        CALL SHOW_GOAL
        CALL SHOW_INITIAL_POINTS
        CALL DRAW_DATA_SEGMENT
        CALL SHOW_REGISTERS_VALUES
        CALL DRAW_REGISTER_NAMES
        DrawRec 30, 535, 280, 639; draw rectangle around player1 registers
        call DRAW_VERTICAL_LINE
        call DRAW_REGISTER_NAMES2
        DrawRec 30, 405, 280,510
        CALL SHOW_CHAT
        ret
    FIXED_LEVEL_TWO endp

    SHOW_FORBIDDEN_CHARACTERS PROC NEAR
        ;;;;Player 1 Forbidden
        movCursor 51,18
        Print_Msg For1
        movCursor 54,18
        printCharacter Forbidden_char1
        ;;;;player 2 forbidden
        movCursor 51,20
        Print_Msg For2
        movCursor 54,20
        printCharacter Forbidden_char2
        ret
    SHOW_FORBIDDEN_CHARACTERS ENDP

    POWER_UP_1_1 PROC NEAR 
    
        CALL CLEAR_SCREEN 
        ;NOT PLAYERTURN 
        MOV power_up_player1,1  
        MOV power_up_player2,1  
        CALL TURN  
        MOV power_up_player1,0  
        MOV power_up_player2,0 
        ;NOT PLAYERTURN 
        
        RET 
        POWER_UP_1_1 ENDP 
        
        POWER_UP_2 PROC NEAR  
        CALL CLEAR_SCREEN 
        ;NOT PLAYERTURN 
        MOV power_up_player1,2 
        MOV power_up_player2,2  
        CALL TURN  
        MOV power_up_player1,0  
        MOV power_up_player2,0 
        ;NOT PLAYERTURN 
        
        
        RET 
    POWER_UP_2 ENDP 
        
    POWER_UP_3 PROC NEAR 

            CMP PLAYERTURN,0 
            JNZ SECONDPLAYER1 
            cmp intial_points_player1,8
            jb CONT0007_temp1
            sub intial_points_player1,8
            CMP power3_player1_used,1
            JZ CONT0007_temp1
            jnz RESUME
            CONT0007_temp1: jmp CONT0007

            RESUME:movCursor 5,2
            Print_Msg NEWFORBIDDEN_MSG
            movCursor 5,3
            mov ah, 07
            int 21h
            mov Forbidden_char2, al
            CALL set_zero_forbidden_player1 
            CALL set_forbidden_player1
            MOV power3_player1_used,1
            JMP CONT0007 
            SECONDPLAYER1: 
            cmp intial_points_player2,8
            jb CONT0007_TEMP2
            CMP power3_player2_used,1
            JZ CONT0007_TEMP2
            JNZ RESUME1
            CONT0007_TEMP2: JMP CONT0007
            RESUME1: sub intial_points_player2,8
            movCursor 5,2
            Print_Msg NEWFORBIDDEN_MSG
            movCursor 5,3
            mov ah, 07
            int 21h
            mov Forbidden_char1, al
            MOV power3_player2_used,1
            CALL set_zero_forbidden_player2 
            CALL set_forbidden_player2
            CONT0007: 
            RET 
    POWER_UP_3 ENDP 
        
    POWER_UP_5 PROC NEAR 
        CMP PLAYERTURN,0 
        JNZ SECONDPLAYER 
        cmp intial_points_player1,30
        jb CONT0009
        ; sub intial_points_player1,30
        MOV power5_player1_used,0
        call power5_player1 
        JMP CONT0009 
        SECONDPLAYER: 
        cmp intial_points_player2,30
        jb CONT0009
        ;sub intial_points_player2,30
        mov power5_player2_used,0
        call power5_player2 
        CONT0009: 
        RET 
    POWER_UP_5 ENDP 

    READGOAL PROC  FAR 
        call CLEAR_SCREEN
        call FIXED_LEVEL_TWO
        movCursor 5,2
        Print_Msg enterNewGoal
        movCursor 5,3
        readString inputValueString
        CALL CHECKINPUTVALUESIZE  
        CALL CONVERT 
        MOV AX,NUMBER
        MOV changed_target,AX
        RET
        READGOAL ENDP
        POWER_UP_6 PROC NEAR 
        CMP PLAYERTURN,0 
        JNZ SECONDPLAYER3 
        CALL READGOAL
        ; call READFOURDIGITFROMKEYBOARD 
        MOV AX, NUMBER
        MOV changed_target, AX
        CALL power6_p1
        JMP CONT0004 
        SECONDPLAYER3: 
        CALL READGOAL
        ; call READFOURDIGITFROMKEYBOARD 
        MOV AX, NUMBER
        MOV changed_target, AX
        CALL power6_p2
        CONT0004: 
        RET 
        POWER_UP_6 ENDP

    CHOOSE_POWER_UP PROC NEAR 
    CHECKCLICK2:     
        GETMOUSEPOSITION y,x 
        mov ax,x 
        mov bx,y 
        CMP Ax,word ptr P1CORDINATES[0] 
        jb notP11 
        cmp AX,word ptr P1CORDINATES[4] 
        ja notP11 
        cmp BX,word ptr P1CORDINATES[2] 
        jb notP11 
        cmp BX,word ptr P1CORDINATES[6] 
        ja notP11 
        cmp PLAYERTURN,0 
        JNZ PLAYER2_PROC1 
        cmp intial_points_player1,5 
        jb FINISH_CHOOSING1_temp1 
        ;sub intial_points_player1,5 
        CALL POWER_UP_1_1 
        FINISH_CHOOSING1_temp1:jmp FINISH_CHOOSING1 
        PLAYER2_PROC1: 
        ;CMP intial_points_player2,5 
        jb  FINISH_CHOOSING1_temp2 
        ;sub intial_points_player2,5 
        CALL POWER_UP_1_1 
        FINISH_CHOOSING1_temp2:JMP FINISH_CHOOSING1 
        ;jmp movlabelOfplayer1 
        notP11: 

        CMP AX,word ptr P2CORDINATES[0] 
        jl notP22 
        cmp AX,word ptr P2CORDINATES[4] 
        jg notP22 
        cmp bx,word ptr P2CORDINATES[2] 
        jl notP22 
        cmp bx,word ptr P2CORDINATES[6] 
        jg noTP22 
        cmp intial_points_player1,3 
        jb FINISH_CHOOSING1 
        CALL POWER_UP_2
        ;sub intial_points_player1,3 
        
        JMP FINISH_CHOOSING1 
        ;jmp ADDlabelOfPlayer1 
        notP22: 
        CMP AX,word ptr P3CORDINATES[0] 
        jl notP33 
        cmp AX,word ptr P3CORDINATES[4] 
        jg notP33 
        cmp bx,word ptr P3CORDINATES[2] 
        jl notP33 
        cmp bx,word ptr P3CORDINATES[6] 
        jg notP33 
        CALL CLR    
        CALL POWER_UP_3
        JMP FINISH_CHOOSING1 
        notP33: 
        CMP AX,word ptr P5CORDINATES[0] 
        jl notP55 
        cmp AX,word ptr P5CORDINATES[4] 
        jg notP55 
        cmp bx,word ptr P5CORDINATES[2] 
        jl notP55 
        cmp bx,word ptr P5CORDINATES[6] 
        jg notP55 
        CALL POWER_UP_5
        JMP FINISH_CHOOSING1 
        notP55: 
        CMP selected_level,'1'
        JZ FINISH_CHOOSING1
        CMP AX,word ptr P6CORDINATES[0] 
        jl notP6 
        cmp AX,word ptr P6CORDINATES[4] 
        jg notP6 
        cmp bx,word ptr P6CORDINATES[2] 
        jl notP6 
        cmp bx,word ptr P6CORDINATES[6] 
        jg notP6 
        CALL POWER_UP_6
        JMP FINISH_CHOOSING1 
        notP6: 
            JMP CHECKCLICK2 
        FINISH_CHOOSING1: 
            RET 
    CHOOSE_POWER_UP ENDP

    setInitialPoints PROC NEAR
        mov al, intial_points_player1
        mov ah, intial_points_player2
        cmp ah, al
        ja  setP1Points 
        mov bl, ah
        jmp finish2
        setP1Points:
            mov bl, al
        
        finish2:
        mov intial_points_player1, bl
        mov intial_points_player2, bl
        ret 
               
    setInitialPoints endp

    GetEnterKeyPressed PROC NEAR
        push ax
        CHECK: mov ah,1
        int 16h
        ;will store the results in the related variables 
        jz CHECK
        MOV AH, 0
        INT 16H 
        cmp al, 13 ;SCAN CODE
        jnz CHECK
        pop ax
        ret
    GetEnterKeyPressed ENDP 

    player1_forbidden_screen PROC NEAR
       
        ;read forbiiden
        setTextCursor 20, 10
        Print_Msg forbiddenCharMess
        setTextCursor 25, 11
        readChar forbidden_char2
        DisplayChar 25, 11, forbidden_char2

        ;read level
        setTextCursor 20, 13
        Print_Msg levelMessage
        setTextCursor 35, 14
        
        readLevel: readChar selected_level
        cmp selected_level, "1"
        je valid
        cmp selected_level, "2" 
        jne readLevel
        valid: DisplayChar 35, 14, selected_level
        
        setTextCursor 20, 16
        Print_Msg press
        CALL GetEnterKeyPressed

        ret
    player1_forbidden_screen endp
    
    player2_forbidden_screen PROC NEAR
    
        ;read forbiiden
        setTextCursor 20, 10
        Print_Msg forbiddenCharMess

        setTextCursor 25, 11
        readChar forbidden_char1
        DisplayChar 25, 11,forbidden_char1

        setTextCursor 20, 13
        Print_Msg press
        CALL GetEnterKeyPressed

        ret
    player2_forbidden_screen endp

    player1Screen PROC NEAR
        setTextCursor 35, 2
        Print_Msg player1_mess
        ;read name
        setTextCursor 30, 10
        Print_Msg enter_name
        setTextCursor 35, 11
        readString player1_name

        ;read initial point
        setTextCursor 30, 13
        Print_Msg initialP
        setTextCursor 35, 14
        readString intial_points_player1
        strToInt intial_points_player1
        setTextCursor 30, 16
        Print_Msg press
        CALL GetEnterKeyPressed

        ret
    player1Screen endp
    
    player2Screen PROC NEAR
        setTextCursor 35,2
        Print_Msg player2_mess
        ;read name
        setTextCursor 30, 10
        Print_Msg enter_name
        setTextCursor 35, 11
        readString player2_name

        ;read initial point
        setTextCursor 30, 13
        Print_Msg initialP
        setTextCursor 35, 14
        readString intial_points_player2
        strToInt intial_points_player2
        setTextCursor 30, 16
        Print_Msg press
        CALL GetEnterKeyPressed
        ret
    player2Screen endp

    SHOW_GOAL PROC NEAR
        movCursor 51,22
        Print_Msg GOAL_VAR
        movCursor 56,22
        push ax
        mov ax,target
        mov temp_var, ah 

        print2Number temp_var
        movCursor 58,22 
        mov temp_var, al
        print2Number temp_var
        pop ax

        ret
    SHOW_GOAL endp

    SHOW_INITIAL_POINTS PROC NEAR

        ;;;;Player 1 initial Points
        movCursor 51,0
        Print_Msg Initial_PL1
        movCursor 54,0
        DISPLAY_2_DIGITS intial_points_player1

        ;;;;;player 2 initial points
        movCursor 67,0
        Print_Msg Initial_PL2
        movCursor 70,0
        DISPLAY_2_DIGITS intial_points_player2
        RET
    SHOW_INITIAL_POINTS ENDP


    DRAW_DATA_SEGMENT  PROC NEAR
        mov Data_Segment_X,27
        mov Data_Segment_Y,1
        mov di,0
        mov Counter_Segment,16
        loop1:
            movCursor Data_Segment_X,Data_Segment_Y
            ;mov ch ,data_segment_1[di]
            print2Number  data_segment_1[di]
            add Data_Segment_Y,1
            inc di
            sub Counter_Segment,1
            cmp Counter_Segment,0
            jnz loop1
            mov Counter_Segment,16
            mov di,0
            mov Data_Segment_Y,1
            add Data_Segment_X,7
            loop2:
                movCursor Data_Segment_X,Data_Segment_Y
                printCharacter Counter[di]
                add Data_Segment_Y,1
                inc di
                sub Counter_Segment,1
                cmp Counter_Segment,0
                jnz loop2
                mov Counter_Segment,16
                mov di,0

                mov Data_Segment_Y,1
                add Data_Segment_X,12
            loop3:
                movCursor Data_Segment_X,Data_Segment_Y
                printCharacter Counter[di]
                add Data_Segment_Y,1
                inc di
                sub Counter_Segment,1
                cmp Counter_Segment,0
                jnz loop3

                mov Data_Segment_Y,1
                sub Data_Segment_X,5

                mov Counter_Segment,16
                mov di,0
            loop4:
                movCursor Data_Segment_X,Data_Segment_Y
                ;mov ch ,data_segment_2[di]
                print2Number  data_segment_2[di]
                add Data_Segment_Y,1
                inc di
                sub Counter_Segment,1
                cmp Counter_Segment,0
                jnz loop4
                movCursor 27,20
                PRINT_STRING_2DIGIT P1
                movCursor 40,20
                PRINT_STRING_2DIGIT P2
                movCursor 51,1
                PRINT_STRING_2DIGIT P1
                
                movCursor 67,1
                PRINT_STRING_2DIGIT P2

        RET
    DRAW_DATA_SEGMENT ENDP

    SHOW_REGISTERS_VALUES PROC NEAR

    ;;;;;;;;;;;;;Player 1
        mov Register_Values_X,60
        mov Register_Values_Y,2
        mov Inner_Counter_RV,2
        mov Outer_Counter_RV,8
        movCursor Register_Values_X,Register_Values_Y
        mov di,1
        loop001:
            
                print2Number Player1_Data_Register[di]
                dec di
                sub Register_Values_X,3
                movCursor Register_Values_X,Register_Values_Y
                print2Number Player1_Data_Register[di]
                add Register_Values_X,3

                add di,3
                add Register_Values_Y,2
                movCursor Register_Values_X,Register_Values_Y     
                sub Outer_Counter_RV,1        
                cmp Outer_Counter_RV,0
                jz SHOW_REGISTERS_VALUES_start_loop2
                JMP FAR PTR loop001

        SHOW_REGISTERS_VALUES_start_loop2:
        ;;;;;;;;;;;;;;;;;;;;Player 2
        mov Register_Values_X,75
        mov Register_Values_Y,2
        mov Inner_Counter_RV,2
        mov Outer_Counter_RV,8
        movCursor Register_Values_X,Register_Values_Y
        mov di,1
        loop002:
            print2Number Player2_Data_Register[di]
            dec di
            sub Register_Values_X,3
            movCursor Register_Values_X,Register_Values_Y
            print2Number Player2_Data_Register[di]
            add Register_Values_X,3
            add di,3
            add Register_Values_Y,2
            movCursor Register_Values_X,Register_Values_Y     
            sub Outer_Counter_RV,1        
            cmp Outer_Counter_RV,0
            jnz loop0002
            jmp endloop002
        loop0002:
            jmp far ptr loop002
        endloop002:
            ret
    SHOW_REGISTERS_VALUES ENDP
    
;     ;description: the fixed data of each screen, players' registers
    FIXED proc NEAR
        CALL SHOW_GOAL
        CALL SHOW_INITIAL_POINTS
        CALL SHOW_FORBIDDEN_CHARACTERS
        CALL DRAW_DATA_SEGMENT
        CALL SHOW_REGISTERS_VALUES
        CALL DRAW_REGISTER_NAMES
        DrawRec 30, 535, 280, 639; draw rectangle around player1 registers
        call DRAW_VERTICAL_LINE
        call DRAW_REGISTER_NAMES2
        DrawRec 30, 405, 280,510
        CALL SHOW_CHAT
        RET
    FIXED endp

    TURN PROC NEAR
        ; AH=2h: Set cursor position
        mov dl, 2 ; Column
        mov dh, 3 ; Row
        mov bx, 0 ; Page number, 0 for graphics modes
        mov ah, 2h
        int 10h

        CALL CLR
        CALL SHOW_POWER_UP
        
        CMP selected_level,'1'
        JNZ LEVEL2_LABEL

        CALL BEGIN_GAME
        JMP CONT0100
        LEVEL2_LABEL:
        CALL BEGIN_GAME_LEVEL_TWO
        CONT0100:
        ;;ASAAD'S TEST OF MOUSE CLICKS
        MainScreen: getMousePosition x, y
                    cmp x,150
                    jb CHOICE_INSTRUCTION
                    JMP CHOICE_POWERUPS
        CHOICE_INSTRUCTION:
            cmp y, 20
            jb MainScreen
            cmp y, 60
            ja MainScreen

            cmp x, 30
            jb MainScreen
            cmp x, 140
            ja MainScreen_bridge 
            jmp continue_choice_instruction
            MainScreen_bridge: jmp MainScreen
            continue_choice_instruction:
            CALL CLR
            MOV INSTorPOWERUP,1
            CALL SHOW_INSTRUCTIONS
            ;print message
            CMP PLAYERTURN,0
            JNZ PLAYER2TURNCALLPROC
            call moveToRightLabelofPlayer1
            JMP CON15
            PLAYER2TURNCALLPROC:
            call moveToRightLabelofPlayer2
        CON15:
            JMP NEXT_CHOICE
        CHOICE_POWERUPS:
            cmp y, 280
            jb MainScreen_bridge
            cmp y, 310
            ja MainScreen_bridge
            cmp x, 515
            jb MainScreen_bridge
            cmp x, 600
            ja MainScreen_bridge
            CALL CLR
            MOV INSTorPOWERUP,0
            CALL  SHOW_POWER_UPS_CHOICE
            CALL CHOOSE_POWER_UP
        NEXT_CHOICE:
            CMP INSTorPOWERUP,0
            JZ POWERUPisCHOSEN
            JNZ firstoperand
        POWERUPisCHOSEN:
        firstoperand: 
        Show_mouse
        RET
    TURN ENDP

    PLAYER1LEVEL2 PROC NEAR
        setTextCursor 20, 2
        Print_Msg LEVEL2MESS
        
        setTextCursor 20, 4
        Print_Msg player1_mess
        ;Read initial value for Player1 AX
        setTextCursor 2, 5
        print_Msg mess
        setTextCursor 6, 5
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player1_data_register[0], AH
        mov player1_data_register[1], AL
        
        ;Read initial value for Player1 BX
        setTextCursor 2, 6
        print_Msg mess1
        setTextCursor 6, 6
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player1_data_register[2], AH
        mov player1_data_register[3], AL

        ;Read initial value for Player1 CX
        setTextCursor 2, 7
        print_Msg mess2
        setTextCursor 6, 7
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player1_data_register[4], AH
        mov player1_data_register[5], AL  

        ;Read initial value for Player1 DX
        setTextCursor 2, 8
        print_Msg mess3
        setTextCursor 6, 8
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player1_data_register[6], AH
        mov player1_data_register[7], AL 

        ;Read initial value for Player1 SI
        setTextCursor 2, 9
        print_Msg mess4
        setTextCursor 6, 9
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player1_data_register[8], AH
        mov player1_data_register[9], AL

        ;Read initial value for Player1 DI
        setTextCursor 2, 10
        print_Msg mess5
        setTextCursor 6,10
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player1_data_register[10], AH
        mov player1_data_register[11], AL

        ;Read initial value for Player1 BP
        setTextCursor 2, 11
        print_Msg mess6
        setTextCursor 6, 11
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player1_data_register[12], AH
        mov player1_data_register[13], AL

        ;Read initial value for Player1 DI
        setTextCursor 2, 12
        print_Msg mess4
        setTextCursor 6, 12
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player1_data_register[14], AH
        mov player1_data_register[15], AL
        ret    
    PLAYER1LEVEL2  ENDP

    PLAYER2LEVEL2 PROC NEAR
        setTextCursor 20, 2
        Print_Msg LEVEL2MESS
        
        setTextCursor 20, 4
        Print_Msg player2_mess
        ;Read initial value for Player1 AX
        setTextCursor 2, 5
        print_Msg mess
        setTextCursor 6, 5
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player2_data_register[0], AH
        mov player2_data_register[1], AL
        
        ;Read initial value for Player1 BX
        setTextCursor 2, 6
        print_Msg mess1
        setTextCursor 6, 6
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player2_data_register[2], AH
        mov player2_data_register[3], AL

        ;Read initial value for Player1 CX
        setTextCursor 2, 7
        print_Msg mess2
        setTextCursor 6, 7
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player2_data_register[4], AH
        mov player2_data_register[5], AL  

        ;Read initial value for Player1 DX
        setTextCursor 2, 8
        print_Msg mess3
        setTextCursor 6, 8
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player2_data_register[6], AH
        mov player2_data_register[7], AL 

        ;Read initial value for Player1 SI
        setTextCursor 2, 9
        print_Msg mess4
        setTextCursor 6, 9
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player2_data_register[8], AH
        mov player2_data_register[9], AL

        ;Read initial value for Player1 DI
        setTextCursor 2, 10
        print_Msg mess5
        setTextCursor 6,10
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player2_data_register[10], AH
        mov player2_data_register[11], AL

        ;Read initial value for Player1 BP
        setTextCursor 2, 11
        print_Msg mess6
        setTextCursor 6, 11
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player2_data_register[12], AH
        mov player2_data_register[13], AL

        ;Read initial value for Player1 DI
        setTextCursor 2, 12
        print_Msg mess4
        setTextCursor 6, 12
        call READFOURDIGITFROMKEYBOARD
        mov AX, INITIALVALUE
        mov player2_data_register[14], AH
        mov player2_data_register[15], AL
        ret    
    PLAYER2LEVEL2  ENDP
    
    readonedigitfromkeyboard PROC  FAR

        mov ah,07
        int 21h
        mov ah,2
        mov dl,AL
        int 21h
        mov TEMP,al
        cmp TEMP, 30h
        jb alphabet
        cmp TEMP,39h
        ja alphabet
        ;if not alphabet :
        sub TEMP,30h
        jmp next

        alphabet:
        cmp TEMP,41h 
        jb notcapital                                             
        cmp TEMP,46h
        ja notcapital
        sub TEMP,37h
        jmp next

        ;if not capital 
        notcapital:
        cmp TEMP,61h
        jb error
        cmp TEMP,66h
        ja error
        sub TEMP,57h
        jmp next


        ;if enter in valid number
        error:
            
        next:            
        RET
    readonedigitfromkeyboard   ENDP 

    READTWODIGITfromkeyboard PROC  FAR
        CALL  readonedigitfromkeyboard
        MOV BL,TEMP
        CALL  readonedigitfromkeyboard 
        MOV AL,BL
        MOV CL,10h
        MUL CL     
        ADD TEMP,AL   
        RET
    READTWODIGITfromkeyboard ENDP 


    READFOURDIGITFROMKEYBOARD PROC NEAR
        CALL READTWODIGITfromkeyboard       
        MOV AL,TEMP
        MOV BYTE PTR INITIALVALUE[1],AL
        MOV AL,0 
        CALL READTWODIGITfromkeyboard               
        MOV AL,TEMP
        MOV BYTE PTR INITIALVALUE[0],AL
        RET

    READFOURDIGITFROMKEYBOARD ENDP
                    
    winnerscreen PROC NEAR
        mov al, 03
        mov ah, 0
        int 10h
        ClearScreen 0,0,79,24
        SETTEXTCURSOR 15,5
        print_Msg winmess
        SETTEXTCURSOR 30,5 
        CMP win_player1,1
        JNZ PLAYER2WON
        print_Msg player1_name+2
        JMP FINISHWINNINGSCREEN
        PLAYER2WON:
        print_Msg player2_name+2
        FINISHWINNINGSCREEN:
        SETTEXTCURSOR 20,10
        Print_Msg press
        CALL GetEnterKeyPressed 
            
        ret
    winnerscreen endp
    
    
