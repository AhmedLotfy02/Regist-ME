.model huge
.stack 64
.data
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

    ;;tests
    x DW ?
    y dw ?
    ;;;;

.code
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
        pop ax              ; you need to jump zero after the macro jz mov_instruction  
        
    Endm



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DRAW_REGISTER_NAMES proc far
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

DRAW_REGISTER_NAMES2 proc far
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

HIDE_POWER_UP proc far
    CALL FIXED
    ret
    HIDE_POWER_UP endp


SHOW_POWER_UP proc far
    movCursor 65,18

    mov dx, offset POWER_BUTTON
    mov ah, 9h
    int 21h

    DrawRec 280,515,310,600

    ret
SHOW_POWER_UP endp

SHOW_INSTRUCTION_BUTTON proc far

    movCursor 5,2
    mov dx, offset INSTRUCTION_BUTTON
    mov ah, 9h
    int 21h
    DrawRec 20,30,60,140

    ret
SHOW_INSTRUCTION_BUTTON endp

SHOW_INSTRUCTIONS proc far
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
BEGIN_GAME proc far
    CALL SHOW_INSTRUCTION_BUTTON
    CALL SHOW_POWER_UP
    CALL FIXED
    ret
BEGIN_GAME endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SHOW_1ST_OPERAND proc far
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
SHOW_2ND_OPERAND proc far
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

SHOW_REGISTERS_CHOICE proc far
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
    SHOW_POWER_UPS_CHOICE proc far

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

SHOW_PLAYER_ONE_NAME proc far
    movCursor 66,15
    mov dx, offset PLAYER_ONE_NAME
    mov ah, 9h
    int 21h
    ret
SHOW_PLAYER_ONE_NAME endp

SHOW_PLAYER_TWO_NAME proc far
    movCursor 66,15
    mov dx, offset PLAYER_TWO_NAME
    mov ah, 9h
    int 21h
    ret
SHOW_PLAYER_TWO_NAME endp

DRAW_CHAT_LINE proc far

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


DRAW_VERTICAL_LINE proc far
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

SHOW_PLAYERS_NAMES_ON_CHAT proc far
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


SHOW_CHAT proc far
    CALL DRAW_CHAT_LINE
    CALL SHOW_PLAYERS_NAMES_ON_CHAT

    ret
SHOW_CHAT endp

CLR proc far
    mov al, 12h ; Video mode number
    mov ah, 0h
    int 10h

    ret
CLR endp

;description: the fixed data of each screen, players' registers
FIXED proc far
    CALL DRAW_REGISTER_NAMES
    DrawRec 30, 535, 280, 639; draw rectangle around player1 registers
    call DRAW_VERTICAL_LINE

    call DRAW_REGISTER_NAMES2
    DrawRec 30, 405, 280,510
    CALL SHOW_CHAT
    RET
FIXED endp

FIRSTSCREEN PROC FAR
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
SECONDSCREEN PROC FAR
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
MAIN PROC FAR
    MOV AX,@DATA
    MOV DS,AX

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
    ;CALL SHOW_POWER_UP
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
    Again: getMousePosition x, y
        cmp y, 20
        jb Again
        cmp y, 60
        ja Again

        cmp x, 30
        jb Again
        cmp x, 140
        ja Again
        ;blankScreen 05h,0,100
        ;ClearScreen 0, 0, 25, 80
    CALL CLR
    CALL SHOW_INSTRUCTIONS
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

END MAIN