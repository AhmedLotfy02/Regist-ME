.model huge
.stack 64

.data
instructions db "MOV ", "ADD ", "SUB ", "MUL ", "DIV ", "INC ", "DEC ", "NOP ", "SAL ", "SHR ", "SHL ", "ROR ", "ROL ", "SAR ","IDIV ", "IMUL "  
registers db "AX ", "AL ", "AH ", "BX ", "BL ", "BH ", "CX ", "CL ", "CH ", "DX ", "DL ", "DH ", "SI ", "DI ", "SP ", "BP ","val ","address "
digits db "0 ", "1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 " ,"A ","B ","C ","D ","E ","F "  
PLAYERTURN DB 0
    instruction_index db 0
    src_index_reg db 0
    dest_index_reg db 17
    src_index_val db 0
    dest_index_val db 18 
    address_mode db 0 
    address_mode2 db 0  
    count_bit_1 db 1   
    count_bit_2 db 1
    losepoint db 0
    initial_point db ?
    enter_name db "Please, Enter your name: $"
    initialP db "Initial Points: $"
    press db "Press Enter key to continue$"
    forbiddenCharMess db "Enter forbidden char for your opponent: $"
    
    DESTORSRC DB 0    ;      0----->DEST  , 1------>SRC

    ; player1 Data variables -----------------------------------------------------------------------------------
        Forbidden_digits_1 db '0000000000000000'
        Forbidden_Registers_1 db '0000000000000000'
        Forbidden_instruction_1 db '0000000000000000' 
        player1_mess db "Player 1 data$"
        levelMessage db "Enter the level (1 or 2): $"
        player1_name db 15 , ?, 15 dup("$")
        Forbidden_char1 db 'M'
        intial_points_player1 db 4, ?, 4 dup(0)
        losepoint_player1 db 0
        selected_level db ?
        data_segment_1 db 0,0,0,0,0,45H,0,0,0,0,0,0,0,0,0,0 
        Player1_Data_Register db 11h,33h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,05h
        power_up_player1 db 0
    ;------------------------    AH  -Al -BH-Bl -CH  -CL-DH  -DL-  SI -     DI --   SP    - BP   -value-addressvalue----

    ; player2 Data variables --------------------------------------------------------------
        player2_mess db "Player 2 data$"
        Forbidden_digits_2 db '0000000000000000'
        Forbidden_Registers_2 db '0000000000000000'
        Forbidden_instruction_2 db '0000000000000000'
        Forbidden_char2 db 'M' 
        player2_name db 15 , ?, 15 dup("$")
        intial_points_player2 db 4, ?, 4 dup(0)
        losepoint_player2 db 0
        data_segment_2 db 0,0,0,0,0,9,0,0,0,0,0,0,0,0,0,0
        Player2_Data_Register db 03h,02h,00h,07h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,05h,05h,00h,05h
        power_up_player2 db 0
    ;------------------------AH  -Al -BH-Bl -CH  -CL-DH  -DL-  SI -     DI --   SP    - BP   -value-addressvalue---- 
    
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
    ; regs names
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
    
Data_Segment_X db 27
Data_Segment_Y db 1
Counter db '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'
Counter_Segment db 16
Register_Values_X db 60
Register_Values_Y db 2
Outer_Counter_RV db 8
Inner_Counter_RV db 2
Temp_Data db 0
P1 db 'P1'
P2 db 'P2'
    ;;tests
    x DW ?
    y dw ?
enterMemAdress db 'enter address','$'  
ERROR_MESSAGE DB'ERROR','$'

VALUE_COORDINATES DW 130,90,170,190
REG_COORDINATES DW 210,90,250,190
inputValueString db 5, ?, 5 dup('$')   
inputValueSize db ?
NUMBER DW ?
TEMP DB ?
player_turn db 1   ; player1-> 1 , player2-> 2 
player_turn1 db 1   ; power up 2
player_turn2 db 1   ; power up 2 
win_player1 db 0
win_player2 db 0   

target dw 105eh

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

;start game messages
    message1 db 'to start game prress f1$'
    message2 db 'to start chat prress f2$'
    message3 db 'to end game prress esc$'        ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.code





;;;;;;;;;;;;;;;;;;;;;;;;;;
CickedMEMORYRegister MACRO Name,value,NumberOfBytes
    local notBP,  NOTDI,notSI,CLICKEDMEMREG, FINALL
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
    local notAX,notAL,notAH,notBX,notBL,notBH,notCX,notCL,notCH,notDX,notDL,notDH,notSI,notDI,notSP,notBP
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
            
        ENDM movCursor

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
;set_forbidden Endm 
; macro to check if number has a digit that is forbidden or not
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
        check_forbidden  Forbidden_array,ah
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
        check_forbidden Forbidden_array,dl
    loop div_number
    
    pop dx
    pop cx
    pop bx
    pop ax
;    check_word_valid endm
endm
           
set_forbidden_player1 proc near
;--------------------------- assume we have it Read it Later in Forbidden_Char2-----------------------------------------;     
    
    ; loop on 17 instruction to set 
;------instructoins,Forbidden_instruction,Forbidden_char2,17,------------------------------- 
    mov si,0
    mov dl,0 
    loop_set_instruction: 
        lea cx ,instructions[si]
        set_forbidden cx,Forbidden_instruction_2,Forbidden_char2,4,dl
        inc dl
        add si,4              
        cmp si,56
        jnz loop_set_instruction  
        
        ;lea cx ,instructions[24] 
        ;set_forbidden cx ,Forbidden_instruction_2,Forbidden_char2,3,6 
        
        mov si,56
        mov dl,14
    loop_set_instruction2: 
        lea cx ,instructions[si]
        set_forbidden cx,Forbidden_instruction_2,Forbidden_char2,5,dl
        inc dl
        add si,5              
        cmp si,66
        jnz loop_set_instruction2     
           
;------------- loop on numbers ----------------------------------------------      
    mov si,0
    mov dl,0 
    loop_set_numbers: 
        lea cx ,digits[si]
        set_forbidden cx,Forbidden_digits_2,Forbidden_char2,2,dl
        inc dl
        add si,2              
        cmp si,32
        jnz loop_set_numbers  
                                                                         
                                                                            
;------------- loop on regsiter 16------------------------------------------    

    mov si,0
    mov dl,0 
    loop_set_registers: 
        lea cx ,registers[si]
        set_forbidden cx,Forbidden_Registers_2,Forbidden_char2,3,dl
        inc dl
        add si,3              
        cmp si,48
        jnz loop_set_registers         
    ret
    set_forbidden_player1 endp

set_forbidden_player2 proc near   ; player2 setforbidden for player1
;--------------------------- assume we have it Read it Later in Forbidden_Char2-----------------------------------------;     
    
    ; loop on 17 instruction to set 
;------instructoins,Forbidden_instruction,Forbidden_char2,17,------------------------------- 
    mov si,0
    mov dl,0 
    loop_set2_instruction: 
        lea cx ,instructions[si]
        set_forbidden cx,Forbidden_instruction_1,Forbidden_char1,4,dl
        inc dl
        add si,4              
        cmp si,56
        jnz loop_set2_instruction  
        
        lea cx ,instructions[24] 
        set_forbidden cx ,Forbidden_instruction_1,Forbidden_char1,3,6 
        
        mov si,56
        mov dl,14
    loop_set2_instruction2: 
        lea cx ,instructions[si]
        set_forbidden cx,Forbidden_instruction_1,Forbidden_char1,5,dl
        inc dl
        add si,5              
        cmp si,66
        jnz loop_set2_instruction2     
           
;------------- loop on numbers ----------------------------------------------      
    mov si,0
    mov dl,0 
    loop_set2_numbers: 
        lea cx ,digits[si]
        set_forbidden cx,Forbidden_digits_1,Forbidden_char1,2,dl
        inc dl
        add si,2              
        cmp si,32
        jnz loop_set2_numbers  
                                                                         
                                                                            
;------------- loop on regsiter 16------------------------------------------    

    mov si,0
    mov dl,0 
    loop_set2_registers: 
        lea cx ,registers[si]
        set_forbidden cx,Forbidden_Registers_1,Forbidden_char1,3,dl
        inc dl
        add si,3              
        cmp si,48
        jnz loop_set2_registers         
    ret
    set_forbidden_player2 endp

set_zero_forbidden_player1 proc near  
    
     mov cx,12
     mov si,0
     loop_set_zero_player1_reg:
     
     mov Forbidden_Registers_2[si],0
         inc si
         dec cx
     jnz  loop_set_zero_player1_reg
     mov cx,16
     mov si,0
     loop_set_zero_player1_digits:    
         mov Forbidden_digits_2[si],0
         inc si
         dec cx
     jnz  loop_set_zero_player1_digits
     mov cx,16
     mov si,0    
     loop_set_zero_player1_instructions:
         mov Forbidden_instruction_2[si],0
         inc si
         dec cx 
     jnz  loop_set_zero_player1_instructions    
    
     ret
     set_zero_forbidden_player1 endp
set_zero_forbidden_player2 proc near  
    
     mov cx,12
     mov si,0
     loop_set_zero_player2_reg:
     
     mov Forbidden_Registers_1[si],0
         inc si
         dec cx
     jnz  loop_set_zero_player2_reg
     mov cx,16
     mov si,0
     loop_set_zero_player2_digits:    
         mov Forbidden_digits_1[si],0
         inc si
         dec cx
     jnz  loop_set_zero_player2_digits
     mov cx,16
     mov si,0    
     loop_set_zero_player2_instructions:
         mov Forbidden_instruction_1[si],0
         inc si
         dec cx 
     jnz  loop_set_zero_player2_instructions    
    
     ret
     set_zero_forbidden_player2 endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    readonedgits   MACRO  I 
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

CONVERT PROC far  
   CMP inputValueSize,1
   JA TWO    
    
    readtwodigitss 0
    MOV AL,TEMP 
    MOV BYTE PTR NUMBER[0],AL
    JMP FIN
   TWO:
   READFOURDIGITs
   FIN:
    RET
CONVERT ENDP  

     CHECKINPUTVALUESIZE PROC far
                         
       ;CALL CHECKISNUM
       cmp inputValueString[1], 0
       jz  setInvalid
       cmp inputValueString[1], 2
       jz setByte
       
       cmp inputValueString[1], 3
       jz convertToWord
       
       cmp inputValueString[1], 4
       jz setWord

       setByte: mov inputValueSize, 1
       jmp endCheck
       
       convertToWord:
            mov bl, inputValueString[4]
            mov inputValueString[5], bl
            mov bl, inputValueString[3]
            mov inputValueString[4], bl
            mov bl, inputValueString[2]
            mov inputValueString[3], bl
            mov inputValueString[2], 0
       
       setWord: mov inputValueSize, 2
       jmp endCheck
       
       setInvalid: mov inputValueSize, 0
       endCheck:
       ret
    CHECKINPUTVALUESIZE ENDP
    
    
   readValue  proc far
    call CLR
    call Fixed
    movCursor 5,2
    Print_Msg enterMemAdress
    movCursor 5,3
    readString inputValueString
    CALL CHECKINPUTVALUESIZE  
    
    CALL CONVERT 
    
    CMP INPUTVALUESIZE,1
    jnz WORDLABEL
    MOV AL,BYTE PTR NUMBER
    CMP PLAYERTURN ,0
    JNZ PLAYER2TURNREADVALUE

    MOV PLAYER2_DATA_REGISTER[17],aL
    JMP CONTINUE1
    PLAYER2TURNREADVALUE:
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

Print macro Stringo                                             ;Takes a string and prints it 
            mov AH, 09h 
            mov dx, offset Stringo 
            int 21h 
    endm Print

  

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

    ; you need to jump zero after the macro jz mov_instruction  
ENDM


;description
readAdress PROC
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




memoryOrReg PROC

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

memoryOrRegORVALUE PROC FAR

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

VALUE_OR_REG PROC

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

;description
SHOW_REGISTERS_ADRESSES_CHOICE PROC FAR
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
        JZ SRCADDRESS
        CickedMEMORYRegister DEST_INDEX_REG,DEST_INDEX_VAL,COUNT_BIT_1
        MOV COUNT_BIT_1,1
        RET

        SRCADDRESS:
            CickedMEMORYRegister SRC_INDEX_REG,SRC_INDEX_VAL,COUNT_BIT_2
            MOV COUNT_BIT_2,1
    RET
SHOW_REGISTERS_ADRESSES_CHOICE ENDP


;------------------------------------------ Macros for clicking an icon on the GUI of player1 -----------------------------------------------
moveToRightLabelofPlayer1 proc FAR 
    ;local notmov,movlabel,notADD,ADDabel,notADC,ADCLabel,notSUB,SUBLabel
    ;,notSBB,SBBlabel,notXOR,XORlabel,notAND,ANDlabel,notOR,ORlabel
    ;,notNOP,NOPlabel,notSHR,SHRlabel,notSHL,SHLlabel,notSAR,SARlabel
    ;,notCLC,CLClabel,notROR,RORlabel,notROL,ROLlabel,
    ;notRCL,RCLlabel,notRCR,RCRlabel,notPUSH,PUSHlabel,
    ;notPOP,POPlabel,notINC,INClabel,notDEC
    ;,DEClabel,notDiv,Divlabel,notIDiv,
    ;IDivlabel,notMUL,MULlabel,notIMUL,IMULlabel
    ; PUSH AX
    ; PUSH BX
    ; PUSH CX
    ; PUSH DX
    

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
    CALL SUBPLAYER1PR 
    jmp far ptr RETURNmovlabelOfplayer1
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
    ;CALL NOP
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
    CALL IMULPLAYER1PR 
    jmp RETURNmovlabelOfplayer1
    noTIMUL:
    ; POP DX
    ; POP CX
    ; POP BX
    ; POP AX    
    JMP CHECKCLICK
    RETURNmovlabelOfplayer1: RET
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
    CALL SUBPLAYER2PR
    jmp far ptr RETmoveToRightLabelofPlayer2
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
    CALL IMULPLAYER2PR
    jmp far ptr RETmoveToRightLabelofPlayer2
    noTIMUL2:

    ; POP DX
    ; POP CX
    ; POP BX
    ; POP AX    
    RETmoveToRightLabelofPlayer2: RET
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
    mov dx, offset player1_name+2 
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
    mov dx, offset player2_name+2
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



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    SHOW_2ND_OPERAND proc near
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
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    SHOW_REGISTERS_CHOICE proc near
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
        JNZ DEST
        CickedRegister SRC_INDEX_REG,SRC_INDEX_VAL,COUNT_BIT_2
        RET
        DEST:
        CickedRegister DEST_INDEX_REG,DEST_INDEX_VAL,COUNT_BIT_1
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


    FIRSTSCREEN PROC near
        CALL CLR
        CALL FIXED
      movCursor 5,2
        PRINT_STRING_3DIGIT VALUE
        movCursor 12,2
        PRINT_STRING_3DIGIT REGISTER
        ;;DRAWING REC AROUND THEM
        ;;AL REC
        DrawRec 25,30,50,70
        ;AH REC
        DrawRec 25,90,50,130
        CALL VALUE_OR_REG
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
    
    beginGame PROC
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
    beginGame ENDP

    setTextCursor macro Column, Row
        pusha
            mov  dl,  Column    
            mov  dh,  Row    
            mov  bh,  0                                              ;page no.
            mov  ah,  2     
            int  10h       
        popa
    endm 
    
    readChar macro char 
        pusha 
        mov ah, 07
        int 21h
        mov char, al
        popa
    endm
    
    DisplayChar macro x,y,char
    ; Push all used regeister in stack to get their original value after the operation 
        push ax
        push bx
        ; assign two registers with location of displayed char to call mov Cursor
        mov ah,x
        mov al,y
        ; mov cursor to detrmined location
        setTextCursor ah,al
        ;interrupt to display char
        mov  al, char
        mov  bh, 0    ;Display page
        mov  ah, 0Eh  ;Teletype
        int  10h
        pop bx
        pop ax   
    ENDM 

    strToInt macro str
        pusha    
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
        popa
    endm
    
    setInitialPoints proc
        mov al, intial_points_player1
        mov ah, intial_points_player2
        cmp ah, al
        ja  setP1Points 
        mov bl, al
        jmp compwith60
        setP1Points:
            mov bl, ah
        
        compwith60:
            cmp bl, 60
            ja setPoints 
            mov initial_point, 60
            jmp finish2
            
            setPoints:
                mov initial_point, bl 
            
        finish2: ret    
    setInitialPoints endp

    GetEnterKeyPressed proc 
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

    player1_forbidden_screen proc 
       
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
    
    player2_forbidden_screen proc 
    
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

    player1Screen proc 
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
    
    player2Screen proc 
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
    pusha
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
    
    popa

ENDM 


   DRAW_DATA_SEGMENT  PROC FAR

        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX

    mov Data_Segment_X,27
    mov Data_Segment_Y,1
    mov di,0
    mov Counter_Segment,16
    loop1:

    movCursor Data_Segment_X,Data_Segment_Y
    mov ch ,data_segment_1[di]
        print2Number  ch
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
    mov ch ,data_segment_2[di]
        print2Number  ch
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
        POP DX
        POP CX
        POP BX
        POP AX

    RET
    DRAW_DATA_SEGMENT ENDP

SHOW_REGISTERS_VALUES PROC FAR



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
    jnz loop001

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


;description: the fixed data of each screen, players' registers
FIXED proc far
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
TURN PROC FAR
         ; AH=2h: Set cursor position
        mov dl, 2 ; Column
        mov dh, 3 ; Row
        mov bx, 0 ; Page number, 0 for graphics modes
        mov ah, 2h
        int 10h

        ;CALL DRAW_REGISTER_NAMES
        CALL CLR
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
 ; JMP FAR PTR BEGIN
        ; jmp loop1
        RET
       TURN ENDP
    


    MAIN PROC near
        MOV AX,@DATA
        MOV DS,AX
        mov ax,@data
        mov ds,ax
        ClearScreen 0,0,79,24
        call player1Screen
        ClearScreen 0,0,79,24
        call player2Screen
        ;ClearScreen 0,0,79,24
        ;call player1_forbidden_screen
        ;ClearScreen 0,0,79,24
        ;call player2_forbidden_screen
        CALL set_forbidden_player1
        CALL set_forbidden_player2
        ClearScreen 0,0,79,24
        call beginGame


        begin:
        ; AH=0h: Set video mode
        mov al, 12h ; Video mode number
        mov ah, 0h
        int 10h
    MAINLOOP:
        CALL TURN 
        MOV AL,PLAYERTURN
        NOT AL
        MOV PLAYERTURN,AL
    JMP MAINLOOP
        ; hlt
    MAIN endp
        finish :
MOVPLAYER1PR PROC NEAR
            ; call draw function or proc of player1
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
            call change_src_dest
            cmp power_up_player1,1
            jz mov_power_up1_player1
            cmp power_up_player1,2
            jz mov_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_mov_player1 
            mov_power_up1_player1: 
                cmp intial_points_player1,5
                JB nopoints_mov_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_mov_powerup1_p1 
                nopoints_mov_powerup1_p1:
                jmp far ptr end_MOV_instruction_player1
                can_perform_mov_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1 
                    sub intial_points_player1,5
                    jmp perform_mov_player1 
            mov_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_mov_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_mov_powerup2_p1 
                nopoints_mov_powerup2_p1:
                jmp far ptr end_MOV_instruction_player1
                can_perform_mov_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_mov_player1
                perform_mov_player1:
                        mov instruction_index,0
                        mov al,address_mode
                        cmp al,1
                        jz address_mode_mov1
                        jmp reg_mode_mov1                
                    address_mode_mov1:  
                        call  mov_address_player1
                        jmp far ptr end_MOV_instruction_player1
                    reg_mode_mov1:
                        call  mov_register_player1 
                jmp far ptr end_MOV_instruction_player1
		end_MOV_instruction_player1:   
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
		
		RET
MOVPLAYER1PR ENDP

ADDPLAYER1PR  PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
            call change_src_dest
        cmp power_up_player1,1
            jz add_power_up1_player1
            cmp power_up_player1,2
            jz add_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_add_player1 
            add_power_up1_player1: 
                cmp intial_points_player1,5
                JB nopoints_add_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_add_powerup1_p1 
                nopoints_add_powerup1_p1:
                jmp far ptr endADD_instruction_player1
                can_perform_add_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1
                    sub intial_points_player1,5
                    jmp perform_add_player1 
            add_power_up2_player1:  
                cmp intial_points_player1,3
                JB nopoints_add_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_add_powerup2_p1 
                nopoints_add_powerup2_p1:
                jmp far ptr endADD_instruction_player1
                can_perform_add_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1 
                    sub intial_points_player1,3
                    jmp perform_add_player1
                perform_add_player1:
                        mov instruction_index,1
                        mov al,address_mode
                        cmp al,1
                        jz address_mode_add1
                        jmp reg_mode_add1                 
                    address_mode_add1:  
                        call  mov_address_player1
                        jmp far ptr endADD_instruction_player1
                    reg_mode_add1:      
                        call  mov_register_player1    
                  jmp far ptr endADD_instruction_player1
		endADD_instruction_player1:
        	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
		RET
ADDPLAYER1PR  ENDP
SUBPLAYER1PR  PROC NEAR
; call drawing and clicking procedure --------------------------------

            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest          
 cmp power_up_player1,1
            jz sub_power_up1_player1
            cmp power_up_player1,2
            jz sub_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_sub_player1 
            sub_power_up1_player1:
                cmp intial_points_player1,5
                JB nopoints_Sub_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Sub_powerup1_p1 
                nopoints_Sub_powerup1_p1:
                jmp far ptr endSUB_instruction_player1
                can_perform_Sub_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1   
                    sub intial_points_player1,5
                    jmp perform_sub_player1 
            sub_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_Sub_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Sub_powerup2_p1 
                nopoints_Sub_powerup2_p1:
                jmp far ptr endSUB_instruction_player1
                can_perform_Sub_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1 
                    sub intial_points_player1,3
                    jmp perform_sub_player1
            perform_sub_player1:
                        mov instruction_index,2
                        mov al,address_mode
                        cmp al,1
                        jz address_mode_sub1
                        jmp reg_mode_sub1        
                        ; address mode processing ---------------------------------------------------------         
                    address_mode_sub1:  
                        call  mov_address_player1
                        jmp far ptr endSUB_instruction_player1
                    reg_mode_sub1:                
                        call  mov_register_player1    
                  jmp far ptr endSUB_instruction_player1
	endSUB_instruction_player1:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
	RET
SUBPLAYER1PR endp

MULPLAYER1PR PROC NEAR
            CALL SHOW_1ST_OPERAND

call change_src_dest 
cmp power_up_player1,1
            jz mul_power_up1_player1
            cmp power_up_player1,2
            jz mul_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_mul_player1 
            mul_power_up1_player1:
                cmp intial_points_player1,5
                JB nopoints_mul_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_mul_powerup1_p1 
                nopoints_mul_powerup1_p1:
                jmp far ptr endMUL_instruction_player1
                can_perform_mul_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1
                    sub intial_points_player1,5
                    jmp perform_mul_player1 
            mul_power_up2_player1: 
                cmp intial_points_player1,3
                JB nopoints_mul_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_mul_powerup2_p1 
                nopoints_mul_powerup2_p1:
                jmp far ptr endMUL_instruction_player1
                can_perform_mul_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_mul_player1
            perform_mul_player1:
                    mov instruction_index,3
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_mul1
                    jmp reg_mode_mul1        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_mul1:  
                    call  div_mul_inc_dec_address_player1
                    jmp far ptr endMUL_instruction_player1
                reg_mode_mul1:
                    call  div_mul_inc_dec_register_player1 
              jmp far ptr endMUL_instruction_player1

	endMUL_instruction_player1:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
RET
MULPLAYER1PR  ENDP

DIVPLAYER1PR  PROC NEAR
            CALL SHOW_1ST_OPERAND
        
call change_src_dest 
 cmp power_up_player1,1
            jz div_power_up1_player1
            cmp power_up_player1,2
            jz div_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_div_player1 
            div_power_up1_player1: 
                cmp intial_points_player1,5
                JB nopoints_div_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_div_powerup1_p1 
                nopoints_div_powerup1_p1:
                jmp far ptr endDIV_instruction_player1
                can_perform_div_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1 
                    sub intial_points_player1,5
                    jmp perform_div_player1 
            div_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_div_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_div_powerup2_p1 
                nopoints_div_powerup2_p1:
                jmp far ptr endDIV_instruction_player1
                can_perform_div_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_div_player1
            perform_div_player1:           
                        mov instruction_index,4
                        mov al,address_mode
                        cmp al,1
                        jz address_mode_div1
                        jmp reg_mode_div1        
                        ; address mode processing ---------------------------------------------------------         
                    address_mode_div1:  
                        call  div_mul_inc_dec_address_player1 
                        jmp far ptr endDIV_instruction_player1
                    reg_mode_div1:
                        call  div_mul_inc_dec_register_player1 
                  jmp far ptr endDIV_instruction_player1

	endDIV_instruction_player1:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
	RET 
DIVPLAYER1PR   ENDP

IDIVPLAYER1PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            
 call change_src_dest 
            cmp power_up_player1,1
            jz idiv_power_up1_player1
            cmp power_up_player1,2
            jz idiv_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_idiv_player1 
            idiv_power_up1_player1:
                cmp intial_points_player1,3
                JB nopoints_idiv_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_idiv_powerup1_p1 
                nopoints_idiv_powerup1_p1:
                jmp far ptr endIDIV_instruction_player1
                can_perform_idiv_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1
                    sub intial_points_player1,5
                    jmp perform_idiv_player1 
            idiv_power_up2_player1:                                                                      
                cmp intial_points_player1,3
                JB nopoints_idiv_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_idiv_powerup2_p1 
                nopoints_idiv_powerup2_p1:
                jmp far ptr endIDIV_instruction_player1
                can_perform_idiv_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1 
                    sub intial_points_player1,3
                    jmp perform_idiv_player1
            perform_idiv_player1:            
                    mov instruction_index,14
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_idiv1
                    jmp reg_mode_idiv1        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_idiv1:  
                    call  div_mul_inc_dec_address_player1 
                    jmp far ptr endIDIV_instruction_player1
                reg_mode_idiv1:
                    call  div_mul_inc_dec_register_player1 
              jmp far ptr endIDIV_instruction_player1
     

	endIDIV_instruction_player1:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
RET
IDIVPLAYER1PR  ENDP  

IMULPLAYER1PR PROC NEAR
; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
                        CALL SHOW_1ST_OPERAND

call change_src_dest             
cmp power_up_player1,1
            jz imul_power_up1_player1
            cmp power_up_player1,2
            jz imul_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_imul_player1 
            imul_power_up1_player1:
                cmp intial_points_player1,5
                JB nopoints_Imul_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Imul_powerup1_p1 
                nopoints_Imul_powerup1_p1:
                jmp far ptr endIMUL_instruction_player1
                can_perform_Imul_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1 
                    sub intial_points_player1,5
                    jmp perform_imul_player1 
            imul_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_Imul_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Imul_powerup2_p1 
                nopoints_Imul_powerup2_p1:
                jmp far ptr endIMUL_instruction_player1
                can_perform_Imul_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_imul_player1
            perform_imul_player1:
                    mov instruction_index,15
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_imul1
                    jmp reg_mode_imul1        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_imul1:  
                    call  div_mul_inc_dec_address_player1
                    jmp far ptr endIMUL_instruction_player1
                reg_mode_imul1:
                    call  div_mul_inc_dec_register_player1 
              jmp far ptr endIMUL_instruction_player1


	endIMUL_instruction_player1:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
RET
IMULPLAYER1PR  ENDP

INCPLAYER1PR  PROC NEAR
            CALL SHOW_1ST_OPERAND

call change_src_dest 
 cmp power_up_player1,1
            jz INC_power_up1_player1
            cmp power_up_player1,2
            jz INC_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_INC_player1 
            INC_power_up1_player1:
                cmp intial_points_player1,5
                JB nopoints_INC_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_INC_powerup1_p1 
                nopoints_INC_powerup1_p1:
                jmp far ptr endINC_instruction_player1
                can_perform_INC_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1
                    sub intial_points_player1,5
                    jmp perform_INC_player1 
            INC_power_up2_player1:                           
                cmp intial_points_player1,3
                JB nopoints_INC_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_INC_powerup2_p1 
                nopoints_INC_powerup2_p1:
                jmp far ptr endINC_instruction_player1
                can_perform_INC_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1   
                    sub intial_points_player1,3
                    jmp perform_INC_player1
            perform_INC_player1:
            
            mov instruction_index,5
            mov al,address_mode
            cmp al,1
            jz address_mode_inc1
            jmp reg_mode_inc1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_inc1:  
            call  div_mul_inc_dec_address_player1
            jmp far ptr endINC_instruction_player1
        reg_mode_inc1:
            call  div_mul_inc_dec_register_player1 
      jmp far ptr endINC_instruction_player1


	endINC_instruction_player1:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
RET
INCPLAYER1PR  ENDP

DECPLAYER1PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            
call change_src_dest 
cmp power_up_player1,1
            jz DEC_power_up1_player1
            cmp power_up_player1,2
            jz DEC_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_DEC_player1 
            DEC_power_up1_player1:    
                cmp intial_points_player1,5
                JB nopoints_DEC_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_DEC_powerup1_p1 
                nopoints_DEC_powerup1_p1:
                jmp far ptr endDEC_instruction_player1
                can_perform_DEC_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1   
                    sub intial_points_player1,5
                    jmp perform_DEC_player1 
            DEC_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_DEC_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_DEC_powerup2_p1 
                nopoints_DEC_powerup2_p1:
                jmp far ptr endDEC_instruction_player1
                can_perform_DEC_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_DEC_player1
            perform_DEC_player1:
            
            mov instruction_index,6
            mov al,address_mode
            cmp al,1
            jz address_mode_dec1
            jmp reg_mode_dec1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_dec1:  
            call  div_mul_inc_dec_address_player1
            jmp far ptr endDEC_instruction_player1
        reg_mode_dec1:
            call  div_mul_inc_dec_register_player1 
      jmp far ptr endDEC_instruction_player1


	endDEC_instruction_player1:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
RET
DECPLAYER1PR  ENDP

SARPLAYER1PR PROC NEAR
; set variable to number then compare
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest 
            cmp power_up_player1,1
            jz SAR_power_up1_player1
            cmp power_up_player1,2
            jz SAR_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_SAR_player1 
            SAR_power_up1_player1:
                cmp intial_points_player1,5
                JB nopoints_SAR_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_SAR_powerup1_p1 
                nopoints_SAR_powerup1_p1:
                jmp far ptr endSAR_instruction_player1
                can_perform_SAR_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1
                    sub intial_points_player1,5
                    jmp perform_SAR_player1 
            SAR_power_up2_player1: 
                cmp intial_points_player1,3
                JB nopoints_SAR_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_SAR_powerup2_p1 
                nopoints_SAR_powerup2_p1:
                jmp far ptr endSAR_instruction_player1
                can_perform_SAR_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_SAR_player1
            perform_SAR_player1:
            
            mov instruction_index,13
            mov al,address_mode
            cmp al,1
            jz address_mode_sar1
            jmp reg_mode_sar1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_sar1:  
            call  shl_shr_ror_rol_address_player1
            jmp far ptr endSAR_instruction_player1
        reg_mode_sar1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr endSAR_instruction_player1

	endSAR_instruction_player1:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
RET
SARPLAYER1PR  ENDP

SALPLAYER1PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest 
  cmp power_up_player1,1
            jz sal_power_up1_player1
            cmp power_up_player1,2
            jz sal_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_SAL_player1 
            sal_power_up1_player1:
                cmp intial_points_player1,5
                JB nopoints_sal_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_sal_powerup1_p1 
                nopoints_sal_powerup1_p1:
                jmp far ptr endSAL_instruction_player1
                can_perform_sal_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1 
                    sub intial_points_player1,5
                    jmp perform_SAL_player1 
            sal_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_sal_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_sal_powerup2_p1 
                nopoints_sal_powerup2_p1:
                jmp far ptr endSAL_instruction_player1
                can_perform_sal_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_SAL_player1
            perform_SAL_player1:
            
            mov instruction_index,8
            mov al,address_mode
            cmp al,1
            jz address_mode_sal1
            jmp reg_mode_sal1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_sal1:  
            call  shl_shr_ror_rol_address_player1
            jmp far ptr endSAL_instruction_player1
        reg_mode_sal1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr endSAL_instruction_player1

	endSAL_instruction_player1:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
RET
SALPLAYER1PR  ENDP

SHRPLAYER1PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest 
 cmp power_up_player1,1
            jz SHR_power_up1_player1
            cmp power_up_player1,2
            jz SHR_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_SHR_player1 
            SHR_power_up1_player1: 
                cmp intial_points_player1,5
                JB nopoints_SHR_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_SHR_powerup1_p1 
                nopoints_SHR_powerup1_p1:
                jmp far ptr endSHR_instruction_player1
                can_perform_SHR_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1  
                    sub intial_points_player1,5
                    jmp perform_SHR_player1 
            SHR_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_SHR_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_SHR_powerup2_p1 
                nopoints_SHR_powerup2_p1:
                jmp far ptr endSHR_instruction_player1
                can_perform_SHR_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1 
                    sub intial_points_player1,3
                    jmp perform_SHR_player1
            perform_SHR_player1:
            
            mov instruction_index,9
            mov al,address_mode
            cmp al,1
            jz address_mode_shr1
            jmp reg_mode_shr1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_shr1:  
            call  shl_shr_ror_rol_address_player1 
            jmp far ptr endSHR_instruction_player1
        reg_mode_shr1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr endSHR_instruction_player1

	endSHR_instruction_player1:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
RET
SHRPLAYER1PR  ENDP

SHLPLAYER1PR PROC NEAR

            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest  
cmp power_up_player1,1
            jz SHL_power_up1_player1
            cmp power_up_player1,2
            jz SHL_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_SHL_player1 
            SHL_power_up1_player1: 
                cmp intial_points_player1,5
                JB nopoints_SHL_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_SHL_powerup1_p1 
                nopoints_SHL_powerup1_p1:
                jmp far ptr endSHL_instruction_player1
                can_perform_SHL_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1
                    sub intial_points_player1,5
                    jmp perform_SHL_player1 
            SHL_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_SHL_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_SHL_powerup2_p1 
                nopoints_SHL_powerup2_p1:
                jmp far ptr endSHL_instruction_player1
                can_perform_SHL_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1   
                    sub intial_points_player1,3
                    jmp perform_SHL_player1
            perform_SHL_player1:
                    mov instruction_index,10
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_shl1
                    jmp reg_mode_shl1        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_shl1:  
                    call  shl_shr_ror_rol_address_player1
                    jmp far ptr endSHL_instruction_player1
                reg_mode_shl1:
                    call  shl_shr_ror_rol_register_player1 
              jmp far ptr endSHL_instruction_player1


	endSHL_instruction_player1:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
RET
SHLPLAYER1PR  ENDP

RORPLAYER1PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest 
cmp power_up_player1,1
            jz ror_power_up1_player1
            cmp power_up_player1,2
            jz ror_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_ror_player1 
            ror_power_up1_player1:
                cmp intial_points_player1,5
                JB nopoints_ror_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Ror_powerup1_p1 
                nopoints_ror_powerup1_p1:
                jmp far ptr endROR_instruction_player1
                can_perform_Ror_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1
                    sub intial_points_player1,5
                    jmp perform_ror_player1 
            ror_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_ror_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Ror_powerup2_p1 
                nopoints_ror_powerup2_p1:
                jmp far ptr endROR_instruction_player1
                can_perform_Ror_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_ror_player1
            perform_ror_player1:
            
            mov instruction_index,11
            mov al,address_mode
            cmp al,1
            jz address_mode_ror1
            jmp reg_mode_ror1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_ror1:  
            call  shl_shr_ror_rol_address_player1 
            jmp far ptr endROR_instruction_player1
        reg_mode_ror1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr endROR_instruction_player1


	endROR_instruction_player1:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
RET
RORPLAYER1PR  ENDP

ROLPLAYER1PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest 
cmp power_up_player1,1
            jz rol_power_up1_player1
            cmp power_up_player1,2
            jz rol_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_rol_player1 
            rol_power_up1_player1:
               cmp intial_points_player1,5
                JB nopoints_rol_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Rol_powerup1_p1 
                nopoints_rol_powerup1_p1:
                jmp far ptr endROL_instruction_player1
                can_perform_Rol_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1  
                    sub intial_points_player1,5
                    jmp perform_rol_player1 
            rol_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_rol_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Rol_powerup2_p1 
                nopoints_rol_powerup2_p1:
                jmp far ptr endROL_instruction_player1
                can_perform_Rol_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_rol_player1
            perform_rol_player1:
            
            mov instruction_index,12
            mov al,address_mode
            cmp al,1
            jz address_mode_rol1
            jmp reg_mode_rol1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_rol1:  
            call  shl_shr_ror_rol_address_player1
            jmp far ptr endROL_instruction_player1
        reg_mode_rol1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr endROL_instruction_player1


	endROL_instruction_player1:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player1,0
RET
ROLPLAYER1PR  ENDP



;--------------------------- INSTRUCTIONS -----------------------------------

        mov_reg_des_player1 proc near
            
            cmp count_bit_1,2
            jz dest_lose_point_player1_mov
            jmp here_dest_player1
            dest_lose_point_player1_mov:
            jmp far ptr  lose_point_dest_player11_mov
            here_dest_player1:
            mov bl,dest_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if dest_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 17                      ; index to address value -> choose which value ?!
            jz check_forbidden_digit_mov_add2 
            jnz check_forbidden_regsiter_mov_add2 
            check_forbidden_digit_mov_add2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1]
                
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_1 ;<----------- working should be uncomment when we solve jump problem
                ;check_forbidden Forbidden_digits_2,0    <----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz  lose_point_1_player1_dest
                jmp cont_address_dest_mode_mov2 
                lose_point_1_player1_dest:
                jmp far ptr lose_point_dest_player11_mov
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp final_address_mode_mov_dest 
          check_forbidden_regsiter_mov_add2:
                check_forbidden Forbidden_Registers_1,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_player1_dest 
                jmp cont_address_dest_mode_mov2 
                lose_point_2_player1_dest:
                jmp far ptr lose_point_dest_player11_mov                 
         cont_address_dest_mode_mov2:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,dest_index_val
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_dest_player1_mov  ; out of index of data segment -> should be error 
            jmp final_address_mode_mov_dest 
            lose_point_dest_player1_mov:
            jmp far ptr lose_point_dest_player11_mov 
            ;----------------------------------- 
            ; now its valid instruction ----------------------------------
       final_address_mode_mov_dest:
            mov bh,0
            mov bl,dest_index_val 
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1]
            mov si,ax
            mov bl,src_index_val
            ;mov cx,Player2_Data_Register[bx]  
            ; check if its two byte or not
                    cmp player_turn1,1
                    jz player1_mov_byte_dest_turn
                    jmp far ptr player1_mov_byte_dest_no_turn
                    player1_mov_byte_dest_turn:
                        cmp instruction_index,0
                        jz mov_address_byte_player1_dest
                        cmp instruction_index,1
                        jz add_address_byte_player1_dest
                        cmp instruction_index,2
                        jz sub_address_byte_player1_dest
                        mov_address_byte_player1_dest: 
                            mov cl,data_segment_2[si] 
                            mov Player2_Data_Register[bx],cl                 ; mov ------------------------
                            ;mov Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_byte_dest_no_turn
                        add_address_byte_player1_dest:                  ; add ------------------------
                            mov cl,data_segment_2[si] 
                            add Player2_Data_Register[bx],cl 
                            ;add Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_byte_dest_no_turn
                        sub_address_byte_player1_dest:                  ; sub ------------------------
                            mov cl,data_segment_2[si] 
                            sub Player2_Data_Register[bx],cl 
                            ;sub Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_byte_dest_no_turn
                   player1_mov_byte_dest_no_turn:
                    cmp player_turn2,1
                    jz player2_mov_byte_dest_turn
                    jmp far ptr end_dest_mov_player1 
                    player2_mov_byte_dest_turn:
                        mov bl,dest_index_val 
                        mov ah,Player1_Data_Register[bx]
                        mov al,Player1_Data_Register[bx+1]
                        cmp ax,000fh
                            JA lose_point_dest2_player1_mov  ; out of index of data segment -> should be error 
                            jmp cont_final_address_mode_mov_dest 
                            lose_point_dest2_player1_mov:
                            jmp far ptr lose_point_dest_player11_mov
                        cont_final_address_mode_mov_dest:
                        mov si,ax
                        mov bl,src_index_val
                        cmp instruction_index,0
                        jz mov_address_byte_player2_dest
                        cmp instruction_index,1
                        jz add_address_byte_player2_dest
                        cmp instruction_index,2
                        jz sub_address_byte_player2_dest
                        mov_address_byte_player2_dest: 
                            mov cl,data_segment_1[si] 
                            mov Player1_Data_Register[bx],cl                 ; mov ------------------------
                            ;mov Player2_Data_Register[bx],ah
                            jmp far ptr end_dest_mov_player1
                        add_address_byte_player2_dest:                  ; add ------------------------
                            mov cl,data_segment_1[si] 
                            add Player1_Data_Register[bx],cl 
                            ;add Player2_Data_Register[bx],ah
                            jmp far ptr end_dest_mov_player1
                        sub_address_byte_player2_dest:                  ; sub ------------------------
                            mov cl,data_segment_1[si] 
                            sub Player1_Data_Register[bx],cl 
                            ;sub Player2_Data_Register[bx],ah
                            jmp far ptr end_dest_mov_player1

    lose_point_dest_player11_mov:
        ;cmp player_turn ,1
        ;jz player1_lose_mov_dest_reg 
        ;dec intial_points_player2
        ;mov losepoint_player2,0 
        ;mov losepoint,0
        ;jmp end_dest_mov_player1
        ;player1_lose_mov_dest_reg:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_dest_mov_player1:
    
    ret
    mov_reg_des_player1 endp
;----------------------------mov to a register ---------------------------------------------------
mov_register_player1 proc near
    
    check_forbidden Forbidden_instruction_1,instruction_index       
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz  LOSREGMOVSRCP1
                jmp STARTMOVADDSRCP1 
                LOSREGMOVSRCP1:
                ;jmp far ptr lose_point_player1
                jmp far ptr end_mov_reg_player1 

            STARTMOVADDSRCP1:
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_1,bl

            mov al,losepoint 
            mov losepoint_player1,al 
            cmp losepoint_player1,1
            jz   lose_point_2_reg_player1 
            jmp cont_reg_mode_mov 
            lose_point_2_reg_player1:
            jmp far ptr lose_point_reg_mov_player1                 
         cont_reg_mode_mov:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            
            ; check other operand------------------ 

            ; call lotfy code to get second operand 
            mov ah,count_bit_2
            mov al,count_bit_1
            cmp ah,al ;---------------------------------------------------
            jnz lose_point_reg_mov_player1_temp 
            jmp to_this_mov_player1
            lose_point_reg_mov_player1_temp:
            jmp far ptr lose_point_reg_mov_player1
            to_this_mov_player1:
            cmp address_mode2,1 
            
            jz address_mode_mov_des_player1
            jmp  address_mode_mov_des_no_player1
            address_mode_mov_des_player1:
                call mov_reg_des_player1
            jmp far ptr end_mov_reg_player1
            
            address_mode_mov_des_no_player1:
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_reg_mov2 
            jnz check_forbidden_regsiter_reg_mov2
            check_forbidden_digit_reg_mov2:
                ; macro needed to check if value has a forbidden digit or not
                
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1] 
                ; call macro that check if value in ax is correct
                ; check if value is 2 bytes or 1 byte so that can call its function
                check_byte_valid al, Forbidden_digits_1 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1 
                
                jz  forbidden_digit_mov_player1 
                jmp final_reg_mode_mov
                forbidden_digit_mov_player1:
                    jmp far ptr end_mov_reg_player1 
            check_forbidden_regsiter_reg_mov2:        
            
                check_forbidden Forbidden_Registers_1,bl
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  forbidden_reg_mov_player1
                jmp final_reg_mode_mov
                forbidden_reg_mov_player1:
                    jmp far ptr end_mov_reg_player1   
              
                                

            ; now its valid instruction ----------------------------------
            final_reg_mode_mov:
            
                ;mov cx,Player2_Data_Register[bx]  
                ; check if its two byte or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1]
                mov bl,src_index_val  
                mov dl,count_bit_2
                mov dh,0
                cmp dl,2
                jz word_mov_reg_Temp_player1
                jmp byte_mov_reg_temp_player1
                word_mov_reg_Temp_player1:
                jmp far ptr word_mov_reg_player1
                byte_mov_reg_temp_player1: 
                    cmp player_turn1,1
                    jz player1_mov_byte_turn
                    jmp player1_mov_byte_no_turn 
                    player1_mov_byte_turn:
                        mov bl,src_index_val 
                        cmp instruction_index,0
                        jz mov_reg_byte_player1
                        cmp instruction_index,1
                        jz add_reg_byte_player1
                        cmp instruction_index,2
                        jz sub_reg_byte_player1
                        mov_reg_byte_player1:                  ; mov ------------------------
                            mov Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_byte_no_turn
                        add_reg_byte_player1:                  ; add ------------------------
                            add Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_byte_no_turn
                        sub_reg_byte_player1:                  ; sub ------------------------
                            sub Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_byte_no_turn
                    player1_mov_byte_no_turn:
                        cmp player_turn2,1
                        jz player2_mov_byte_turn
                        jmp far ptr end_mov_reg_player1
                        player2_mov_byte_turn:
                            mov bl,dest_index_val 
                            mov ah,Player1_Data_Register[bx]
                            mov al,Player1_Data_Register[bx+1]
                            mov bl,src_index_val  
                            cmp instruction_index,0
                            jz mov_reg_byte_player2
                            cmp instruction_index,1
                            jz add_reg_byte_player2
                            cmp instruction_index,2
                            jz sub_reg_byte_player2
                            mov_reg_byte_player2:                  ; mov ------------------------
                                mov Player1_Data_Register[bx],ah
                                jmp far ptr end_mov_reg_player1
                            add_reg_byte_player2:                  ; add ------------------------
                                add Player1_Data_Register[bx],ah
                                jmp far ptr end_mov_reg_player1
                            sub_reg_byte_player2:                  ; sub ------------------------
                                sub Player1_Data_Register[bx],ah
                                jmp far ptr end_mov_reg_player1
                                                        
                word_mov_reg_player1:
                    cmp player_turn1,1
                    jz player1_mov_word_turn
                    jmp player1_mov_word_no_turn 
                    player1_mov_word_turn:
                    
                        cmp instruction_index,0
                        jz mov_reg_word_player1
                        cmp instruction_index,1
                        jz add_reg_word_player1
                        cmp instruction_index,2
                        jz sub_reg_word_player1
                        mov_reg_word_player1:                  ; mov ------------------------
                            mov Player2_Data_Register[bx+1],al
                            mov Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_word_no_turn
                        add_reg_word_player1:                  ; add ------------------------
                            add Player2_Data_Register[bx+1],al
                            adc Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_word_no_turn
                        sub_reg_word_player1:                  ; sub ------------------------
                            sub Player2_Data_Register[bx+1],al
                            sbb Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_word_no_turn             
                                                            ; lose point because of invalid instruction
    
                    player1_mov_word_no_turn:
                        cmp player_turn2,1
                        jz player2_mov_word_turn
                        jmp far ptr end_mov_reg_player1
                        player2_mov_word_turn:
                        mov bl,dest_index_val 
                        mov ah,Player1_Data_Register[bx]
                        mov al,Player1_Data_Register[bx+1]
                        mov bl,src_index_val
                        cmp instruction_index,0
                        jz mov_reg_word_player2
                        cmp instruction_index,1
                        jz add_reg_word_player2
                        cmp instruction_index,2
                        jz sub_reg_word_player2
                        mov_reg_word_player2:                  ; mov ------------------------
                            mov Player1_Data_Register[bx+1],al
                            mov Player1_Data_Register[bx],ah
                            jmp far ptr end_mov_reg_player1
                        add_reg_word_player2:                  ; add ------------------------
                            add Player1_Data_Register[bx+1],al
                            adc Player1_Data_Register[bx],ah
                            jmp far ptr end_mov_reg_player1
                        sub_reg_word_player2:                  ; sub ------------------------
                            sub Player1_Data_Register[bx+1],al
                            sbb Player1_Data_Register[bx],ah
                            jmp far ptr end_mov_reg_player1 
    
    
    lose_point_reg_mov_player1:
        ;cmp player_turn ,1
        ;jz player1_lose_mov_reg 
        ;dec intial_points_player2
        ;mov losepoint_player2,0 
        ;mov losepoint,0
        ;jmp end_mov_reg_player1
        ;player1_lose_mov_reg:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_mov_reg_player1:
     
    ret 
    mov_register_player1 endp
;---------------------------------------------------  mov to datasegment  -----------------------------------------------------------------
mov_address_player1  proc near
    
        check_forbidden Forbidden_instruction_1,instruction_index   
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz  LOSMOVREGSRCP1
                jmp STARTMOVREGSRCP1 
                LOSMOVREGSRCP1:
                ;jmp far ptr lose_point_player1
                jmp far ptr end_mov_address_player1 

            STARTMOVREGSRCP1:
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 18                      ; index to address value -> choose which value ?!
            jz check_forbidden_digit_mov 
            jnz check_forbidden_regsiter_mov 
            check_forbidden_digit_mov:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1]
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_1 ;<----------- working should be uncomment when we solve jump problem
                mov Player1_Data_Register[bx+1],al
                mov Player1_Data_Register[bx],ah 
                ;check_forbidden Forbidden_digits_2,0   ;<----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz  lose_point_1_player1
                jmp cont_address_mode_mov 
                lose_point_1_player1:
                ;jmp far ptr lose_point_player1
                jmp far ptr end_mov_address_player1
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp cont_address_mode_mov 
            check_forbidden_regsiter_mov:
                check_forbidden Forbidden_Registers_1,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_player1 
                jmp cont_address_mode_mov 
                lose_point_2_player1:
                jmp far ptr lose_point_player1                 
         cont_address_mode_mov:
            ;check if value in ax is less than f for two turns player1_turn & player2_turn
            mov bh,0
            mov bl,src_index_val
            cmp player_turn1,1              ;-> player1 turn 
            jz player1_check_address_mov
            jmp cont_check_address_mode_mov2
            player1_check_address_mov:
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_3_player1  ; out of index of data segment -> should be error 
            jmp cont_check_address_mode_mov2 
            lose_point_3_player1:
            jmp far ptr lose_point_player1
        cont_check_address_mode_mov2:
            cmp player_turn2,1              ;-> player1 turn 
            jz player2_check_address_mov
            jmp cont_address_mode_mov2
            player2_check_address_mov:
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            cmp ax,000fh  
            JA lose_point_4_player1  ; out of index of data segment -> should be error 
            jmp cont_address_mode_mov2 
            lose_point_4_player1:
            jmp far ptr lose_point_player1
            ; check other operand------------------ 
            cont_address_mode_mov2:
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_mov2 
            jnz check_forbidden_regsiter_mov2
            check_forbidden_digit_mov2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1] 
                ; call macro that check if value in ax is correct
                check_word_valid ax, Forbidden_digits_1 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
  
                jz  forbidden_address_mov_player1
                jmp final_address_mode_mov
                forbidden_address_mov_player1:
                    jmp far ptr end_mov_address_player1  
            
            check_forbidden_regsiter_mov2:        
            
                check_forbidden Forbidden_Registers_1,bl
                 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                ;jz  lose_point_player1   
                jz temp_end_mov_address_player1   ; -> jump far here
                jmp  final_address_mode_mov
                temp_end_mov_address_player1:
                jmp far ptr end_mov_address_player1
                ;mov bh,0
                ;mov bl,dest_index_val
                ;mov ah,Player2_Data_Register[bx]
                ;mov al,Player2_Data_Register[bx+1]

            ; now its valid instruction ----------------------------------
            final_address_mode_mov:
            mov bh,0
            mov bl,src_index_val 
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1]
            mov si,ax
            mov bl,dest_index_val
            ;mov cx,Player2_Data_Register[bx]  
            ; check if its two byte or not 
            mov dl,count_bit_2
            mov dh,0
            cmp dl,2
            jz lose_point_plyer1       ;-> should jmp far
            jmp not_lose_point_plyer1
            lose_point_plyer1:
            jmp far ptr lose_point_player1
            ; paste here  
            not_lose_point_plyer1:
                    cmp player_turn1,1              ;-> player1 turn 
                    jz player1_mov_address_byte_turn
                    jmp player1_mov_address_byte_no_turn 
                    player1_mov_address_byte_turn:      
                        cmp instruction_index,0
                        jz mov_address_byte_player1
                        cmp instruction_index,1
                        jz add_address_byte_player1
                        cmp instruction_index,2
                        jz sub_address_byte_player1
                        mov_address_byte_player1:                  ; mov ------------------------
                            mov cl,Player2_Data_Register[bx]
                            mov data_segment_2[si],cl
                            ;mov Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_address_byte_no_turn
                        add_address_byte_player1:                  ; add ------------------------
                            mov cl,Player2_Data_Register[bx]
                            add data_segment_2[si],cl
                            ;add Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_address_byte_no_turn
                        sub_address_byte_player1:                  ; sub ------------------------
                            mov cl,Player2_Data_Register[bx]
                            sub data_segment_2[si],cl
                            ;sub Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_address_byte_no_turn
                            
                     player1_mov_address_byte_no_turn:
                        cmp player_turn2,1
                        jz player2_mov_address_byte_turn
                        jmp far ptr end_mov_address_player1
                        player2_mov_address_byte_turn:
                            mov bl,src_index_val 
                            mov ah,Player1_Data_Register[bx]
                            mov al,Player1_Data_Register[bx+1]
                            mov si,ax
                            mov bl,dest_index_val
                            cmp instruction_index,0
                            jz mov_address_byte_player2
                            cmp instruction_index,1
                            jz add_address_byte_player2
                            cmp instruction_index,2
                            jz sub_address_byte_player2
                            mov_address_byte_player2:                  ; mov ------------------------
                                mov cl,Player1_Data_Register[bx]
                                mov data_segment_1[si],cl
                                jmp far ptr end_mov_address_player1
                            add_address_byte_player2:                  ; add ------------------------
                                mov cl,Player1_Data_Register[bx]
                                add data_segment_1[si],cl
                                jmp far ptr end_mov_address_player1
                            sub_address_byte_player2:                  ; sub ------------------------
                                mov cl,Player1_Data_Register[bx]
                                sub data_segment_1[si],cl
                                jmp far ptr end_mov_address_player1                                    
              
    lose_point_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_mov_address_player1:
    
    ret
    mov_address_player1 endp 

;----------------------------div mul inc dec imul idiv reg ---------------------------------------------------
div_mul_inc_dec_register_player1 proc near
    
    check_forbidden Forbidden_instruction_1,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_1,bl

            mov al,losepoint 
            mov losepoint_player1,al 
            cmp losepoint_player1,1
            jz   lose_point_2_reg_div_player1 
            jmp cont_reg_mode_div 
            lose_point_2_reg_div_player1:
            jmp far ptr end_div_reg_player1                 
         cont_reg_mode_div:
            mov dl,count_bit_1
            mov dh,0
            cmp dl,2
            jz temp_word_div_reg_player1
            jmp temp_byte_div_reg_player1
            temp_word_div_reg_player1:
            jmp far ptr word_div_reg_player1
            temp_byte_div_reg_player1:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,0
                    mov cl,Player2_Data_Register[bx]            
                    mov ah,Player2_Data_Register[0]
                    mov al,Player2_Data_Register[1]
                    mov dx,0 
                    ; add player turn here : 
                    cmp player_turn1,1
                    jz player1_div_byte_turn
                    jmp player1_div_byte_no_turn 
                    player1_div_byte_turn:    
                        cmp instruction_index,4
                        jz div_reg_byte_player1
                        cmp instruction_index,3
                        jz mul_reg_byte_player1
                        cmp instruction_index,14
                        jz idiv_reg_byte_player1 
                        cmp instruction_index,15
                        jz imul_reg_byte_player1
                        cmp instruction_index,5
                        jz inc_reg_byte_player1
                        cmp instruction_index,6
                        jz dec_reg_byte_player1
                        div_reg_byte_player1:                  ; div ------------------------
                            cmp cx,0
                            jz div_zero_byte_reg_p1
                            jmp not_div_zero_byte_reg_p1
                            div_zero_byte_reg_p1:
                            jmp far ptr lose_point_div_player1
                            not_div_zero_byte_reg_p1:
                            div cx
                            mov Player2_Data_Register[0],dl
                            mov Player2_Data_Register[1],al
                            jmp far ptr player1_div_byte_no_turn
                        mul_reg_byte_player1:                  ; mul ------------------------
                            mul cl
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al 
                            jmp far ptr player1_div_byte_no_turn
                        idiv_reg_byte_player1:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv_zero_byte_reg_p1
                            jmp not_idiv_zero_byte_reg_p1
                            idiv_zero_byte_reg_p1:
                            jmp far ptr lose_point_div_player1
                            not_idiv_zero_byte_reg_p1:
                            idiv cx
                            mov Player2_Data_Register[0],dl
                            mov Player2_Data_Register[1],al
                            jmp far ptr player1_div_byte_no_turn 
                        imul_reg_byte_player1:                  ; imul ------------------------
                            imul cl
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            jmp far ptr player1_div_byte_no_turn
                        inc_reg_byte_player1:                  ; inc ------------------------
                            inc cl
                            mov Player2_Data_Register[bx],cl
                            jmp far ptr player1_div_byte_no_turn
                        dec_reg_byte_player1:                  ; dec ------------------------
                            dec cx
                            mov Player2_Data_Register[bx],cl
                            jmp far ptr player1_div_byte_no_turn
                    
                    player1_div_byte_no_turn:        
                    cmp player_turn2,1
                    jz player2_div_byte_turn
                    jmp far ptr end_div_reg_player1 
                    player2_div_byte_turn:
                        mov cl,Player1_Data_Register[bx]            
                        mov ah,Player1_Data_Register[0]
                        mov al,Player1_Data_Register[1]    
                        cmp instruction_index,4
                        jz div_reg_byte_player2
                        cmp instruction_index,3
                        jz mul_reg_byte_player2
                        cmp instruction_index,14
                        jz idiv_reg_byte_player1 
                        cmp instruction_index,15
                        jz imul_reg_byte_player2
                        cmp instruction_index,5
                        jz inc_reg_byte_player2
                        cmp instruction_index,6
                        jz dec_reg_byte_player2
                        div_reg_byte_player2:                  ; div ------------------------
                            cmp cx,0
                            jz div_zero_byte_reg_p2
                            jmp not_div_zero_byte_reg_p2
                            div_zero_byte_reg_p2:
                            jmp far ptr lose_point_div_player1
                            not_div_zero_byte_reg_p2:
                            div cx
                            mov Player1_Data_Register[0],dl
                            mov Player1_Data_Register[1],al
                            jmp far ptr end_div_reg_player1
                        mul_reg_byte_player2:                  ; mul ------------------------
                            mul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al 
                            jmp far ptr end_div_reg_player1
                        idiv_reg_byte_player2:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv_zero_byte_reg_p2
                            jmp not_idiv_zero_byte_reg_p2
                            idiv_zero_byte_reg_p2:
                            jmp far ptr lose_point_div_player1
                            not_idiv_zero_byte_reg_p2:
                            idiv cx
                            mov Player1_Data_Register[0],dl
                            mov Player1_Data_Register[1],al
                            jmp far ptr end_div_reg_player1 
                        imul_reg_byte_player2:                  ; imul ------------------------
                            imul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            jmp far ptr end_div_reg_player1
                        inc_reg_byte_player2:                  ; inc ------------------------
                            inc cl
                            mov Player1_Data_Register[bx],cl
                            jmp far ptr end_div_reg_player1
                        dec_reg_byte_player2:                  ; dec ------------------------
                            dec cx
                            mov Player1_Data_Register[bx],cl
                            jmp far ptr end_div_reg_player1     
            word_div_reg_player1:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,Player2_Data_Register[bx]
                    mov cl,Player2_Data_Register[bx+1]             
                    mov ah,Player2_Data_Register[0]
                    mov al,Player2_Data_Register[1]
                    mov dh,Player2_Data_Register[6]
                    mov dl,Player2_Data_Register[7] 
                    ; add player turn here
                     
                    cmp player_turn1,1
                    jz player1_div_word_turn
                    jmp player1_div_word_no_turn 
                    player1_div_word_turn: 
                        cmp instruction_index,4
                        jz div_reg_word_player1
                        cmp instruction_index,3
                        jz mul_reg_word_player1
                        cmp instruction_index,14
                        jz idiv_reg_word_player1 
                        cmp instruction_index,15
                        jz imul_reg_word_player1
                        cmp instruction_index,5
                        jz inc_reg_word_player1
                        cmp instruction_index,6
                        jz dec_reg_word_player1
                        div_reg_word_player1:                  ; div ------------------------
                            cmp cx,0
                            jz div_zero_word_reg_p1
                            div cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr player1_div_word_no_turn
                            div_zero_word_reg_p1:
                            jmp far ptr lose_point_div_player1
                            not_div_zero_word_reg_p1:

                        mul_reg_word_player1:                  ; mul ------------------------
                            mul cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr player1_div_word_no_turn 
                        idiv_reg_word_player1:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv_zero_word_reg_p1
                            jmp not_idiv_zero_word_reg_p1
                            idiv_zero_word_reg_p1:
                            jmp far ptr lose_point_div_player1
                            not_idiv_zero_word_reg_p1:
                            idiv cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al 
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr player1_div_word_no_turn 
                        imul_reg_word_player1:                  ; imul ------------------------
                            imul cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr player1_div_word_no_turn
                        inc_reg_word_player1:                  ; inc ------------------------
                            inc cx
                            mov Player2_Data_Register[bx],ch
                            mov Player2_Data_Register[bx+1],cl
                            jmp far ptr player1_div_word_no_turn
                        dec_reg_word_player1:                  ; dec ------------------------
                            dec cx
                            mov Player2_Data_Register[bx],ch
                            mov Player2_Data_Register[bx+1],cl
                            jmp far ptr player1_div_word_no_turn 
                    
                    ; add player turn here 
                    player1_div_word_no_turn:
                    cmp player_turn2,1
                    jz player2_div_word_turn
                    jmp far ptr end_div_reg_player1
                    player2_div_word_turn:
                        
                        mov ch,Player1_Data_Register[bx]
                        mov cl,Player1_Data_Register[bx+1]             
                        mov ah,Player1_Data_Register[0]
                        mov al,Player1_Data_Register[1]
                        mov dh,Player1_Data_Register[6]
                        mov dl,Player1_Data_Register[7] 
                        cmp instruction_index,4
                        jz div_reg_word_player2
                        cmp instruction_index,3
                        jz mul_reg_word_player2
                        cmp instruction_index,14
                        jz idiv_reg_word_player2 
                        cmp instruction_index,15
                        jz imul_reg_word_player2
                        cmp instruction_index,5
                        jz inc_reg_word_player2
                        cmp instruction_index,6
                        jz dec_reg_word_player2
                        div_reg_word_player2:                  ; div ------------------------
                            cmp cx,0
                            jz div_zero_word_reg_p2
                            div cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr end_div_reg_player1
                            div_zero_word_reg_p2:
                            jmp far ptr lose_point_div_player1

                        mul_reg_word_player2:                  ; mul ------------------------
                            mul cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr end_div_reg_player1 
                        idiv_reg_word_player2:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv_zero_word_reg_p2
                            jmp not_idiv_zero_word_reg_p2
                            idiv_zero_word_reg_p2:
                            jmp far ptr lose_point_div_player1
                            not_idiv_zero_word_reg_p2:
                            idiv cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al 
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr end_div_reg_player1 
                        imul_reg_word_player2:                  ; imul ------------------------
                            imul cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr end_div_reg_player1
                        inc_reg_word_player2:                  ; inc ------------------------
                            inc cx
                            mov Player1_Data_Register[bx],ch
                            mov Player1_Data_Register[bx+1],cl
                            jmp far ptr end_div_reg_player1
                        dec_reg_word_player2:                  ; dec ------------------------
                            dec cx
                            mov Player1_Data_Register[bx],ch
                            mov Player1_Data_Register[bx+1],cl
                            jmp far ptr end_div_reg_player1 
                    
    
   lose_point_div_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0                
    end_div_reg_player1:
     
    ret 
    div_mul_inc_dec_register_player1 endp
;---------------------------------------------------  mov to datasegment  -----------------------------------------------------------------
div_mul_inc_dec_address_player1  proc near
    
        check_forbidden Forbidden_instruction_1,instruction_index                   
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 18                      ; index to address value -> choose which value ?!
            jz forbidden_digit_address_div 
            jnz forbidden_regsiter_address_div 
            forbidden_digit_address_div:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1]
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_1 
                ;check_forbidden Forbidden_digits_2,0    <----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz  lose_point_1_div_address_player1
                jmp cont_address_mode_div 
                lose_point_1_div_address_player1:
                ;jmp far ptr lose_point_player1
                jmp far ptr end_div_address_player1
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp cont_address_mode_div 
           forbidden_regsiter_address_div:
                check_forbidden Forbidden_Registers_1,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_div_address_player1 
                jmp cont_address_mode_div 
                lose_point_2_div_address_player1:
                jmp far ptr lose_point_div_address_player1                 
         cont_address_mode_div:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val 
            cmp player_turn1,1              ;-> player1 turn 
            jz player1_check_address_div
            jmp cont_check_address_mode_div2
            player1_check_address_div:
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_3_div_address_player1  ; out of index of data segment -> should be error 
            jmp cont_check_address_mode_div2 
            lose_point_3_div_address_player1:
            jmp far ptr lose_point_div_address_player1
            cont_check_address_mode_div2:
            cmp player_turn2,1              ;-> player1 turn 
            jz player2_check_address_div
            jmp final_address_mode_div
            player2_check_address_div:
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            cmp ax,000fh  
            JA lose_point_4_div_address_player1  ; out of index of data segment -> should be error 
            jmp final_address_mode_div 
            lose_point_4_div_address_player1:
            jmp far ptr lose_point_div_address_player1
            final_address_mode_div:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,Player2_Data_Register[bx]
                    mov cl,Player2_Data_Register[bx+1]
                    mov si,cx
                    mov cl,data_segment_2[si]
                    mov ch,0            
                    mov ah,Player2_Data_Register[0]
                    mov al,Player2_Data_Register[1]
                    
                    ; paste here
                    cmp player_turn1,1              ;-> player1 turn 
                    jz player1_div_address_byte_turn
                    jmp player1_div_address_byte_no_turn 
                    player1_div_address_byte_turn:
                        cmp instruction_index,4
                        jz div_address_byte_player1
                        cmp instruction_index,3
                        jz mul_address_byte_player1
                        cmp instruction_index,14
                        jz idiv_address_byte_player1 
                        cmp instruction_index,15
                        jz imul_address_byte_player1
                        cmp instruction_index,5
                        jz inc_address_byte_player1
                        cmp instruction_index,6
                        jz dec_address_byte_player1
                        div_address_byte_player1:                  ; div ------------------------
                            cmp cx,0
                            jz div_zero_address_reg_p1
                            jmp not_div_zero_address_reg_p1
                            div_zero_address_reg_p1:
                            jmp far ptr lose_point_div_player1
                            not_div_zero_address_reg_p1:
                            div cx
                            mov Player2_Data_Register[0],dh
                            mov Player2_Data_Register[1],al
                            jmp far ptr player1_div_address_byte_no_turn
                        mul_address_byte_player1:                  ; mul ------------------------
                            mul cl
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al 
                            jmp far ptr player1_div_address_byte_no_turn
                        idiv_address_byte_player1:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv_zero_address_reg_p1
                            jmp not_idiv_zero_address_reg_p1
                            idiv_zero_address_reg_p1:
                            jmp far ptr lose_point_div_player1
                            not_idiv_zero_address_reg_p1:
                            idiv cx
                            mov Player2_Data_Register[0],dh
                            mov Player2_Data_Register[1],al
                            jmp far ptr player1_div_address_byte_no_turn 
                        imul_address_byte_player1:                  ; imul ------------------------
                            imul cl
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            jmp far ptr player1_div_address_byte_no_turn
                        inc_address_byte_player1:                  ; inc ------------------------
                            inc cl
                            mov data_segment_2[si],cl
                            jmp far ptr player1_div_address_byte_no_turn
                        dec_address_byte_player1:                  ; dec ------------------------
                            dec cx
                            mov data_segment_2[si],cl
                            jmp far ptr player1_div_address_byte_no_turn 

                                        
                    player1_div_address_byte_no_turn:
                        cmp player_turn2,1
                        jz player2_div_address_byte_turn
                        jmp far ptr end_div_address_player1
                        player2_div_address_byte_turn:
                            mov ch,Player1_Data_Register[bx]
                            mov cl,Player1_Data_Register[bx+1]
                            mov si,cx
                            mov cl,data_segment_1[si]
                            mov ch,0            
                            mov ah,Player1_Data_Register[0]
                            mov al,Player1_Data_Register[1]
                            cmp instruction_index,4
                            jz div_address_byte_player2
                            cmp instruction_index,3
                            jz mul_address_byte_player2
                            cmp instruction_index,14
                            jz idiv_address_byte_player2 
                            cmp instruction_index,15
                            jz imul_address_byte_player2
                            cmp instruction_index,5
                            jz inc_address_byte_player2
                            cmp instruction_index,6
                            jz dec_address_byte_player2
                            div_address_byte_player2:                  ; div ------------------------
                                cmp cx,0
                                jz div_zero_address_reg_p2
                                jmp not_div_zero_address_reg_p2
                                div_zero_address_reg_p2:
                                jmp far ptr lose_point_div_player1
                                not_div_zero_address_reg_p2:
                                div cx
                                mov Player1_Data_Register[0],dh
                                mov Player1_Data_Register[1],al
                                jmp far ptr end_div_address_player1
                            mul_address_byte_player2:                  ; mul ------------------------
                                mul cl
                                mov Player1_Data_Register[0],ah
                                mov Player1_Data_Register[1],al 
                                jmp far ptr end_div_address_player1
                            idiv_address_byte_player2:                  ; idiv ------------------------
                                cmp cx,0
                                jz idiv_zero_address_reg_p2
                                jmp not_idiv_zero_address_reg_p2
                                idiv_zero_address_reg_p2:
                                jmp far ptr lose_point_div_player1
                                not_idiv_zero_address_reg_p2:
                                idiv cx
                                mov Player1_Data_Register[0],dh
                                mov Player1_Data_Register[1],al
                                jmp far ptr end_div_address_player1 
                            imul_address_byte_player2:                  ; imul ------------------------
                                imul cl
                                mov Player1_Data_Register[0],ah
                                mov Player1_Data_Register[1],al
                                jmp far ptr end_div_address_player1
                            inc_address_byte_player2:                  ; inc ------------------------
                                inc cl
                                mov data_segment_1[si],cl
                                jmp far ptr end_div_address_player1
                            dec_address_byte_player2:                  ; dec ------------------------
                                dec cx
                                mov data_segment_1[si],cl
                                jmp far ptr end_div_address_player1 
                    
              
    lose_point_div_address_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_div_address_player1:
    
    ret
    div_mul_inc_dec_address_player1 endp
    
;----------------------------shl  reg ---------------------------------------------------
shl_shr_ror_rol_register_player1 proc near
    
    check_forbidden Forbidden_instruction_1,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_1,bl

            mov al,losepoint 
            mov losepoint_player1,al 
            cmp losepoint_player1,1
            jz   lose_point_2_reg_shl_player1 
            jmp cont_reg_mode_shl 
            lose_point_2_reg_shl_player1:
            jmp far ptr end_shl_reg_player1                 
         cont_reg_mode_shl:
         
           ; check if value or cl is valid 
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_reg_shl2 
            jnz check_forbidden_regsiter_reg_shl2
            check_forbidden_digit_reg_shl2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player2_Data_Register[bx]
                mov Player1_Data_Register[bx],ah
 
                ; call macro that check if value in ax is correct
                check_byte_valid ah, Forbidden_digits_1 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  forbidden_reg_shl_player1
                jmp cont_reg_mode_shl2
                forbidden_reg_shl_player1:
                jmp far ptr end_shl_reg_player1  
            
            check_forbidden_regsiter_reg_shl2:        
                
                cmp bl,7
                jnz lose_point_not_reg_cl_p1
                check_forbidden Forbidden_Registers_1,bl                 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1   
                jz temp_end_shl_reg_player1   ; -> jump far here
                jmp  cont_reg_mode_shl2
                temp_end_shl_reg_player1:
                jmp far ptr end_shl_reg_player1
                lose_point_not_reg_cl_p1:
                jmp far ptr lose_point_shl_address_player1 
         cont_reg_mode_shl2:
            mov dl,count_bit_1
            mov dh,0
            cmp dl,2
            jz temp_word_shl_reg_player1
            jmp temp_byte_shl_reg_player1
            temp_word_shl_reg_player1:
            jmp far ptr word_shl_reg_player1
            temp_byte_shl_reg_player1:
                    mov bh,0
                    mov bl,dest_index_val
                    mov ch,0
                    mov cl,Player2_Data_Register[bx]
                    mov bl, src_index_val
                                 
                    ; paste here
                    cmp player_turn1,1
                    jz player1_shl_byte_turn
                    jmp player1_shl_byte_no_turn 
                    player1_shl_byte_turn:
                        cmp instruction_index,10
                        jz shl_reg_byte_player1
                        cmp instruction_index,9
                        jz shr_reg_byte_player1
                        cmp instruction_index,11
                        jz ror_reg_byte_player1 
                        cmp instruction_index,12
                        jz rol_reg_byte_player1
                        cmp instruction_index,8
                        jz sal_reg_byte_player1
                        cmp instruction_index,13
                        jz sar_reg_byte_player1
                        shl_reg_byte_player1:                  ; div ------------------------
                            shl Player2_Data_Register[bx],cl
                            jmp far ptr player1_shl_byte_no_turn
                        shr_reg_byte_player1:                  ; mul ------------------------
                            shr Player2_Data_Register[bx],cl
                            jmp far ptr player1_shl_byte_no_turn
                        ror_reg_byte_player1:                  ; idiv ------------------------
                            ror Player2_Data_Register[bx],cl
                            jmp far ptr player1_shl_byte_no_turn 
                        rol_reg_byte_player1:                  ; imul ------------------------
                            rol Player2_Data_Register[bx],cl
                            jmp far ptr player1_shl_byte_no_turn
                        sal_reg_byte_player1:                  ; inc ------------------------
                            sal Player2_Data_Register[bx],cl
                            jmp far ptr player1_shl_byte_no_turn
                        sar_reg_byte_player1:                  ; dec ------------------------
                            sar Player2_Data_Register[bx],cl
                            jmp far ptr player1_shl_byte_no_turn
                   ; paste here     
                    player1_shl_byte_no_turn:        
                    cmp player_turn2,1
                    jz player2_shl_byte_turn
                    jmp far ptr end_shl_reg_player1 
                    player2_shl_byte_turn:
                        mov bl,dest_index_val
                        mov ch,0
                        mov cl,Player1_Data_Register[bx]
                        mov bl, src_index_val
                        cmp instruction_index,10
                        jz shl_reg_byte_player2
                        cmp instruction_index,9
                        jz shr_reg_byte_player2
                        cmp instruction_index,11
                        jz ror_reg_byte_player2 
                        cmp instruction_index,12
                        jz rol_reg_byte_player2
                        cmp instruction_index,8
                        jz sal_reg_byte_player2
                        cmp instruction_index,13
                        jz sar_reg_byte_player2
                        shl_reg_byte_player2:                  ; div ------------------------
                            shl Player1_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player1
                        shr_reg_byte_player2:                  ; mul ------------------------
                            shr Player1_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player1
                        ror_reg_byte_player2:                  ; idiv ------------------------
                            ror Player1_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player1 
                        rol_reg_byte_player2:                  ; imul ------------------------
                            rol Player1_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player1
                        sal_reg_byte_player2:                  ; inc ------------------------
                            sal Player1_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player1
                        sar_reg_byte_player2:                  ; dec ------------------------
                            sar Player1_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player1
                         
                         
            word_shl_reg_player1:
                    mov bh,0   
                    mov bl,dest_index_val
                    mov cl,Player2_Data_Register[bx]
                    mov bl,src_index_val
                    mov ah,Player2_Data_Register[bx]
                    mov al,Player2_Data_Register[bx+1]
                                  
                    ; paste here
                    cmp player_turn1,1
                    jz player1_shl_word_turn
                    jmp player1_shl_word_no_turn 
                    player1_shl_word_turn: 
                        cmp instruction_index,10
                        jz shl_reg_word_player1
                        cmp instruction_index,9
                        jz shr_reg_word_player1
                        cmp instruction_index,11
                        jz ror_reg_word_player1 
                        cmp instruction_index,12
                        jz rol_reg_word_player1
                        cmp instruction_index,8
                        jz sal_reg_word_player1
                        cmp instruction_index,13
                        jz sar_reg_word_player1 
                        shl_reg_word_player1:              ; div ------------------------
                            shl ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr player1_shl_word_no_turn
                        shr_reg_word_player1:                  ; mul ------------------------
                            shr ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr player1_shl_word_no_turn 
                        ror_reg_word_player1:                  ; idiv ------------------------
                            ror ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr player1_shl_word_no_turn 
                        rol_reg_word_player1:                  ; imul ------------------------
                            rol ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr player1_shl_word_no_turn
                        sal_reg_word_player1:                  ; inc ------------------------
                            sal ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr player1_shl_word_no_turn
                        sar_reg_word_player1:                  ; dec ------------------------
                            sar ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr player1_shl_word_no_turn
                  
                  ; paste here
                    player1_shl_word_no_turn:
                    cmp player_turn2,1
                    jz player2_shl_word_turn
                    jmp far ptr end_shl_reg_player1
                    player2_shl_word_turn: 
                        mov bl,dest_index_val
                        mov cl,Player1_Data_Register[bx]
                        mov bl,src_index_val
                        mov ah,Player1_Data_Register[bx]
                        mov al,Player1_Data_Register[bx+1]
                        cmp instruction_index,10
                        jz shl_reg_word_player2
                        cmp instruction_index,9
                        jz shr_reg_word_player2
                        cmp instruction_index,11
                        jz ror_reg_word_player2 
                        cmp instruction_index,12
                        jz rol_reg_word_player2
                        cmp instruction_index,8
                        jz sal_reg_word_player2
                        cmp instruction_index,13
                        jz sar_reg_word_player2 
                        shl_reg_word_player2:              ; div ------------------------
                            shl ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player1
                        shr_reg_word_player2:                  ; mul ------------------------
                            shr ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player1 
                        ror_reg_word_player2:                  ; idiv ------------------------
                            ror ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player1 
                        rol_reg_word_player2:                  ; imul ------------------------
                            rol ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player1
                        sal_reg_word_player2:                  ; inc ------------------------
                            sal ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player1
                        sar_reg_word_player2:                  ; dec ------------------------
                            sar ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player1
                  
    lose_point_shl_reg_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
            
    end_shl_reg_player1:
     
    ret 
    shl_shr_ror_rol_register_player1 endp
;---------------------------------------------------  shl to datasegment  -----------------------------------------------------------------
shl_shr_ror_rol_address_player1  proc near
    
        check_forbidden Forbidden_instruction_1,instruction_index                   
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 17                      ; index to address value -> choose which value ?!
            jz forbidden_digit_address_shl 
            jnz forbidden_regsiter_address_shl 
            forbidden_digit_address_shl:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1]
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_1 
                ;check_forbidden Forbidden_digits_2,0    <----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz  lose_point_1_shl_address_player1
                jmp cont_address_mode_shl 
                lose_point_1_shl_address_player1:
                ;jmp far ptr lose_point_player1
                jmp far ptr end_shl_address_player1
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp cont_address_mode_shl 
           forbidden_regsiter_address_shl:
                check_forbidden Forbidden_Registers_1,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_shl_address_player1 
                jmp cont_address_mode_shl 
                lose_point_2_shl_address_player1:
                jmp far ptr lose_point_shl_address_player1                 
         cont_address_mode_shl:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_3_shl_address_player1  ; out of index of data segment -> should be error 
            jmp cont_address_mode_shl2 
            lose_point_3_shl_address_player1:
            jmp far ptr lose_point_shl_address_player1 
            
            cont_address_mode_shl2:
           ; check if value or cl is valid 
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_address_shl2 
            jnz check_forbidden_regsiter_address_shl2
            check_forbidden_digit_address_shl2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player2_Data_Register[bx]
                mov Player1_Data_Register[bx],ah
 
                ; call macro that check if value in ax is correct
                check_byte_valid ah, Forbidden_digits_1 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  forbidden_address_shl_player1
                jmp final_address_mode_shl
                forbidden_address_shl_player1:
                jmp far ptr end_shl_address_player1  
            
            check_forbidden_regsiter_address_shl2:        
                
                cmp bl,7
                jnz lose_point_not_address_cl_p1
                check_forbidden Forbidden_Registers_1,bl                 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                ;jz  lose_point_player1   
                jz temp_end_shl_address_player1   ; -> jump far here
                jmp  final_address_mode_shl
                temp_end_shl_address_player1:
                jmp far ptr end_shl_address_player1
                jmp final_address_mode_shl
                 lose_point_not_address_cl_p1:
                 jmp far ptr lose_point_shl_address_player1
            final_address_mode_shl:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,Player2_Data_Register[bx]
                    mov cl,Player2_Data_Register[bx+1]
                    mov si,cx 
                    mov bl, dest_index_val  
                    mov cl, Player2_Data_Register[bx]
                    mov ch,0            
                    
                    cmp player_turn1,1              ;-> player1 turn 
                    jz player1_shl_address_byte_turn
                    jmp player1_shl_address_byte_no_turn 
                    player1_shl_address_byte_turn:       
                            cmp instruction_index,10
                            jz shl_address_byte_player1
                            cmp instruction_index,9
                            jz shr_address_byte_player1
                            cmp instruction_index,11
                            jz ror_address_byte_player1 
                            cmp instruction_index,12
                            jz rol_address_byte_player1
                            cmp instruction_index,8
                            jz sal_address_byte_player1
                            cmp instruction_index,13
                            jz sar_address_byte_player1
                            shl_address_byte_player1:                  ; div ------------------------
                                shl data_segment_2[si],cl
                                jmp far ptr player1_shl_address_byte_no_turn
                            shr_address_byte_player1:                  ; mul ------------------------
                                shr data_segment_2[si],cl
                                jmp far ptr player1_shl_address_byte_no_turn
                            ror_address_byte_player1:                  ; idiv ------------------------
                                ror data_segment_2[si],cl
                                jmp far ptr player1_shl_address_byte_no_turn 
                            rol_address_byte_player1:                  ; imul ------------------------
                                rol data_segment_2[si],cl
                                jmp far ptr player1_shl_address_byte_no_turn
                            sal_address_byte_player1:                  ; inc ------------------------
                                sal data_segment_2[si],cl
                                jmp far ptr player1_shl_address_byte_no_turn
                            sar_address_byte_player1:                  ; dec ------------------------
                                sar data_segment_2[si],cl
                                jmp far ptr player1_shl_address_byte_no_turn  
                    player1_shl_address_byte_no_turn:
                        cmp player_turn2,1
                        jz player2_shl_address_byte_turn
                        jmp far ptr end_shl_address_player1
                        player2_shl_address_byte_turn:     
                            
                            mov bl,src_index_val
                            mov ch,Player1_Data_Register[bx]
                            mov cl,Player1_Data_Register[bx+1]
                            mov si,cx 
                            mov bl, dest_index_val  
                            mov cl, Player1_Data_Register[bx]
                            mov ch,0                            
                            cmp instruction_index,10
                            jz shl_address_byte_player2
                            cmp instruction_index,9
                            jz shr_address_byte_player2
                            cmp instruction_index,11
                            jz ror_address_byte_player2 
                            cmp instruction_index,12
                            jz rol_address_byte_player2
                            cmp instruction_index,8
                            jz sal_address_byte_player2
                            cmp instruction_index,13
                            jz sar_address_byte_player2
                            shl_address_byte_player2:                  ; div ------------------------
                                shl data_segment_1[si],cl
                                jmp far ptr end_shl_address_player1
                            shr_address_byte_player2:                  ; mul ------------------------
                                shr data_segment_1[si],cl
                                jmp far ptr end_shl_address_player1
                            ror_address_byte_player2:                  ; idiv ------------------------
                                ror data_segment_1[si],cl
                                jmp far ptr end_shl_address_player1 
                            rol_address_byte_player2:                  ; imul ------------------------
                                rol data_segment_1[si],cl
                                jmp far ptr end_shl_address_player1
                            sal_address_byte_player2:                  ; inc ------------------------
                                sal data_segment_1[si],cl
                                jmp far ptr end_shl_address_player1
                            sar_address_byte_player2:                  ; dec ------------------------
                                sar data_segment_1[si],cl
                                jmp far ptr end_shl_address_player1  

            
              
    lose_point_shl_address_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_shl_address_player1:
    
    ret
    shl_shr_ror_rol_address_player1 endp 




;------------------------------- PLAYER 2 -------------------


MOVPLAYER2PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND

call change_src_dest 
            cmp power_up_player2,1
            jz mov_power_up1_player2
            cmp power_up_player2,2
            jz mov_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_mov_player2 
            mov_power_up1_player2: 
                cmp intial_points_player2,5
                JB nopoints_mov_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_mov_powerup1_p2 
                nopoints_mov_powerup1_p2:
                jmp far ptr endMOV_instruction_player2
                can_perform_mov_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player1,5
                    jmp perform_mov_player2 
            mov_power_up2_player2:
                cmp intial_points_player2,3
                JB nopoints_mov_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_mov_powerup2_p2 
                nopoints_mov_powerup2_p2:
                jmp far ptr endMOV_instruction_player2
                can_perform_mov_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_mov_player2
                perform_mov_player2:
                        mov instruction_index,0
                        mov al,address_mode
                        cmp al,1
                        jz address_mode_mov2
                        jmp reg_mode_mov2                
                    address_mode_mov2:  
                        call  mov_address_player2
                        jmp far ptr endMOV_instruction_player2
                    reg_mode_mov2:
                        call  mov_register_player2 
                jmp far ptr endMOV_instruction_player2

	endMOV_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
RET
MOVPLAYER2PR  ENDP





ADDPLAYER2PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest 
		cmp power_up_player1,1
            jz add_power_up1_player2
            cmp power_up_player1,2
            jz add_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_add_player2 
            add_power_up1_player2: 
                cmp intial_points_player2,5
                JB nopoints_add_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_add_powerup1_p2 
                nopoints_add_powerup1_p2:
                jmp far ptr endADD_instruction_player2
                can_perform_add_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0
                    sub intial_points_player2,5
                    jmp perform_add_player2 
            add_power_up2_player2:  
                cmp intial_points_player2,3
                JB nopoints_add_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_add_powerup2_p2 
                nopoints_add_powerup2_p2:
                jmp far ptr endADD_instruction_player2
                can_perform_add_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1 
                    sub intial_points_player2,3
                    jmp perform_add_player2
                perform_add_player2:
                        mov instruction_index,1
                        mov al,address_mode
                        cmp al,1
                        jz address_mode_add2
                        jmp reg_mode_add2                 
                    address_mode_add2:  
                        call  mov_address_player2
                        jmp far ptr endADD_instruction_player2
                    reg_mode_add2:      
                        call  mov_register_player2    
                  jmp far ptr endADD_instruction_player2

	endADD_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
RET
ADDPLAYER2PR  ENDP

SUBPLAYER2PR  PROC NEAR
; call drawing and clicking procedure --------------------------------
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
           call change_src_dest  
           cmp power_up_player2,1
            jz sub_power_up1_player2
            cmp power_up_player1,2
            jz sub_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_sub_player2 
            sub_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_Sub_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_Sub_powerup1_p2 
                nopoints_Sub_powerup1_p2:
                jmp far ptr endSUB_instruction_player2	
                can_perform_Sub_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0   
                    sub intial_points_player2,5
                    jmp perform_sub_player2 
            sub_power_up2_player2:
                cmp intial_points_player2,3
                JB nopoints_Sub_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_Sub_powerup2_p2 
                nopoints_Sub_powerup2_p2:
                jmp far ptr endSUB_instruction_player2	
                can_perform_Sub_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1 
                    sub intial_points_player2,3
                    jmp perform_sub_player2
            perform_sub_player2:
                        mov instruction_index,2
                        mov al,address_mode
                        cmp al,1
                        jz address_mode_sub2
                        jmp reg_mode_sub2        
                        ; address mode processing ---------------------------------------------------------         
                    address_mode_sub2:  
                        call  mov_address_player2
                        jmp far ptr endSUB_instruction_player2	
                    reg_mode_sub2:                
                        call  mov_register_player2    
                  jmp far ptr endSUB_instruction_player2	
	endSUB_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
	RET
SUBPLAYER2PR endp

MULPLAYER2PR PROC NEAR
            CALL SHOW_1ST_OPERAND

	call change_src_dest 
	cmp power_up_player2,1
            jz mul_power_up1_player2
            cmp power_up_player2,2
            jz mul_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_mul_player2 
            mul_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_mul_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_mul_powerup1_p2 
                nopoints_mul_powerup1_p2:
                jmp far ptr endMUL_instruction_player2
                can_perform_mul_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_mul_player2 
            mul_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_mul_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_mul_powerup2_p2 
                nopoints_mul_powerup2_p2:
                jmp far ptr endMUL_instruction_player2
                can_perform_mul_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_mul_player2
            perform_mul_player2:
                    mov instruction_index,3
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_mul2
                    jmp reg_mode_mul2        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_mul2:  
                    call  divmulincdecaddressplayer2
                    jmp far ptr endMUL_instruction_player2
                reg_mode_mul2:
                    call  divmulincdecregisterplayer2 
              jmp far ptr endMUL_instruction_player2
	endMUL_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
RET
MULPLAYER2PR  ENDP

DIVPLAYER2PR  PROC NEAR
            CALL SHOW_1ST_OPERAND

call change_src_dest      
cmp power_up_player2,1
            jz div_power_up1_player2
            cmp power_up_player2,2
            jz div_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_div_player2 
            div_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_div_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_div_powerup1_p2 
                nopoints_div_powerup1_p2:
                jmp far ptr endDIV_instruction_player2
                can_perform_div_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_div_player2 
            div_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_div_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_div_powerup2_p2 
                nopoints_div_powerup2_p2:
                jmp far ptr endDIV_instruction_player2
                can_perform_div_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_div_player2
            perform_div_player2:
                    mov instruction_index,4
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_div2
                    jmp reg_mode_div2        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_div2:  
                    call  divmulincdecaddressplayer2
                    jmp far ptr endDIV_instruction_player2
                reg_mode_div2:
                    call  divmulincdecregisterplayer2 
              jmp far ptr endDIV_instruction_player2
 	endDIV_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
	RET 
DIVPLAYER2PR   ENDP

IDIVPLAYER2PR PROC NEAR
            CALL SHOW_1ST_OPERAND

call change_src_dest 
  cmp power_up_player2,1
            jz Idiv_power_up1_player2
            cmp power_up_player2,2
            jz Idiv_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_Idiv_player2 
            Idiv_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_Idiv_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_Idiv_powerup1_p2 
                nopoints_Idiv_powerup1_p2:
                jmp far ptr endIDIV_instruction_player2
                can_perform_Idiv_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_Idiv_player2 
            Idiv_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_Idiv_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_Idiv_powerup2_p2 
                nopoints_Idiv_powerup2_p2:
                jmp far ptr endIDIV_instruction_player2
                can_perform_Idiv_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_Idiv_player2
            perform_Idiv_player2:
                    mov instruction_index,14
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_Idiv2
                    jmp reg_mode_Idiv2        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_Idiv2:  
                    call  divmulincdecaddressplayer2
                    jmp far ptr endIDIV_instruction_player2
                reg_mode_Idiv2:
                    call  divmulincdecregisterplayer2 
              jmp far ptr endIDIV_instruction_player2
           

	endIDIV_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
RET
IDIVPLAYER2PR  ENDP  

IMULPLAYER2PR PROC NEAR
            CALL SHOW_1ST_OPERAND

call change_src_dest         
cmp power_up_player2,1
            jz imul_power_up1_player2
            cmp power_up_player2,2
            jz imul_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_imul_player2 
            imul_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_imul_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_imul_powerup1_p2 
                nopoints_imul_powerup1_p2:
                jmp far ptr endIMUL_instruction_player2
                can_perform_imul_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_imul_player2 
            imul_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_imul_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_imul_powerup2_p2 
                nopoints_imul_powerup2_p2:
                jmp far ptr endIMUL_instruction_player2
                can_perform_imul_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_imul_player2
            perform_imul_player2:
                    mov instruction_index,15
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_imul2
                    jmp reg_mode_imul2        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_imul2:  
                    call  divmulincdecaddressplayer2
                    jmp far ptr endIMUL_instruction_player2
                reg_mode_imul2:
                    call  divmulincdecregisterplayer2 
              jmp far ptr endIMUL_instruction_player2
    
	endIMUL_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
RET
IMULPLAYER2PR  ENDP

INCPLAYER2PR  PROC NEAR
            CALL SHOW_1ST_OPERAND

call change_src_dest        
 cmp power_up_player2,1
            jz INC_power_up1_player2
            cmp power_up_player2,2
            jz INC_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_INC_player2 
            INC_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_INC_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_INC_powerup1_p2 
                nopoints_INC_powerup1_p2:
                jmp far ptr endINC_instruction_player2
                can_perform_INC_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_INC_player2 
            INC_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_INC_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_INC_powerup2_p2 
                nopoints_INC_powerup2_p2:
                jmp far ptr endINC_instruction_player2
                can_perform_INC_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_INC_player2
            perform_INC_player2:
                    mov instruction_index,5
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_INC2
                    jmp reg_mode_INC2        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_INC2:  
                    call  divmulincdecaddressplayer2
                    jmp far ptr endINC_instruction_player2
                reg_mode_INC2:
                    call  divmulincdecregisterplayer2 
              jmp far ptr endINC_instruction_player2
        
      	
	endINC_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
RET
INCPLAYER2PR  ENDP

DECPLAYER2PR PROC NEAR
            CALL SHOW_1ST_OPERAND

call change_src_dest             
cmp power_up_player2,1
            jz DEC_power_up1_player2
            cmp power_up_player2,2
            jz DEC_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_DEC_player2 
            DEC_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_DEC_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_DEC_powerup1_p2 
                nopoints_DEC_powerup1_p2:
                jmp far ptr endDEC_instruction_player2
                can_perform_DEC_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_DEC_player2 
            DEC_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_DEC_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_DEC_powerup2_p2 
                nopoints_DEC_powerup2_p2:
                jmp far ptr endDEC_instruction_player2
                can_perform_DEC_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_DEC_player2
            perform_DEC_player2:
                    mov instruction_index,6
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_DEC2
                    jmp reg_mode_DEC2        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_DEC2:  
                    call  divmulincdecaddressplayer2
                    jmp far ptr endDEC_instruction_player2
                reg_mode_DEC2:
                    call  divmulincdecregisterplayer2 
              jmp far ptr endDEC_instruction_player2

	endDEC_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
RET
DECPLAYER2PR  ENDP

SARPLAYER2PR PROC NEAR
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
            call change_src_dest 
            cmp power_up_player2,1
            jz SAR_power_up1_player2
            cmp power_up_player2,2
            jz SAR_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_SAR_player2 
            SAR_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_SAR_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SAR_powerup1_p2 
                nopoints_SAR_powerup1_p2:
                jmp far ptr endSAR_instruction_player2
                can_perform_SAR_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_SAR_player2 
            SAR_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_SAR_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SAR_powerup2_p2 
                nopoints_SAR_powerup2_p2:
                jmp far ptr endSAR_instruction_player2
                can_perform_SAR_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_SAR_player2
            perform_SAR_player2:
            
            mov instruction_index,13
            mov al,address_mode
            cmp al,1
            jz address_mode_sar2
            jmp reg_mode_sar2        
            ; address mode processing ---------------------------------------------------------         
        address_mode_sar2:  
            call  shlshrrorroladdressplayer2
            jmp far ptr endSAR_instruction_player2
        reg_mode_sar2:
            call  shlshrrorrolregisterplayer2 
      jmp far ptr endSAR_instruction_player2

          
	endSAR_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
RET
SARPLAYER2PR  ENDP

SALPLAYER2PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest   
cmp power_up_player2,1
            jz SAL_power_up1_player2
            cmp power_up_player2,2
            jz SAL_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_SAL_player2 
            SAL_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_SAL_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SAL_powerup1_p2 
                nopoints_SAL_powerup1_p2:
                jmp far ptr endSAL_instruction_player2
                can_perform_SAL_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_SAL_player2 
            SAL_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_SAL_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SAL_powerup2_p2 
                nopoints_SAL_powerup2_p2:
                jmp far ptr endSAL_instruction_player2
                can_perform_SAL_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_SAL_player2
            perform_SAL_player2:
            
            mov instruction_index,8
            mov al,address_mode
            cmp al,1
            jz address_mode_sal2
            jmp reg_mode_sal2        
            ; address mode processing ---------------------------------------------------------         
        address_mode_sal2:  
            call  shlshrrorroladdressplayer2
            jmp far ptr endSAL_instruction_player2
        reg_mode_sal2:
            call  shlshrrorrolregisterplayer2 
      jmp far ptr endSAL_instruction_player2
    

  	endSAL_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
RET
SALPLAYER2PR  ENDP

SHRPLAYER2PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest             
cmp power_up_player2,1
            jz SHR_power_up1_player2
            cmp power_up_player2,2
            jz SHR_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_SHR_player2 
            SHR_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_SHR_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SAR_powerup1_p2 
                nopoints_SHR_powerup1_p2:
                jmp far ptr endSHR_instruction_player2
                can_perform_SHR_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_SHR_player2 
            SHR_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_SHR_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SHR_powerup2_p2 
                nopoints_SHR_powerup2_p2:
                jmp far ptr endSHR_instruction_player2
                can_perform_SHR_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_SHR_player2
            perform_SHR_player2:
            
            mov instruction_index,9
            mov al,address_mode
            cmp al,1
            jz address_mode_SHR2
            jmp reg_mode_SHR2        
            ; address mode processing ---------------------------------------------------------         
        address_mode_SHR2:  
            call  shlshrrorroladdressplayer2
            jmp far ptr endSHR_instruction_player2
        reg_mode_SHR2:
            call  shlshrrorrolregisterplayer2 
      jmp far ptr endSHR_instruction_player2

 	endSHR_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
RET
SHRPLAYER2PR  ENDP

SHLPLAYER2PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest 	
cmp power_up_player2,1
            jz SHL_power_up1_player2
            cmp power_up_player2,2
            jz SHL_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_SHL_player2 
            SHL_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_SHL_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SHL_powerup1_p2 
                nopoints_SHL_powerup1_p2:
                jmp far ptr endSHL_instruction_player2
                can_perform_SHL_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_SHL_player2 
            SHL_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_SHL_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SHL_powerup2_p2 
                nopoints_SHL_powerup2_p2:
                jmp far ptr endSHL_instruction_player2
                can_perform_SHL_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_SHL_player2
            perform_SHL_player2:
            
            mov instruction_index,10
            mov al,address_mode
            cmp al,1
            jz address_mode_SHL2
            jmp reg_mode_SHL2        
            ; address mode processing ---------------------------------------------------------         
        address_mode_SHL2:  
            call  shlshrrorroladdressplayer2
            jmp far ptr endSHL_instruction_player2
        reg_mode_SHL2:
            call  shlshrrorrolregisterplayer2 
      jmp far ptr endSHL_instruction_player2
  

	endSHL_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
RET
SHLPLAYER2PR  ENDP

RORPLAYER2PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest 
  cmp power_up_player2,1
            jz ROR_power_up1_player2
            cmp power_up_player2,2
            jz ROR_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_ROR_player2 
            ROR_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_ROR_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_ROR_powerup1_p2 
                nopoints_ROR_powerup1_p2:
                jmp far ptr endROR_instruction_player2
                can_perform_ROR_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_ROR_player2 
            ROR_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_ROR_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_ROR_powerup2_p2 
                nopoints_ROR_powerup2_p2:
                jmp far ptr endROR_instruction_player2
                can_perform_ROR_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_ROR_player2
            perform_ROR_player2:
            
            mov instruction_index,11
            mov al,address_mode
            cmp al,1
            jz address_mode_ROR2
            jmp reg_mode_ROR2        
            ; address mode processing ---------------------------------------------------------         
        address_mode_ROR2:  
            call  shlshrrorroladdressplayer2
            jmp far ptr endROR_instruction_player2
        reg_mode_ROR2:
            call  shlshrrorrolregisterplayer2 
      jmp far ptr endROR_instruction_player2


	endROR_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
RET
RORPLAYER2PR  ENDP

ROLPLAYER2PR PROC NEAR
                    CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
        call change_src_dest 
        cmp power_up_player2,1
            jz ROL_power_up1_player2
            cmp power_up_player2,2
            jz ROL_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_ROL_player2 
            ROL_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_ROL_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_ROL_powerup1_p2 
                nopoints_ROL_powerup1_p2:
                jmp far ptr endROL_instruction_player2
                can_perform_ROL_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_ROL_player2 
            ROL_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_ROL_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_ROL_powerup2_p2 
                nopoints_ROL_powerup2_p2:
                jmp far ptr endROL_instruction_player2
                can_perform_ROL_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_ROL_player2
            perform_ROL_player2:
            
            mov instruction_index,12
            mov al,address_mode
            cmp al,1
            jz address_mode_ROL2
            jmp reg_mode_ROL2        
            ; address mode processing ---------------------------------------------------------         
        address_mode_ROL2:  
            call  shlshrrorroladdressplayer2
            jmp far ptr endROL_instruction_player2
        reg_mode_ROL2:
            call  shlshrrorrolregisterplayer2 
      jmp far ptr endROL_instruction_player2
    
	endROL_instruction_player2:
	mov address_mode ,0
	mov address_mode2 ,0
	mov power_up_player2,0	
RET
ROLPLAYER2PR  ENDP







;-------------------------------------mov instruction -----------------------------------------------------------
mov_reg_des_player2 proc near
            
            cmp count_bit_1,2
            jz dest2_lose_point_player2_mov
            jmp here2_dest_player2
            dest2_lose_point_player2_mov:
            jmp far ptr  lose2_point_dest_player22_mov
            here2_dest_player2:
            mov bl,dest_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if dest_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 17                      ; index to address value -> choose which value ?!
            jz check2_forbidden_digit_mov_add22 
            jnz check2_forbidden_regsiter_mov_add22 
            check2_forbidden_digit_mov_add22:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player1_Data_Register[bx]
                mov al,Player1_Data_Register[bx+1]
                
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_2 ;<----------- working should be uncomment when we solve jump problem
                ;check_forbidden Forbidden_digits_2,0    <----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz  lose2_point_1_player2_dest
                jmp cont2_address_dest_mode_mov22 
                lose2_point_1_player2_dest:
                jmp far ptr lose2_point_dest_player22_mov
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp final2_address_mode_mov2_dest 
          check2_forbidden_regsiter_mov_add22:
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz   lose2_point_2_player2_dest 
                jmp cont2_address_dest_mode_mov22 
                lose2_point_2_player2_dest:
                jmp far ptr lose2_point_dest_player22_mov                 
         cont2_address_dest_mode_mov22:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,dest_index_val
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose2_point_dest_player2_mov  ; out of index of data segment -> should be error 
            jmp final2_address_mode_mov2_dest 
            lose2_point_dest_player2_mov:
            jmp far ptr lose2_point_dest_player22_mov 
            ;----------------------------------- 
            ; now its valid instruction ----------------------------------
       final2_address_mode_mov2_dest:
            mov bh,0
            mov bl,dest_index_val 
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1]
            mov si,ax
            mov bl,src_index_val
            ;mov cx,Player2_Data_Register[bx]  
            ; check if its two byte or not
                    cmp player_turn2,1
                    jz player222_mov_byte_dest_turn
                    jmp far ptr player222_mov_byte_dest_no_turn
                    player222_mov_byte_dest_turn:
                        cmp instruction_index,0
                        jz mov2_address_byte_player22_dest
                        cmp instruction_index,1
                        jz add2_address_byte_player22_dest
                        cmp instruction_index,2
                        jz sub2_address_byte_player22_dest
                        mov2_address_byte_player22_dest: 
                            mov cl,data_segment_1[si] 
                            mov Player1_Data_Register[bx],cl                 ; mov ------------------------
                            ;mov Player2_Data_Register[bx],ah
                            jmp far ptr player222_mov_byte_dest_no_turn
                        add2_address_byte_player22_dest:                  ; add ------------------------
                            mov cl,data_segment_1[si] 
                            add Player1_Data_Register[bx],cl 
                            ;add Player2_Data_Register[bx],ah
                            jmp far ptr player222_mov_byte_dest_no_turn
                        sub2_address_byte_player22_dest:                  ; sub ------------------------
                            mov cl,data_segment_1[si] 
                            sub Player1_Data_Register[bx],cl 
                            ;sub Player2_Data_Register[bx],ah
                            jmp far ptr player222_mov_byte_dest_no_turn
                   player222_mov_byte_dest_no_turn:
                    cmp player_turn1,1
                    jz player211_mov_byte_dest_turn
                    jmp far ptr end2_dest_mov_player2 
                    player211_mov_byte_dest_turn:
                        mov bl,dest_index_val 
                        mov ah,Player2_Data_Register[bx]
                        mov al,Player2_Data_Register[bx+1]
                        cmp ax,000fh
                            JA lose2_point_dest2_player22_mov  ; out of index of data segment -> should be error 
                            jmp cont2_final_address_mode_mov2_dest 
                            lose2_point_dest2_player22_mov:
                            jmp far ptr lose2_point_dest_player22_mov
                        cont2_final_address_mode_mov2_dest:
                        mov si,ax
                        mov bl,src_index_val
                        cmp instruction_index,0
                        jz mov2_address_byte_player11_dest
                        cmp instruction_index,1
                        jz add2_address_byte_player11_dest
                        cmp instruction_index,2
                        jz sub2_address_byte_player11_dest
                        mov2_address_byte_player11_dest: 
                            mov cl,data_segment_2[si] 
                            mov Player2_Data_Register[bx],cl                 ; mov ------------------------
                            ;mov Player2_Data_Register[bx],ah
                            jmp far ptr end2_dest_mov_player2
                        add2_address_byte_player11_dest:                  ; add ------------------------
                            mov cl,data_segment_2[si] 
                            add Player2_Data_Register[bx],cl 
                            ;add Player2_Data_Register[bx],ah
                            jmp far ptr end2_dest_mov_player2
                        sub2_address_byte_player11_dest:                  ; sub ------------------------
                            mov cl,data_segment_2[si] 
                            sub Player2_Data_Register[bx],cl 
                            ;sub Player2_Data_Register[bx],ah
                            jmp far ptr end2_dest_mov_player2

    lose2_point_dest_player22_mov:
        ;cmp player_turn ,1
        ;jz player1_lose_mov_dest_reg 
        ;dec intial_points_player2
        ;mov losepoint_player2,0 
        ;mov losepoint,0
        ;jmp end_dest_mov_player1
        ;player1_lose_mov_dest_reg:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0
    
    end2_dest_mov_player2:
    
    ret
    mov_reg_des_player2 endp
;----------------------------mov to a register ---------------------------------------------------
mov_register_player2 proc near
    
    check_forbidden Forbidden_instruction_2,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_2,bl

            mov al,losepoint 
            mov losepoint_player2,al 
            cmp losepoint_player2,1
            jz   lose2_point_2_reg_player2 
            jmp cont2_reg2_mode_mov 
            lose2_point_2_reg_player2:
            jmp far ptr lose2_point_reg_mov_player2                 
         cont2_reg2_mode_mov:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            
            ; check other operand------------------ 

            ; call lotfy code to get second operand 
            mov ah,count_bit_2
            mov al,count_bit_1
            cmp ah,al ;---------------------------------------------------
            jnz lose2_point_reg_mov_player2_temp 
            jmp to2_this_mov_player2
            lose2_point_reg_mov_player2_temp:
            jmp far ptr lose2_point_reg_mov_player2
            to2_this_mov_player2:
            cmp address_mode2,1 
            
            jz address2_mode_mov_des_player2
            jmp  address2_mode_mov_des_no_player2
            address2_mode_mov_des_player2:
                call mov_reg_des_player2
            jmp far ptr end2_mov_reg_player2
            
            address2_mode_mov_des_no_player2:
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check2_forbidden_digit_reg_mov22 
            jnz check2_forbidden_regsiter_reg_mov22
            check2_forbidden_digit_reg_mov22:
                ; macro needed to check if value has a forbidden digit or not
                
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player1_Data_Register[bx]
                mov al,Player1_Data_Register[bx+1] 
                ; call macro that check if value in ax is correct
                ; check if value is 2 bytes or 1 byte so that can call its function
                check_byte_valid al, Forbidden_digits_2 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1 
                
                jz  forbidden2_digit_mov_player2 
                jmp final2_reg_mode_mov2
                forbidden2_digit_mov_player2:
                    jmp far ptr end2_mov_reg_player2 
            check2_forbidden_regsiter_reg_mov22:        
            
                check_forbidden Forbidden_Registers_2,bl
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1
                jz  forbidden2_reg_mov_player2
                jmp final2_reg_mode_mov2
                forbidden2_reg_mov_player2:
                    jmp far ptr end2_mov_reg_player2   
              
                                

            ; now its valid instruction ----------------------------------
            final2_reg_mode_mov2:
            
                ;mov cx,Player2_Data_Register[bx]  
                ; check if its two byte or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player1_Data_Register[bx]
                mov al,Player1_Data_Register[bx+1]
                mov bl,src_index_val  
                mov dl,count_bit_2
                mov dh,0
                cmp dl,2
                jz word2_mov_reg_Temp_player2
                jmp byte2_mov_reg_temp_player2
                word2_mov_reg_Temp_player2:
                jmp far ptr word2_mov_reg_player2
                byte2_mov_reg_temp_player2: 
                    cmp player_turn2,1
                    jz player222_mov_byte_turn
                    jmp player222_mov_byte_no_turn 
                    player222_mov_byte_turn:
                        mov bl,src_index_val 
                        cmp instruction_index,0
                        jz mov2_reg_byte_player22
                        cmp instruction_index,1
                        jz add2_reg_byte_player22
                        cmp instruction_index,2
                        jz sub2_reg_byte_player22
                        mov2_reg_byte_player22:                  ; mov ------------------------
                            mov Player1_Data_Register[bx],ah
                            jmp far ptr player222_mov_byte_no_turn
                        add2_reg_byte_player22:                  ; add ------------------------
                            add Player1_Data_Register[bx],ah
                            jmp far ptr player222_mov_byte_no_turn
                        sub2_reg_byte_player22:                  ; sub ------------------------
                            sub Player1_Data_Register[bx],ah
                            jmp far ptr player222_mov_byte_no_turn
                    player222_mov_byte_no_turn:
                        cmp player_turn1,1
                        jz player211_mov_byte_turn
                        jmp far ptr end2_mov_reg_player2
                        player211_mov_byte_turn:
                            mov bl,dest_index_val 
                            mov ah,Player2_Data_Register[bx]
                            mov al,Player2_Data_Register[bx+1]
                            mov bl,src_index_val  
                            cmp instruction_index,0
                            jz mov2_reg_byte_player11
                            cmp instruction_index,1
                            jz add2_reg_byte_player11
                            cmp instruction_index,2
                            jz sub2_reg_byte_player11
                            mov2_reg_byte_player11:                  ; mov ------------------------
                                mov Player2_Data_Register[bx],ah
                                jmp far ptr end2_mov_reg_player2
                            add2_reg_byte_player11:                  ; add ------------------------
                                add Player2_Data_Register[bx],ah
                                jmp far ptr end2_mov_reg_player2
                            sub2_reg_byte_player11:                  ; sub ------------------------
                                sub Player2_Data_Register[bx],ah
                                jmp far ptr end2_mov_reg_player2
                                                        
                word2_mov_reg_player2:
                    cmp player_turn2,1
                    jz player222_mov_word_turn
                    jmp player222_mov_word_no_turn 
                    player222_mov_word_turn:
                    
                        cmp instruction_index,0
                        jz mov2_reg_word_player22
                        cmp instruction_index,1
                        jz add2_reg_word_player22
                        cmp instruction_index,2
                        jz sub2_reg_word_player22
                        mov2_reg_word_player22:                  ; mov ------------------------
                            mov Player1_Data_Register[bx+1],al
                            mov Player1_Data_Register[bx],ah
                            jmp far ptr player222_mov_word_no_turn
                        add2_reg_word_player22:                  ; add ------------------------
                            add Player1_Data_Register[bx+1],al
                            adc Player1_Data_Register[bx],ah
                            jmp far ptr player222_mov_word_no_turn
                        sub2_reg_word_player22:                  ; sub ------------------------
                            sub Player1_Data_Register[bx+1],al
                            sbb Player1_Data_Register[bx],ah
                            jmp far ptr player222_mov_word_no_turn             
                                                            ; lose point because of invalid instruction
    
                    player222_mov_word_no_turn:
                        cmp player_turn1,1
                        jz player211_mov_word_turn
                        jmp far ptr end2_mov_reg_player2
                        player211_mov_word_turn:
                        mov bl,dest_index_val 
                        mov ah,Player2_Data_Register[bx]
                        mov al,Player2_Data_Register[bx+1]
                        mov bl,src_index_val
                        cmp instruction_index,0
                        jz mov2_reg_word_player11
                        cmp instruction_index,1
                        jz add2_reg_word_player11
                        cmp instruction_index,2
                        jz sub2_reg_word_player11
                        mov2_reg_word_player11:                  ; mov ------------------------
                            mov Player2_Data_Register[bx+1],al
                            mov Player2_Data_Register[bx],ah
                            jmp far ptr end2_mov_reg_player2
                        add2_reg_word_player11:                  ; add ------------------------
                            add Player2_Data_Register[bx+1],al
                            adc Player2_Data_Register[bx],ah
                            jmp far ptr end2_mov_reg_player2
                        sub2_reg_word_player11:                  ; sub ------------------------
                            sub Player2_Data_Register[bx+1],al
                            sbb Player2_Data_Register[bx],ah
                            jmp far ptr end2_mov_reg_player2 
    
    
    lose2_point_reg_mov_player2:
        ;cmp player_turn ,1
        ;jz player1_lose_mov_reg 
        ;dec intial_points_player2
        ;mov losepoint_player2,0 
        ;mov losepoint,0
        ;jmp end_mov_reg_player1
        ;player1_lose_mov_reg:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0
    
    end2_mov_reg_player2:
     
    ret 
    mov_register_player2 endp
;---------------------------------------------------  mov to datasegment  -----------------------------------------------------------------
mov_address_player2  proc near
    
        check_forbidden Forbidden_instruction_2,instruction_index       
;-----------------------------i have all indexes-------------------------------------------- 
; ---------------------------- assume bolbol will send byte indicate if its address or not (two address modes for destination & source)
            
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 18                      ; index to address value -> choose which value ?!
            jz check22_forbidden_digit_mov 
            jnz check22_forbidden_regsiter_mov 
            check22_forbidden_digit_mov:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ah,Player1_Data_Register[bx]
                mov al,Player1_Data_Register[bx+1]
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_2 ;<----------- working should be uncomment when we solve jump problem
                mov Player2_Data_Register[bx+1],al
                mov Player2_Data_Register[bx],ah 
                ;check_forbidden Forbidden_digits_2,0   ;<----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz  lose2_point_1_player2
                jmp cont22_address_mode_mov 
                lose2_point_1_player2:
                ;jmp far ptr lose_point_player1
                jmp far ptr end2_mov_address_player2
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp cont22_address_mode_mov 
            check22_forbidden_regsiter_mov:
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz   lose2_point_2_player2 
                jmp cont22_address_mode_mov 
                lose2_point_2_player2:
                jmp far ptr lose2_point_player2                 
         cont22_address_mode_mov:
            ;check if value in ax is less than f for two turns player1_turn & player2_turn
            mov bh,0
            mov bl,src_index_val
            cmp player_turn2,1              ;-> player1 turn 
            jz player222_check_address_mov
            jmp cont2_check_address_mode_mov22
            player222_check_address_mov:
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose2_point_3_player22  ; out of index of data segment -> should be error 
            jmp cont2_check_address_mode_mov22 
            lose2_point_3_player22:
            jmp far ptr lose2_point_player2
            cont2_check_address_mode_mov22:
            cmp player_turn1,1              ;-> player1 turn 
            jz player211_check_address_mov
            jmp cont2_address_mode_mov22
            player211_check_address_mov:
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh  
            JA lose2_point_4_player22  ; out of index of data segment -> should be error 
            jmp cont2_address_mode_mov22 
            lose2_point_4_player22:
            jmp far ptr lose2_point_player2
            ; check other operand------------------ 
            cont2_address_mode_mov22:
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check2_forbidden_digit_mov22 
            jnz check2_forbidden_regsiter_mov22
            check2_forbidden_digit_mov22:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player1_Data_Register[bx]
                mov al,Player1_Data_Register[bx+1] 
                ; call macro that check if value in ax is correct
                check_word_valid ax, Forbidden_digits_2 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1
  
                jz  forbidden2_address_mov_player2
                jmp final2_address_mode_mov2
                forbidden2_address_mov_player2:
                    jmp far ptr end2_mov_address_player2  
            
            check2_forbidden_regsiter_mov22:        
            
                check_forbidden Forbidden_Registers_2,bl
                 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1
                ;jz  lose_point_player1   
                jz temp2_end_mov_address_player2   ; -> jump far here
                jmp  final2_address_mode_mov2
                temp2_end_mov_address_player2:
                jmp far ptr end2_mov_address_player2
                ;mov bh,0
                ;mov bl,dest_index_val
                ;mov ah,Player2_Data_Register[bx]
                ;mov al,Player2_Data_Register[bx+1]

            ; now its valid instruction ----------------------------------
            final2_address_mode_mov2:
            mov bh,0
            mov bl,src_index_val 
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1]
            mov si,ax
            mov bl,dest_index_val
            ;mov cx,Player2_Data_Register[bx]  
            ; check if its two byte or not 
            mov dl,count_bit_2
            mov dh,0
            cmp dl,2
            jz lose2_point_plyer2       ;-> should jmp far
            jmp not2_lose_point_plyer2
            lose2_point_plyer2:
            jmp far ptr lose2_point_player2
            ; paste here  
            not2_lose_point_plyer2:
                    cmp player_turn2,1              ;-> player1 turn 
                    jz player222_mov_address_byte_turn
                    jmp player222_mov_address_byte_no_turn 
                    player222_mov_address_byte_turn:      
                        cmp instruction_index,0
                        jz mov2_address_byte_player22
                        cmp instruction_index,1
                        jz add2_address_byte_player22
                        cmp instruction_index,2
                        jz sub2_address_byte_player22
                        mov2_address_byte_player22:                  ; mov ------------------------
                            mov cl,Player1_Data_Register[bx]
                            mov data_segment_1[si],cl
                            ;mov Player2_Data_Register[bx],ah
                            jmp far ptr player222_mov_address_byte_no_turn
                        add2_address_byte_player22:                  ; add ------------------------
                            mov cl,Player1_Data_Register[bx]
                            add data_segment_1[si],cl
                            ;add Player2_Data_Register[bx],ah
                            jmp far ptr player222_mov_address_byte_no_turn
                        sub2_address_byte_player22:                  ; sub ------------------------
                            mov cl,Player1_Data_Register[bx]
                            sub data_segment_1[si],cl
                            ;sub Player2_Data_Register[bx],ah
                            jmp far ptr player222_mov_address_byte_no_turn
                            
                     player222_mov_address_byte_no_turn:
                        cmp player_turn1,1
                        jz player211_mov_address_byte_turn
                        jmp far ptr end2_mov_address_player2
                        player211_mov_address_byte_turn:
                            mov bl,src_index_val 
                            mov ah,Player2_Data_Register[bx]
                            mov al,Player2_Data_Register[bx+1]
                            mov si,ax
                            mov bl,dest_index_val
                            cmp instruction_index,0
                            jz mov2_address_byte_player11
                            cmp instruction_index,1
                            jz add2_address_byte_player11
                            cmp instruction_index,2
                            jz sub2_address_byte_player11
                            mov2_address_byte_player11:                  ; mov ------------------------
                                mov cl,Player2_Data_Register[bx]
                                mov data_segment_2[si],cl
                                jmp far ptr end2_mov_address_player2
                            add2_address_byte_player11:                  ; add ------------------------
                                mov cl,Player2_Data_Register[bx]
                                add data_segment_2[si],cl
                                jmp far ptr end2_mov_address_player2
                            sub2_address_byte_player11:                  ; sub ------------------------
                                mov cl,Player2_Data_Register[bx]
                                sub data_segment_2[si],cl
                                jmp far ptr end2_mov_address_player2                                    
              
    lose2_point_player2:
        dec intial_points_player2
        mov losepoint_player1,0 
        mov losepoint,0
    
    end2_mov_address_player2:
    
    ret
    mov_address_player2 endp 
;----------------------------div mul inc dec imul idiv reg ---------------------------------------------------
divmulincdecregisterplayer2 proc near
    
    check_forbidden Forbidden_instruction_2,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_2,bl

            mov al,losepoint 
            mov losepoint_player2,al 
            cmp losepoint_player2,1
            jz   lose2point2regdivplayer2 
            jmp cont2regmode2div 
            lose2point2regdivplayer2:
            jmp far ptr end2divregplayer2                 
         cont2regmode2div:
            mov dl,count_bit_1
            mov dh,0
            cmp dl,2
            jz temp2worddivregplayer2
            jmp temp2bytedivregplayer2
            temp2worddivregplayer2:
            jmp far ptr word2divregplayer2
            temp2bytedivregplayer2:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,0
                    mov cl,Player1_Data_Register[bx]            
                    mov ah,Player1_Data_Register[0]
                    mov al,Player1_Data_Register[1]
                    mov dx,0 
                    ; add player turn here : 
                    cmp player_turn2,1
                    jz player222divbyteturn
                    jmp player222divbytenoturn 
                    player222divbyteturn:    
                        cmp instruction_index,4
                        jz div2regbyteplayer22
                        cmp instruction_index,3
                        jz mul2regbyteplayer22
                        cmp instruction_index,14
                        jz idiv2regbyteplayer22 
                        cmp instruction_index,15
                        jz imul2regbyteplayer22
                        cmp instruction_index,5
                        jz inc2regbyteplayer22
                        cmp instruction_index,6
                        jz dec2regbyteplayer22
                        div2regbyteplayer22:                  ; div ------------------------
                            cmp cx,0
                            jz div2zerobyteregp22
                            jmp not2divzerobyteregp22
                            div2zerobyteregp22:
                            jmp far ptr lose2pointdivplayer2
                            not2divzerobyteregp22:
                            div cx
                            mov Player1_Data_Register[0],dl
                            mov Player1_Data_Register[1],al
                            jmp far ptr player222divbytenoturn
                        mul2regbyteplayer22:                  ; mul ------------------------
                            mul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al 
                            jmp far ptr player222divbytenoturn
                        idiv2regbyteplayer22:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv2zerobyteregp22
                            jmp not2idivzerobyteregp22
                            idiv2zerobyteregp22:
                            jmp far ptr lose2pointdivplayer2
                            not2idivzerobyteregp22:
                            idiv cx
                            mov Player1_Data_Register[0],dl
                            mov Player1_Data_Register[1],al
                            jmp far ptr player222divbytenoturn 
                        imul2regbyteplayer22:                  ; imul ------------------------
                            imul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            jmp far ptr player222divbytenoturn
                        inc2regbyteplayer22:                  ; inc ------------------------
                            inc cl
                            mov Player1_Data_Register[bx],cl
                            jmp far ptr player222divbytenoturn
                        dec2regbyteplayer22:                  ; dec ------------------------
                            dec cx
                            mov Player1_Data_Register[bx],cl
                            jmp far ptr player222divbytenoturn
                    
                    player222divbytenoturn:        
                    cmp player_turn1,1
                    jz player211divbyteturn
                    jmp far ptr end2divregplayer2 
                    player211divbyteturn:
                        mov cl,Player2_Data_Register[bx]            
                        mov ah,Player2_Data_Register[0]
                        mov al,Player2_Data_Register[1]    
                        cmp instruction_index,4
                        jz div2regbyteplayer11
                        cmp instruction_index,3
                        jz mul2regbyteplayer11
                        cmp instruction_index,14
                        jz idiv2regbyteplayer11 
                        cmp instruction_index,15
                        jz imul2regbyteplayer11
                        cmp instruction_index,5
                        jz inc2regbyteplayer11
                        cmp instruction_index,6
                        jz dec2regbyteplayer11
                        div2regbyteplayer11:                  ; div ------------------------
                            cmp cx,0
                            jz div2zerobyteregp11
                            jmp not2divzerobyteregp11
                            div2zerobyteregp11:
                            jmp far ptr lose2pointdivplayer2
                            not2divzerobyteregp11:
                            div cx
                            mov Player2_Data_Register[0],dl
                            mov Player2_Data_Register[1],al
                            jmp far ptr end2divregplayer2
                        mul2regbyteplayer11:                  ; mul ------------------------
                            mul cl
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al 
                            jmp far ptr end2divregplayer2
                        idiv2regbyteplayer11:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv2zerobyteregp11
                            jmp not2idivzerobyteregp11
                            idiv2zerobyteregp11:
                            jmp far ptr lose2pointdivplayer2
                            not2idivzerobyteregp11:
                            idiv cx
                            mov Player2_Data_Register[0],dl
                            mov Player2_Data_Register[1],al
                            jmp far ptr end2divregplayer2 
                        imul2regbyteplayer11:                  ; imul ------------------------
                            imul cl
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            jmp far ptr end2divregplayer2
                        inc2regbyteplayer11:                  ; inc ------------------------
                            inc cl
                            mov Player2_Data_Register[bx],cl
                            jmp far ptr end2divregplayer2
                        dec2regbyteplayer11:                  ; dec ------------------------
                            dec cx
                            mov Player2_Data_Register[bx],cl
                            jmp far ptr end2divregplayer2     
            word2divregplayer2:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,Player1_Data_Register[bx]
                    mov cl,Player1_Data_Register[bx+1]             
                    mov ah,Player1_Data_Register[0]
                    mov al,Player1_Data_Register[1]
                    mov dh,Player1_Data_Register[6]
                    mov dl,Player1_Data_Register[7] 
                    ; add player turn here
                     
                    cmp player_turn2,1
                    jz player222divwordturn
                    jmp player222divwordnoturn 
                    player222divwordturn: 
                        cmp instruction_index,4
                        jz div2regwordplayer22
                        cmp instruction_index,3
                        jz mul2regwordplayer22
                        cmp instruction_index,14
                        jz idiv2regwordplayer22 
                        cmp instruction_index,15
                        jz imul2regwordplayer22
                        cmp instruction_index,5
                        jz inc2regwordplayer22
                        cmp instruction_index,6
                        jz dec2regwordplayer22
                        div2regwordplayer22:                  ; div ------------------------
                            cmp cx,0
                            jz div2zerowordregp22
                            div cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr player222divwordnoturn
                            div2zerowordregp22:
                            jmp far ptr lose2pointdivplayer2
                            not2divzerowordregp22:

                        mul2regwordplayer22:                  ; mul ------------------------
                            mul cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr player222divwordnoturn 
                        idiv2regwordplayer22:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv2zerowordregp22
                            jmp not2idivzerowordregp22
                            idiv2zerowordregp22:
                            jmp far ptr lose2pointdivplayer2
                            not2idivzerowordregp22:
                            idiv cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al 
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr player222divwordnoturn 
                        imul2regwordplayer22:                  ; imul ------------------------
                            imul cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr player222divwordnoturn
                        inc2regwordplayer22:                  ; inc ------------------------
                            inc cx
                            mov Player1_Data_Register[bx],ch
                            mov Player1_Data_Register[bx+1],cl
                            jmp far ptr player222divwordnoturn
                        dec2regwordplayer22:                  ; dec ------------------------
                            dec cx
                            mov Player1_Data_Register[bx],ch
                            mov Player1_Data_Register[bx+1],cl
                            jmp far ptr player222divwordnoturn 
                    
                    ; add player turn here 
                    player222divwordnoturn:
                    cmp player_turn1,1
                    jz player211divwordturn
                    jmp far ptr end2divregplayer2
                    player211divwordturn:
                        
                        mov ch,Player2_Data_Register[bx]
                        mov cl,Player2_Data_Register[bx+1]             
                        mov ah,Player2_Data_Register[0]
                        mov al,Player2_Data_Register[1]
                        mov dh,Player2_Data_Register[6]
                        mov dl,Player2_Data_Register[7] 
                        cmp instruction_index,4
                        jz div2regwordplayer11
                        cmp instruction_index,3
                        jz mul2regwordplayer11
                        cmp instruction_index,14
                        jz idiv2regwordplayer11 
                        cmp instruction_index,15
                        jz imul2regwordplayer11
                        cmp instruction_index,5
                        jz inc2regwordplayer11
                        cmp instruction_index,6
                        jz dec2regwordplayer11
                        div2regwordplayer11:                  ; div ------------------------
                            cmp cx,0
                            jz div2zerowordregp11
                            div cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr end2divregplayer2
                            div2zerowordregp11:
                            jmp far ptr lose2pointdivplayer2

                        mul2regwordplayer11:                  ; mul ------------------------
                            mul cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr end2divregplayer2 
                        idiv2regwordplayer11:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv2zerowordregp11
                            jmp not2idivzerowordregp11
                            idiv2zerowordregp11:
                            jmp far ptr lose2pointdivplayer2
                            not2idivzerowordregp11:
                            idiv cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al 
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr end2divregplayer2 
                        imul2regwordplayer11:                  ; imul ------------------------
                            imul cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr end2divregplayer2
                        inc2regwordplayer11:                  ; inc ------------------------
                            inc cx
                            mov Player2_Data_Register[bx],ch
                            mov Player2_Data_Register[bx+1],cl
                            jmp far ptr end2divregplayer2
                        dec2regwordplayer11:                  ; dec ------------------------
                            dec cx
                            mov Player2_Data_Register[bx],ch
                            mov Player2_Data_Register[bx+1],cl
                            jmp far ptr end2divregplayer2 
                    
    
   lose2pointdivplayer2:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0                
    end2divregplayer2:
     
    ret 
    divmulincdecregisterplayer2 endp
    

divmulincdecaddressplayer2  proc near
    
        check_forbidden Forbidden_instruction_2,instruction_index                   
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 18                      ; index to address value -> choose which value ?!
            jz forbiddendigitaddress2div 
            jnz forbiddenregsiteraddress2div 
            forbiddendigitaddress2div:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ah,Player1_Data_Register[bx]
                mov al,Player1_Data_Register[bx+1]
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_2 
                ;check_forbidden Forbidden_digits_2,0    <----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz  losepoint1divaddressplayer2
                jmp contaddressmode2div 
                losepoint1divaddressplayer2:
                ;jmp far ptr lose_point_player1
                jmp far ptr enddivaddressplayer2
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp contaddressmode2div 
           forbiddenregsiteraddress2div:
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz   losepoint2divaddressplayer2 
                jmp contaddressmode2div 
                losepoint2divaddressplayer2:
                jmp far ptr losepointdivaddressplayer2                 
         contaddressmode2div:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val 
            cmp player_turn2,1              ;-> player1 turn 
            jz player22checkaddressdiv
            jmp contcheckaddressmode2div2
            player22checkaddressdiv:
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            cmp ax,000fh
            JA losepoint3divaddressplayer2  ; out of index of data segment -> should be error 
            jmp contcheckaddressmode2div2 
            losepoint3divaddressplayer2:
            jmp far ptr losepointdivaddressplayer2
            contcheckaddressmode2div2:
            cmp player_turn1,1              ;-> player1 turn 
            jz player11checkaddressdiv
            jmp finaladdressmode2div
            player11checkaddressdiv:
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh  
            JA losepoint4divaddressplayer2  ; out of index of data segment -> should be error 
            jmp finaladdressmode2div 
            losepoint4divaddressplayer2:
            jmp far ptr losepointdivaddressplayer2
            finaladdressmode2div:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,Player1_Data_Register[bx]
                    mov cl,Player1_Data_Register[bx+1]
                    mov si,cx
                    mov cl,data_segment_1[si]
                    mov ch,0            
                    mov ah,Player1_Data_Register[0]
                    mov al,Player1_Data_Register[1]
                    
                    ; paste here
                    cmp player_turn2,1              ;-> player1 turn 
                    jz player22divaddressbyteturn
                    jmp player22divaddressbytenoturn 
                    player22divaddressbyteturn:
                        cmp instruction_index,4
                        jz divaddressbyteplayer22
                        cmp instruction_index,3
                        jz muladdressbyteplayer22
                        cmp instruction_index,14
                        jz idivaddressbyteplayer22 
                        cmp instruction_index,15
                        jz imuladdressbyteplayer22
                        cmp instruction_index,5
                        jz incaddressbyteplayer22
                        cmp instruction_index,6
                        jz decaddressbyteplayer22
                        divaddressbyteplayer22:                  ; div ------------------------
                            cmp cx,0
                            jz divzeroaddressregp22
                            jmp notdivzeroaddressregp22
                            divzeroaddressregp22:
                            jmp far ptr losepointdivaddressplayer2
                            notdivzeroaddressregp22:
                            div cx
                            mov Player1_Data_Register[0],dh
                            mov Player1_Data_Register[1],al
                            jmp far ptr player22divaddressbytenoturn
                        muladdressbyteplayer22:                  ; mul ------------------------
                            mul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al 
                            jmp far ptr player22divaddressbytenoturn
                        idivaddressbyteplayer22:                  ; idiv ------------------------
                            cmp cx,0
                            jz idivzeroaddressregp22
                            jmp notidivzeroaddressregp22
                            idivzeroaddressregp22:
                            jmp far ptr losepointdivaddressplayer2
                            notidivzeroaddressregp22:
                            idiv cx
                            mov Player1_Data_Register[0],dh
                            mov Player1_Data_Register[1],al
                            jmp far ptr player22divaddressbytenoturn 
                        imuladdressbyteplayer22:                  ; imul ------------------------
                            imul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            jmp far ptr player22divaddressbytenoturn
                        incaddressbyteplayer22:                  ; inc ------------------------
                            inc cl
                            mov data_segment_1[si],cl
                            jmp far ptr player22divaddressbytenoturn
                        decaddressbyteplayer22:                  ; dec ------------------------
                            dec cx
                            mov data_segment_1[si],cl
                            jmp far ptr player22divaddressbytenoturn 

                                        
                    player22divaddressbytenoturn:
                        cmp player_turn1,1
                        jz player11divaddressbyteturn
                        jmp far ptr enddivaddressplayer2
                        player11divaddressbyteturn:
                            mov ch,Player2_Data_Register[bx]
                            mov cl,Player2_Data_Register[bx+1]
                            mov si,cx
                            mov cl,data_segment_2[si]
                            mov ch,0            
                            mov ah,Player2_Data_Register[0]
                            mov al,Player2_Data_Register[1]
                            cmp instruction_index,4
                            jz divaddressbyteplayer11
                            cmp instruction_index,3
                            jz muladdressbyteplayer11
                            cmp instruction_index,14
                            jz idivaddressbyteplayer11 
                            cmp instruction_index,15
                            jz imuladdressbyteplayer11
                            cmp instruction_index,5
                            jz incaddressbyteplayer11
                            cmp instruction_index,6
                            jz decaddressbyteplayer11
                            divaddressbyteplayer11:                  ; div ------------------------
                                cmp cx,0
                                jz divzeroaddressregp11
                                jmp notdivzeroaddressregp11
                                divzeroaddressregp11:
                                jmp far ptr losepointdivaddressplayer2
                                notdivzeroaddressregp11:
                                div cx
                                mov Player2_Data_Register[0],dh
                                mov Player2_Data_Register[1],al
                                jmp far ptr enddivaddressplayer2
                            muladdressbyteplayer11:                  ; mul ------------------------
                                mul cl
                                mov Player2_Data_Register[0],ah
                                mov Player2_Data_Register[1],al 
                                jmp far ptr enddivaddressplayer2
                            idivaddressbyteplayer11:                  ; idiv ------------------------
                                cmp cx,0
                                jz idivzeroaddressregp11
                                jmp notidivzeroaddressregp11
                                idivzeroaddressregp11:
                                jmp far ptr losepointdivaddressplayer2
                                notidivzeroaddressregp11:
                                idiv cx
                                mov Player2_Data_Register[0],dh
                                mov Player2_Data_Register[1],al
                                jmp far ptr enddivaddressplayer2 
                            imuladdressbyteplayer11:                  ; imul ------------------------
                                imul cl
                                mov Player2_Data_Register[0],ah
                                mov Player2_Data_Register[1],al
                                jmp far ptr enddivaddressplayer2
                            incaddressbyteplayer11:                  ; inc ------------------------
                                inc cl
                                mov data_segment_2[si],cl
                                jmp far ptr enddivaddressplayer2
                            decaddressbyteplayer11:                  ; dec ------------------------
                                dec cx
                                mov data_segment_2[si],cl
                                jmp far ptr enddivaddressplayer2 
                    
              
    losepointdivaddressplayer2:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0
    
    enddivaddressplayer2:
    
    ret
    divmulincdecaddressplayer2 endp




;----------------------------shl  reg ---------------------------------------------------
shlshrrorrolregisterplayer2 proc near
    
    check_forbidden Forbidden_instruction_2,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_2,bl

            mov al,losepoint 
            mov losepoint_player2,al 
            cmp losepoint_player2,1
            jz   losepoint2regshlplayer2 
            jmp contregmode2shl 
            losepoint2regshlplayer2:
            jmp far ptr endshlregplayer2                 
         contregmode2shl:
         
           ; check if value or cl is valid 
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz checkforbiddendigitreg2shl2 
            jnz checkforbiddenregsiterreg2shl2
            checkforbiddendigitreg2shl2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player1_Data_Register[bx]
                mov Player2_Data_Register[bx],ah
 
                ; call macro that check if value in ax is correct
                check_byte_valid ah, Forbidden_digits_2 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1
                jz  forbiddenregshlplayer2
                jmp contregmode2shl2
                forbiddenregshlplayer2:
                jmp far ptr endshlregplayer2  
            
            checkforbiddenregsiterreg2shl2:        
                
                cmp bl,7
                jnz losepointnotregclp2
                check_forbidden Forbidden_Registers_2,bl                 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1   
                jz tempendshlregplayer2   ; -> jump far here
                jmp  contregmode2shl2
                tempendshlregplayer2:
                jmp far ptr endshlregplayer2
                losepointnotregclp2:
                jmp far ptr losepointshlregplayer2 
         contregmode2shl2:
            mov dl,count_bit_1
            mov dh,0
            cmp dl,2
            jz tempwordshlregplayer2
            jmp tempbyteshlregplayer2
            tempwordshlregplayer2:
            jmp far ptr wordshlregplayer2
            tempbyteshlregplayer2:
                    mov bh,0
                    mov bl,dest_index_val
                    mov ch,0
                    mov cl,Player1_Data_Register[bx]
                    mov bl, src_index_val
                                 
                    ; paste here
                    cmp player_turn2,1
                    jz player22shlbyteturn
                    jmp player22shlbytenoturn 
                    player22shlbyteturn:
                        cmp instruction_index,10
                        jz shlregbyteplayer22
                        cmp instruction_index,9
                        jz shrregbyteplayer22
                        cmp instruction_index,11
                        jz rorregbyteplayer22 
                        cmp instruction_index,12
                        jz rolregbyteplayer22
                        cmp instruction_index,8
                        jz salregbyteplayer22
                        cmp instruction_index,13
                        jz sarregbyteplayer22
                        shlregbyteplayer22:                  ; div ------------------------
                            shl Player1_Data_Register[bx],cl
                            jmp far ptr player22shlbytenoturn
                        shrregbyteplayer22:                  ; mul ------------------------
                            shr Player1_Data_Register[bx],cl
                            jmp far ptr player22shlbytenoturn
                        rorregbyteplayer22:                  ; idiv ------------------------
                            ror Player1_Data_Register[bx],cl
                            jmp far ptr player22shlbytenoturn 
                        rolregbyteplayer22:                  ; imul ------------------------
                            rol Player1_Data_Register[bx],cl
                            jmp far ptr player22shlbytenoturn
                        salregbyteplayer22:                  ; inc ------------------------
                            sal Player1_Data_Register[bx],cl
                            jmp far ptr player22shlbytenoturn
                        sarregbyteplayer22:                  ; dec ------------------------
                            sar Player1_Data_Register[bx],cl
                            jmp far ptr player22shlbytenoturn
                   ; paste here     
                    player22shlbytenoturn:        
                    cmp player_turn1,1
                    jz player11shlbyteturn
                    jmp far ptr endshlregplayer2 
                    player11shlbyteturn:
                        mov bl,dest_index_val
                        mov ch,0
                        mov cl,Player2_Data_Register[bx]
                        mov bl, src_index_val
                        cmp instruction_index,10
                        jz shlregbyteplayer11
                        cmp instruction_index,9
                        jz shrregbyteplayer11
                        cmp instruction_index,11
                        jz rorregbyteplayer11 
                        cmp instruction_index,12
                        jz rolregbyteplayer11
                        cmp instruction_index,8
                        jz salregbyteplayer11
                        cmp instruction_index,13
                        jz sarregbyteplayer11
                        shlregbyteplayer11:                  ; div ------------------------
                            shl Player2_Data_Register[bx],cl
                            jmp far ptr endshlregplayer2
                        shrregbyteplayer11:                  ; mul ------------------------
                            shr Player2_Data_Register[bx],cl
                            jmp far ptr endshlregplayer2
                        rorregbyteplayer11:                  ; idiv ------------------------
                            ror Player2_Data_Register[bx],cl
                            jmp far ptr endshlregplayer2 
                        rolregbyteplayer11:                  ; imul ------------------------
                            rol Player2_Data_Register[bx],cl
                            jmp far ptr endshlregplayer2
                        salregbyteplayer11:                  ; inc ------------------------
                            sal Player2_Data_Register[bx],cl
                            jmp far ptr endshlregplayer2
                        sarregbyteplayer11:                  ; dec ------------------------
                            sar Player2_Data_Register[bx],cl
                            jmp far ptr endshlregplayer2
                         
                         
            wordshlregplayer2:
                    mov bh,0   
                    mov bl,dest_index_val
                    mov cl,Player1_Data_Register[bx]
                    mov bl,src_index_val
                    mov ah,Player1_Data_Register[bx]
                    mov al,Player1_Data_Register[bx+1]
                                  
                    ; paste here
                    cmp player_turn2,1
                    jz player22shlwordturn
                    jmp player22shlwordnoturn 
                    player22shlwordturn: 
                        cmp instruction_index,10
                        jz shlregwordplayer22
                        cmp instruction_index,9
                        jz shrregwordplayer22
                        cmp instruction_index,11
                        jz rorregwordplayer22
                        cmp instruction_index,12
                        jz rolregwordplayer22
                        cmp instruction_index,8
                        jz salregwordplayer22
                        cmp instruction_index,13
                        jz sarregwordplayer22 
                        shlregwordplayer22:              ; div ------------------------
                            shl ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22shlwordnoturn
                        shrregwordplayer22:                  ; mul ------------------------
                            shr ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22shlwordnoturn 
                        rorregwordplayer22:                  ; idiv ------------------------
                            ror ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22shlwordnoturn 
                        rolregwordplayer22:                  ; imul ------------------------
                            rol ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22shlwordnoturn
                        salregwordplayer22:                  ; inc ------------------------
                            sal ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22shlwordnoturn
                        sarregwordplayer22:                  ; dec ------------------------
                            sar ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22shlwordnoturn
                  
                  ; paste here
                    player22shlwordnoturn:
                    cmp player_turn1,1
                    jz player11shlwordturn
                    jmp far ptr endshlregplayer2
                    player11shlwordturn: 
                        mov bl,dest_index_val
                        mov cl,Player2_Data_Register[bx]
                        mov bl,src_index_val
                        mov ah,Player2_Data_Register[bx]
                        mov al,Player2_Data_Register[bx+1]
                        cmp instruction_index,10
                        jz shlregwordplayer11
                        cmp instruction_index,9
                        jz shrregwordplayer11
                        cmp instruction_index,11
                        jz rorregwordplayer11 
                        cmp instruction_index,12
                        jz rolregwordplayer11
                        cmp instruction_index,8
                        jz salregwordplayer11
                        cmp instruction_index,13
                        jz sarregwordplayer11
                        shlregwordplayer11:              ; div ------------------------
                            shl ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr endshlregplayer2
                        shrregwordplayer11:                  ; mul ------------------------
                            shr ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr endshlregplayer2 
                        rorregwordplayer11:                  ; idiv ------------------------
                            ror ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr endshlregplayer2 
                        rolregwordplayer11:                  ; imul ------------------------
                            rol ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr endshlregplayer2
                        salregwordplayer11:                  ; inc ------------------------
                            sal ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr endshlregplayer2
                        sarregwordplayer11:                  ; dec ------------------------
                            sar ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr endshlregplayer2
                  
    losepointshlregplayer2:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0
            
    endshlregplayer2:
     
    ret 
    shlshrrorrolregisterplayer2 endp
;---------------------------------------------------  shl to datasegment  -----------------------------------------------------------------
shlshrrorroladdressplayer2  proc near
    
        check_forbidden Forbidden_instruction_2,instruction_index                   
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 17                      ; index to address value -> choose which value ?!
            jz forbiddendigitaddress22shl 
            jnz forbiddenregsiteraddress22shl 
            forbiddendigitaddress22shl:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ah,Player1_Data_Register[bx]
                mov al,Player1_Data_Register[bx+1]
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_2 
                ;check_forbidden Forbidden_digits_2,0    <----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz  losepoint1shladdressplayer2
                jmp contaddressmode2shl 
                losepoint1shladdressplayer2:
                ;jmp far ptr lose_point_player1
                jmp far ptr endshladdressplayer2
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp contaddressmode2shl 
           forbiddenregsiteraddress22shl:
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   losepoint2shladdressplayer2 
                jmp contaddressmode2shl 
                losepoint2shladdressplayer2:
                jmp far ptr losepointshladdressplayer2                 
         contaddressmode2shl:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            cmp ax,000fh
            JA losepoint3shladdressplayer2  ; out of index of data segment -> should be error 
            jmp contaddressmodeshl22 
            losepoint3shladdressplayer2:
            jmp far ptr losepointshladdressplayer2 
            
            contaddressmodeshl22:
           ; check if value or cl is valid 
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz checkforbiddendigitaddressshl22 
            jnz checkforbiddenregsiteraddressshl22
            checkforbiddendigitaddressshl22:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player1_Data_Register[bx]
                mov Player2_Data_Register[bx],ah
 
                ; call macro that check if value in ax is correct
                check_byte_valid ah, Forbidden_digits_2 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1
                jz  forbiddenaddressshlplayer2
                jmp finaladdressmodeshl2
                forbiddenaddressshlplayer2:
                jmp far ptr endshladdressplayer2  
            
            checkforbiddenregsiteraddressshl22:        
                
                cmp bl,7
                jnz losepointnotaddressclp2
                check_forbidden Forbidden_Registers_2,bl                 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1
                ;jz  lose_point_player1   
                jz tempendshladdressplayer2   ; -> jump far here
                jmp  finaladdressmodeshl2
                tempendshladdressplayer2:
                jmp far ptr endshladdressplayer2
                jmp finaladdressmodeshl2
                 losepointnotaddressclp2:
                 jmp far ptr losepointshladdressplayer2
            finaladdressmodeshl2:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,Player1_Data_Register[bx]
                    mov cl,Player1_Data_Register[bx+1]
                    mov si,cx 
                    mov bl, dest_index_val  
                    mov cl, Player1_Data_Register[bx]
                    mov ch,0            
                    
                    cmp player_turn2,1              ;-> player1 turn 
                    jz player22shladdressbyteturn
                    jmp player22shladdressbytenoturn 
                    player22shladdressbyteturn:       
                            cmp instruction_index,10
                            jz shladdressbyteplayer22
                            cmp instruction_index,9
                            jz shraddressbyteplayer22
                            cmp instruction_index,11
                            jz roraddressbyteplayer22 
                            cmp instruction_index,12
                            jz roladdressbyteplayer22
                            cmp instruction_index,8
                            jz saladdressbyteplayer22
                            cmp instruction_index,13
                            jz saraddressbyteplayer22
                            shladdressbyteplayer22:                  ; div ------------------------
                                shl data_segment_1[si],cl
                                jmp far ptr player22shladdressbytenoturn
                            shraddressbyteplayer22:                  ; mul ------------------------
                                shr data_segment_1[si],cl
                                jmp far ptr player22shladdressbytenoturn
                            roraddressbyteplayer22:                  ; idiv ------------------------
                                ror data_segment_1[si],cl
                                jmp far ptr player22shladdressbytenoturn 
                            roladdressbyteplayer22:                  ; imul ------------------------
                                rol data_segment_1[si],cl
                                jmp far ptr player22shladdressbytenoturn
                            saladdressbyteplayer22:                  ; inc ------------------------
                                sal data_segment_1[si],cl
                                jmp far ptr player22shladdressbytenoturn
                            saraddressbyteplayer22:                  ; dec ------------------------
                                sar data_segment_1[si],cl
                                jmp far ptr player22shladdressbytenoturn  
                    player22shladdressbytenoturn:
                        cmp player_turn1,1
                        jz player11shladdressbyteturn
                        jmp far ptr endshladdressplayer2
                        player11shladdressbyteturn:     
                            
                            mov bl,src_index_val
                            mov ch,Player2_Data_Register[bx]
                            mov cl,Player2_Data_Register[bx+1]
                            mov si,cx 
                            mov bl, dest_index_val  
                            mov cl, Player2_Data_Register[bx]
                            mov ch,0                            
                            cmp instruction_index,10
                            jz shladdressbyteplayer11
                            cmp instruction_index,9
                            jz shraddressbyteplayer11
                            cmp instruction_index,11
                            jz roraddressbyteplayer11 
                            cmp instruction_index,12
                            jz roladdressbyteplayer11
                            cmp instruction_index,8
                            jz saladdressbyteplayer11
                            cmp instruction_index,13
                            jz saraddressbyteplayer11
                            shladdressbyteplayer11:                  ; div ------------------------
                                shl data_segment_2[si],cl
                                jmp far ptr endshladdressplayer2
                            shraddressbyteplayer11:                  ; mul ------------------------
                                shr data_segment_2[si],cl
                                jmp far ptr endshladdressplayer2
                            roraddressbyteplayer11:                  ; idiv ------------------------
                                ror data_segment_2[si],cl
                                jmp far ptr endshladdressplayer2 
                            roladdressbyteplayer11:                  ; imul ------------------------
                                rol data_segment_2[si],cl
                                jmp far ptr endshladdressplayer2
                            saladdressbyteplayer11:                  ; inc ------------------------
                                sal data_segment_2[si],cl
                                jmp far ptr endshladdressplayer2
                            saraddressbyteplayer11:                  ; dec ------------------------
                                sar data_segment_2[si],cl
                                jmp far ptr endshladdressplayer2  

            
              
    losepointshladdressplayer2:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0
    
    endshladdressplayer2:
    
    ret
    shlshrrorroladdressplayer2 endp 

change_src_dest proc near      
    mov al, src_index_reg
    mov bl, dest_index_reg
    mov src_index_reg,bl
    mov dest_index_reg,al 
    
    mov al, src_index_val
    mov bl, dest_index_val
    mov src_index_val,bl
    mov dest_index_val,al  
    ret
    change_src_dest endp     
    
;----------------------------shl  reg ---------------------------------------------------

    END MAIN

