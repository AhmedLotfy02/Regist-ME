instructions db "mov ", "add ", "sub ", "mul ", "div ", "and ", "or ", "nor ", "xor ", "shr ", "shl ", "ror ", "rol ", "push ", "pop ", "inc ", "dec "  
    registers db "ax ", "al ", "ah ", "bx ", "bl ", "bh ", "cx ", "cl ", "ch ", "dx ", "dl ", "dh ", "si ", "di ", "sp ", "bp ","val ","address "
    digits db "0 ", "1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 "  

    instruction_index db 0
    src_index_reg db 0
    dest_index_reg db 17
    src_index_val db 0
    dest_index_val db 18 
    address_mode db 0 
    address_mode2 db 1  
    count_bit_1 db 1   
    count_bit_2 db 1
    losepoint db 0
    initial_point db ?
    enter_name db "Please, Enter your name: $"
    initialP db "Initial Points: $"
    press db "Press Enter key to continue$"
    forbiddenCharMess db "Enter forbidden char for your opponent: $"
    


    ; player1 Data variables -----------------------------------------------------------------------------------
        Forbidden_digits_1 db '0000000000'
        Forbidden_Registers_1 db '0000000000000000'
        Forbidden_instruction_1 db '00000000000000000' 
        player1_mess db "Player 1 data$"
        levelMessage db "Enter the level (1 or 2): $"
        player1_name db 15 , ?, 15 dup("$")
        Forbidden_char1 db 'o'
        intial_points_player1 db 4, ?, 4 dup(0)
        losepoint_player1 db 0
        selected_level db ?
        data_segment_1 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 
        Player1_Data_Register db 11h,22h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,05h
    ;------------------------AH  -Al -BH-Bl -CH  -CL-DH  -DL-  SI -     DI --   SP    - BP   -value-addressvalue----

    ; player2 Data variables --------------------------------------------------------------
        player2_mess db "Player 2 data$"
        Forbidden_digits_2 db '0000000000'
        Forbidden_Registers_2 db '0000000000000000'
        Forbidden_instruction_2 db '00000000000000000'
        Forbidden_char2 db ? 
        player2_name db 15 , ?, 15 dup("$")
        intial_points_player2 db 4, ?, 4 dup(0)
        losepoint_player2 db 0
        data_segment_2 db 0,0,0,0,0,9,0,0,0,0,0,0,0,0,0,0
        Player2_Data_Register db 03h,02h,00h,07h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,05h,05h,00h,05h
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
    
data_segment_1 db 01,0Ah,0AFH,73,66,0,0,0,0,0,0,0,0,0,0,0 
Player1_Data_Register db 11h,22h,32h,44h,04h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,05h
data_segment_2 db 01,22,44,0Ah,0AFh,9,0,0,0,0,0,0,0,0,0,0
Player2_Data_Register db 03h,02h,08h,07h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,05h,05h,00h,05h
Data_Segment_X db 27
Data_Segment_Y db 1
Counter db '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'
Counter_Segment db 16
Register_Values_X db 60
Register_Values_Y db 2
Outer_Counter_RV db 8
Inner_Counter_RV db 2
Temp_Data db ?
P1 db 'P1'
P2 db 'P2'
    ;;tests
    x DW ?
    y dw ?
    

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
    message3 db 'to end game prress esc$'