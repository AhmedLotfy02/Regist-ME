.model large 
.stack 64
.Data 
; general variables ----------------------------------------------------------------------------------------------
; All instructions, digits and registers
instructions db "MOV ", "ADD ", "SUB ", "MUL ", "DIV ", "INC ", "DEC ", "NOP ", "SAL ", "SHR ", "SHL ", "ROR ", "ROL ", "SAR ","IDIV ", "IMUL "  
registers db "AX ", "AL ", "AH ", "BX ", "BL ", "BH ", "CX ", "CL ", "CH ", "DX ", "DL ", "DH ", "SI ", "DI ", "SP ", "BP ","val ","address "
digits db "0 ", "1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 "  

instruction_index db 0 
; mov-> 0 add-> 1 sub-> 2
; MUL-> 3 DIV-> 4 IDIV-> 14 IMUL-> 15  INC-> 5 DEC-> 6 
; NOP-> 7
; SAL-> 8 SHR-> 9 SHL-> 10 ROR-> 11 ROL-> 12 SAR->13

src_index_reg db 0
dest_index_reg db 17
src_index_val db 0
dest_index_val db 18 
address_mode db 0 
address_mode2 db 1  
count_bit_1 db 1   
count_bit_2 db 1
player_turn db 1   ; player1-> 1 , player2-> 2 
player_turn1 db 1   ; power up 2
player_turn2 db 1   ; power up 2
losepoint db 0                  
win_player1 db 0
win_player2 db 0   

target dw 105eh


; player1 Data variables -----------------------------------------------------------------------------------
Forbidden_digits_1 db '0000000000'
Forbidden_Registers_1 db '0000000000000000'
Forbidden_instruction_1 db '00000000000000000' 
Forbidden_char1 db 'o'
intial_points_player1 db 60
losepoint_player1 db 0  
power_up_player1 db 1

data_segment_1 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 
Player1_Data_Register db 11h,22h,33h,44h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,05h
;------------------------AH  -Al -BH-Bl -CH  -CL-DH  -DL-  SI -     DI --   SP    - BP   -value-addressvalue----

; player2 Data variables --------------------------------------------------------------

Forbidden_digits_2 db '0000000000'
Forbidden_Registers_2 db '0000000000000000'
Forbidden_instruction_2 db '00000000000000000'
Forbidden_char2 db 'h'  
intial_points_player2 db 60
losepoint_player2 db 0
power_up_player2 db 1

data_segment_2 db 0,0,0,0,0,9,0,0,0,0,0,0,0,0,0,0
Player2_Data_Register db 03h,02h,08h,07h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,05h,05h,00h,05h
;------------------------AH  -Al -BH-Bl -CH  -CL-DH  -DL-  SI -     DI --   SP    - BP   -value-addressvalue----   
main proc far
    mov ax,@data
    mov ds,ax
    mov es,ax
    
;-----------------test procedure ---------------    
    call Reach_target_player2
     
    cmp win_player1,1
    jz wins_player1
    jnz doesnt_win_player1
    
    wins_player1:
        ;mov ah,9
        ;lea dx,mes_win1
        ;int 21h 
        ;jmp endgame
    
    doesnt_win_player1:
;-----------------test procedure ---------------   
    call  Reach_target_player1 
    cmp win_player2,1
    jz wins_player2
    jnz doesnt_win_player2
    
    wins_player2:
        ;mov ah,9
        ;lea dx,mes_win2
        ;int 21h 
        jmp endgame
    
    doesnt_win_player2:

    endgame:
            hlt
    main endp   
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
end main