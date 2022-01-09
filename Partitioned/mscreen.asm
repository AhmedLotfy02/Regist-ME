.model small
.stack 64
.data

p1_button_F1_F2_ESC db 8
p2_button_F1_F2_ESC db 7
chat_invitation db    'you sent Chat invitation to ','$'
game_invitation db    'you sent Game invitation to ','$'
end_mes db 'end game $'
chat_invitation2 db    ' sent Chat invitation to you ','$'
game_invitation2 db    ' sent Game invitation to you','$' 

V_S_R db 0
not_r db 0
check_buffer_status db 0
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
        LEVEL2MESS db "Enter Initial Values for Your Registers$"
        winmess db 'THE WINNER IS: $'
        DESTORSRC DB 0    ;      0----->DEST  , 1------>SRC
    power3_player1_used db 0
    power3_player2_used db 0
    INITIALVALUE DW ? 
    TEMP DB ?  

    power5_player1_used db 0
    power5_player2_used db 0
        ; player1 Data variables -----------------------------------------------------------------------------------
            Forbidden_digits_1 db '0000000000000000'
            Forbidden_Registers_1 db '0000000000000000'
            Forbidden_instruction_1 db '0000000000000000' 
            player1_mess db "Player 1 data$"
            levelMessage db "Enter the level (1 or 2): $"
            player1_name db 15 , ?, 15 dup("$"),'$'
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
            player2_name db 15 , ?, 15 dup("$"),'$'
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
            XOR_INS DB 'MUL','$'
            AND_INS DB 'SAL','$'
            OR_INS DB 'SAR','$'
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
    enterMemAdress db 'Enter an address','$' 
    enterValue db 'Enter a value', '$' 
    enterNewGoal db "Enter new Goal$"
    ERROR_MESSAGE DB'ERROR','$'
    X_POWER_UP_3_TEMP db 'L'
    VALUE_COORDINATES DW 130,90,170,190
    REG_COORDINATES DW 210,90,250,190
    inputValueString db 5, ?, 5 dup('$')   
    inputValueSize db ?
    NUMBER DW ?
    player_turn db 1   ; player1-> 1 , player2-> 2 
    player_turn1 db 1   ; power up 2
    player_turn2 db 1   ; power up 2 
    win_player1 db 0
    win_player2 db 0   
    Initial_PL1 db 'I1:','$'
    Initial_PL2 db 'I2:','$'
    For1 db 'F1:','$'
    For2 db 'F2:','$'
    GOAL_VAR db 'GOAL:',"$"
    target dw 105eh
    NEWFORBIDDEN_MSG DB 'PLEASE ENTER NEW FORBIDDEN CHAR','$'
    P6_VAR DB 'P6'
    is_changed_p1 db 0 
    is_changed_p2 db 0
    is_changed db 0

    changed_target dw 1111h 
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
        P1CORDINATES dw 315,480,345,520
        P2CORDINATES DW 315,540,345,580
        P3CORDINATES DW 360,480,385,520
        P5CORDINATES DW 360,540,385,580
        P6CORDINATES DW 360,594,385,630

        ;DrawRec 360,594,385,630

    ;start game messages
        message1 db 'to start game prress f1$'
        message2 db 'to start chat prress f2$'
        message3 db 'to end game prress esc$'        ;;;;


.code

include macros.inc
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

main proc far
    
    mov ax,@data
    mov ds,ax
    mov es,ax
    

    call intialize
    ;bbbb:
        mov al, 03
        mov ah, 0
        int 10h
        ClearScreen 0,0,79,24
        call player1Screen

        ClearScreen 0,0,79,24

        call check_R_Buffer
        cmp check_buffer_status , 1
        jz receive_then_send
        call send_name_player2
        call read_name_player2
        ;call send_name_player2
        jmp bbbb
        receive_then_send:
        mov V_S_R,3dh
        call send_name_points
        call read_name_player2
        call send_name_player2
        ;call read_name_player2

        ;jmp bbbb
        ;cmp not_r,1
        ;jz send_again
        ;jmp bbbb
        ;send_again:
        call send_name_player2
        ;call read_name_player2
        ;call send_receive_name
        
    bbbb:
    ;Print_Msg player1_mess
    ;call send_name_player2
    ;call read_name_player2
    setTextCursor 35, 6
    Print_Msg player2_name[2]
    ;DisplayChar  0,0 ,player2_name[2]
    ;DisplayChar  1,0 ,player2_name[3]
    ;DisplayChar  2,0 ,player2_name[4]
    ;DisplayChar  3,0 ,player2_name[5]

    
    ;call beginGame

    ;jmp bbbb

    call check_R_Buffer
    cmp check_buffer_status , 1
    jnz Empty_buffer_here
    jmp noEmpty_buffer_here
    Empty_buffer_here:
    call receive_name_points
    noEmpty_buffer_here:
    
    mov V_S_R,0
;-------------------------------------------  call main screen ---------------------------------------------------
    
    ClearScreen 0,0,79,24
    call main_choose
    
    game_logic:
        ClearScreen 0,0,79,24
        ;Print_Msg player2_name[2]

        ; if 1 -> my turn 0 -> other player
        cmp player_turn,1
        jz i_start
        jmp he_start
        i_start:
        call player1_forbidden_screen
        mov al, forbidden_char2
        mov V_S_R,al 
        call send_name_points
        mov al, selected_level
        mov V_S_R,al 
        call send_name_points
        call receive_name_points
        mov al,V_S_R
        mov Forbidden_char1,al
        jmp to_begin_game
        jmp game_logic
        he_start:   
        call receive_name_points
        mov al,V_S_R
        mov Forbidden_char1,al
        call receive_name_points
        mov al,V_S_R
        mov selected_level,al
        call  player2_forbidden_screen
        mov al,forbidden_char2
        mov V_S_R,al
        call send_name_points
    jmp to_begin_game
    jmp game_logic

to_begin_game:
        ClearScreen 0,0,79,24

jmp to_begin_game
    ;---------------------------------------------------------chat assad code 
    chat_logic:
        ;ClearScreen 0,0,79,24
         Print_Msg player1_name[2]

    jmp chat_logic

    end_game_finihsed:
        ClearScreen 0,0,79,24
        ;print end_mes
    jmp end_game_finihsed

    main endp

;;;;; main screen serial choice

main_choose proc near
;------------ draw first ---------------------
        ;call CLR
        ClearScreen 0,0,79,24
        movCursor 25,7
        print message1 
        movCursor 25,12
        print message2
        movCursor 25,17
        print message3

;---------- take button click and send it 

start_m_Chat_game:
        mov ah,1
        int 16h 
        jz to_receive_pressed_button
        jmp to_not_receive_pressed_button
        to_receive_pressed_button:
        jmp far ptr receive_pressed_button
        to_not_receive_pressed_button:
        mov ah,0
        int 16H
        
        mov V_S_R,ah
        ;call send_name_points
        
        call send_without_wait
        mov p1_button_F1_F2_ESC,ah
        cmp ah,1
        jne not_ESC
        DisplayChar 3,3,'E'
        jmp far ptr Send_end_game
        not_ESC:
        cmp ah,59
        jne notf1
        DisplayChar 3,3,'G'
        jmp far ptr game_clicked
        notf1:
        cmp ah,60
        jne  start_m_Chat_game ; or receive ?!
        DisplayChar 3,3,'C'
        jmp chat_clicked
        ;jmp far ptr loo

chat_clicked:

movCursor 0,22
print chat_invitation
print player2_name[2] 
mov al,p2_button_F1_F2_ESC
cmp p1_button_F1_F2_ESC,al
jz now2_chat_begin
jmp receive_pressed_button
now2_chat_begin:
    ClearScreen 0,0,79,24
jmp far ptr chat_logic

game_clicked:
movCursor 0,22
print game_invitation 
print player2_name[2] 

mov al,p2_button_F1_F2_ESC
cmp p1_button_F1_F2_ESC,al

jz now2_game_begin
jmp receive_pressed_button
now2_game_begin:
    ClearScreen 0,0,79,24
    mov player_turn ,0
jmp far ptr game_logic



; receive_without_wait-------------------------------------------------------------------------------------

receive_pressed_button:

        call receive_without_wait
        mov al, V_S_R
        mov p2_button_F1_F2_ESC,al
        DisplayChar 30,0,ah

; check if esc so that end
        cmp p2_button_F1_F2_ESC ,1
        jz yes_esc
        jmp not_Send_end_game
        ;jz Send_end_game
        yes_esc:
        jmp far ptr end_game_finihsed
        not_Send_end_game:

; check game or not 
        cmp p2_button_F1_F2_ESC,59
        jz yes_game_from2
        jmp check_chat_from2
        yes_game_from2:
                movCursor 0,24
                print player2_name[2]
                movCursor 16,24
                print game_invitation2 
                jmp far ptr check_if_equal



; check chat or not 
check_chat_from2:
        cmp p2_button_F1_F2_ESC,60
        jz yes_chat_from2
        jmp far ptr check_if_equal
        yes_chat_from2:
                movCursor 0,24
                print player2_name[2]
                movCursor 16,24
                print chat_invitation2 


; check if equal ----------------------------------------------------
check_if_equal:
        mov al, p1_button_F1_F2_ESC
        cmp p2_button_F1_F2_ESC,al

        jz chat_or_game_or_esc
        jmp far ptr start_m_Chat_game
        chat_or_game_or_esc:

        cmp p2_button_F1_F2_ESC ,59
        jz now_game_begin 
        jmp far ptr start_m_Chat_game
        now_game_begin:
            ClearScreen 0,0,79,24
            mov player_turn ,1
        jmp far ptr game_logic

        cmp p2_button_F1_F2_ESC ,60
        jz now_chat_begin 
        jmp far ptr start_m_Chat_game
        now_chat_begin:
            ClearScreen 0,0,79,24
        jmp far ptr chat_logic

Send_end_game:
;-------------------- send here and end
print end_mes
jmp far ptr end_game_finihsed

ret
main_choose endp




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
        ;Print_Msg press
        ;CALL GetEnterKeyPressed

        ret
    player1Screen endp

intialize proc near


mov dx,3fbh 			
mov al,10000000b		
out dx,al				

mov dx,3f8h			
mov al,0ch			
out dx,al

mov dx,3f9h
mov al,00h
out dx,al

mov dx,3fbh
mov al,00011011b

out dx,al


ret

intialize ENDp

send_name_points proc near

		mov dx , 3FDH		
AGAIN_name_points:  	In al , dx 			
  		test al , 00100000b
  		JZ AGAIN_name_points    
        DisplayChar  1,0 ,'a'                           
        ;jmp AGAIN_name_points
  		mov dx , 3F8H		
  		mov  al,V_S_R
  		out dx , al

ret
send_name_points endp


send_without_wait proc near

		mov dx , 3FDH		
        In al , dx 			
  		test al , 00100000b
  		JZ AGAIN_without_no   
        jmp AGAIN_without
        AGAIN_without_no:
          jmp far ptr receive_pressed_button 
        AGAIN_without:
        DisplayChar  1,0 ,'a'                           
        ;jmp AGAIN_name_points
  		mov dx , 3F8H		
  		mov  al,V_S_R
  		out dx , al

ret
send_without_wait endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;------ check line status
check_R_Buffer proc near

    mov dx , 3FDH
    in al , dx
    test al , 1
    jz Empty_buffer
    mov check_buffer_status,0
    DisplayChar  8,0 ,'0'
    jmp end_check_status
    Empty_buffer:
    mov check_buffer_status,1
    DisplayChar  8,0 ,'1'
    
end_check_status:

ret
check_R_Buffer endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;------------------ receive without wait and jump to start_m_Chat_game
receive_without_wait proc near

    mov dx , 3FDH
    in al , dx
    test al , 1
    JZ to_send_temp2
    jmp con_rec
    to_send_temp2:
    DisplayChar 25,0,'N'
    jmp far ptr start_m_Chat_game
    ; jump to 
con_rec:
    mov dx , 03F8H
    in al , dx
    mov V_S_R , al
    DisplayChar 28,0,'Y'
    ret
    receive_without_wait endp
;;;;;;;;;;;;;;;;;;;;;;;;;;; receive_name_points and wait 
receive_name_points proc near
    
    mov dx , 3FDH
    CHK3: in al , dx
    test al , 1
    jz CHK3
    JZ to_send_temp
    jmp looo
    to_send_temp:
    ;jmp far ptr to_send
looo:
    mov dx , 03F8H
    in al , dx
    mov V_S_R , al
    mov not_r,1
    ret
    receive_name_points endp



send_receive_name proc near

        mov cl,player1_name[1]
        mov si ,2
        mov di ,2
    lopon_name_r:


        call receive_name_points
        mov al,V_S_R
        mov player2_name[di],al
        DisplayChar  1,0 ,player2_name[di]
        inc di
        cmp di,17
        jz end_S_R_name
        ;jz to_send
    jmp lopon_name_r

to_send:
        
; comment -> send a character 
        
        lopon_name:

        mov al, player1_name[si]
        mov V_S_R,al

        call send_name_points
        ;DisplayChar  2,0 ,V_S_R
        inc si
        cmp si,17
        jz end_S_R_name
        jmp lopon_name


end_S_R_name:

ret
send_receive_name endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

read_name_player2 proc near

    mov si ,2
    loopon_name_r:

    call receive_name_points
        cmp V_S_R,1ch
        jz cont_points
        cmp V_S_R,3dh
        jz loopon_name_r
        mov al,V_S_R
        mov player2_name[si],al
        inc si
    jmp loopon_name_r



    cont_points:
        call receive_name_points
        mov al,V_S_R
        mov intial_points_player2,al

ret
read_name_player2 endp

send_name_player2 proc near


        mov cl,player1_name[1]
        mov si ,2

        loopon_name:
        mov al, player1_name[si]
        mov V_S_R,al

        call send_name_points
        inc si
        dec cx
        jnz loopon_name

        mov V_S_R, 1ch
        call send_name_points

        mov al,intial_points_player1
        mov V_S_R, al
        call send_name_points

ret
send_name_player2 endp

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
        readChar forbidden_char2
        DisplayChar 25, 11,forbidden_char2

        setTextCursor 20, 13
        Print_Msg press
        CALL GetEnterKeyPressed

        ret
    player2_forbidden_screen endp

end main