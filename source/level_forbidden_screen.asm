.model small
.stack 64
.data
        ; general variables ----------------------------------------------------------------------------------------------
    ; All instructions, digits and registers
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
    


.code
    Print_Msg MACRO msg ; variable defined above with '$'at end
                push ax
                ;push dx      ;does we need to push dx?!
                mov ah,9h
                mov dx,offset msg 
                int 21h
                ;pop dx
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
    endm 
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
            jmp finish
            
            setPoints:
                mov initial_point, bl 
            
        finish: ret    
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

main proc 
    mov ax, @data
    mov ds, ax 

    ClearScreen 0, 0, 80, 25
    call player1Screen
    ClearScreen 0, 0, 80, 25
    call player2Screen
    CALL setInitialPoints
    ClearScreen 0, 0, 80, 25
    call player1_forbidden_screen
    ClearScreen 0, 0, 80, 25
    call player2_forbidden_screen

main endp

END MAIN 