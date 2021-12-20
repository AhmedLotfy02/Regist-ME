;include ./Macros/Print_Show.inc
.model medium
.data            





choose_chat db    'To Start Chat Press F1','$'
Choose_game db    'To Start Game Press F2','$'
Choose_Exit db    'To Exit Press Esc','$' 
chat_invitation db    'you sent Chat invitation to ','$'
game_invitation db    'you sent Game invitation to ','$'
chat_invitation2 db    ' sent Chat invitation to you ','$'
game_invitation2 db    ' sent Game invitation to you','$'  
print_level1 db 'to Select Level 1 press 1 ','$'
print_level2 db 'to Select Level 2 press 2 ','$'  
print_forbidden db 'Enter forbidden character for ','$'
Player1_Name db    'Sabry','$'
Player2_Name db    'Assad','$'  
  
user_level_selection db 1                    ; determine which user will start game user1 or user2    
pressed_button db   '$'                      ; determine last pressed button before start chat or game    
selected_level db 1
forbidden_char1 db '$'
forbidden_char2 db '$'
.code


set_cursor macro x, y
    push ax
    mov ah,2
    mov dh,y
    mov dl,x
    ;mov dx,0A0Ah   ; dh = y, dl = x
    int 10h 
    pop ax
    set_cursor endm 

get_key macro 
    mov ah,0
    int 16h  
    get_key endm

;-----------------MACROS------
Print_Msg MACRO msg ; variable defined above with '$'at end
            push ax
            ;push dx      ;does we need to push dx?!
            mov ah,9h
            mov dx,offset msg 
            int 21h
            ;pop dx
            pop ax
ENDM Print_Msg

Show_mouse Macro 
    push ax
    mov ax,1
    int 33h    
    pop ax
Endm Show_mouse   
Clear_Screen macro

    push ax
    push cx 
    push dx
    push bx
    mov ax,0600h 
    mov bh,07
    mov cx,0 
    mov dx,184FH
    int 10h
    pop bx
    pop dx
    pop cx
    pop ax
Clear_Screen endm 
main proc far      
    
    
    mov ax,@data
    mov ds,ax
    
    main_screen:
    ; First Set cursor to Location you want
        ; call function set cursor from macro and pass location
    set_cursor 17h,05h    
    ; Second Print Choose_chat
    Print_Msg  choose_chat
    ; thrid Set cursor to Location you want
    set_cursor 17h,08h 
    ; Fourth Print Choose_chat 
     Print_Msg  Choose_game
    ; fifth Set cursor to Location you want
    set_cursor 17h,0bh     
    ; sixth Print Choose_chat       
     Print_Msg  Choose_Exit      
     
    ; call function set cursor from macro and pass location
    ;set_cursor 27h,05h    
    ; Second Print Choose_chat
    ;Print_Msg  choose_chat
    ; thrid Set cursor to Location you want
    ;set_cursor 27h,08h 
    ; Fourth Print Choose_chat 
    ; Print_Msg  Choose_game
    ; fifth Set cursor to Location you want
    ;set_cursor 27h,0bh     
    ; sixth Print Choose_chat       
    ; Print_Msg  Choose_Exit   
    ;...................................USER1................................................... 
    ; get key to determine what user want to do
    ; push ax ; if needed
    get_F1_F2_ESC_USER1:  get_key
                  ; compare scaned character with F1,F2,Esc   
    ;mov pressed_button , ah
    cmp ah,3dh                       ; should be 3b
    jz check_pressed_chat_1
    ;jz send_chat_invitation     ; should send invitation and wait for second user        
                 
    cmp ah,3ch     
    jz check_pressed_game_1
    ;jz send_game_invitation       ; should send invitation and wait for second user  
    
    
    cmp ah,01h 
    jz exit_hlt
    
    jmp  get_F1_F2_ESC_USER1
    
    check_pressed_chat_1:    
        set_cursor 00h,16h
        Print_Msg chat_invitation 
        Print_Msg Player2_Name  
    
        set_cursor 29h,16h  
        Print_Msg Player1_Name
        Print_Msg chat_invitation2     
        
        cmp ah,pressed_button 
        jz chat_code      
        mov pressed_button ,ah    
        jmp get_F1_F2_ESC_USER2
        ;jz set_user2_start_game  
        
     check_pressed_game_1:   
     
        set_cursor 00h,16h
        Print_Msg game_invitation 
        Print_Msg Player2_Name  
        set_cursor 29h,16h  
        Print_Msg Player1_Name
        Print_Msg game_invitation2 
        cmp ah,pressed_button 
        jz game_code      
        mov pressed_button ,ah 
        mov user_level_selection,1 
        jmp get_F1_F2_ESC_USER2
    ;send_chat_invitation:  
    ;set_cursor 00h,16h
    ;Print_Msg choose_chat_invitation 
    ;Print_Msg Player2_Name  
    
    ;set_cursor 29h,16h  
    ;Print_Msg Player1_Name
    ;Print_Msg choose_chat_invitation2 

    ;jmp  get_F1_F2_ESC_USER2
    ;send_game_invitation:
    ;set_cursor 00h,16h
    ;Print_Msg choose_game_invitation 
    ;Print_Msg Player2_Name  
    
    ;set_cursor 29h,16h  
    ;Print_Msg Player1_Name
    ;Print_Msg choose_game_invitation2 
    
    ;jmp  get_F1_F2_ESC_USER2
    ;...................................USER2................................................... 
    ; get key to determine what user want to do
    ; push ax ; if needed    
    
    get_F1_F2_ESC_USER2:  get_key
                  ; compare scaned character with F1,F2,Esc
    cmp ah,3dh      ; should be 3b
    jz check_pressed_chat_2
    ;jz chat_code     ; should send invitation and wait for second user        
                 
    cmp ah,3ch  
    jz check_pressed_game_2
    ;jz game_code       ; should send invitation and wait for second user  
    
    
    cmp ah,01h 
    jz exit_hlt
    jmp  get_F1_F2_ESC_USER2
    
    check_pressed_chat_2:   
        set_cursor 00h,16h 
        Print_Msg Player2_Name 
        Print_Msg chat_invitation2 
 
    
        set_cursor 29h,16h  
        Print_Msg chat_invitation     
        Print_Msg Player1_Name       
        cmp ah,pressed_button 
        jz chat_code      
        mov pressed_button ,ah    
        jmp get_F1_F2_ESC_USER1
    
    check_pressed_game_2:
        set_cursor 00h,16h
        Print_Msg Player2_Name  
        Print_Msg game_invitation2 
        set_cursor 29h,16h  
        Print_Msg game_invitation 
        Print_Msg Player1_Name
        cmp ah,pressed_button 
        jz game_code      
        mov pressed_button ,ah 
        mov user_level_selection,2 
        jmp get_F1_F2_ESC_USER1    
    
    
    chat_code:     
    ;set_cursor 07h,18h
    ;Print_Msg chat_invitation 
    ;Print_Msg Player2_Name
    
    
    game_code:             


    
    Clear_Screen
    
    ;mov ah,2
    ;mov al,0
    ;mov dl,17
    ;mov dh,8
    ;int 10h   
    ;set_cursor 0,0 
    set_cursor 17h,08h
    ; Fourth Print Choose_chat 
    Print_Msg  print_level1
    ; fifth Set cursor to Location you want
    set_cursor 17h,0bh     
    ; sixth Print Choose_chat       
    Print_Msg print_level2    
    
get_level_1_or_2:
    get_key
    cmp al,'1'
    jz start_selection_of_forbidden_level1
    cmp al,'2'
    jz edit_level
    jmp get_level_1_or_2  
    
edit_level:    
    mov selected_level,2
    jmp start_selection_of_forbidden_level2                  

;---------------------------------------------------------------------------------------------------------    
    start_selection_of_forbidden_level1:   
    Clear_Screen
    mov al,user_level_selection     
    
    cmp al,1           
    
    jz user_one_starts_level_1              ; should select level first & forbidden character
    jmp user_two_starts_level_1
;---------------------------------------------------------------------------------------------------------    
    user_one_starts_level_1:

    
    set_cursor 17h,08h     
    ; sixth Print Choose_chat       
    Print_Msg print_forbidden 
    Print_Msg Player2_Name        
    mov ah,8
    mov bh,0
    int 10 
    mov forbidden_char2,al 
    Clear_Screen    
    set_cursor 17h,08h     
    ; sixth Print Choose_chat       
    Print_Msg print_forbidden 
    Print_Msg Player1_Name   
    mov ah,8
    mov bh,0
    int 10    
    mov forbidden_char1,al
    jmp exit_hlt
;---------------------------------------------------------------------------------------------------------
    user_two_starts_level_1: 
    
    set_cursor 17h,08h     
    ; sixth Print Choose_chat       
    Print_Msg print_forbidden 
    Print_Msg Player1_Name
    mov ah,8
    mov bh,0
    int 10     
    mov forbidden_char1,al
    Clear_Screen    
    set_cursor 17h,08h     
    ; sixth Print Choose_chat       
    Print_Msg print_forbidden 
    Print_Msg Player2_Name      
    mov ah,8
    mov bh,0
    int 10    
    mov forbidden_char2,al 
    
;---------------------------------------------------------------------------------------------------------    
    start_selection_of_forbidden_level2:   
    Clear_Screen
    mov al,user_level_selection     
    
    cmp al,1           
    
    jz user_one_starts_level_2              ; should select level first & forbidden character
    jmp user_two_starts_level_2
;---------------------------------------------------------------------------------------------------------    
    user_one_starts_level_2:
    set_cursor 17h,08h     
    ; sixth Print Choose_chat       
    Print_Msg print_forbidden 
    Print_Msg Player2_Name         
    mov ah,07
    int 21h
    mov forbidden_char2,al 
    
    Clear_Screen    
    set_cursor 17h,08h     
    ; sixth Print Choose_chat       
    Print_Msg print_forbidden 
    Print_Msg Player1_Name      
    mov ah,07
    int 21h    
    mov forbidden_char1,al
    jmp exit_hlt
;---------------------------------------------------------------------------------------------------------
    user_two_starts_level_2:
    
    set_cursor 17h,08h     
    ; sixth Print Choose_chat       
    Print_Msg print_forbidden 
    Print_Msg Player1_Name    
    mov ah,07
    int 21h    
    mov forbidden_char1,al
    
    Clear_Screen    
    set_cursor 17h,08h     
    ; sixth Print Choose_chat       
    Print_Msg print_forbidden 
    Print_Msg Player2_Name     
    mov ah,07
    int 21h    
    mov forbidden_char2,al    
    
    
    
      
    exit_hlt:
    
    hlt
    main endp
end main
    
    
    
    