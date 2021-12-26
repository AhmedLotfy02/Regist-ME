.model small

.stack 64

.data

; All instructions, digits and registers
instructions db "mov ", "add ", "sub ", "mul ", "div ", "and ", "or ", "nor ", "xor ", "shr ", "shl ", "ror ", "rol ", "push ", "pop ", "inc ", "dec "  
registers db "ax ", "al ", "ah ", "bx ", "bl ", "bh ", "cx ", "cl ", "ch ", "dx ", "dl ", "dh ", "si ", "di ", "sp ", "bp ","val ","address "
Player1_Data_Register dw 0000h,0000h,105eh,0000h,0000h,0000h,0000h,0000h,0000h,0005h
;-------------------------Ax---BX---CX---DX---SI---DI---SP---BP---value-addressvalue----  
Player2_Data_Register dw  0001h,0000h,105eh,0000h,0000h,0000h,0000h,0000h,0000h,0005h
;-------------------------Ax---BX---CX---DX---SI---DI---SP---BP---value-addressvalue----     
data_segment_1 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  
data_segment_2 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

digits db "0 ", "1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 "  
src_index_reg db 17
dest_index_reg db 0
src_index_val db 18
dest_index_val db 0 
address_mode db 1  
count_bit_1 db 2   
count_bit_2 db 2

;Forbidden Arrays to check if it is forbidden or not, if the corresponding index has value 1, it is forbidden  
Forbidden_digits_1 db '0000000000'
Forbidden_Registers_1 db '0000000000000000'
Forbidden_instruction_1 db '00000000000000000' 
Forbidden_char1 db 'o'
Forbidden_digits_2 db '0000000000'
Forbidden_Registers_2 db '0000000000000000'
Forbidden_instruction_2 db '00000000000000000'
Forbidden_char2 db 'h'

win_player1 db 0
win_player2 db 0   

target dw 105eh

mes_win1 db 'player1 wins ','$'
mes_win2 db ' player2 wins','$'
.code
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
        mov ah,9
        lea dx,mes_win1
        int 21h 
        ;jmp endgame
    
    doesnt_win_player1:
;-----------------test procedure ---------------   
    call  Reach_target_player1 
    cmp win_player2,1
    jz wins_player2
    jnz doesnt_win_player2
    
    wins_player2:
        mov ah,9
        lea dx,mes_win2
        int 21h 
        jmp endgame
    
    doesnt_win_player2:

    endgame:
            hlt
    main endp   
Reach_target_player2 proc near
    
    mov ax, target
    mov si,0
    mov cx,8
    mov dx,0
    loop_on_registers_2:
    
        cmp ax,Player2_Data_Register[si]   ; compare target and each register of player2 so that to check if player 1 wins or not
        jz reached_win_player1  
        jmp not_reached_player1
        reached_win_player1:
        mov dx,1
        mov cx,1
        not_reached_player1:
        add si,2
        dec cx 
        
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
    mov cx,8
    mov dx,0
    loop_on_registers_1:
    
        cmp ax,Player1_Data_Register[si]   ; compare target and each register of player2 so that to check if player 1 wins or not
        jz reached_win_player2  
        jmp not_reached_player2
        reached_win_player2:
        mov dx,1
        mov cx,1
        not_reached_player2:
        add si,2
        dec cx 
        
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


end main