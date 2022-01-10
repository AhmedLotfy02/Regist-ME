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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

            rightShield db 23,5,40
    db 23,6,40,24,6,40
    db 23,7,40,25,7,40
    db 23,8,40,24,8,40,25,8,40
    db 24,9,40,25,9,40,26,9,40
    db 24,10,40,25,10,40,26,10,40,28,10,40
    db 23,11,40,24,11,40,27,11,40,28,11,40
    db 23,12,40,24,12,40,25,12,40,26,12,40,27,12,40,28,12,40,29,12,40
    db 22,13,40,23,13,40,24,13,40,26,13,40,27,13,40,28,13,40,29,13,40
    db 23,14,40,24,14,40,26,14,40,28,14,40,29,14,40
    db 23,15,40,24,15,40,25,15,40,27,15,40,28,15,40,29,15,40
    db 23,16,40,24,16,40,25,16,40,26,16,40,27,16,40,28,16,40
    db 24,17,40,25,17,40,26,17,40,27,17,40,28,17,40
    db 24,18,40,25,18,40,26,18,40,27,18,40,28,18,40
    db 24,19,40,25,19,40,26,19,40,27,19,40,28,19,40
    db 24,20,40,25,20,40,26,20,40,27,20,40,28,20,40
    db 24,21,40,25,21,40,26,21,40,27,21,40,28,21,40
    db 24,22,40,25,22,40,26,22,40,27,22,40,28,22,40
    db 24,23,40,25,23,40,26,23,40,27,23,40,28,23,40
    db 24,24,40,25,24,40,26,24,40,27,24,40,28,24,40
    db 24,25,40,25,25,40,26,25,40,27,25,40,28,25,40
    db 24,26,40,25,26,40,26,26,40,27,26,40,28,26,40
    db 24,27,40,25,27,40,26,27,40,27,27,40,28,27,40
    db 24,28,40,25,28,40,26,28,40,27,28,40,28,28,40
    db 24,29,40,25,29,40,26,29,40,27,29,40,28,29,40
    db 24,30,40,25,30,40,26,30,40,27,30,40,28,30,40
    db 24,31,40,25,31,40,26,31,40,27,31,40,28,31,40
    db 24,32,40,25,32,40,26,32,40,27,32,40,28,32,40
    db 24,33,40,25,33,40,26,33,40,27,33,40,28,33,40
    db 24,34,40,25,34,40,26,34,40,27,34,40,28,34,40
    db 24,35,40,25,35,40,26,35,40,27,35,40,28,35,40
    db 24,36,40,25,36,40,26,36,40,27,36,40,28,36,40
    db 24,37,40,25,37,40,26,37,40,27,37,40,28,37,40
    db 24,38,40,25,38,40,26,38,40,27,38,40,28,38,40
    db 24,39,40,25,39,40,26,39,40,27,39,40,28,39,40
    db 24,40,40,25,40,40,26,40,40,27,40,40,28,40,40
    db 24,41,40,25,41,40,26,41,40,27,41,40,28,41,40
    db 24,42,40,25,42,40,26,42,40,27,42,40,28,42,40
    db 24,43,40,25,43,40,26,43,40,27,43,40,28,43,40
    db 24,44,40,25,44,40,26,44,40,27,44,40,28,44,40
    db 23,45,40,24,45,40,25,45,40,26,45,40,27,45,40,28,45,40
    db 23,46,40,24,46,40,25,46,40,26,46,40,27,46,40,28,46,40
    db 23,47,40,24,47,40,25,47,40,26,47,40,28,47,40,29,47,40
    db 22,48,40,23,48,40,24,48,40,26,48,40,28,48,40,29,48,40
    db 22,49,40,23,49,40,24,49,40,26,49,40,27,49,40,28,49,40,29,49,40
    db 23,50,40,24,50,40,25,50,40,27,50,40,28,50,40,29,50,40
    db 23,51,40,24,51,40,26,51,40,27,51,40,28,51,40
    db 24,52,40,25,52,40,26,52,40
    db 24,53,40,25,53,40,26,53,40
    db 23,54,40,25,54,40,26,54,40
    db 23,55,40,24,55,40,25,55,40
    db 23,56,40
    db 23,57,4
    rightShieldSize dw 60 
    RightP_height dw 50
    RightP_Width dw 21
     Pr_x dw 200
     Pr_y dw 150     
     shooter db 24,2,27,25,2,27,23,3,27,24,3,44,25,3,44,26,3,28,23,4,43,24,4,44,25
    db 4,44,26,4,66,22,5,28,23,5,44,24,5,44,25,5,44,26,5,44,27,5,28,21
   db 6,0,22,6,66,23,6,44,24,6,44,25,6,44,26,6,44,27,6,66,15,7,0,16,7,0,21,7,0,22,7,43,23,7,44,24,7,44,25,7,44
db 26,7,44,27,7,43,28,7,0,14,8,30,15,8,27,16,8,27,17,8,30,21,8,29,22,8,43,23,8,44,24,8,44,25,8,44
db 26,8,44,27,8,43,28,8,29,32,8,30,33,8,27,34,8,27,12,9,0,13,9,0,14,9,27,15,9,44,16,9,44,17,9,27,18
db 9,0,19,9,0,20,9,0,21,9,27,22,9,44,23,9,44
db 24,9,44,25,9,44,26,9,44,27,9,44,28,9,28,29,9,0,30,9,0,31,9,0,32,9,27,33,9,44,34,9,44,35,9,27
db 11,10,30,12,10,7,13,10,27,14,10,43,15,10,43,16,10,43,17,10,43,18,10,66,19,10,27,20,10,28,21,10,7
db 22,10,7,23,10,44,24,10,43,25,10,43,26,10,44,27,10,7,28,10,7
db 29,10,28,30,10,27,31,10,66,32,10,43,33,10,43,34,10,43,35,10,43,36,10,27,37,10,7,11
db 11,28,12,11,44,13,11,44,14,11,44,15,11,44,16,11,44,17,11,44,18,11,44,19

db 11,43,20,11,43,21,11,44,22,11,43,23,11,43,24,11,7,25,11,140,26,11,43,27,11
db 43,28,11,44,29,11,43,30,11,43,31,11,44
db 32,11,44,33,11,44,34,11,44,35,11,44,36,11,44,37,11,44,11,12,28,12,12,44,13
db 12,44,14,12,44,15,12,44,16,12,44,17,12,44,18,12,44,19,12,43,20,12,43,21,12,44,22
db 12,43,23,12,140,24,12,43,25,12,43,26,12,140,27,12,43,28,12,44,29,12,43,30,12,44
db 31,12,44,32,12,44,33,12,44,34,12,44
db 35,12,44,36,12,44,37,12,44,11,13,28,12,13,44,13,13,44,14,13,44,15,13,44,16
db 13,44,17,13,44,18,13,44,19,13,44,20,13,43,21,13,43,22,13,140,23,13,43,24,13,43
db 25,13,43,26,13,43,27,13,140,28,13,43,29,13,43,30,13,44,31,13,44,32,13,44,33
db 13,44,34,13,44,35,13,44,36,13,44,37,13,44
db 11,14,28,12,14,44,13,14,44,14,14,44,15,14,44,16,14,44,17,14,44,18,14,44,19
db 14,44,20,14,43,21,14,43,22,14,43,23,14,43,24,14,44,25,14,44,26,14,43,27,14
db 43,28,14,43,29,14,43,30,14,44,31,14,44,32,14,44,33,14,44,34,14,44,35,14,44,36
db 14,44,37,14,44,11,15,28,12,15,44,13,15,44
db 14,15,44,15,15,44,16,15,44,17,15,44,18,15,44,19,15,43,20,15,43,21,15,7,22
db 15,43,23,15,43,24,15,44,25,15,44,26,15,43,27,15,43,28,15,7,29,15,7,30,15,44,31,15
db 44,32,15,44,33,15,44,34,15,44,35,15,44,36,15,44,37,15,44,11,16
db 29,12,16,44,13,16,44,14,16,44,15,16,44,16,16,44
db 17,16,44,18,16,44,19,16,43,20,16,7,21,16,43,22,16,43,23,16,44,24,16,44,25

db 16,44,26,16,44,27,16,43,28,16,43,29,16,7,30,16,43,31,16,44,32,16,44,33,16,44,34,16
db 44,35,16,44,36,16,44,37,16,43,38,16,29,12,17,27,13,17,27,14,17,25,15,17,43,16
db 17,43,17,17,25,18,17,27,19,17,28
db 20,17,66,21,17,43,22,17,43,23,17,44,24,17,44,25,17,44,26,17,44,27,17,43,28
db 17,43,29,17,66,30,17,28,31,17,27,32,17,25,33,17,43,34,17,43,35,17,25,36
db 17,27,37,17,27,13,18,0,14,18,28,15,18,66,16,18,66,17,18,28,19,18,0,20,18,66
db 21,18,43,22,18,43,23,18,44,24,18,44,25,18,44
db 26,18,44,27,18,43,28,18,43,29,18,66,30,18,0,32,18,28,33,18,66,34,18,66,35
db 18,28,36,18,0,15,19,0,16,19,0,19,19,0,20,19,43,21,19,43,22,19,43,23,19,44
db 24,19,44,25,19,44,26,19,44,27,19,43,28,19,43,29,19,66,30,19,0,33,19,0,34
db 19,0,19,20,0,20,20,43,21,20,43,22,20,43
db 23,20,44,24,20,44,25,20,44,26,20,44,27,20,43,28,20,43,29,20,43,30,20,0
db 19,21,30,20,21,43,21,21,43,22,21,43,23,21,44,24,21,44,25,21,44,26,21,44,27
db 21,43,28,21,43,29,21,43,30,21,30,19,22,29,20,22,43,21,22,43,22,22,43,23,22
db 44,24,22,44,25,22,44,26,22,44,27,22,43,28,22,43
db 29,22,43,30,22,30,17,23,30,18,23,28,19,23,7,20,23,43,21,23,140,22,23
db 140,23,23,43,24,23,43,25,23,43,26,23,43,27,23,140,28,23,140,29,23,43,30,23,7
db 31,23,28,32,23,30,16,24,0,17,24,27,18,24,44,19,24,44,20,24,44,21,24,43,22
db 24,44,23,24,44,24,24,44,25,24,44,26,24,44,27,24,44
db 28,24,43,29,24,44,30,24,44,31,24,44,32,24,27,33,24,0,16,25,30,17,25
db 43,18,25,44,19,25,44,20,25,44,21,25,43,22,25,44,23,25,44,24,25,43,25,25
db 43,26,25,44,27,25,44,28,25,43,29,25,44,30,25,44,31,25,44,32,25,43,33,25
db 30,16,26,28,17,26,44,18,26,44,19,26,44,20,26,44,21,26,43
db 22,26,44,23,26,44,24,26,43,25,26,43,26,26,44,27,26,44,28,26,43,29,26
db 44,30,26,44,31,26,44,32,26,44,33,26,28,16,27,27,17,27,44,18,27,44,19,27
db 44,20,27,44,21,27,43,22,27,44,23,27,44,24,27,43,25,27,43,26,27,44,27,27
db 43,28,27,43,29,27,44,30,27,44,31,27,44,32,27,44,33,27,27
db 11,28,29,12,28,29,16,28,27,17,28,44,18,28,44,19,28,44,20,28,44,21,28
db 44,22,28,43,23,28,44,24,28,43,25,28,43,26,28,44,27,28,43,28,28,44,29
db 28,44,30,28,44,31,28,44,32,28,44,33,28,27,37,28,29,38,28,29,10,29,28,11
db 29,43,12,29,43,13,29,29,16,29,27,17,29,44,18,29,44,19,29,44
db 20,29,44,21,29,44,22,29,43,23,29,44,24,29,43,25,29,43,26,29,44,27,29
db 43,28,29,44,29,29,44,30,29,44,31,29,44,32,29,44,33,29,27,36,29,28,37,29,43
db 38,29,43,39,29,28,8,30,27,9,30,27,10,30,25,11,30,43,12,30,43,13,30,25
db 14,30,27,15,30,28,16,30,28,17,30,44,18,30,44,19,30,44
db 20,30,44,21,30,44,22,30,43,23,30,43,24,30,7,25,30,7,26,30,43,27,30,43
db 28,30,44,29,30,44,30,30,44,31,30,44,32,30,44,33,30,29,34,30,28,35,30
db 27,36,30,25,37,30,43,38,30,43,39,30,25,40,30,27,41,30,27,7,31,29,8,31
db 43,9,31,44,10,31,44,11,31,43,12,31,43,13,31,44,14,31,44
db 15,31,43,16,31,30,17,31,43,18,31,44,19,31,44,20,31,44,21,31,43,22,31
db 43,23,31,43,24,31,43,25,31,27,26,31,43,27,31,43,28,31,43,29,31,44,30
db 31,44,31,31,44,32,31,66,33,31,30,34,31,43,35,31,44,36,31,44,37,31,43,38,31,43,39,31,44,40,31,44,41,31,43,42,31,29,7,32,28,8,32,44
db 9,32,44,10,32,44,11,32,43,12,32,43,13,32,44,14,32,44,15,32,43,16,32,29
db 17,32,27,18,32,43,19,32,43,20,32,43,21,32,44,22,32,44,23,32,43,24,32,43
db 25,32,43,26,32,43,27,32,44,28,32,44,29,32,43,30,32,43,31,32,43,32,32,28,33,32,29,34,32,43,35,32,44,36,32,44,37,32,43,38,32,43
db 39,32,44,40,32,44,41,32,44,42,32,28,7,33,28,8,33,44,9,33,44,10,33,44,11
db 33,43,12,33,43,13,33,44,14,33,44,15,33,44,16,33,25,17,33,66,18,33,44,19,33,44
db 20,33,44,21,33,44,22,33,44,23,33,43,24,33,43,25,33,43,26,33,43,27,33,44,28,33,44,29,33,44,30,33,44,31,33,44,32,33,66
db 33,33,25,34,33,44,35,33,44,36,33,44,37,33,43,38,33,43,39,33,44,40,33,44,41
db 33,44,42,33,28,7,34,28,8,34,44,9,34,44,10,34,44,11,34,43,12,34,43,13,34,44,14
db 34,43,15,34,43,16,34,44,17,34,44,18,34,44,19,34,44,20,34,44,21,34,44,22,34,44,23,34,43,24,34,43,25,34,43,26,34,43
db 27,34,44,28,34,44,29,34,44,30,34,44,31,34,44,32,34,44,33,34,44,34,34,43,35
db 34,43,36,34,44,37,34,43,38,34,43,39,34,44,40,34,44,41,34,44,42,34,28,7,35,28,8
db 35,44,9,35,44,10,35,44,11,35,140,12,35,140,13,35,43,14,35,44,15,35,44,16,35,44,17,35,44,18,35,44,19,35,44,20,35,44
db 21,35,44,22,35,44,23,35,43,24,35,43,25,35,43,26,35,43,27,35,44,28,35,44,29,35
db 44,30,35,44,31,35,44,32,35,44,33,35,44,34,35,44,35,35,44,36,35,43,37,35,140,38,35
db 140,39,35,44,40,35,44,41,35,44,42,35,28,8,36,43,9,36,44,10,36,140,11,36,43,12,36,164,13,36,44,14,36,44,15,36,44
db 16,36,44,17,36,44,18,36,44,19,36,44,20,36,44,21,36,44,22,36,44,23,36,43,24,36,7
db 25,36,25,26,36,43,27,36,44,28,36,44,29,36,44,30,36,44,31,36,44,32,36,44,33,36,44
db 34,36,44,35,36,44,36,36,44,37,36,140,38,36,43,39,36,140,40,36,44,41,36,43,42,36,29
db 8,37,25,9,37,43,10,37,43
db 11,37,43,12,37,25,13,37,44,14,37,44,15,37,44,16,37,44,17,37,44,18,37,44,19,37,44
db 20,37,44,21,37,44,22,37,44,23,37,44,24,37,43,25,37,43,26,37,44,27,37,44,28,37,44
db 29,37,44,30,37,44,31,37,44,32,37,44,33,37,44,34,37,44,35,37,44,36,37,44,37,37,25,38,37,43,39,37,43,40,37,43
db 41,37,25,6,38,27,7,38,43,8,38,44,9,38,44,10,38,43,11,38,43,12,38,25,13,38,44,14
db 38,44,15,38,44,16,38,44,17,38,44,18,38,44,19,38,44,20,38,44,21,38,44,22,38,44,23
db 38,44,24,38,44,25,38,44,26,38,44,27,38,44,28,38,44,29,38,44,30,38,44,31,38,44,32
db 38,44,33,38,44,34,38,44
db 35,38,44,36,38,44,37,38,25,38,38,7,39,38,43,40,38,44,41,38,44,42,38,43,43,38,27,5
db 39,27,6,39,44,7,39,44,8,39,44,9,39,44,10,39,43,11,39,27,12,39,25,13,39,44,14,39,44
db 15,39,44,16,39,44,17,39,44,18,39,44,19,39,44,20,39,44,21,39,43,22,39,66,23,39,27,24,39,27,25,39,27
db 26,39,27,27,39,66,28,39,43,29,39,44,30,39,44,31,39,44,32,39,44,33,39,44,34,39,44
db 35,39,44,36,39,44,37,39,25,38,39,7,39,39,43,40,39,44,41,39,44,42,39,44,43,39,44,44
db 39,27,5,40,28,6,40,44,7,40,44,8,40,44,9,40,44,10,40,44,11,40,43,12,40,43,13,40,44,14,40,44,15,40,44
db 16,40,43,17,40,43,18,40,66,19,40,27,20,40,28,21,40,30,22,40,0,29,40,28
db 30,40,27,31,40,66,32,40,43,33,40,43,34,40,44,35,40,44,36,40,44,37,40,43,38
db 40,43,39,40,44,40,40,44,41,40,44,42,40,44,43,40,44,44,40,28,5,41,30,6,41
db 43,7,41,44,8,41,44,9,41,44,10,41,44,11,41,44
db 12,41,43,13,41,43,14,41,66,15,41,27,16,41,29,17,41,0,18,41,0,33,41,29
db 34,41,27,35,41,66,36,41,43,37,41,43,38,41,44,39,41,44,40,41,44,41,41,44,42
db 41,44,43,41,43,6,42,43,7,42,44,8,42,44,9,42,43,10,42,66,11,42,27,12,42,29
db 13,42,0,14,42,0,37,42,29,38,42,27,39,42,66
db 40,42,43,41,42,44,42,42,44,43,42,43,5,43,0,6,43,27,7,43,27,8,43,28,9,43
db 30,10,43,0,41,43,28,42,43,27,43,43,27,6,44,0
shooterSize dw 48 
 
bullet db 14,1,66,15,1,66,14,2,65,15,2,164,13,3,89,14,3,7,15,3,136,16,3,66,13,4,67,14,4,25,15,4
db 208,16,4,24,13,5,66,14,5,25,15,5,17,16,5,24,13,6,66,14,6,164,15
db 6,17,16,6,164,13,7,65,14,7,24,15,7,17,16,7,163,13,8,65,14,8,24,15,8,209,16,8,164,17,8,65,12,9,7
db 13,9,66,14,9,164,15,9,210,16,9,164,17,9,25,12,10,24,13,10,66
db 14,10,25,15,10,18,16,10,139,17,10,25,12,11,164,13,11,65,14,11
db 25,15,11,209,16,11,140,17,11,24,12,12,27,13,12,67,14,12,164,15
db 12,17,16,12,138,17,12,27,12,13,66,13,13,67,14,13,164,15,13,18,16,13,210,17,13,24,12,14,24
db 13,14,66,14,14,25,15,14,211,16,14,137,17,14,164,12,15,24,13
db 15,66,14,15,65,15,15,211,16,15,138,17,15,164,12,16,25,13,16,66
db 14,16,65,15,16,210,16,16,137,17,16,24,12,17,164,13,17,66,14,17
db 65,15,17,211,16,17,138,17,17,164,12,18,7,13,18,66,14,18,65,15,18,211,16,18,138,17,18,25,12,19,24
db 13,19,66,14,19,65,15,19,236,16,19,138,17,19,164,12,20,25,13
db 20,66,14,20,65,15,20,212,16,20,138,17,20,25,12,21,25,13,21,66
db 14,21,65,15,21,236,16,21,138,17,21,24,12,22,164,13,22,66,14,22
db 65,15,22,137,16,22,138,17,22,24,12,23,164,13,23,66,14,23,66,15,23,137,16,23,139,17,23,25,12,24,164
db 13,24,66,14,24,65,15,24,212,16,24,139,17,24,27,12,25,27,13
db 25,65,14,25,65,15,25,137,16,25,139,17,25,7,12,26,28,13,26,65
db 14,26,6,15,26,114,16,26,164,17,26,28,13,27,30,14,27,27,15,27,7,16,27,28
BulletSize dw 30 
drawBulletOrNot db 0
BULLET_X DW 200
BULLET_Y DW 150
chicken1 db 19,0,41,20,0,41,19,1,41,20,1,41,19,2,41,20,2,4,18,3,15,19,3,66,20,3,64
db 21,3,91,18,4,27,19,4,30,20,4,15,21,4,28,22,4,160,18,5,7,19,5,22,20,5,23,21
db 5,161,22,5,28,17,6,15,18,6,15,19,6,25,20,6,25,21,6,7,22,6,15,23,6,0,16,7,15,17,7,15,18,7,67
db 19,7,43,20,7,43,21,7,65,22,7,30,23,7,30,16,8,0,17,8,90,18,8,42,19,8,6
db 20,8,6,21,8,41,22,8,12,23,8,29,24,8,29,16,9,15,17,9,42,18,9,113,19,9,112
db 20,9,184,21,9,113,22,9,6,23,9,28,24,9,29,16,10,0,17,10,29,18,10,6,19,10,41,20,10,6,21,10,6,22,10,7
db 23,10,102,24,10,28,0,11,29,1,11,30,2,11,0,3,11,15,4,11,15,5,11,15,6,11
db 15,7,11,15,16,11,28,17,11,81,18,11,7,19,11,6,20,11,41,21,11,24,22,11,80
db 23,11,28,32,11,15,33,11,15,34,11,15,35,11,15,36,11,15,37,11,0,38,11,30
db 39,11,29,0,12,28,1,12,29,2,12,30,3,12,30
db 4,12,15,5,12,15,6,12,15,7,12,15,8,12,15,9,12,15,10,12,15,17,12,7,18
db 12,80,19,12,12,20,12,41,21,12,7,22,12,28,29,12,15,30,12,15,31,12,15,32
db 12,15,33,12,15,34,12,15,35,12,15,36,12,30,37,12,30,38,12,29,39,12,28,1
db 13,28,2,13,28,3,13,28,4,13,29,5,13,29,6,13,30
db 7,13,0,8,13,15,9,13,15,10,13,15,11,13,15,12,13,15,13,13,15,18,13,78
db 19,13,12,20,13,41,21,13,25,22,13,25,26,13,15,27,13,15,28,13,15,29,13
db 15,30,13,15,31,13,15,32,13,15,33,13,30,34,13,30,35,13,29,36,13,28,37
db 13,28,38,13,28,2,14,28,3,14,27,4,14,27,5,14,27,6,14,28
db 7,14,29,8,14,30,9,14,30,10,14,0,11,14,15,12,14,15,13,14,15,14,14,15
db 15,14,15,17,14,53,18,14,53,19,14,6,20,14,41,21,14,3,22,14,3,24,14,15,25
db 14,15,26,14,15,27,14,15,28,14,15,29,14,0,30,14,30,31,14,30,32,14,29,33
db 14,28,34,14,28,35,14,27,36,14,27,37,14,28,4,15,27
db 5,15,7,6,15,7,7,15,27,8,15,27,9,15,27,10,15,28,11,15,29,12,15,30,13
db 15,0,14,15,15,15,15,15,16,15,15,17,15,77,18,15,53,19,15,25,20,15,23
db 21,15,3,22,15,3,23,15,30,24,15,15,25,15,15,26,15,15,27,15,30,28,15
db 29,29,15,28,30,15,27,31,15,27,32,15,27,33,15,7,34,15,7
db 35,15,27,0,16,30,1,16,15,2,16,15,3,16,15,4,16,15,5,16,0,6,16,29,7
db 16,29,8,16,28,9,16,28,10,16,27,11,16,27,12,16,27,13,16,27,14,16,29
db 15,16,30,16,16,102,17,16,11,18,16,101,19,16,15,20,16,0,21,16,78,22
db 16,3,23,16,78,24,16,30,25,16,29,26,16,28,27,16,27,28,16,27
db 29,16,27,30,16,28,31,16,28,32,16,29,33,16,29,34,16,30,35,16,15,36,16,15,37
db 16,15,38,16,15,39,16,30,0,17,29,1,17,29,2,17,30,3,17,30,4,17,30,5,17,0,6,17
db 15,7,17,15,8,17,15,9,17,15,10,17,0,11,17,30,12,17,29,13,17,28,14,17,7,15,17,7,16,17,53,17,17,11,18,17,101
db 19,17,77,20,17,102,21,17,0,22,17,78,23,17,3,24,17,25,25,17,27,26,17
db 28,27,17,29,28,17,30,29,17,30,30,17,15,31,17,15,32,17,15,33,17,15,34,17
db 15,35,17,30,36,17,30,37,17,30,38,17,29,39,17,29,0,18,29,1,18,28,2,18,28
db 3,18,28,4,18,28,5,18,28,6,18,28,7,18,28,8,18,29
db 9,18,29,10,18,29,11,18,30,12,18,30,13,18,30,14,18,29,15,18,11,16,18
db 11,17,18,11,18,18,11,19,18,78,20,18,78,21,18,15,22,18,78,23,18,3,24,18
db 3,25,18,28,26,18,0,27,18,30,28,18,30,29,18,29,30,18,29,31,18,29,32,18
db 28,33,18,28,34,18,28,35,18,28,36,18,28,37,18,28,38,18,28
db 39,18,29,2,19,28,3,19,27,4,19,7,5,19,7,6,19,27,7,19,28,8,19,28,9,19
db 28,10,19,28,11,19,28,12,19,28,13,19,28,14,19,78,15,19,11,16,19,11,17
db 19,11,18,19,77,19,19,77,20,19,30,21,19,101,22,19,78,23,19,3,24,19,3
db 25,19,3,26,19,28,27,19,28,28,19,28,29,19,28,30,19,28
db 31,19,28,32,19,28,33,19,27,34,19,7,35,19,7,36,19,27,37,19,28,3,20
db 30,4,20,29,5,20,29,6,20,30,7,20,0,8,20,0,9,20,0,10,20,0,11,20,0,12
db 20,30,13,20,102,14,20,53,15,20,11,16,20,11,17,20,11,18,20,102,19,20
db 15,20,20,15,21,20,78,22,20,78,23,20,3,24,20,3,25,20,3
db 26,20,7,27,20,30,28,20,0,29,20,0,30,20,0,31,20,0,32,20,0,33,20,30
db 34,20,29,35,20,29,36,20,29,1,21,28,2,21,29,3,21,30,4,21,30,5,21,30,6
db 21,30,7,21,29,8,21,29,9,21,28,10,21,27,11,21,7,12,21,7,13,21,11,14,21,11,15
db 21,11,16,21,11,17,21,11,18,21,78,19,21,78
db 20,21,102,21,21,30,22,21,78,23,21,3,24,21,3,25,21,3,26,21,3,27,21,25,28,21
db 27,29,21,27,30,21,28,31,21,29,32,21,29,33,21,30,34,21,30,35,21,30,36,21,30,37
db 21,29,38,21,28,1,22,29,2,22,29,3,22,28,4,22,28,5,22,28,6,22,27,7,22,7,8,22,25,9,22,7,10,22,27,11,22,28
db 12,22,78,13,22,53,14,22,11,15,22,11,16,22,11,17,22,11,18,22,78,19,22,78,20,22
db 103,21,22,15,22,22,3,23,22,3,24,22,3,25,22,3,26,22,3,27,22,172,28,22,28,29,22
db 27,30,22,7,31,22,25,32,22,7,33,22,27,34,22,28,35,22,28,36,22,28,37,22,29,38,22,29,3,23,29,4,23,28,5,23,27
db 6,23,7,7,23,7,8,23,28,9,23,30,10,23,0,11,23,30,12,23,77,13,23,53,14,23,11,15
db 23,11,16,23,11,17,23,77,18,23,102,19,23,78,20,23,30,21,23,30,22,23,3,23,23,3,24
db 23,3,25,23,3,26,23,3,27,23,3,28,23,29,29,23,15,30,23,30,31,23,28,32,23,27,33,23,7,34,23,27,35,23,28
db 36,23,29,5,24,29,6,24,29,7,24,30,8,24,30,9,24,29,10,24,27,11,24,25,12,24,53
db 13,24,11,14,24,11,15,24,11,16,24,78,17,24,102,18,24,0,19,24,15,20,24,30,21,24
db 78,22,24,3,23,24,3,24,24,3,25,24,3,26,24,3,27,24,3,28,24,24,29,24,88,30,24,29,31,24,30,32,24,30,33,24,30
db 34,24,29,4,25,28,5,25,29,6,25,29,7,25,28,8,25,28,9,25,27,10,25,25,11,25,79
db 12,25,11,13,25,11,14,25,78,15,25,78,16,25,78,17,25,78,18,25,3,19,25,3,20,25
db 3,21,25,3,22,25,3,23,25,3,24,25,3,25,25,3,26,25,3,27,25,3,28,25,3,29,25,25,30,25,27,31,25,28,32,25,28
db 33,25,29,34,25,29,35,25,29,4,26,29,5,26,29,6,26,29,7,26,29,8,26,28,9,26,27
db 10,26,79,11,26,53,12,26,78,13,26,78,14,26,78,15,26,78,16,26,78,17,26,78,18,26
db 3,19,26,3,20,26,3,21,26,3,22,26,3,23,26,3,24,26,3,25,26,3,26,26,3,27,26,148,28,26,3,29,26,3,30,26,7
db 31,26,28,32,26,29,33,26,29,34,26,29,35,26,29,10,27,53,11,27,78,12,27,53,13
db 27,3,14,27,3,15,27,53,16,27,53,17,27,3,18,27,3,19,27,3,20,27,3,21,27,3,22,27
db 3,23,27,3,24,27,3,25,27,148,26,27,148,27,27,148,28,27,3,29,27,3,11,28,3,12,28,3,13,28,53,14,28,3,15,28,3
db 16,28,3,17,28,3,18,28,3,19,28,3,20,28,3,21,28,148,22,28,148,23,28,148,24
db 28,148,25,28,3,26,28,3,27,28,3,28,28,3,29,28,3,12,29,78,13,29,79,14,29,3,15
db 29,3,16,29,3,17,29,3,18,29,3,19,29,25,20,29,25,21,29,3,22,29,3,23,29,3,24,29,3,25,29,3,26,29,3,27,29,7
db 12,30,15,13,30,28,14,30,7,15,30,27,16,30,78,17,30,79,18,30,79,19,30,28,20
db 30,86,21,30,78,22,30,79,23,30,79,24,30,7,25,30,7,26,30,27,27,30,29,12,31,15
db 13,31,15,14,31,28,15,31,86,16,31,86,17,31,29,18,31,29,19,31,30,20,31,29,21,31,30,22,31,29
db 23,31,29,24,31,86,25,31,28
db 26,31,27,27,31,28,13,32,30,14,32,29,15,32,28,16,32,28,17,32,29,18,32,29
db 19,32,29,20,32,29,21,32,29,22,32,29,23,32,29,24,32,28,25,32,27,26,32,27,27
db 32,28,13,33,29,14,33,27,15,33,7,16,33,27,17,33,81,18,33,28,19,33,28,20,33
db 29,21,33,28,22,33,28,23,33,80,24,33,7,25,33,7
db 26,33,27,14,34,27,15,34,42,16,34,140,17,34,7,18,34,81,19,34,28,20,34,27
db 21,34,81,22,34,81,23,34,12,24,34,6,25,34,23,10,35,42,11,35,43,14,35,43,15
db 35,42,16,35,41,17,35,140,22,35,65,23,35,42,24,35,6,25,35,6,28,35,43,29,35
db 42,10,36,42,11,36,42,12,36,6,13,36,42,14,36,42
db 15,36,6,16,36,6,17,36,42,23,36,42,24,36,42,25,36,42,26,36,42,27,36,43
db 28,36,42,29,36,42,30,36,6,9,37,6,10,37,42,11,37,42,12,37,42,13,37,6,14
db 37,42,15,37,42,16,37,6,17,37,42,23,37,42,24,37,42,25,37,42,26,37,42,27
db 37,42,28,37,41,29,37,42,30,37,6,9,38,42,10,38,42
db 11,38,42,12,38,42,13,38,6,14,38,6,15,38,42,16,38,42,17,38,42,22,38
db 43,23,38,42,24,38,42,25,38,42,26,38,6,27,38,42,28,38,42,29,38,42,30
db 38,6,11,39,42,12,39,6,13,39,42,14,39,42,15,39,42,16,39,42,17,39,42,22
db 39,42,23,39,42,24,39,42,25,39,42,26,39,42,27,39,42,28,39,42
db 29,39,42
Chicken1Size dw 40 
Chicken_X dw 10
Chicken_Y dw 10 
insideChick1 db '1'
insideChick2 db '2'
insideChick3 db '3'
DoneShotting db 0
CHICK1orCHICK2 db 0
CHICK1_COUNTER db 0
CHICK2_COUNTER db 0
CHICK1_LorR db 0
CHICK2_LorR db 0
GAMECOUNTER DB 0

.code

DISPLAY_2_DIGITS    MACRO   NUMBER
        pusha
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
        popa
    ENDM




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
    
    
   readValue  proc far
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

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BEGIN_GAME proc near
        CALL SHOW_INSTRUCTION_BUTTON
        CALL SHOW_POWER_UP
        CALL FIXED
        ret
    BEGIN_GAME endp

     BEGIN_GAME_LEVEL_TWO proc far
    CALL SHOW_INSTRUCTION_BUTTON
    CALL SHOW_POWER_UP
    CALL FIXED_LEVEL_TWO  

    ret
    BEGIN_GAME_LEVEL_TWO endp
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


    SHOW_POWER_UP_6 PROC FAR
        movCursor 75,23
        PRINT_STRING_2DIGIT P6_VAR

        DrawRec 360,594,385,630

    RET
    SHOW_POWER_UP_6 ENDP


    ;;1,2,3,5
        SHOW_POWER_UPS_CHOICE proc near

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
FIXED_LEVEL_TWO proc far
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

;;;;;;;;;;;;;;;;;;;;;;;;;;nEW LOTFY
SHOW_FORBIDDEN_CHARACTERS PROC FAR
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
POWER_UP_1_1 PROC FAR 
 
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
 
POWER_UP_2 PROC FAR  
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
 
POWER_UP_3 PROC FAR 
 

CMP PLAYERTURN,0 
JNZ SECONDPLAYER1 
cmp intial_points_player1,8
jb CONT0007
sub intial_points_player1,8

CMP power3_player1_used,1
JZ CONT0007
movCursor 5,2
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
jb CONT0007
CMP power3_player2_used,1
JZ CONT0007
sub intial_points_player2,8
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
 
POWER_UP_5 PROC FAR 
 
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
 

READGOAL PROC 
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

POWER_UP_6 PROC FAR 
 
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

CHOOSE_POWER_UP PROC FAR 
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
    jb FINISH_CHOOSING1 
    ;sub intial_points_player1,5 
    CALL POWER_UP_1_1 
    jmp FINISH_CHOOSING1 
    PLAYER2_PROC1: 
    ;CMP intial_points_player2,5 
    jb  FINISH_CHOOSING1 
    ;sub intial_points_player2,5 
    CALL POWER_UP_1_1 
    JMP FINISH_CHOOSING1 
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
        mov bl, ah
        jmp finish2
        setP1Points:
            mov bl, al
        
        finish2:
        mov intial_points_player1, bl
        mov intial_points_player2, bl
        ret 
               
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


SHOW_GOAL proc far
movCursor 51,22
Print_Msg GOAL_VAR
movCursor 56,22
push ax
mov ax,target

print2Number ah
movCursor 58,22 
print2Number al
pop ax

ret
SHOW_GOAL endp



SHOW_INITIAL_POINTS PROC FAR

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
        CMP selected_level,'1'
        JNZ LEVEL2_LABEL

        CALL BEGIN_GAME
        JMP CONT0100
        LEVEL2_LABEL:
        CALL BEGIN_GAME_LEVEL_TWO

        CONT0100:
       
        ; CALL SHOW_POWER_UPS_CHOICE
        ;  CALL SHOW_POWER_UP_6
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
        CALL CHOOSE_POWER_UP
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
    PLAYER1LEVEL2 PROC far
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

    PLAYER2LEVEL2 PROC far
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
readonedigitfromkeyboard   PROC  

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
                
                
READTWODIGITfromkeyboard PROC
           
  CALL  readonedigitfromkeyboard
    MOV BL,TEMP
  CALL  readonedigitfromkeyboard 
  MOV AL,BL
    MOV CL,10h
    MUL CL     
    ADD TEMP,AL   
    RET
READTWODIGITfromkeyboard ENDP 


READFOURDIGITFROMKEYBOARD PROC
   CALL READTWODIGITfromkeyboard       
    MOV AL,TEMP
    MOV BYTE PTR INITIALVALUE[1],AL
    MOV AL,0 
   CALL READTWODIGITfromkeyboard               
    MOV AL,TEMP
    MOV BYTE PTR INITIALVALUE[0],AL
    RET

READFOURDIGITFROMKEYBOARD ENDP
                 
winnerscreen proc
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
  
    MAIN PROC near
        MOV AX,@DATA
        MOV DS,AX
        mov ax,@data
        mov Es,ax
        ;bbbb:
        
        ; call power5_player2
        
        ; call power5_player1
        
        bbbb:
        mov al, 03
        mov ah, 0
        int 10h
        ClearScreen 0,0,79,24
        call player1Screen

        ClearScreen 0,0,79,24
        call player1_forbidden_screen

        cmp selected_level, "2"
        jnz level1Player1SC 
        
        ClearScreen 0,0,79,24
        call PLAYER1LEVEL2

        level1Player1SC:ClearScreen 0,0,79,24
        call player2Screen

        ClearScreen 0,0,79,24
        call player2_forbidden_screen
        CALL set_forbidden_player1
        CALL set_forbidden_player2
        CALL setInitialPoints
        cmp selected_level, "2"
        jnz level1Player2SC
        
        ClearScreen 0,0,79,24
        call PLAYER2LEVEL2

        
        ;  bbbb:
        
        level1Player2SC:
        call beginGame


        begin:
        ; AH=0h: Set video mode
        mov al, 12h ; Video mode number
        mov ah, 0h
        int 10h
    MAINLOOP:

        MOV AH,1
        INT 16h
        JZ CHECKOUTGAME
        MOV AH,0
        INT 16h
        cmp ah,1
        jnz CHECKOUTGAME 
        JMP FAR PTR bbbb
    CHECKOUTGAME:
     CMP GAMECOUNTER,7
        JNZ CONT109
        CALL  GAMEPROCCALL
        mov al, 12h ; Video mode number
        mov ah, 0h
        int 10h
  
        CONT109:
        INC GAMECOUNTER
       
        CALL TURN 
        MOV AL,PLAYERTURN
        NOT AL
        MOV PLAYERTURN,AL
        call Reach_target_player2
        cmp win_player1,1 
        jz endgame
        call Reach_target_player1
        cmp win_player2,1 
        jz endgame
        call zero_points_player1
        cmp win_player2,1 
        jz endgame
        call zero_points_player2
        cmp win_player1,1 
        jz endgame
    JMP MAINLOOP
    endgame:
    CALL winnerscreen
    ; call CLEAR_SCREEN
    jmp far ptr bbbb 
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
                        CMP FORBIDDEN_INSTRUCTION_1[0],'1'
                        JZ end_MOV_instruction_player1
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
                                        CMP FORBIDDEN_INSTRUCTION_1[1],'1'
            JZ endADD_instruction_player1
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
                                    CMP FORBIDDEN_INSTRUCTION_1[2],'1'
            JZ endSUB_instruction_player1
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
                                    CMP FORBIDDEN_INSTRUCTION_1[3],'1'
            JZ endMUL_instruction_player1
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
                                    CMP FORBIDDEN_INSTRUCTION_1[4],'1'
            JZ endDIV_instruction_player1        
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
                                    CMP FORBIDDEN_INSTRUCTION_1[14],'1'
            JZ endIDIV_instruction_player1          
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
                                    CMP FORBIDDEN_INSTRUCTION_1[15],'1'
            JZ endIMUL_instruction_player1
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
                                    CMP FORBIDDEN_INSTRUCTION_1[5],'1'
            JZ endINC_instruction_player1
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
                                    CMP FORBIDDEN_INSTRUCTION_1[6],'1'
            JZ endDEC_instruction_player1
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
                                    CMP FORBIDDEN_INSTRUCTION_1[13],'1'
            JZ endSAR_instruction_player1
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
                                    CMP FORBIDDEN_INSTRUCTION_1[8],'1'
            JZ endSAL_instruction_player1
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
                                    CMP FORBIDDEN_INSTRUCTION_1[9],'1'
            JZ endSHR_instruction_player1
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
                                    CMP FORBIDDEN_INSTRUCTION_1[10],'1'
            JZ endSHL_instruction_player1
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
                        CMP FORBIDDEN_INSTRUCTION_1[11],'1'
            JZ endROR_instruction_player1
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
            CMP FORBIDDEN_INSTRUCTION_1[12],'1'
            JZ endROL_instruction_player1
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
            CMP ADDRESS_MODE2,1
            JZ lose_point_player1
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
                CMP FORBIDDEN_INSTRUCTION_2[0],'1'
                    JZ endMOV_instruction_player2
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
                                CMP FORBIDDEN_INSTRUCTION_2[1],'1'
                    JZ endMOV_instruction_player2
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
                            CMP FORBIDDEN_INSTRUCTION_2[2],'1'
                    JZ endSUB_instruction_player2
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
                            CMP FORBIDDEN_INSTRUCTION_2[3],'1'
                    JZ endMUL_instruction_player2
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
                                        CMP FORBIDDEN_INSTRUCTION_2[4],'1'
                    JZ endDIV_instruction_player2
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
                                        CMP FORBIDDEN_INSTRUCTION_2[14],'1'
                    JZ endIDIV_instruction_player2
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
                                        CMP FORBIDDEN_INSTRUCTION_2[15],'1'
                    JZ endIMUL_instruction_player2
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
                                        CMP FORBIDDEN_INSTRUCTION_2[5],'1'
                    JZ endINC_instruction_player2
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
                                        CMP FORBIDDEN_INSTRUCTION_2[6],'1'
                    JZ endDEC_instruction_player2
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
                                        CMP FORBIDDEN_INSTRUCTION_2[13],'1'
                    JZ endSAR_instruction_player2
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
                                        CMP FORBIDDEN_INSTRUCTION_2[8],'1'
                    JZ endSAL_instruction_player2
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
                                        CMP FORBIDDEN_INSTRUCTION_2[9],'1'
                    JZ endSHR_instruction_player2
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
                                        CMP FORBIDDEN_INSTRUCTION_2[10],'1'
                    JZ endSHL_instruction_player2
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
                                        CMP FORBIDDEN_INSTRUCTION_2[11],'1'
                    JZ endROR_instruction_player2
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
                                        CMP FORBIDDEN_INSTRUCTION_2[12],'1'
                    JZ endROL_instruction_player2
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
            CMP ADDRESS_MODE2,1
            JZ lose2_point_player2
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
    Reach_target_player2 proc near
    
    mov ax, target
    mov si,0
    mov di,8
    mov dx,0
    loop_on_registers_2:
        
        mov ch,Player2_Data_Register[si]
        mov cl,Player2_Data_Register[si+1]
        cmp ax,cx   ; compare target and each register of player2 so that to check if player 1 wins or not
        jz reached_win_player1  
        jmp not_reached_player1
        reached_win_player1:
        mov dx,1
        mov di,1
        not_reached_player1:
        add si,2
        dec di 
        
    jnz loop_on_registers_2
    
    cmp dx,1
    ; jz                  ; player1 wins 
    ; jnz                 ; player1 doesnt win yet
    ; set variable win_player1 to 1 or 0
    jz player1_wins
    jmp continue_playing_player2 
    player1_wins:
        mov win_player1,dl
    continue_playing_player2:
    
    ret
    Reach_target_player2 endp

Reach_target_player1 proc near
    
    mov ax, target
    mov si,0
    mov di,8
    mov dx,0
    loop_on_registers_1:
        
        mov ch,Player1_Data_Register[si]
        mov cl,Player1_Data_Register[si+1]
        cmp ax,cx   ; compare target and each register of player2 so that to check if player 1 wins or not
        jz reached_win_player2  
        jmp not_reached_player2
        reached_win_player2:
        mov dx,1
        mov di,1
        not_reached_player2:
        add si,2
        dec di 
        
    jnz loop_on_registers_1
    
    cmp dx,1
    ; jz                  ; player1 wins 
    ; jnz                 ; player1 doesnt win yet
    ; set variable win_player1 to 1 or 0
    jz player2_wins
    jmp continue_playing_player1 
    player2_wins:
        mov win_player2,dl
    continue_playing_player1:
    
    ret
    Reach_target_player1 endp

zero_points_player1 proc near
    
    cmp intial_points_player1,0
    jz player1_lose_zeropoints
    jmp player1_not_lose_zeropoints
    player1_lose_zeropoints:
        mov win_player2,1
    player1_not_lose_zeropoints: 
    ret
    zero_points_player1 endp 

zero_points_player2 proc near
    
    cmp intial_points_player2,0
    jz player2_lose_zeropoints
    jmp player2_not_lose_zeropoints
    player2_lose_zeropoints:
        mov win_player1,1
    player2_not_lose_zeropoints: 
    ret
    zero_points_player2 endp
power5_player1 proc near                                             
    cmp power5_player1_used,1
    jz power5_used_by_player1
    ; check if intial points are greater than 30 so that can use power 
    cmp intial_points_player1,30
    jb not_enough_points_5_player1    
    mov cx,8
    mov si,0
    mov power5_player1_used ,1 
    sub intial_points_player1,30
    clear_registers_player1:
        mov Player1_Data_Register[si],0
                mov Player1_Data_Register[si+1],0

        add si,2  
        dec cx
    jnz clear_registers_player1
    ; cannot be executed -----------------------------
    not_enough_points_5_player1:
     
    power5_used_by_player1:
    ret
    power5_player1 endp
power5_player2 proc near                                             
    
    cmp power5_player2_used,1
    jz power5_used_by_player2
    ; check if intial points are greater than 30 so that can use power 
    cmp intial_points_player2,30
    jb not_enough_points_5_player2    
    mov cx,8
    mov si,0
    mov power5_player2_used ,1 
    sub intial_points_player2,30
    clear_registers_player2:
        mov Player2_Data_Register[si],0
        mov Player2_Data_Register[si+1],0
        add si,2  
        dec cx
    jnz clear_registers_player2
    
    ; cannot be executed -----------------------------
    not_enough_points_5_player2:
     
    power5_used_by_player2:
    ret
    power5_player2 endp

;----------------------------shl  reg ---------------------------------------------------
power6_p1 proc near
    
    mov al,is_changed_p1
    mov is_changed ,al
    call power6_both
    mov is_changed_p1,1
    
    ret 
    power6_p1 endp  
power6_p2 proc near
    
    mov al,is_changed_p2
    mov is_changed ,al
    call power6_both
    mov is_changed_p2,2
    
    ret 
    power6_p2 endp

power6_both proc near
     
    ;mov al,is_changed_p1
    ;mov is_changed ,al
    
    cmp is_changed ,1
    jz used_power6_p1
    jmp far ptr check_p2
    used_power6_p1:
    jmp far ptr end_power6
    check_p2:
    cmp is_changed ,2
    jz used_power6_p2
    jmp far ptr not_used_power6
    used_power6_p2:
    jmp far ptr end_power6
    
    not_used_power6:
    
    ; ------------ loop on all registers of player1 16 byte  ------------------
    
    
    mov cx,8
    mov si,0
    mov dx,changed_target
    p1_targetE:
               
               cmp Player1_Data_Register[si],dh
               jz  other_byte_p1
               jmp not_equal_p1
               other_byte_p1: 
               cmp Player1_Data_Register[si+1],dl
               jz end_power6
               not_equal_p1:
               add si,2
               dec cx
               jnz p1_targetE
    
        
    ; ------------ loop on all registers of player2 ------------------
    mov cx,8
    mov si,0
    p2_targetE:
               cmp Player2_Data_Register[si],dh
               jz  other_byte_p2
               jmp not_equal_p2
               other_byte_p2: 
               cmp Player2_Data_Register[si+1],dl
               jz end_power6
               not_equal_p2:
               add si,2
               dec cx
               jnz p2_targetE          
     
     jmp can_change 
     
     can_change:
     mov target,dx
     end_power6:     
     
     ret
     power6_both endp
drawShieldRight proc near
   mov ah,0ch
    mov bx, offset shooter
    whileRightShieldBeingDrawn:
       drawDynamicPixel [bx],[bx+1],[bx+2], Pr_y, Pr_x
       add bx,3
       cmp bx,offset shooterSize
    JNE whileRightShieldBeingDrawn
   ret
drawShieldRight endp
 

drawBullet proc near
   mov ah,0ch
    mov bx, offset bullet
    whileRightShieldBeingDrawn1:
     
       drawDynamicPixel [bx],[bx+1],[bx+2],BULLET_Y , BULLET_X
       add bx,3
       cmp bx,offset BulletSize
    JNE whileRightShieldBeingDrawn1
   ret
drawBullet endp
 

drawChicken1 proc near
   mov ah,0ch
    mov bx, offset chicken1
    whileRightShieldBeingDrawn2:
     
       drawDynamicPixel [bx],[bx+1],[bx+2],Chicken_Y, Chicken_X
       add bx,3
       cmp bx,offset Chicken1Size
    JNE whileRightShieldBeingDrawn2
    
   ret
drawChicken1 endp
 




MOV_LEFT PROC FAR
cmp Pr_x,2
jz end1

cmp Pr_x,3
jz end1

cmp Pr_x,4
jz end1
sub Pr_x,4
CALL CLEAR_SCREEN
CALL SHOW_DONE_SHOTTING
CALL drawShieldRight

end1:
ret
MOV_LEFT ENDP

MOV_RIGHT proc far
cmp Pr_x,260
jz end2

add Pr_x,4
CALL CLEAR_SCREEN
CALL SHOW_DONE_SHOTTING
CALL drawShieldRight
end2:
ret
MOV_RIGHT endp
MOV_UP proc far
cmp Pr_Y,22
jz end3
cmp Pr_y,21
jz end3
cmp Pr_y,20
jz end3

sub Pr_y,4
CALL CLEAR_SCREEN
CALL SHOW_DONE_SHOTTING
CALL drawShieldRight
end3:
ret
MOV_UP endp


MOV_DOWN proc far
cmp Pr_y,150
jz end4
cmp Pr_y,151
jz end4
cmp Pr_y,152
jz end4
CMP Pr_y,153
jz end4

ADD Pr_y,4
CALL CLEAR_SCREEN
CALL SHOW_DONE_SHOTTING
CALL drawShieldRight
end4:
ret
MOV_DOWN endp

DYNAMIC_BULLET PROC FAR

cmp drawBulletOrNot,1
jnz cont

cmp BULLET_Y,10
jz remove_Bullet
cmp BULLET_Y,9
jz remove_Bullet
cmp BULLET_Y,8
jz remove_Bullet

cmp BULLET_Y,7
jz remove_Bullet
cmp BULLET_Y,6
jz remove_Bullet

donotRemove:
SUB BULLET_Y,1
;CALL CLEAR_SCREEN
CALL SHOW_DONE_SHOTTING
CALL drawBullet
jmp cont



remove_Bullet:
mov drawBulletOrNot,0
;CALL CLEAR_SCREEN
CALL SHOW_DONE_SHOTTING

jmp cont

cont:

cmp drawBulletOrNot,1
jnz end0002 
mov ax,Chicken_X
cmp ax,BULLET_X
jae no
add ax,20
mov dx,BULLET_X
sub dx,10
cmp ax,dx
jb no
mov ax,0
cmp ax,BULLET_Y
jg no
mov ax,20
cmp ax,BULLET_Y
jb no
inc DoneShotting
mov drawBulletOrNot,0
no:

end0002:

RET
DYNAMIC_BULLET ENDP

SHOW_DONE_SHOTTING PROC FAR
movCursor 0,0
print2Number DoneShotting


RET
SHOW_DONE_SHOTTING ENDP


DYNAMIC_CHICK1 PROC FAR
cmp Chicken_X,260
jz ChangeDir
cmp Chicken_X,9
jz ChangeDir1
jmp cont3
ChangeDir:
mov CHICK1_LorR,1
jmp cont3
ChangeDir1:
mov CHICK1_LorR,0
cont3:
cmp CHICK1_LorR,0
jz RightMoving

LeftMoving:

sub Chicken_X,1
;CALL CLEAR_SCREEN
CALL drawChicken1
jmp cont1

RightMoving:
add Chicken_X,1
;CALL CLEAR_SCREEN
CALL drawChicken1

cont1:
RET
DYNAMIC_CHICK1 ENDP

GAMEPROCCALL PROC FAR
   mov al, 13h ; Video mode number
     mov ah, 0h
    int 10h




;CALL drawBullet
CALL drawShieldRight
CALL SHOW_DONE_SHOTTING





GameLoop:
CALL drawShieldRight

cmp CHICK1orCHICK2,0
JNZ drawChick2_Begin
CALL drawChicken1
jmp TEMP2_JUMPING
drawChick2_Begin:
;CALL drawChicken2

TEMP2_JUMPING:

mov ah,6
CHECK001: 
mov ah,1
int 16h
jz dy
mov ah,0
int 16h   
cmp ah, 4bh
jz movLeft
cmp ah,4dh
jz movRight
cmp ah,48h
jz movUp
cmp ah,50h
jz movDown
cmp ah,39h
jz Space_bar

dy:

CALL CLEAR_SCREEN
CALL DYNAMIC_BULLET
CALL SHOW_DONE_SHOTTING
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmp CHICK1orCHICK2,0
JZ DRAW_CHICK1_LABEL

;;Dynamic_chick2
JMP TEMP_JUMPING
DRAW_CHICK1_LABEL:
;;DYNAMIC_CHICK1
CALL DYNAMIC_CHICK1
 cmp DoneShotting,3
   jnz GameLoop 
    cmp PLAYERTURN,0

    JNZ TURN2PLAYER2
    add intial_points_player1,1
    jmp ENDGAME001
    TURN2PLAYER2:
    add intial_points_player2,1
    jmp ENDGAME001
; ;jnz GameLoop
 ;jz endGame
; cmp DoneShotting,3
; jnz endGame

TEMP_JUMPING:
;add initial points
;jmp endGame


jmp GameLoop

movUp:
CALL MOV_UP
jmp GameLoop

movDown:
CALL MOV_DOWN
jmp GameLoop
movLeft:
CALL MOV_LEFT
jmp GameLoop

movRight:
CALL MOV_RIGHT
jmp GameLoop

Space_bar:
push ax
mov drawBulletOrNot,1
mov ax,Pr_x
mov BULLET_X,ax
mov ax,Pr_y
mov BULLET_Y,ax
pop ax
CALL drawBullet
jmp GameLoop


ENDGAME001:
RET
GAMEPROCCALL ENDP

endoffile:
    END MAIN

