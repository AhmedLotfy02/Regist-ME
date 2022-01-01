.model huge
.stack 64
.data
instructions db "MOV ", "ADD ", "SUB ", "MUL ", "DIV ", "INC ", "DEC ", "NOP ", "SAL ", "SHR ", "SHL ", "ROR ", "ROL ", "SAR ","IDIV ", "IMUL "  
registers db "AX ", "AL ", "AH ", "BX ", "BL ", "BH ", "CX ", "CL ", "CH ", "DX ", "DL ", "DH ", "SI ", "DI ", "SP ", "BP ","val ","address "
digits db "0 ", "1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 "  
message db 'he pressed the mov','$'
MOUSEPOSITION_X dw ?
MOUSEPOSITION_Y dw ?
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    src_index_reg db 0
    dest_index_reg db 17
    src_index_val db 0
    dest_index_val db 18 
    address_mode db 0      ;first operand is address ----> set 1  ,if isn't address ---->set 0
    address_mode2 db 1     ;second operand is address ----> set 1 ,if isn't address ---->set 0
    count_bit_1 db 1       ; byte --> 1  , word ---> 2  first operand 
    count_bit_2 db 1       ; byte --> 1  , word ---> 2  second operand 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; instructions coordinates;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MOVCORDINATES  dw 25,30,50,70
    ADDCORDINATES  dw 25,90,50,130
    SUBCORDINATES  dw 75,30,100,70 
    DIVCORDINATES  dw 75,90,100,130
    XORCORDINATES  dw 125,30,150,70
    ANDCORDINATES dw 125,90,150,130
    SHRCORDINATES dw 175,30,200,70
    NOPCORDINATES dw 175,90,200,130
    SHLCORDINATES  dw 220,30,250,70
    RORCORDINATES  dw 220,90,250,130
    ROLCORDINATES  dw 270,30,295,70
    INCCORDINATES  dw 270,90,295,130
    DECCORDINATES  dw 315,30,345,70
    ORCORDINATES  dw 315,90,345,130
    IMULCORDINATES dw 360,30,385,80
    IDIVCORDINATES dw 360,90,385,140
    x1 dw ?
        x2 dw ?
        y1 dw ?
        y2 dw ?
        VALUE DB 'VALUE','$'
        REGISTER DB 'REGISTER','$'
        ADDRESS DB 'ADDRESS','$'
        P1Name db 'Asaad', '$'
        P2Name db 'Nabil', '$'
        chara db 'c'
        mess db 'AX: ','$'
        mess1 db 'BX: ','$'
        mess2 db 'CX: ','$'
        mess3 db 'DX: ','$'
        mess4 db 'SI:','$'
        mess5 db 'DI:','$'
        mess6 db 'SP:','$'
        mess7 db 'BP:','$'
        name1 db 'NAME:','$'
        POWER_BUTTON db 'POWER UPS','$'
        INSTRUCTION_BUTTON db 'INSTRUCTION','$'
        MOV_INS DB 'MOV','$'
        ADD_INS DB 'ADD','$'
        SUB_INS DB 'SUB','$'
        DIV_INS DB 'DIV','$'
        IDIV_INS DB 'IDIV','$'
        IMUL_INS DB 'IMUL', '$'
        XOR_INS DB 'XOR','$'
        AND_INS DB 'AND','$'
        OR_INS DB 'OR_','$'
        NOP_INS DB 'NOP','$'
        SHR_INS DB 'SHR','$'
        SHL_INS DB 'SHL','$'
        ROR_INS DB 'ROR','$'
        ROL_INS DB 'ROL','$'
        INC_INS DB 'INC','$'
        DEC_INS DB 'DEC','$'
        ADDRESS_CHOICE DB 'MEM','$'
        REGISTER_CHOICE DB 'REG','$'
        VALUE_CHOICE DB 'VAL','$'
        AH_REG DB 'AH','$'
        AL_REG DB 'AL','$'
        AX_REG DB 'AX','$'
        BH_REG DB 'BH','$'
        BL_REG DB 'BL','$'
        BX_REG DB 'BX','$'
        CL_REG DB 'CL','$'
        CH_REG DB 'CH','$'
        CX_REG DB 'CX','$'
        DH_REG DB 'DH','$'
        DL_REG DB 'DL','$'
        DX_REG DB 'DX','$'
        SI_REG DB 'SI','$'
        DI_REG DB 'DI','$'
        SP_REG DB 'SP','$'
        BP_REG DB 'BP','$'
        POWER_UP_1ST DB 'P1','$'
        POWER_UP_2ST DB 'P2','$'
        POWER_UP_3ST DB 'P3','$'
        POWER_UP_5ST DB 'P5','$'
        PLAYER_ONE_NAME DB 15,?,15 DUP('$')
        PLAYER_TWO_NAME DB 15,?,15 DUP('$')
        PLAYER_ONE_TITLE DB 'PLAYER ONE:','$'
        PLAYER_TWO_TITLE DB 'PLAYER TWO:','$'
        INSTorPOWERUP DB ?
        ;;tests
        x DW ?
        y dw ?
        message1 db 'to start game prress f1$'
        message2 db 'to start chat prress f2$'
        message3 db 'to end game prress esc$'
        ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
        drawFilledRec MACRO xb,yb,xen,yen,color
            local firstLoop,secondLoop  
            PUSH AX
            PUSH DX
            PUSH CX
            PUSH DI

            mov cx,Yb ;Column
            mov dx,Xb ;Row
            mov BX, xen
            mov di,yen

            mov al,COLOR ;Pixel color
            mov ah,0ch ;Draw Pixel Command
            firstLoop:
            mov cx,yb
            secondLoop:
            int 10h
            inc cx
            cmp cx,DI
            jnz secondLoop
            inc dx
            cmp dx,BX
            jnz firstLoop

            POP DI
            pop Cx
            pop DX
            pop ax
            
        ENDM






        DrawRec Macro Xb,Yb,Xen,Yen 
            local back1, back2, back3, back4
            PUSH AX
            PUSH DX
            PUSH CX
            mov cx,Yb ;Column
            mov dx,Xb ;Row
            mov al,5 ;Pixel color
            mov ah,0ch ;Draw Pixel Command



            back1: int 10h
            inc cx
            cmp cx,Yen
            jnz back1 

            mov cx,Yb ;Column
            mov dx,Xen ;Row

            back2: int 10h
            inc cx
            cmp cx,Yen
            jnz back2 

            mov cx,Yb ;Column
            mov dx,Xb ;Row
                    
            back3: int 10h
            inc dx
            cmp dx,xen
            jnz back3

            mov cx,Yen ;Column
            mov dx,Xb ;Row
                    
            back4: int 10h
            inc dx
            cmp dx,xen
            jnz back4
            POP CX 
            POP DX
            POP AX

        ENDM


        PRINT_STRING_2DIGIT MACRO Stringo
            local loop4
            mov di,0    
            mov cx,2
            loop4:
                printCharacter Stringo[di]
                inc di
            loop loop4 

        ENDM



        PRINT_STRING_3DIGIT MACRO Stringo
            local loop4
            mov di,0    
            mov cx,3
            loop4:
                printCharacter Stringo[di]
                inc di
            loop loop4 

        ENDM


        PRINT_STRING_4DIGIT MACRO Stringo
            local loop4
            mov di,0    
            mov cx,4
            loop4:
                printCharacter Stringo[di]
                inc di
            loop loop4 

        ENDM

        DrawButtonMessage macro String
            local loop4
            pusha

            mov di,0   
            mov bh, '$' 
            loop4:
                printCharacter String[di]
                inc di
                mov bl, String[di]
                cmp bl, bh
            jne loop4

            popa
        ENDM

        movCursor MACRO x, y
            ; Push all used regeister in stack to get their original value after the operation
            push ax
            push dx
            
            ; Intrrupt to mov the cursor to determined position
            mov ah, 2h
            mov dl, x
            mov dh, y
            int 10h
            
            pop dx
            pop ax
            
        ENDM movCursor
        ClearScreen MACRO beginCol,beginRow,endCol,endRow 
            ; Push all used regeister in stack to get their original value after the operation 
            push ax
            push bx
            push cx
            push dx
            mov ax,0600h
            mov bh,0
            ; assign registers to detrmined clear area
            mov cl,beginCol
            mov ch,beginRow
            mov dl,endCol
            mov dh,endRow
            ;interrupt to clear dtermined screen
            int 10h
            pop dx
            pop cx
            pop bx
            pop ax
            
        ENDM

        setTextCursor macro Column, Row
            pusha
                mov  dl,  Column    
                mov  dh,  Row    
                mov  bh,  0                                              ;page no.
                mov  ah,  2     
                int  10h       
            popa
        endm setTextCursor

        displayCharacter macro Char                                     ;Takes a character and displays it
            mov dl,  Char
            add dl, 30h
            mov ah,  2h
            int 21h
        endm displayCharacter
        
        printCharacter macro Char                                     ;Takes a character and displays it
            mov dl,  Char
            mov ah,  2h
            int 21h
        endm printCharacter

        blankScreen macro color,  from_x,  to_x                                     ;from,  to indicates the range on x-axis
            mov ah, 06                                                          ;Scroll (Zero lines anyway)
            mov al, 00h                                                         ;to blank the screen
            mov bh, color                                                       ;color to blank the screen with
            mov ch,  0h                                                         ;0 to 24 (text mode is 80x25)
            mov cl, from_x 
            mov dh,  24
            mov dl, to_x
                                                                                ;to the end of the screen
            int 10h
        endm blankScreen 

        Print macro Stringo                                             ;Takes a string and prints it 
                mov AH, 09h 
                mov dx, offset Stringo 
                int 21h 
        endm Print

        Show_mouse Macro 
            push ax
            mov ax,1
            int 33h    
            pop ax
        Endm  
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        HideMouse macro
            push ax
            mov ax,2
            int 33h
            pop ax
        ENDM 
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        



        getMousePosition Macro x, y
            ; Push all used regeister in stack to get their original value after the operation 
            local Mypos
            Show_mouse
            push ax
            push cx
            push bx
            push dx
            
            ;Intrrupt to get the mouse position x in CX, y in DX, Mouse status in BX
            mov ax, 3
            mov bx,0
            Mypos:int 33h
            cmp bx,1           ; on click will close the loop
            ;jz print 
            jnz Mypos         ;wait for click
            mov x, cx         ;save the x-coordinate
            mov y, dx         ;save the y-coordinate
            
            pop dx
            pop bx
            pop cx
            pop ax              ; you need to jmp zero after the macro jz mov_instruction  
            
        Endm



;we will use the variables of the coordinates of the registers in the GUI
.code
Print macro Stringo                                             ;Takes a string and prints it 
            mov AH, 09h 
            mov dx, offset Stringo 
            int 21h 
    endm Print
;------------------------------------------ Macros for clicking an icon on the GUI of player1 -----------------------------------------------
moveToRightLabelofPlayer1 proc FAR 
    ; local notmov;,movlabel,notADD,ADDabel,notADC,ADCLabel,notSUB,SUBLabel,notSBB,SBBlabel,notXOR,XORlabel,notAND,ANDlabel,notOR,ORlabel,notNOP,NOPlabel,notSHR,SHRlabel,notSHL,SHLlabel,notSAR,SARlabel,notCLC,CLClabel,notROR,RORlabel,notROL,ROLlabel,notRCL,RCLlabel,notRCR,RCRlabel,notPUSH,PUSHlabel,notPOP,POPlabel,notINC,INClabel,notDEC,DEClabel,notDiv,Divlabel,notIDiv,IDivlabel,notMUL,MULlabel,notIMUL,IMULlabel
    ; PUSH AX
    ; PUSH BX
    ; PUSH CX
    ; PUSH DX
    

    
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
    print message
    ;jmp movlabelOfplayer1
    notmov:


    
    CMP AX,word ptr ADDCORDINATES[0]
    jl notADD
    cmp AX,word ptr ADDCORDINATES[4]
    jg notADD
    cmp bx,word ptr ADDCORDINATES[2]
    jl notADD
    cmp bx,word ptr ADDCORDINATES[6]
    jg noTADD
    ;jmp ADDlabelOfPlayer1
    notADD:



    ; CMP AX,word ptr ADCCORDINATES[0]
    ; jl notADC
    ; cmp AX,word ptr ADCCORDINATES[4]
    ; jg notADC
    ; cmp bx,word ptr ADCCORDINATES[2]
    ; jl notADC
    ; cmp bx,word ptr ADCCORDINATES[6]
    ; jg notADC
    ; jmp ADCLabelOfPlayer1
    ; notADC:




    CMP AX,word ptr SUBCORDINATES[0]
    jl notSUB
    cmp AX,word ptr SUBCORDINATES[4]
    jg notSUB
    cmp bx,word ptr SUBCORDINATES[2]
    jl notSUB
    cmp bx,word ptr SUBCORDINATES[6]
    jg notSUB
    ;jmp SUBLabelOfPlayer1
    notSUB:




    ; CMP AX,word ptr SBBCORDINATES[0]
    ; jl notSBB
    ; cmp AX,word ptr SBBCORDINATES[4]
    ; jg notSBB
    ; cmp bx,word ptr SBBCORDINATES[2]
    ; jl notSBB
    ; cmp bx,word ptr SBBCORDINATES[6]
    ; jg notSBB
    ; ;jmp SBBlabelOfPlayer1
    ; notSBB:




    CMP AX,word ptr XORCORDINATES[0]
    jl notXOR
    cmp AX,word ptr XORCORDINATES[4]
    jg notXOR
    cmp bx,word ptr XORCORDINATES[2]
    jl noTXOR
    cmp bx,word ptr XORCORDINATES[6]
    jg notXOR
    ;jmp XORlabelOfPlayer1
    notXOR:



    CMP AX,word ptr ANDCORDINATES[0]
    jb notAND
    cmp AX,word ptr ANDCORDINATES[4]
    ja notAND
    cmp bx,word ptr ANDCORDINATES[2]
    jb notAND
    cmp bx,word ptr ANDCORDINATES[6]
    ja notAND
    ;jmp ANDlabelOfPlayer1
    ;print message
    notAND:


    CMP AX,word ptr ORCORDINATES[0]
    jl notOR
    cmp AX,word ptr ORCORDINATES[4]
    jg notOR
    cmp bx,word ptr ORCORDINATES[2]
    jl notOR
    cmp bx,word ptr ORCORDINATES[6]
    jg notOR
    ;jmp ORlabelOfPlayer1
    notOR:



    CMP AX,word ptr NOPCORDINATES[0]
    jl notNOP
    cmp AX,word ptr NOPCORDINATES[4]
    jg notNOP
    cmp bx,word ptr NOPCORDINATES[2]
    jl notNOP
    cmp bx,word ptr NOPCORDINATES[6]
    jg notNOP
    ;jmp NOPlabelOfPlayer1
    noTNOP:



    CMP AX,word ptr SHRCORDINATES[0]
    jl notSHR
    cmp AX,word ptr SHRCORDINATES[4]
    jg notSHR
    cmp bx,word ptr SHRCORDINATES[2]
    jl notSHR
    cmp bx,word ptr SHRCORDINATES[6]
    jg notSHR
    ;jmp SHRlabelOfPlayer1
    noTSHR:


    CMP AX,word ptr SHLCORDINATES[0]
    jl notSHL
    cmp AX,word ptr SHLCORDINATES[4]
    jg notSHL
    cmp bx,word ptr SHLCORDINATES[2]
    jl notSHL
    cmp bx,word ptr SHLCORDINATES[6]
    jg notSHL
    ;jmp SHLlabelOfPlayer1
    noTSHL:



; CMP AX,word ptr SARCORDINATES[0]
;     jl notSAR
;     cmp AX,word ptr SARCORDINATES[4]
;     jg notSAR
;     cmp bx,word ptr SARCORDINATES[2]
;     jl notSAR
;     cmp bx,word ptr SARCORDINATES[6]
;     jg notSAR
;     ;jmp SARlabelOfPlayer1
;     noTSAR:



; CMP AX,word ptr CLCCORDINATES[0]
;     jl notCLC
;     cmp AX,word ptr CLCCORDINATES[4]
;     jg notCLC
;     cmp bx,word ptr CLCCORDINATES[2]
;     jl notCLC
;     cmp bx,word ptr CLCCORDINATES[6]
;     jg notCLC
;     ;jmp CLClabelOfPlayer1
;     noTCLC:



CMP AX,word ptr RORCORDINATES[0]
    jl notROR
    cmp AX,word ptr RORCORDINATES[4]
    jg notROR
    cmp bx,word ptr RORCORDINATES[2]
    jl notROR
    cmp bx,word ptr RORCORDINATES[6]
    jg notROR
    ;jmp RORlabelOfPlayer1
    noTROR:

CMP AX,word ptr ROLCORDINATES[0]
    jl notROL
    cmp AX,word ptr ROLCORDINATES[4]
    jg notROL
    cmp bx,word ptr ROLCORDINATES[2]
    jl notROL
    cmp bx,word ptr ROLCORDINATES[6]
    jg notROL
    print mess
    ;jmp ROLlabelOfPlayer1
    noTROL:


; CMP AX,word ptr RCLCORDINATES[0]
;     jl notRCL
;     cmp AX,word ptr RCLCORDINATES[4]
;     jg notRCL
;     cmp bx,word ptr RCLCORDINATES[2]
;     jl notRCL
;     cmp bx,word ptr RCLCORDINATES[6]
;     jg notRCL
;     ;jmp RCLlabelOfPlayer1
;     noTRCL:



; CMP AX,word ptr RCRCORDINATES[0]
;     jl notRCR
;     cmp AX,word ptr RCRCORDINATES[4]
;     jg notRCR
;     cmp bx,word ptr RCRCORDINATES[2]
;     jl notRCR
;     cmp bx,word ptr RCRCORDINATES[6]
;     jg notRCR
;     ;jmp RCRlabelOfPlayer1
;     noTRCR:

; CMP AX,word ptr PUSHCORDINATES[0]
;     jl notPUSH
;     cmp AX,word ptr PUSHCORDINATES[4]
;     jg notPUSH
;     cmp bx,word ptr PUSHCORDINATES[2]
;     jl notPUSH
;     cmp bx,word ptr PUSHCORDINATES[6]
;     jg notPUSH
;     ;jmp PUSHlabelOfPlayer1
;     noTPUSH:



; CMP AX,word ptr POPCORDINATES[0]
;     jl notPOP
;     cmp AX,word ptr POPCORDINATES[4]
;     jg notPOP
;     cmp bx,word ptr POPCORDINATES[2]
;     jl notPOP
;     cmp bx,word ptr POPCORDINATES[6]
;     jg notPOP
;     ;jmp POPlabelOfPlayer1
;     noTPOP:



CMP AX,word ptr INCCORDINATES[0]
    jl notINC
    cmp AX,word ptr INCCORDINATES[4]
    jg notINC
    cmp bx,word ptr INCCORDINATES[2]
    jl notINC
    cmp bx,word ptr INCCORDINATES[6]
    jg notINC
    ;jmp INClabelOfPlayer1
    noTINC:


CMP AX,word ptr DECCORDINATES[0]
    jl notDEC
    cmp AX,word ptr DECCORDINATES[4]
    jg notDEC
    cmp bx,word ptr DECCORDINATES[2]
    jl notDEC
    cmp bx,word ptr DECCORDINATES[6]
    jg notDEC
    ;jmp DEClabelOfPlayer1
    noTDEC:


CMP AX,word ptr DivCORDINATES[0]
    jl notDiv
    cmp AX,word ptr DivCORDINATES[4]
    jg notDiv
    cmp bx,word ptr DivCORDINATES[2]
    jl notDiv
    cmp bx,word ptr DivCORDINATES[6]
    jg notDiv
    ;jmp DivlabelOfPlayer1
    noTDiv:

CMP AX,word ptr IDivCORDINATES[0]
    jl notIDiv
    cmp AX,word ptr IDivCORDINATES[4]
    jg notIDiv
    cmp bx,word ptr IDivCORDINATES[2]
    jl notIDiv
    cmp bx,word ptr IDivCORDINATES[6]
    jg notIDiv
    ;jmp IDivlabelOfPlayer1
    noTIDiv:

    ; CMP AX,word ptr MULCORDINATES[0]
    ; jl notMUL
    ; cmp AX,word ptr MULCORDINATES[4]
    ; jg notMUL
    ; cmp bx,word ptr MULCORDINATES[2]
    ; jl notMUL
    ; cmp bx,word ptr MULCORDINATES[6]
    ; jg notMUL
    ; ;jmp MULlabelOfPlayer1
    ; noTMUL:

    CMP AX,word ptr IMULCORDINATES[0]
    jl notIMUL
    cmp AX,word ptr IMULCORDINATES[4]
    jg notIMUL
    cmp bx,word ptr IMULCORDINATES[2]
    jl notIMUL
    cmp bx,word ptr IMULCORDINATES[6]
    jg notIMUL
    ;jmp IMULlabelOfPlayer1
    noTIMUL:
    ; POP DX
    ; POP CX
    ; POP BX
    ; POP AX    
moveToRightLabelofPlayer1 ENDP

;------------------------------------------ Macros for clicking an icon on the GUI of player 2 -----------------------------------------------
moveToRightLabelofPlayer2 proc FAR 
    ; local notmov;,movlabel,notADD,ADDabel,notADC,ADCLabel,notSUB,SUBLabel,notSBB,SBBlabel,notXOR,XORlabel,notAND,ANDlabel,notOR,ORlabel,notNOP,NOPlabel,notSHR,SHRlabel,notSHL,SHLlabel,notSAR,SARlabel,notCLC,CLClabel,notROR,RORlabel,notROL,ROLlabel,notRCL,RCLlabel,notRCR,RCRlabel,notPUSH,PUSHlabel,notPOP,POPlabel,notINC,INClabel,notDEC,DEClabel,notDiv,Divlabel,notIDiv,IDivlabel,notMUL,MULlabel,notIMUL,IMULlabel
    ; PUSH AX
    ; PUSH BX
    ; PUSH CX
    ; PUSH DX
    


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
    print message
    ;jmp movlabelOfplayer2
    notmov2:


    
    CMP AX,word ptr ADDCORDINATES[0]
    jl notADD2
    cmp AX,word ptr ADDCORDINATES[4]
    jg notADD2
    cmp bx,word ptr ADDCORDINATES[2]
    jl notADD2
    cmp bx,word ptr ADDCORDINATES[6]
    jg noTADD2
    ;jmp ADDlabelOfPlayer2
    notADD2:



    ; CMP AX,word ptr ADCCORDINATES[0]
    ; jl notADC
    ; cmp AX,word ptr ADCCORDINATES[4]
    ; jg notADC
    ; cmp bx,word ptr ADCCORDINATES[2]
    ; jl notADC
    ; cmp bx,word ptr ADCCORDINATES[6]
    ; jg notADC
    ; jmp ADCLabelOfPlayer2
    ; notADC:




    CMP AX,word ptr SUBCORDINATES[0]
    jl notSUB2
    cmp AX,word ptr SUBCORDINATES[4]
    jg notSUB2
    cmp bx,word ptr SUBCORDINATES[2]
    jl notSUB2
    cmp bx,word ptr SUBCORDINATES[6]
    jg notSUB2
    ;jmp SUBLabelOfPlayer2
    notSUB2:




    ; CMP AX,word ptr SBBCORDINATES[0]
    ; jl notSBB
    ; cmp AX,word ptr SBBCORDINATES[4]
    ; jg notSBB
    ; cmp bx,word ptr SBBCORDINATES[2]
    ; jl notSBB
    ; cmp bx,word ptr SBBCORDINATES[6]
    ; jg notSBB
    ; ;jmp SBBlabelOfPlayer2
    ; notSBB:




    CMP AX,word ptr XORCORDINATES[0]
    jl notXOR2
    cmp AX,word ptr XORCORDINATES[4]
    jg notXOR2
    cmp bx,word ptr XORCORDINATES[2]
    jl noTXOR2
    cmp bx,word ptr XORCORDINATES[6]
    jg notXOR2
    ;jmp XORlabelOfPlayer2
    notXOR2:



    CMP AX,word ptr ANDCORDINATES[0]
    jb notAND2
    cmp AX,word ptr ANDCORDINATES[4]
    ja notAND2
    cmp bx,word ptr ANDCORDINATES[2]
    jb notAND2
    cmp bx,word ptr ANDCORDINATES[6]
    ja notAND2
    ;jmp ANDlabelOfPlayer2
    print message
    notAND2:


    CMP AX,word ptr ORCORDINATES[0]
    jl notOR2
    cmp AX,word ptr ORCORDINATES[4]
    jg notOR2
    cmp bx,word ptr ORCORDINATES[2]
    jl notOR2
    cmp bx,word ptr ORCORDINATES[6]
    jg notOR2
    ;jmp ORlabelOfPlayer2
    notOR2:



    CMP AX,word ptr NOPCORDINATES[0]
    jl notNOP2
    cmp AX,word ptr NOPCORDINATES[4]
    jg notNOP2
    cmp bx,word ptr NOPCORDINATES[2]
    jl notNOP2
    cmp bx,word ptr NOPCORDINATES[6]
    jg notNOP2
    ;jmp NOPlabelOfPlayer2
    noTNOP2:



    CMP AX,word ptr SHRCORDINATES[0]
    jl notSHR2
    cmp AX,word ptr SHRCORDINATES[4]
    jg notSHR2
    cmp bx,word ptr SHRCORDINATES[2]
    jl notSHR2
    cmp bx,word ptr SHRCORDINATES[6]
    jg notSHR2
    ;jmp SHRlabelOfPlayer2
    noTSHR2:


    CMP AX,word ptr SHLCORDINATES[0]
    jl notSHL2
    cmp AX,word ptr SHLCORDINATES[4]
    jg notSHL2
    cmp bx,word ptr SHLCORDINATES[2]
    jl notSHL2
    cmp bx,word ptr SHLCORDINATES[6]
    jg notSHL2
    ;jmp SHLlabelOfPlayer2
    noTSHL2:



; CMP AX,word ptr SARCORDINATES[0]
;     jl notSAR
;     cmp AX,word ptr SARCORDINATES[4]
;     jg notSAR
;     cmp bx,word ptr SARCORDINATES[2]
;     jl notSAR
;     cmp bx,word ptr SARCORDINATES[6]
;     jg notSAR
;     ;jmp SARlabelOfPlayer2
;     noTSAR:



; CMP AX,word ptr CLCCORDINATES[0]
;     jl notCLC
;     cmp AX,word ptr CLCCORDINATES[4]
;     jg notCLC
;     cmp bx,word ptr CLCCORDINATES[2]
;     jl notCLC
;     cmp bx,word ptr CLCCORDINATES[6]
;     jg notCLC
;     ;jmp CLClabelOfPlayer2
;     noTCLC:



CMP AX,word ptr RORCORDINATES[0]
    jl notROR2
    cmp AX,word ptr RORCORDINATES[4]
    jg notROR2
    cmp bx,word ptr RORCORDINATES[2]
    jl notROR2
    cmp bx,word ptr RORCORDINATES[6]
    jg notROR2
    ;jmp RORlabelOfPlayer2
    noTROR2:

CMP AX,word ptr ROLCORDINATES[0]
    jl notROL2
    cmp AX,word ptr ROLCORDINATES[4]
    jg notROL2
    cmp bx,word ptr ROLCORDINATES[2]
    jl notROL2
    cmp bx,word ptr ROLCORDINATES[6]
    jg notROL2
    ;jmp ROLlabelOfPlayer2
    noTROL2:


; CMP AX,word ptr RCLCORDINATES[0]
;     jl notRCL
;     cmp AX,word ptr RCLCORDINATES[4]
;     jg notRCL
;     cmp bx,word ptr RCLCORDINATES[2]
;     jl notRCL
;     cmp bx,word ptr RCLCORDINATES[6]
;     jg notRCL
;     ;jmp RCLlabelOfPlayer2
;     noTRCL:



; CMP AX,word ptr RCRCORDINATES[0]
;     jl notRCR
;     cmp AX,word ptr RCRCORDINATES[4]
;     jg notRCR
;     cmp bx,word ptr RCRCORDINATES[2]
;     jl notRCR
;     cmp bx,word ptr RCRCORDINATES[6]
;     jg notRCR
;     ;jmp RCRlabelOfPlayer2
;     noTRCR:

; CMP AX,word ptr PUSHCORDINATES[0]
;     jl notPUSH
;     cmp AX,word ptr PUSHCORDINATES[4]
;     jg notPUSH
;     cmp bx,word ptr PUSHCORDINATES[2]
;     jl notPUSH
;     cmp bx,word ptr PUSHCORDINATES[6]
;     jg notPUSH
;     ;jmp PUSHlabelOfPlayer2
;     noTPUSH:



; CMP AX,word ptr POPCORDINATES[0]
;     jl notPOP
;     cmp AX,word ptr POPCORDINATES[4]
;     jg notPOP
;     cmp bx,word ptr POPCORDINATES[2]
;     jl notPOP
;     cmp bx,word ptr POPCORDINATES[6]
;     jg notPOP
;     ;jmp POPlabelOfPlayer2
;     noTPOP:



CMP AX,word ptr INCCORDINATES[0]
    jl notINC2
    cmp AX,word ptr INCCORDINATES[4]
    jg notINC2
    cmp bx,word ptr INCCORDINATES[2]
    jl notINC2
    cmp bx,word ptr INCCORDINATES[6]
    jg notINC2
    ;jmp INClabelOfPlayer2
    noTINC2:


CMP AX,word ptr DECCORDINATES[0]
    jl notDEC2
    cmp AX,word ptr DECCORDINATES[4]
    jg notDEC2
    cmp bx,word ptr DECCORDINATES[2]
    jl notDEC2
    cmp bx,word ptr DECCORDINATES[6]
    jg notDEC2
    ;jmp DEClabelOfPlayer2
    noTDEC2:


CMP AX,word ptr DivCORDINATES[0]
    jl notDiv2
    cmp AX,word ptr DivCORDINATES[4]
    jg notDiv2
    cmp bx,word ptr DivCORDINATES[2]
    jl notDiv2
    cmp bx,word ptr DivCORDINATES[6]
    jg notDiv2
    ;jmp DivlabelOfPlayer2
    noTDiv2:

CMP AX,word ptr IDivCORDINATES[0]
    jl notIDiv2
    cmp AX,word ptr IDivCORDINATES[4]
    jg notIDiv2
    cmp bx,word ptr IDivCORDINATES[2]
    jl notIDiv2
    cmp bx,word ptr IDivCORDINATES[6]
    jg notIDiv2
    ;jmp IDivlabelOfPlayer2
    noTIDiv2:

    ; CMP AX,word ptr MULCORDINATES[0]
    ; jl notMUL
    ; cmp AX,word ptr MULCORDINATES[4]
    ; jg notMUL
    ; cmp bx,word ptr MULCORDINATES[2]
    ; jl notMUL
    ; cmp bx,word ptr MULCORDINATES[6]
    ; jg notMUL
    ; ;jmp MULlabelOfPlayer2
    ; noTMUL:

    CMP AX,word ptr IMULCORDINATES[0]
    jl notIMUL2
    cmp AX,word ptr IMULCORDINATES[4]
    jg notIMUL2
    cmp bx,word ptr IMULCORDINATES[2]
    jl notIMUL2
    cmp bx,word ptr IMULCORDINATES[6]
    jg notIMUL2
    ;jmp IMULlabelOfPlayer2
    noTIMUL2:

    ; POP DX
    ; POP CX
    ; POP BX
    ; POP AX    
moveToRightLabelofPlayer2 ENDP
;-----------------------------------------------------------------------------------------------------------------------


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    DRAW_REGISTER_NAMES proc near
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
    mov dx, offset P1NAME 
    mov ah, 9h 
    int 21h 
    
    ret 
    DRAW_REGISTER_NAMES endp

    DRAW_REGISTER_NAMES2 proc near
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
    mov dx, offset P2NAME 
    mov ah, 9h 
    int 21h 
    
    ret 
    DRAW_REGISTER_NAMES2 endp

    HIDE_POWER_UP proc near
        CALL FIXED
        ret
        HIDE_POWER_UP endp


    SHOW_POWER_UP proc near
        movCursor 65,18

        mov dx, offset POWER_BUTTON
        mov ah, 9h
        int 21h

        DrawRec 280,515,310,600

        ret
    SHOW_POWER_UP endp

    SHOW_INSTRUCTION_BUTTON proc near

        movCursor 5,2
        mov dx, offset INSTRUCTION_BUTTON
        mov ah, 9h
        int 21h
        DrawRec 20,30,60,140

        ret
    SHOW_INSTRUCTION_BUTTON endp

    SHOW_INSTRUCTIONS proc near
        CALL FIXED
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

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BEGIN_GAME proc near
        CALL SHOW_INSTRUCTION_BUTTON
        CALL SHOW_POWER_UP
        CALL FIXED
        ret
    BEGIN_GAME endp
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    SHOW_1ST_OPERAND proc near
        CALL FIXED
        movCursor 5,2
        PRINT_STRING_3DIGIT ADDRESS_CHOICE
        movCursor 12,2

        PRINT_STRING_3DIGIT REGISTER_CHOICE
        ;;ADDRESS_CHOICE REC
        DrawRec 25,30,50,70
        ;REGISTER_CHOICE REC
        DrawRec 25,90,50,130

        ret
    SHOW_1ST_OPERAND endp



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    SHOW_2ND_OPERAND proc near
        CALL FIXED
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
        ret
    SHOW_2ND_OPERAND endp
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    SHOW_REGISTERS_CHOICE proc near
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

        ret
    SHOW_REGISTERS_CHOICE endp

    ;;1,2,3,5
        SHOW_POWER_UPS_CHOICE proc near

        CALL FIXED

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

    SHOW_PLAYER_ONE_NAME proc near
        movCursor 66,15
        mov dx, offset PLAYER_ONE_NAME
        mov ah, 9h
        int 21h
        ret
    SHOW_PLAYER_ONE_NAME endp

    SHOW_PLAYER_TWO_NAME proc near
        movCursor 66,15
        mov dx, offset PLAYER_TWO_NAME
        mov ah, 9h
        int 21h
        ret
    SHOW_PLAYER_TWO_NAME endp

    DRAW_CHAT_LINE proc near

        push ax
        push cx
        push dx
        push si
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
        pop si
        pop dx
        pop cx
        pop ax
        ret
    DRAW_CHAT_LINE endp 


    DRAW_VERTICAL_LINE proc near
        push ax
        push cx
        push dx
        push si
        mov cx, 400;Column
        mov dx,0 ;Row
        mov si,400
        mov al,0ah ;Pixel color
        mov ah,0ch ;Draw Pixel Command
        back0: int 10h
        inc dx
        cmp dx, 400
        jne back0
        pop si
        pop dx
        pop cx
        pop ax
        ret
    DRAW_VERTICAL_LINE endp

    SHOW_PLAYERS_NAMES_ON_CHAT proc near
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


    SHOW_CHAT proc near
        CALL DRAW_CHAT_LINE
        CALL SHOW_PLAYERS_NAMES_ON_CHAT

        ret
    SHOW_CHAT endp

    CLR proc near
        mov al, 12h ; Video mode number
        mov ah, 0h
        int 10h

        ret
    CLR endp

    ;description: the fixed data of each screen, players' registers
    FIXED proc near
        CALL DRAW_REGISTER_NAMES
        DrawRec 30, 535, 280, 639; draw rectangle around player1 registers
        call DRAW_VERTICAL_LINE

        call DRAW_REGISTER_NAMES2
        DrawRec 30, 405, 280,510
        CALL SHOW_CHAT
        RET
    FIXED endp

    FIRSTSCREEN PROC near
        CALL FIXED
        movCursor 14,9
        DrawRec 130,90,170,190
        DrawButtonMessage ADDRESS
        

        movCursor 14,14
        DrawRec 210,90,250,190
        DrawButtonMessage REGISTER
        RET
    FIRSTSCREEN ENDP

    ;THE SECOND SCREEN WILL MAKE THE USER CHOOSE BETWEEN REGISTER AND VALUE AND ADRESS
    SECONDSCREEN PROC near
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
    getKeyPressed macro 
        mov ah,0
        int 16h
    endm getKeyPressed
    
    MAIN PROC near
        MOV AX,@DATA
        MOV DS,AX
        mov ax,@data
        mov ds,ax
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
        jmp finish
        notscape:
        cmp ah,59
        jne notf1
        jmp begin
        notf1:
        cmp ah,60
        jne loo   
        ;jmp chat
        jmp loo


        begin:
        ; AH=0h: Set video mode
        mov al, 12h ; Video mode number
        mov ah, 0h
        int 10h

        ; AH=2h: Set cursor position
        mov dl, 2 ; Column
        mov dh, 3 ; Row
        mov bx, 0 ; Page number, 0 for graphics modes
        mov ah, 2h
        int 10h

        ;CALL DRAW_REGISTER_NAMES
        CALL SHOW_POWER_UP
        ;CALL SHOW_INSTRUCTION_BUTTON
        ;CALL SHOW_INSTRUCTIONS
        ;CALL HIDE_POWER_UP
        CALL BEGIN_GAME
        ;CALL SHOW_AFTER_INSTRUCTION
        ;CALL SHOW_2ND_OPERAND
        ;CALL SHOW_REGISTERS_CHOICE
        ;CALL SHOW_POWER_UPS_CHOICE
        ;CALL SHOW_PLAYER_ONE_NAME
        ;CALL SHOW_PLAYER_TWO_NAME
        ;CALL SHOW_CHAT


        ;;ASAAD'S TEST OF MOUSE CLICKS
        MainScreen: getMousePosition x, y
            cmp x,150
            jb CHOICE_INSTRUCTION
            JMP CHOICE_POWERUPS

            ; cmp y, 20
            ; jb MainScreen
            ; cmp y, 60
            ; ja MainScreen

            ; cmp x, 30
            ; jb MainScreen
            ; cmp x, 140
            ; ja MainScreen
            
    ;DrawRec 280,515,310,600
        CHOICE_INSTRUCTION:
            cmp y, 20
            jb MainScreen
            cmp y, 60
            ja MainScreen

            cmp x, 30
            jb MainScreen
            cmp x, 140
            ja MainScreen
            CALL CLR
            MOV INSTorPOWERUP,1
        CALL SHOW_INSTRUCTIONS
        ;print message
        call moveToRightLabelofPlayer1
       
        JMP NEXT_CHOICE
        CHOICE_POWERUPS:
        cmp y, 280
            jb MainScreen
            cmp y, 310
            ja MainScreen

            cmp x, 515
            jb MainScreen
            cmp x, 600
            ja MainScreen
            CALL CLR
            MOV INSTorPOWERUP,0
        
        
        CALL  SHOW_POWER_UPS_CHOICE

        NEXT_CHOICE:
            CMP INSTorPOWERUP,0
            JZ POWERUPisCHOSEN
            JNZ firstoperand

                POWERUPisCHOSEN:
                firstoperand:    


        Show_mouse
        ;;;;;;
        ;CALL SHOW_AFTER_INSTRUCTION
        ;CALL SHOW_2ND_OPERAND
        ;CALL SHOW_REGISTERS_CHOICE
        ;CALL SHOW_POWER_UPS_CHOICE
        ;CALL SHOW_PLAYER_ONE_NAME
        ;CALL SHOW_PLAYER_TWO_NAME
        ;CALL SHOW_CHAT

        ; loop1:

        ; jmp loop1
        ; hlt
    MAIN endp
        finish :
    END MAIN

CickedRegister MACRO Name,value,NumberOfBytes
    local notAX,notAL,notAH,notBX,notBL,notBH,notCX,notCL,notCH,notDX,notDL,notDH,notSI,notDI,notSP,notBP
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    GETMOUSEPOSITION MOUSEPOSITION_X,MOUSEPOSITION_Y
    MOV AX,MOUSEPOSITION_X
    MOV BX,MOUSEPOSITION_Y


    ;AX
    CMP AX,AXCORDINATES[0]
    jl notAX
    cmp AX,AXCORDINATES[2]
    jg notAX
    cmp bx,AXCORDINATES[1]
    jl notAX
    cmp bx,AXCORDINATES[3]
    jg notAX
    mov Name,0
    mov value,0
    mov NumberOfBytes,2
    notAX:


    ;AL
    CMP AX,ALCORDINATES[0]
    jl notAL
    cmp AX,ALCORDINATES[2]
    jg notAL
    cmp bx,ALCORDINATES[1]
    jl notAL
    cmp bx,ALCORDINATES[3]
    jg notAL
    mov Name,1
    mov value,1
    mov NumberOfBytes,1
    notAL:

    ;AH
    CMP AX,AHCORDINATES[0]
    jl notAH
    cmp AX,AHCORDINATES[2]
    jg notAH
    cmp bx,AHCORDINATES[1]
    jl notAH
    cmp bx,AHCORDINATES[3]
    jg notAH
    mov Name,2
    mov value,0
    mov NumberOfBytes,1
    notAH:

    ;BX
    CMP AX,BXCORDINATES[0]
    jl notBX 
    cmp AX,BXCORDINATES[2]
    jg notBX 
    cmp bx,BXCORDINATES[1]
    jl notBX
    cmp bx,BXCORDINATES[3]
    jg notBX
    mov Name,3
    mov value,3
    mov NumberOfBytes,2
    notBX:

    
    ;BL
    CMP AX,BLCORDINATES[0]
    jl notBL
    cmp AX,BLCORDINATES[2]
    jg notBL
    cmp bx,BLCORDINATES[1]
    jl notBL
    cmp bx,BLCORDINATES[3]
    jg notBL
    mov Name,4
    mov value,3
    mov NumberOfBytes,1
    notBL:

    ;BH
    CMP AX,BHCORDINATES[0]
    jl notBH
    cmp AX,BHCORDINATES[2]
    jg notBH
    cmp bx,BHCORDINATES[1]
    jl notBH
    cmp bx,BHCORDINATES[3]
    jg notBH
    mov Name,5
    mov value,2
    mov NumberOfBytes,1
    notBH:

    ;CX
    CMP AX,CXCORDINATES[0]
    jl notCX
    cmp AX,CXCORDINATES[2]
    jg notCX
    cmp bx,CXCORDINATES[1]
    jl notCX
    cmp bx,CXCORDINATES[3]
    jg notCX
    mov Name,6
    mov value,4
    mov NumberOfBytes,2
    notCX:

    ;CL
    CMP AX,CLCORDINATES[0]
    jl notCL
    cmp AX,CLCORDINATES[2]
    jg notCL
    cmp bx,AXCORDINATES[1]
    jl notCL
    cmp bx,CLCORDINATES[3]
    jg notCL
    mov Name,7
    mov value,5
    mov NumberOfBytes,1
    notCL:

    ;CH
    CMP AX,CHCORDINATES[0]
    jl notCH
    cmp AX,CHCORDINATES[2]
    jg notCH
    cmp bx,CHCORDINATES[1]
    jl notCH
    cmp bx,CHCORDINATES[3]
    jg notCH
    mov Name,8
    mov value,4
    mov NumberOfBytes,1
    notCH:

    ;DX
    CMP AX,DXCORDINATES[0]
    jl notDX
    cmp AX,DXCORDINATES[2]
    jg notDX
    cmp bx,DXCORDINATES[1]
    jl notDX
    cmp bx,DXCORDINATES[3]
    jg notDX
    mov Name,9
    mov value,6
    mov NumberOfBytes,2
    notDX:

    ;DL
    CMP AX,DLCORDINATES[0]
    jl notDL
    cmp AX,DLCORDINATES[2]
    jg notDL
    cmp bx,DLCORDINATES[1]
    jl notDL
    cmp bx,DLCORDINATES[3]
    jg notDL
    mov Name,10
    mov value,7
    mov NumberOfBytes,1
    notDL:

    ;DH
    CMP AX,DHCORDINATES[0]
    jl notDH
    cmp AX,DHCORDINATES[2]
    jg notDH
    cmp bx,DHCORDINATES[1]
    jl notDH
    cmp bx,DHCORDINATES[3]
    jg notDH
    mov Name,11
    mov value,6
    mov NumberOfBytes,1
    notDH:

    ;SI
    CMP AX,SICORDINATES[0]
    jl notSI
    cmp AX,SICORDINATES[2]
    jg notSI
    cmp bx,SICORDINATES[1]
    jl notSI
    cmp bx,SICORDINATES[3]
    jg notSI
    mov Name,12
    mov value,8
    mov NumberOfBytes,2
    notSI:

    ;DI
    CMP AX,DICORDINATES[0]
    jl notDI
    cmp AX,DICORDINATES[2]
    jg notDI
    cmp bx,DICORDINATES[1]
    jl notDI
    cmp bx,DICORDINATES[3]
    jg notDI
    mov Name,13
    mov value,10
    mov NumberOfBytes,2
    notDI:

    ;SP
    CMP AX,SPCORDINATES[0]
    jl notSP
    cmp AX,SPCORDINATES[2]
    jg notSP
    cmp bx,SPCORDINATES[1]
    jl notSP
    cmp bx,SPCORDINATES[3]
    jg notSP
    mov Name,14
    mov value,12
    mov NumberOfBytes,2
    notSP:

    ;BP
    CMP AX,BPCORDINATES[0]
    jl notBP
    cmp AX,BPCORDINATES[2]
    jg notBP
    cmp bx,BPCORDINATES[1]
    jl notBP
    cmp bx,BPCORDINATES[3]
    jg notBP
    mov Name,15
    mov value,14
    mov NumberOfBytes,2
    notBP:



    
    
    POP DX
    POP CX
    POP BX
    POP AX
    
ENDM