DISPLAY_2_DIGITS    MACRO   NUMBER
        
        push ax 
        push bx 
        push dx
        MOV AH,0
        MOV AL,NUMBER
        MOV BL,10
        DIV BL
        
        ADD AL,'0'
        ADD AH,'0'
        
        MOV BL,AH
        
        MOV DL,AL
        MOV AH,2
        INT 21H
        
        MOV DL,BL
        INT 21H
        pop dx 
        pop bx 
        pop ax
        
ENDM

;;;;;;;;;;;;;;;;;;;;;;;;;;
CickedMEMORYRegister MACRO Name,value,NumberOfBytes
    LOCAL notBP,  NOTDI
    local notSI,CLICKEDMEMREG, FINALL   
    CLICKEDMEMREG:
    GETMOUSEPOSITION Y,X
    MOV AX,X
    MOV BX,Y
    ;BX
    CMP AX,word ptr MOVCORDINATES[0]
    jl notBP
    cmp AX,word ptr MOVCORDINATES[4]
    jg notBP
    cmp bx,word ptr MOVCORDINATES[2]
    jl notBP
    cmp bx,word ptr MOVCORDINATES[6]
    jg notBP
    mov Name,3
    mov value,2
    mov NumberOfBytes,2
    JMP FINALL
    notBP:

 ;DI
    CMP AX,word ptr ADDCORDINATES[0]
    jl NOTDI
    cmp AX,word ptr ADDCORDINATES[4]
    jg NOTDI
    cmp bx,word ptr ADDCORDINATES[2]
    jl NOTDI
    cmp bx,word ptr ADDCORDINATES[6]
    jg NOTDI
    mov Name,13
    mov value,10
    mov NumberOfBytes,2
    JMP FINALL
    NOTDI:

   ;SI
    CMP AX,word ptr SUBCORDINATES[0]
    jl notSI
    cmp AX,word ptr SUBCORDINATES[4]
    jg notSI
    cmp bx,word ptr SUBCORDINATES[2]
    jl notSI
    cmp bx,word ptr SUBCORDINATES[6]
    jg notSI
    mov Name,12
    mov value,8
    mov NumberOfBytes,2
    JMP FINALL
    notSI:
    JMP CLICKEDMEMREG
    FINALL:
ENDM

;;;;;;;;;;;;;;;;;;;;;;;;;;;

CickedRegister MACRO Name,value,NumberOfBytes
    local notAX,notAL,notAH,notBX
    local notBL,notBH,notCX,notCL
    local notCH,notDX,notDL,notDH
    local notSI,notDI,notSP,notBP
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    GETMOUSEPOSITION Y,X
    MOV AX,X
    MOV BX,Y


    ;AX
    CMP AX,word ptr SHLCORDINATES[0]
    jl notAX
    cmp AX,word ptr SHLCORDINATES[4]
    jg notAX
    cmp bx,word ptr SHLCORDINATES[2]
    jl notAX
    cmp bx,word ptr SHLCORDINATES[6]
    jg notAX
    mov Name,0
    mov value,0
    mov NumberOfBytes,2
    notAX:


    ;AL
    CMP AX,word ptr MOVCORDINATES[0]
    jl notAL
    cmp AX,word ptr MOVCORDINATES[4]
    jg notAL
    cmp bx,word ptr MOVCORDINATES[2]
    jl notAL
    cmp bx,word ptr MOVCORDINATES[6]
    jg notAL
    mov Name,1
    mov value,1
    mov NumberOfBytes,1
    notAL:

    ;AH
    CMP AX,word ptr ADDCORDINATES[0]
    jl notAH
    cmp AX,word ptr ADDCORDINATES[4]
    jg notAH
    cmp bx,word ptr ADDCORDINATES[2]
    jl notAH
    cmp bx,word ptr ADDCORDINATES[6]
    jg notAH
    mov Name,2
    mov value,0
    mov NumberOfBytes,1
    notAH:

    ;BX
    CMP AX,word ptr RORCORDINATES[0]
    jl notBX 
    cmp AX,word ptr RORCORDINATES[4]
    jg notBX 
    cmp bx,word ptr RORCORDINATES[2]
    jl notBX
    cmp bx,word ptr RORCORDINATES[6]
    jg notBX
    mov Name,3
    mov value,2
    mov NumberOfBytes,2
    notBX:

    
    ;BL
    CMP AX,word ptr SUBCORDINATES[0]
    jl notBL
    cmp AX,word ptr SUBCORDINATES[4]
    jg notBL
    cmp bx,word ptr SUBCORDINATES[2]
    jl notBL
    cmp bx,word ptr SUBCORDINATES[6]
    jg notBL
    mov Name,4
    mov value,3
    mov NumberOfBytes,1
    notBL:

    ;BH
    CMP AX,word ptr DIVCORDINATES[0]
    jl notBH
    cmp AX,word ptr DIVCORDINATES[4]
    jg notBH
    cmp bx,word ptr DIVCORDINATES[2]
    jl notBH
    cmp bx,word ptr DIVCORDINATES[6]
    jg notBH
    mov Name,5
    mov value,2
    mov NumberOfBytes,1
    notBH:

    ;CX
    CMP AX,word ptr ROLCORDINATES[0]
    jl notCX
    cmp AX,word ptr ROLCORDINATES[4]
    jg notCX
    cmp bx,word ptr ROLCORDINATES[2]
    jl notCX
    cmp bx,word ptr ROLCORDINATES[6]
    jg notCX
    mov Name,6
    mov value,4
    mov NumberOfBytes,2
    notCX:

    ;CL
    CMP AX,word ptr XORCORDINATES[0]
    jl notCL
    cmp AX,word ptr XORCORDINATES[4]
    jg notCL
    cmp bx,word ptr XORCORDINATES[2]
    jl notCL
    cmp bx,word ptr XORCORDINATES[6]
    jg notCL
    mov Name,7
    mov value,5
    mov NumberOfBytes,1
    notCL:

    ;CH
    CMP AX,word ptr ANDCORDINATES[0]
    jl notCH
    cmp AX,word ptr ANDCORDINATES[4]
    jg notCH
    cmp bx,word ptr ANDCORDINATES[2]
    jl notCH
    cmp bx,word ptr ANDCORDINATES[6]
    jg notCH
    mov Name,8
    mov value,4
    mov NumberOfBytes,1
    notCH:

    ;DX
    CMP AX,word ptr INCCORDINATES[0]
    jl notDX
    cmp AX,word ptr INCCORDINATES[4]
    jg notDX
    cmp bx,word ptr INCCORDINATES[2]
    jl notDX
    cmp bx,word ptr INCCORDINATES[6]
    jg notDX
    mov Name,9
    mov value,6
    mov NumberOfBytes,2
    notDX:

    ;DL
    CMP AX,word ptr SHRCORDINATES[0]
    jl notDL
    cmp AX,word ptr SHRCORDINATES[4]
    jg notDL
    cmp bx,word ptr SHRCORDINATES[2]
    jl notDL
    cmp bx,word ptr SHRCORDINATES[6]
    jg notDL
    mov Name,10
    mov value,7
    mov NumberOfBytes,1
    notDL:

    ;DH
    CMP AX,word ptr NOPCORDINATES[0]
    jl notDH
    cmp AX,word ptr NOPCORDINATES[4]
    jg notDH
    cmp bx,word ptr NOPCORDINATES[2]
    jl notDH
    cmp bx,word ptr NOPCORDINATES[6]
    jg notDH
    mov Name,11
    mov value,6
    mov NumberOfBytes,1
    notDH:

    ;SI
    CMP AX,word ptr DECCORDINATES[0]
    jl notSI
    cmp AX,word ptr DECCORDINATES[4]
    jg notSI
    cmp bx,word ptr DECCORDINATES[2]
    jl notSI
    cmp bx,word ptr DECCORDINATES[6]
    jg notSI
    mov Name,12
    mov value,8
    mov NumberOfBytes,2
    notSI:

    ;DI
    CMP AX,word ptr ORCORDINATES[0]
    jl notDI
    cmp AX,word ptr ORCORDINATES[4]
    jg notDI
    cmp bx,word ptr ORCORDINATES[2]
    jl notDI
    cmp bx,word ptr ORCORDINATES[6]
    jg notDI
    mov Name,13
    mov value,10
    mov NumberOfBytes,2
    notDI:

    ;SP
    CMP AX,word ptr IDIVCORDINATES[0]
    jl notSP
    cmp AX,word ptr IDIVCORDINATES[4]
    jg notSP
    cmp bx,word ptr IDIVCORDINATES[2]
    jl notSP
    cmp bx,word ptr IDIVCORDINATES[6]
    jg notSP
    mov Name,14
    mov value,12
    mov NumberOfBytes,2
    notSP:

    ;BP
    CMP AX,word ptr IMULCORDINATES[0]
    jl notBP
    cmp AX,word ptr IMULCORDINATES[4]
    jg notBP
    cmp bx,word ptr IMULCORDINATES[2]
    jl notBP
    cmp bx,word ptr IMULCORDINATES[6]
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

    Print_Msg MACRO msg ; variable defined above with '$'at end
        push ax
        ;push dx      ;does we need to push dx?!
        mov ah,9h
        mov dx,offset msg 
        int 21h
        ;pop dx
        pop ax
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
        
    ENDM 

    readString MACRO str
        ; Push all used regeister in stack to get their original value after the operation
        push ax
        push dx
        
        ; Intrrupt to read specific string from the keyboard
        mov ah, 0Ah
        mov dx, offset str
        int 21h
        
        pop dx
        pop ax
            
    ENDM 

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    readonedgits MACRO  I 
        local    alphabet,next  ,notcapital,error 
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX

        MOV AL,inputValueString[2][I]
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
            mov inputvaluesize,0
        next:      
        POP DX
            POP CX
            POP BX
            POP AX

        ; you need to jump zero after the macro jz mov_instruction  
    ENDM

    readtwodigitss MACRO index1 
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        readonedgits index1
        MOV AL,TEMP
        readonedgits index1+1 
        MOV CL,10h
        MUL CL     
        ADD TEMP,AL 
        POP DX
        POP CX
        POP BX
        POP AX
    ENDM 


    READFOURDIGITs MACRO  
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        READTWODIGITSs 0
        MOV AH,TEMP
        MOV AL,0 
        READTWODIGITSs 2
        ADD AL,TEMP
        MOV NUMBER,AX
        

        POP DX
        POP CX
        POP BX
        POP AX
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
            push di
            push bx 

            mov di,0   
            mov bh, '$' 
            loop4:
                printCharacter String[di]
                inc di
                mov bl, String[di]
                cmp bl, bh
            jne loop4

            pop bx 
            pop di
        ENDM

        setTextCursor macro Column, Row
            push ax 
            push dx 
            push bx 
                mov  dl,  Column    
                mov  dh,  Row    
                mov  bh,  0                                              ;page no.
                mov  ah,  2     
                int  10h       
            pop bx 
            pop dx 
            pop ax
        endm 

        displayCharacter macro Char                                     ;Takes a character and displays it
            mov dl,  Char
            add dl, 30h
            mov ah,  2h
            int 21h
        endm 
        
        printCharacter macro Char                                     ;Takes a character and displays it
            mov dl,  Char
            mov ah,  2h
            int 21h
        endm 

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
        endm  

        Print macro Stringo                                             ;Takes a string and prints it 
            mov AH, 09h 
            mov dx, offset Stringo 
            int 21h 
        endm 

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
        local Mypos
        Show_mouse
        push ax
        push cx
        push bx
        push dx
        
        mov ax, 3
        mov bx,0
        Mypos:int 33h
        cmp bx,1          
        ;jz print 
        jnz Mypos         
        mov x, cx        
        mov y, dx         
        
        pop dx
        pop bx
        pop cx
        pop ax                
                
    Endm 



        ;we will use the variables of the coordinates of the registers in the GUI

        Print macro Stringo     
            mov AH, 09h 
            mov dx, offset Stringo 
            int 21h 
        endm 

  

        readonedgit MACRO digit    
            local    alphabet,next  ,notcapital,error 
            PUSH AX
            PUSH BX
            PUSH CX
            PUSH DX

            mov ah,07
            int 21h
            mov ah,2
            mov dl,al
            int 21h
            mov digit,al
            cmp digit, 30h
            jb alphabet
            cmp digit,39h
            ja alphabet
            ;if not alphabet :
            sub digit,30h
            jmp next

            alphabet:
            cmp digit,41h 
            jb notcapital
            cmp digit,46h
            ja notcapital
            sub digit,37h
            jmp next

            ;if not capital 
            notcapital:
            cmp digit,61h
            jb error
            cmp digit,66h
            ja error
            sub digit,57h
            jmp next


            ;if enter in valid number
            error:
            Print_Msg ERROR_MESSAGE 
            next:      
            POP DX
            POP CX
            POP BX
            POP AX

            
    ENDM 

    setTextCursor macro Column, Row
        push ax 
        push bx 
        push dx 
            mov  dl,  Column    
            mov  dh,  Row    
            mov  bh,  0                                              ;page no.
            mov  ah,  2     
            int  10h       
        pop dx 
        pop bx 
        pop ax 
    endm 
    
    readChar macro char 
        push ax 
        mov ah, 07
        int 21h
        mov char, al
        pop ax
    endm
    
    DisplayChar macro x,y,char
     
        push ax
        push bx
        mov ah,x
        mov al,y
        setTextCursor ah,al
        mov  al, char
        mov  bh, 0    ;Display page
        mov  ah, 0Eh  ;Teletype
        int  10h
        pop bx
        pop ax   
    ENDM 

    strToInt macro str
        push bx 
        push ax 
        push dx
            ;first digit from left(tens)
            mov al, str[2]
            sub al, 30h
            mov bl, 10
            mul bl
            mov dl, al

            ;read the second digit(units) and add it to tens
            mov al, str[3]
            sub al, 30h
            add dl, al

            mov str, dl
        pop dx 
        pop ax
        pop bx 
    endm

    ClearScreen MACRO beginCol,beginRow,endCol,endRow 
        ; Push all used regeister in stack to get their original value after the operation 
        push ax
        push bx
        push cx
        push dx
        mov ax,0600h
        mov bh,07
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

    print2Number MACRO num
        local numerical,next,numerical2,next2
        
        push ax
        push cx 
        push dx 
        
        mov al,byte ptr num
        mov ah,0
        mov cl,10h
        div cl
        cmp al,0ah
        jb numerical
        add al,37h     
        mov dl,  al 
        push ax
        mov ah,  2h
        int 21h 
        pop ax
        jmp next
        numerical:
        add al,30h 
    
        mov dl,  al
        push ax
        mov ah,  2h
        int 21h 
        pop ax
        next:
        cmp ah,0ah
        jb numerical2
        add ah,37h     
        mov dl,  ah 
        push ax
        mov ah,  2h
        int 21h
        pop ax 
        jmp next2
        numerical2:
        add ah,30h 
        mov dl,  ah
        push ax
        mov ah,  2h
        int 21h
        pop ax
        next2:
        
        pop dx
        pop cx 
        pop ax

    ENDM 

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

    getKeyPressed macro 
        mov ah,0
        int 16h
    endm 
    
    check_byte_valid macro val,Forbidden_array
    local div_number        
    push ax
    push bx
    push cx
    push dx
    
    mov dx,0
    mov ch,0
    mov cl,2
    mov ah,0
    mov al,val
    mov bl,10h
    div_number: 
        mov ah,0
        div bl
        check_forbidden  Forbidden_array,0
    loop div_number
    
    pop dx
    pop cx
    pop bx
    pop ax
    ;check_byte_valid endm 
    endm
 ; macro to check if number has a digit that is forbidden or not same as above but word
check_word_valid macro val,Forbidden_array
    local div_number        
    push ax
    push bx
    push cx
    push dx
    
    mov dx,0
    mov ch,0
    mov cl,4
    mov ax,val 
    mov bx,10h
    jmp div_number

    div_number:
        mov dx,0
        div bx
        check_forbidden Forbidden_array,0
    loop div_number
    
    pop dx
    pop cx
    pop bx
    pop ax
;    check_word_valid endm
    endm

    check_forbidden macro Forbidden_array,index 
    local  lose_1point
    local  not_lose_1point
    push Ax
    push bx
    mov bh,0
    mov bl,index  
    mov ah,Forbidden_array[bx] ;compare position at index in forbidden array
    cmp ah,'1' ; compare        
    pop bx  
    pop Ax
    jz lose_1point    ; jmp here or outside ?! to be discussed later
    jmp not_lose_1point
    lose_1point:
    mov losepoint,1 
    not_lose_1point:
    ;mov losepoint,0
 
    endm
set_forbidden macro instruction_name,Forbidden_array,Forbidden_char,size2,index
    local Set_bit
    local Dont_Set_bit
    push DI
    push Ax
    push Cx 
    push bx 
    
    ;lea DI,instruction_name
    mov di, instruction_name
    mov al,Forbidden_char
    mov ch,0
    mov cl,size2   ;Search the string in  DI for Forbidden char
    REPNE SCASB ;[Scan string]Continue while not equal
    cmp cl,0
    jA Set_bit
    jmp Dont_Set_bit
    Set_bit:
            mov bl,index
            mov bh,0
            mov Forbidden_array[bx],'1' ; forbidden for instruction with index = index 
    Dont_Set_bit:
    pop bx  
    pop Cx
    pop Ax
    pop Di
endm

drawDynamicPixel macro column, row, color, Y_t, X_t ;x, y, color...the last two parameters are the dynamic position of the pixel
        xor ch,ch
        xor dh,dh
        mov dl, row
        mov cl, column
        mov al, color
        ;Dynamics:
        add dx, Y_t
        add cx, X_t
        int 10h
ENDM drawDynamicPixel

changeMode macro number
    mov al, number ; Video mode number
    mov ah, 0h
    int 10h
endm

scrollUP MACRO beginCol,beginRow,endCol,endRow 
        push ax
        push bx
        push cx
        push dx
        mov ah,06; to scrollup 
        mov al, 01; number of lines to scroll
        mov bh,07
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
