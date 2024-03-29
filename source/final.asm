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
address_mode db 0      ;first operand is address ----> set 1  ,if isn't address ---->set 0
address_mode2 db 1     ;second operand is address ----> set 1 ,if isn't address ---->set 0
count_bit_1 db 1       ; byte --> 1  , word ---> 2  first operand 
count_bit_2 db 1       ; byte --> 1  , word ---> 2  second operand 
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
.code   

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
set_forbidden macro instruction_name,Forbidden_array,Forbidden_char,size,index
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
    mov cl,size   ;Search the string in  DI for Forbidden char
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
    mov bl,10
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
    mov bx,10
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
;----------------------------------------main start -----------------------------------------------------------------

main proc far
    mov ax,@data
    mov ds,ax     
    mov ES,AX
                                                                                              
                                                                                                               
        
        jmp Mov_instruction_player1    
    
    ; power_up_1 
    ; call player1_turn 
    ; call player2_turn
    ; player_state -> 1 -> player1 , 2->player2 
    
    ; player1 start -> draw screen 
    ; powerup_player1 -> 1 > player1 ,2 ->1,2
    ;
    ;
    ;
    ;
    ;before mov there is layer
    ;1) player1 perform instruction on player2 data ---> copy player2 data into temp
    ;2) player1 perform power up on player1 data    ---> copy player1 data into temp
    ;
    ;3) player2 perform instruction on player2 data ---> copy player2 data into temp
    ;4) player2 perform power up on player1 data    ---> copy player1 data into temp
    Mov_instruction_player1: 
            
            ; call draw function or proc of player1
            
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
                        jmp far ptr end_instruction_player1
                    reg_mode_mov1:
                        call  mov_register_player1 
                jmp far ptr end_instruction_player1   

    ADD_instruction_player1:
        ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
                        jmp far ptr end_instruction_player1
                    reg_mode_add1:      
                        call  mov_register_player1    
                  jmp far ptr end_instruction_player1 
    Sub_instruction_player1: 
                                  
        ; call drawing and clicking procedure --------------------------------
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
                        jmp far ptr end_instruction_player1
                    reg_mode_sub1:                
                        call  mov_register_player1    
                  jmp far ptr end_instruction_player1 
    MUL_instruction_player1:                               
        ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
                    jmp far ptr end_instruction_player1
                reg_mode_mul1:
                    call  div_mul_inc_dec_register_player1 
              jmp far ptr end_instruction_player1                
        
    DIV_instruction_player1:                     
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
                        jmp far ptr end_instruction_player1
                    reg_mode_div1:
                        call  div_mul_inc_dec_register_player1 
                  jmp far ptr end_instruction_player1
     
    Idiv_instruction_player1:
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare 
            
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
                    jmp far ptr end_instruction_player1
                reg_mode_idiv1:
                    call  div_mul_inc_dec_register_player1 
              jmp far ptr end_instruction_player1 
     
    Imul_instruction_player1:
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
                    jmp far ptr end_instruction_player1
                reg_mode_imul1:
                    call  div_mul_inc_dec_register_player1 
              jmp far ptr end_instruction_player1 
    
    INC_instruction_player1:
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
            jmp far ptr end_instruction_player1
        reg_mode_inc1:
            call  div_mul_inc_dec_register_player1 
      jmp far ptr end_instruction_player1 
     
    DEC_instruction_player1:
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
            jmp far ptr end_instruction_player1
        reg_mode_dec1:
            call  div_mul_inc_dec_register_player1 
      jmp far ptr end_instruction_player1 

    

    NOP_instruction_player1: 
        jmp far ptr end_instruction_player1 
    SAR_instruction_player1: 
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
            jmp far ptr end_instruction_player1
        reg_mode_sar1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr end_instruction_player1
    SAL_instruction_player1:  
                ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
            jmp far ptr end_instruction_player1
        reg_mode_sal1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr end_instruction_player1
    
    SHR_instruction_player1:
                ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
            jmp far ptr end_instruction_player1
        reg_mode_shr1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr end_instruction_player1 
     
    SHL_instruction_player1: 
                ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
                    jmp far ptr end_instruction_player1
                reg_mode_shl1:
                    call  shl_shr_ror_rol_register_player1 
              jmp far ptr end_instruction_player1
    ROR_instruction_player1: 
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
            jmp far ptr end_instruction_player1
        reg_mode_ror1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr end_instruction_player1
    
    ROL_instruction_player1: 
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
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
                jmp far ptr end_instruction_player1
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
                jmp far ptr end_instruction_player1
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
            jmp far ptr end_instruction_player1
        reg_mode_rol1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr end_instruction_player1    

    
             
    end_instruction_player1:
            mov power_up_player1,0             


    hlt
    main endp

;----------------------------------------main end -----------------------------------------------------------------


;-------------------------------------mov instruction -----------------------------------------------------------
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
;-----------------------------i have all indexes-------------------------------------------- 
; ---------------------------- assume bolbol will send byte indicate if its address or not (two address modes for destination & source)
            
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
     
    
;----------------------------shl  reg ---------------------------------------------------
;----------------------------------player 2---------------------------------------------------------------------------

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
div_mul_inc_dec_register_player2 proc near
    
    check_forbidden Forbidden_instruction_2,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_2,bl

            mov al,losepoint 
            mov losepoint_player2,al 
            cmp losepoint_player2,1
            jz   lose2_point_2_reg_div_player2 
            jmp cont2_reg_mode_2div 
            lose2_point_2_reg_div_player2:
            jmp far ptr end2_div_reg_player2                 
         cont2_reg_mode_2div:
            mov dl,count_bit_1
            mov dh,0
            cmp dl,2
            jz temp2_word_div_reg_player2
            jmp temp2_byte_div_reg_player2
            temp2_word_div_reg_player2:
            jmp far ptr word2_div_reg_player2
            temp2_byte_div_reg_player2:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,0
                    mov cl,Player1_Data_Register[bx]            
                    mov ah,Player1_Data_Register[0]
                    mov al,Player1_Data_Register[1]
                    mov dx,0 
                    ; add player turn here : 
                    cmp player_turn2,1
                    jz player222_div_byte_turn
                    jmp player222_div_byte_no_turn 
                    player222_div_byte_turn:    
                        cmp instruction_index,4
                        jz div2_reg_byte_player22
                        cmp instruction_index,3
                        jz mul2_reg_byte_player22
                        cmp instruction_index,14
                        jz idiv2_reg_byte_player22 
                        cmp instruction_index,15
                        jz imul2_reg_byte_player22
                        cmp instruction_index,5
                        jz inc2_reg_byte_player22
                        cmp instruction_index,6
                        jz dec2_reg_byte_player22
                        div2_reg_byte_player22:                  ; div ------------------------
                            cmp cx,0
                            jz div2_zero_byte_reg_p22
                            jmp not2_div_zero_byte_reg_p22
                            div2_zero_byte_reg_p22:
                            jmp far ptr lose2_point_div_player2
                            not2_div_zero_byte_reg_p22:
                            div cx
                            mov Player1_Data_Register[0],dl
                            mov Player1_Data_Register[1],al
                            jmp far ptr player222_div_byte_no_turn
                        mul2_reg_byte_player22:                  ; mul ------------------------
                            mul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al 
                            jmp far ptr player222_div_byte_no_turn
                        idiv2_reg_byte_player22:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv2_zero_byte_reg_p22
                            jmp not2_idiv_zero_byte_reg_p22
                            idiv2_zero_byte_reg_p22:
                            jmp far ptr lose2_point_div_player2
                            not2_idiv_zero_byte_reg_p22:
                            idiv cx
                            mov Player1_Data_Register[0],dl
                            mov Player1_Data_Register[1],al
                            jmp far ptr player222_div_byte_no_turn 
                        imul2_reg_byte_player22:                  ; imul ------------------------
                            imul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            jmp far ptr player222_div_byte_no_turn
                        inc2_reg_byte_player22:                  ; inc ------------------------
                            inc cl
                            mov Player1_Data_Register[bx],cl
                            jmp far ptr player222_div_byte_no_turn
                        dec2_reg_byte_player22:                  ; dec ------------------------
                            dec cx
                            mov Player1_Data_Register[bx],cl
                            jmp far ptr player222_div_byte_no_turn
                    
                    player222_div_byte_no_turn:        
                    cmp player_turn1,1
                    jz player211_div_byte_turn
                    jmp far ptr end2_div_reg_player2 
                    player211_div_byte_turn:
                        mov cl,Player2_Data_Register[bx]            
                        mov ah,Player2_Data_Register[0]
                        mov al,Player2_Data_Register[1]    
                        cmp instruction_index,4
                        jz div2_reg_byte_player11
                        cmp instruction_index,3
                        jz mul2_reg_byte_player11
                        cmp instruction_index,14
                        jz idiv2_reg_byte_player11 
                        cmp instruction_index,15
                        jz imul2_reg_byte_player11
                        cmp instruction_index,5
                        jz inc2_reg_byte_player11
                        cmp instruction_index,6
                        jz dec2_reg_byte_player11
                        div2_reg_byte_player11:                  ; div ------------------------
                            cmp cx,0
                            jz div2_zero_byte_reg_p11
                            jmp not2_div_zero_byte_reg_p11
                            div2_zero_byte_reg_p11:
                            jmp far ptr lose2_point_div_player2
                            not2_div_zero_byte_reg_p11:
                            div cx
                            mov Player2_Data_Register[0],dl
                            mov Player2_Data_Register[1],al
                            jmp far ptr end2_div_reg_player2
                        mul2_reg_byte_player11:                  ; mul ------------------------
                            mul cl
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al 
                            jmp far ptr end2_div_reg_player2
                        idiv2_reg_byte_player11:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv2_zero_byte_reg_p11
                            jmp not2_idiv_zero_byte_reg_p11
                            idiv2_zero_byte_reg_p11:
                            jmp far ptr lose2_point_div_player2
                            not2_idiv_zero_byte_reg_p11:
                            idiv cx
                            mov Player2_Data_Register[0],dl
                            mov Player2_Data_Register[1],al
                            jmp far ptr end2_div_reg_player2 
                        imul2_reg_byte_player11:                  ; imul ------------------------
                            imul cl
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            jmp far ptr end2_div_reg_player2
                        inc2_reg_byte_player11:                  ; inc ------------------------
                            inc cl
                            mov Player2_Data_Register[bx],cl
                            jmp far ptr end2_div_reg_player2
                        dec2_reg_byte_player11:                  ; dec ------------------------
                            dec cx
                            mov Player2_Data_Register[bx],cl
                            jmp far ptr end2_div_reg_player2     
            word2_div_reg_player2:
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
                    jz player222_div_word_turn
                    jmp player222_div_word_no_turn 
                    player222_div_word_turn: 
                        cmp instruction_index,4
                        jz div2_reg_word_player22
                        cmp instruction_index,3
                        jz mul2_reg_word_player22
                        cmp instruction_index,14
                        jz idiv2_reg_word_player22 
                        cmp instruction_index,15
                        jz imul2_reg_word_player22
                        cmp instruction_index,5
                        jz inc2_reg_word_player22
                        cmp instruction_index,6
                        jz dec2_reg_word_player22
                        div2_reg_word_player22:                  ; div ------------------------
                            cmp cx,0
                            jz div2_zero_word_reg_p22
                            div cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr player222_div_word_no_turn
                            div2_zero_word_reg_p22:
                            jmp far ptr lose2_point_div_player2
                            not2_div_zero_word_reg_p22:

                        mul2_reg_word_player22:                  ; mul ------------------------
                            mul cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr player222_div_word_no_turn 
                        idiv2_reg_word_player22:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv2_zero_word_reg_p22
                            jmp not2_idiv_zero_word_reg_p22
                            idiv2_zero_word_reg_p22:
                            jmp far ptr lose2_point_div_player2
                            not2_idiv_zero_word_reg_p22:
                            idiv cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al 
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr player222_div_word_no_turn 
                        imul2_reg_word_player22:                  ; imul ------------------------
                            imul cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr player222_div_word_no_turn
                        inc2_reg_word_player22:                  ; inc ------------------------
                            inc cx
                            mov Player1_Data_Register[bx],ch
                            mov Player1_Data_Register[bx+1],cl
                            jmp far ptr player222_div_word_no_turn
                        dec2_reg_word_player22:                  ; dec ------------------------
                            dec cx
                            mov Player1_Data_Register[bx],ch
                            mov Player1_Data_Register[bx+1],cl
                            jmp far ptr player222_div_word_no_turn 
                    
                    ; add player turn here 
                    player222_div_word_no_turn:
                    cmp player_turn1,1
                    jz player211_div_word_turn
                    jmp far ptr end2_div_reg_player2
                    player211_div_word_turn:
                        
                        mov ch,Player2_Data_Register[bx]
                        mov cl,Player2_Data_Register[bx+1]             
                        mov ah,Player2_Data_Register[0]
                        mov al,Player2_Data_Register[1]
                        mov dh,Player2_Data_Register[6]
                        mov dl,Player2_Data_Register[7] 
                        cmp instruction_index,4
                        jz div2_reg_word_player11
                        cmp instruction_index,3
                        jz mul2_reg_word_player11
                        cmp instruction_index,14
                        jz idiv2_reg_word_player11 
                        cmp instruction_index,15
                        jz imul2_reg_word_player11
                        cmp instruction_index,5
                        jz inc2_reg_word_player11
                        cmp instruction_index,6
                        jz dec2_reg_word_player11
                        div2_reg_word_player11:                  ; div ------------------------
                            cmp cx,0
                            jz div2_zero_word_reg_p11
                            div cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr end2_div_reg_player2
                            div2_zero_word_reg_p11:
                            jmp far ptr lose2_point_div_player2

                        mul2_reg_word_player11:                  ; mul ------------------------
                            mul cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr end2_div_reg_player2 
                        idiv2_reg_word_player11:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv2_zero_word_reg_p11
                            jmp not2_idiv_zero_word_reg_p11
                            idiv2_zero_word_reg_p11:
                            jmp far ptr lose2_point_div_player2
                            not2_idiv_zero_word_reg_p11:
                            idiv cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al 
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr end2_div_reg_player2 
                        imul2_reg_word_player11:                  ; imul ------------------------
                            imul cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr end2_div_reg_player2
                        inc2_reg_word_player11:                  ; inc ------------------------
                            inc cx
                            mov Player2_Data_Register[bx],ch
                            mov Player2_Data_Register[bx+1],cl
                            jmp far ptr end2_div_reg_player2
                        dec2_reg_word_player11:                  ; dec ------------------------
                            dec cx
                            mov Player2_Data_Register[bx],ch
                            mov Player2_Data_Register[bx+1],cl
                            jmp far ptr end2_div_reg_player2 
                    
    
   lose2_point_div_player2:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0                
    end2_div_reg_player2:
     
    ret 
    div_mul_inc_dec_register_player2 endp
    

div_mul_inc_dec_address_player2  proc near
    
        check_forbidden Forbidden_instruction_2,instruction_index                   
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 18                      ; index to address value -> choose which value ?!
            jz forbidden_digit_address_2div 
            jnz forbidden_regsiter_address_2div 
            forbidden_digit_address_2div:
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
                jz  lose_point_1_div_address_player2
                jmp cont_address_mode_2div 
                lose_point_1_div_address_player2:
                ;jmp far ptr lose_point_player1
                jmp far ptr end_div_address_player2
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp cont_address_mode_2div 
           forbidden_regsiter_address_2div:
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz   lose_point_2_div_address_player2 
                jmp cont_address_mode_2div 
                lose_point_2_div_address_player2:
                jmp far ptr lose_point_div_address_player2                 
         cont_address_mode_2div:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val 
            cmp player_turn2,1              ;-> player1 turn 
            jz player22_check_address_div
            jmp cont_check_address_mode_2div2
            player22_check_address_div:
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_3_div_address_player2  ; out of index of data segment -> should be error 
            jmp cont_check_address_mode_2div2 
            lose_point_3_div_address_player2:
            jmp far ptr lose_point_div_address_player2
            cont_check_address_mode_2div2:
            cmp player_turn1,1              ;-> player1 turn 
            jz player11_check_address_div
            jmp final_address_mode_2div
            player11_check_address_div:
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh  
            JA lose_point_4_div_address_player2  ; out of index of data segment -> should be error 
            jmp final_address_mode_2div 
            lose_point_4_div_address_player2:
            jmp far ptr lose_point_div_address_player2
            final_address_mode_2div:
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
                    jz player22_div_address_byte_turn
                    jmp player22_div_address_byte_no_turn 
                    player22_div_address_byte_turn:
                        cmp instruction_index,4
                        jz div_address_byte_player22
                        cmp instruction_index,3
                        jz mul_address_byte_player22
                        cmp instruction_index,14
                        jz idiv_address_byte_player22 
                        cmp instruction_index,15
                        jz imul_address_byte_player22
                        cmp instruction_index,5
                        jz inc_address_byte_player22
                        cmp instruction_index,6
                        jz dec_address_byte_player22
                        div_address_byte_player22:                  ; div ------------------------
                            cmp cx,0
                            jz div_zero_address_reg_p22
                            jmp not_div_zero_address_reg_p22
                            div_zero_address_reg_p22:
                            jmp far ptr lose_point_div_address_player2
                            not_div_zero_address_reg_p22:
                            div cx
                            mov Player1_Data_Register[0],dh
                            mov Player1_Data_Register[1],al
                            jmp far ptr player22_div_address_byte_no_turn
                        mul_address_byte_player22:                  ; mul ------------------------
                            mul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al 
                            jmp far ptr player22_div_address_byte_no_turn
                        idiv_address_byte_player22:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv_zero_address_reg_p22
                            jmp not_idiv_zero_address_reg_p22
                            idiv_zero_address_reg_p22:
                            jmp far ptr lose_point_div_address_player2
                            not_idiv_zero_address_reg_p22:
                            idiv cx
                            mov Player1_Data_Register[0],dh
                            mov Player1_Data_Register[1],al
                            jmp far ptr player22_div_address_byte_no_turn 
                        imul_address_byte_player22:                  ; imul ------------------------
                            imul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            jmp far ptr player22_div_address_byte_no_turn
                        inc_address_byte_player22:                  ; inc ------------------------
                            inc cl
                            mov data_segment_1[si],cl
                            jmp far ptr player22_div_address_byte_no_turn
                        dec_address_byte_player22:                  ; dec ------------------------
                            dec cx
                            mov data_segment_1[si],cl
                            jmp far ptr player22_div_address_byte_no_turn 

                                        
                    player22_div_address_byte_no_turn:
                        cmp player_turn1,1
                        jz player11_div_address_byte_turn
                        jmp far ptr end_div_address_player2
                        player11_div_address_byte_turn:
                            mov ch,Player2_Data_Register[bx]
                            mov cl,Player2_Data_Register[bx+1]
                            mov si,cx
                            mov cl,data_segment_2[si]
                            mov ch,0            
                            mov ah,Player2_Data_Register[0]
                            mov al,Player2_Data_Register[1]
                            cmp instruction_index,4
                            jz div_address_byte_player11
                            cmp instruction_index,3
                            jz mul_address_byte_player11
                            cmp instruction_index,14
                            jz idiv_address_byte_player11 
                            cmp instruction_index,15
                            jz imul_address_byte_player11
                            cmp instruction_index,5
                            jz inc_address_byte_player11
                            cmp instruction_index,6
                            jz dec_address_byte_player11
                            div_address_byte_player11:                  ; div ------------------------
                                cmp cx,0
                                jz div_zero_address_reg_p11
                                jmp not_div_zero_address_reg_p11
                                div_zero_address_reg_p11:
                                jmp far ptr lose_point_div_address_player2
                                not_div_zero_address_reg_p11:
                                div cx
                                mov Player2_Data_Register[0],dh
                                mov Player2_Data_Register[1],al
                                jmp far ptr end_div_address_player2
                            mul_address_byte_player11:                  ; mul ------------------------
                                mul cl
                                mov Player2_Data_Register[0],ah
                                mov Player2_Data_Register[1],al 
                                jmp far ptr end_div_address_player2
                            idiv_address_byte_player11:                  ; idiv ------------------------
                                cmp cx,0
                                jz idiv_zero_address_reg_p11
                                jmp not_idiv_zero_address_reg_p11
                                idiv_zero_address_reg_p11:
                                jmp far ptr lose_point_div_address_player2
                                not_idiv_zero_address_reg_p11:
                                idiv cx
                                mov Player2_Data_Register[0],dh
                                mov Player2_Data_Register[1],al
                                jmp far ptr end_div_address_player2 
                            imul_address_byte_player11:                  ; imul ------------------------
                                imul cl
                                mov Player2_Data_Register[0],ah
                                mov Player2_Data_Register[1],al
                                jmp far ptr end_div_address_player2
                            inc_address_byte_player11:                  ; inc ------------------------
                                inc cl
                                mov data_segment_2[si],cl
                                jmp far ptr end_div_address_player2
                            dec_address_byte_player11:                  ; dec ------------------------
                                dec cx
                                mov data_segment_2[si],cl
                                jmp far ptr end_div_address_player2 
                    
              
    lose_point_div_address_player2:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0
    
    end_div_address_player2:
    
    ret
    div_mul_inc_dec_address_player2 endp





;----------------------------shl  reg ---------------------------------------------------
shl_shr_ror_rol_register_player2 proc near
    
    check_forbidden Forbidden_instruction_2,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_2,bl

            mov al,losepoint 
            mov losepoint_player2,al 
            cmp losepoint_player2,1
            jz   lose_point_2_reg_shl_player2 
            jmp cont_reg_mode_2shl 
            lose_point_2_reg_shl_player2:
            jmp far ptr end_shl_reg_player2                 
         cont_reg_mode_2shl:
         
           ; check if value or cl is valid 
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_reg2_shl2 
            jnz check_forbidden_regsiter_reg2_shl2
            check_forbidden_digit_reg2_shl2:
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
                jz  forbidden_reg_shl_player2
                jmp cont_reg_mode_2shl2
                forbidden_reg_shl_player2:
                jmp far ptr end_shl_reg_player2  
            
            check_forbidden_regsiter_reg2_shl2:        
                
                cmp bl,7
                jnz lose_point_not_reg_cl_p2
                check_forbidden Forbidden_Registers_2,bl                 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1   
                jz temp_end_shl_reg_player2   ; -> jump far here
                jmp  cont_reg_mode_2shl2
                temp_end_shl_reg_player2:
                jmp far ptr end_shl_reg_player2
                lose_point_not_reg_cl_p2:
                jmp far ptr lose_point_shl_reg_player2 
         cont_reg_mode_2shl2:
            mov dl,count_bit_1
            mov dh,0
            cmp dl,2
            jz temp_word_shl_reg_player2
            jmp temp_byte_shl_reg_player2
            temp_word_shl_reg_player2:
            jmp far ptr word_shl_reg_player2
            temp_byte_shl_reg_player2:
                    mov bh,0
                    mov bl,dest_index_val
                    mov ch,0
                    mov cl,Player1_Data_Register[bx]
                    mov bl, src_index_val
                                 
                    ; paste here
                    cmp player_turn2,1
                    jz player22_shl_byte_turn
                    jmp player22_shl_byte_no_turn 
                    player22_shl_byte_turn:
                        cmp instruction_index,10
                        jz shl_reg_byte_player22
                        cmp instruction_index,9
                        jz shr_reg_byte_player22
                        cmp instruction_index,11
                        jz ror_reg_byte_player22 
                        cmp instruction_index,12
                        jz rol_reg_byte_player22
                        cmp instruction_index,8
                        jz sal_reg_byte_player22
                        cmp instruction_index,13
                        jz sar_reg_byte_player22
                        shl_reg_byte_player22:                  ; div ------------------------
                            shl Player1_Data_Register[bx],cl
                            jmp far ptr player22_shl_byte_no_turn
                        shr_reg_byte_player22:                  ; mul ------------------------
                            shr Player1_Data_Register[bx],cl
                            jmp far ptr player22_shl_byte_no_turn
                        ror_reg_byte_player22:                  ; idiv ------------------------
                            ror Player1_Data_Register[bx],cl
                            jmp far ptr player22_shl_byte_no_turn 
                        rol_reg_byte_player22:                  ; imul ------------------------
                            rol Player1_Data_Register[bx],cl
                            jmp far ptr player22_shl_byte_no_turn
                        sal_reg_byte_player22:                  ; inc ------------------------
                            sal Player1_Data_Register[bx],cl
                            jmp far ptr player22_shl_byte_no_turn
                        sar_reg_byte_player22:                  ; dec ------------------------
                            sar Player1_Data_Register[bx],cl
                            jmp far ptr player22_shl_byte_no_turn
                   ; paste here     
                    player22_shl_byte_no_turn:        
                    cmp player_turn1,1
                    jz player11_shl_byte_turn
                    jmp far ptr end_shl_reg_player2 
                    player11_shl_byte_turn:
                        mov bl,dest_index_val
                        mov ch,0
                        mov cl,Player2_Data_Register[bx]
                        mov bl, src_index_val
                        cmp instruction_index,10
                        jz shl_reg_byte_player11
                        cmp instruction_index,9
                        jz shr_reg_byte_player11
                        cmp instruction_index,11
                        jz ror_reg_byte_player11 
                        cmp instruction_index,12
                        jz rol_reg_byte_player11
                        cmp instruction_index,8
                        jz sal_reg_byte_player11
                        cmp instruction_index,13
                        jz sar_reg_byte_player11
                        shl_reg_byte_player11:                  ; div ------------------------
                            shl Player2_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player2
                        shr_reg_byte_player11:                  ; mul ------------------------
                            shr Player2_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player2
                        ror_reg_byte_player11:                  ; idiv ------------------------
                            ror Player2_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player2 
                        rol_reg_byte_player11:                  ; imul ------------------------
                            rol Player2_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player2
                        sal_reg_byte_player11:                  ; inc ------------------------
                            sal Player2_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player2
                        sar_reg_byte_player11:                  ; dec ------------------------
                            sar Player2_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player2
                         
                         
            word_shl_reg_player2:
                    mov bh,0   
                    mov bl,dest_index_val
                    mov cl,Player1_Data_Register[bx]
                    mov bl,src_index_val
                    mov ah,Player1_Data_Register[bx]
                    mov al,Player1_Data_Register[bx+1]
                                  
                    ; paste here
                    cmp player_turn2,1
                    jz player22_shl_word_turn
                    jmp player22_shl_word_no_turn 
                    player22_shl_word_turn: 
                        cmp instruction_index,10
                        jz shl_reg_word_player22
                        cmp instruction_index,9
                        jz shr_reg_word_player22
                        cmp instruction_index,11
                        jz ror_reg_word_player22
                        cmp instruction_index,12
                        jz rol_reg_word_player22
                        cmp instruction_index,8
                        jz sal_reg_word_player22
                        cmp instruction_index,13
                        jz sar_reg_word_player22 
                        shl_reg_word_player22:              ; div ------------------------
                            shl ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22_shl_word_no_turn
                        shr_reg_word_player22:                  ; mul ------------------------
                            shr ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22_shl_word_no_turn 
                        ror_reg_word_player22:                  ; idiv ------------------------
                            ror ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22_shl_word_no_turn 
                        rol_reg_word_player22:                  ; imul ------------------------
                            rol ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22_shl_word_no_turn
                        sal_reg_word_player22:                  ; inc ------------------------
                            sal ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22_shl_word_no_turn
                        sar_reg_word_player22:                  ; dec ------------------------
                            sar ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22_shl_word_no_turn
                  
                  ; paste here
                    player22_shl_word_no_turn:
                    cmp player_turn1,1
                    jz player11_shl_word_turn
                    jmp far ptr end_shl_reg_player2
                    player11_shl_word_turn: 
                        mov bl,dest_index_val
                        mov cl,Player2_Data_Register[bx]
                        mov bl,src_index_val
                        mov ah,Player2_Data_Register[bx]
                        mov al,Player2_Data_Register[bx+1]
                        cmp instruction_index,10
                        jz shl_reg_word_player11
                        cmp instruction_index,9
                        jz shr_reg_word_player11
                        cmp instruction_index,11
                        jz ror_reg_word_player11 
                        cmp instruction_index,12
                        jz rol_reg_word_player11
                        cmp instruction_index,8
                        jz sal_reg_word_player11
                        cmp instruction_index,13
                        jz sar_reg_word_player11
                        shl_reg_word_player11:              ; div ------------------------
                            shl ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player2
                        shr_reg_word_player11:                  ; mul ------------------------
                            shr ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player2 
                        ror_reg_word_player11:                  ; idiv ------------------------
                            ror ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player2 
                        rol_reg_word_player11:                  ; imul ------------------------
                            rol ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player2
                        sal_reg_word_player11:                  ; inc ------------------------
                            sal ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player2
                        sar_reg_word_player11:                  ; dec ------------------------
                            sar ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player2
                  
    lose_point_shl_reg_player2:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0
            
    end_shl_reg_player2:
     
    ret 
    shl_shr_ror_rol_register_player2 endp




shl_shr_ror_rol_address_player2  proc near
    
        check_forbidden Forbidden_instruction_2,instruction_index                   
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 17                      ; index to address value -> choose which value ?!
            jz forbidden_digit_address_22shl 
            jnz forbidden_regsiter_address_22shl 
            forbidden_digit_address_22shl:
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
                jz  lose_point_1_shl_address_player2
                jmp cont_address_mode_2shl 
                lose_point_1_shl_address_player2:
                ;jmp far ptr lose_point_player1
                jmp far ptr end_shl_address_player2
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp cont_address_mode_2shl 
           forbidden_regsiter_address_22shl:
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_shl_address_player2 
                jmp cont_address_mode_2shl 
                lose_point_2_shl_address_player2:
                jmp far ptr lose_point_shl_address_player2                 
         cont_address_mode_2shl:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_3_shl_address_player2  ; out of index of data segment -> should be error 
            jmp cont_address_mode_shl22 
            lose_point_3_shl_address_player2:
            jmp far ptr lose_point_shl_address_player2 
            
            cont_address_mode_shl22:
           ; check if value or cl is valid 
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_address_shl22 
            jnz check_forbidden_regsiter_address_shl22
            check_forbidden_digit_address_shl22:
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
                jz  forbidden_address_shl_player2
                jmp final_address_mode_shl2
                forbidden_address_shl_player2:
                jmp far ptr end_shl_address_player2  
            
            check_forbidden_regsiter_address_shl22:        
                
                cmp bl,7
                jnz lose_point_not_address_cl_p2
                check_forbidden Forbidden_Registers_2,bl                 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1
                ;jz  lose_point_player1   
                jz temp_end_shl_address_player2   ; -> jump far here
                jmp  final_address_mode_shl2
                temp_end_shl_address_player2:
                jmp far ptr end_shl_address_player2
                jmp final_address_mode_shl2
                 lose_point_not_address_cl_p2:
                 jmp far ptr lose_point_shl_address_player2
            final_address_mode_shl2:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,Player1_Data_Register[bx]
                    mov cl,Player1_Data_Register[bx+1]
                    mov si,cx 
                    mov bl, dest_index_val  
                    mov cl, Player1_Data_Register[bx]
                    mov ch,0            
                    
                    cmp player_turn2,1              ;-> player1 turn 
                    jz player22_shl_address_byte_turn
                    jmp player22_shl_address_byte_no_turn 
                    player22_shl_address_byte_turn:       
                            cmp instruction_index,10
                            jz shl_address_byte_player22
                            cmp instruction_index,9
                            jz shr_address_byte_player22
                            cmp instruction_index,11
                            jz ror_address_byte_player22 
                            cmp instruction_index,12
                            jz rol_address_byte_player22
                            cmp instruction_index,8
                            jz sal_address_byte_player22
                            cmp instruction_index,13
                            jz sar_address_byte_player22
                            shl_address_byte_player22:                  ; div ------------------------
                                shl data_segment_1[si],cl
                                jmp far ptr player22_shl_address_byte_no_turn
                            shr_address_byte_player22:                  ; mul ------------------------
                                shr data_segment_1[si],cl
                                jmp far ptr player22_shl_address_byte_no_turn
                            ror_address_byte_player22:                  ; idiv ------------------------
                                ror data_segment_1[si],cl
                                jmp far ptr player22_shl_address_byte_no_turn 
                            rol_address_byte_player22:                  ; imul ------------------------
                                rol data_segment_1[si],cl
                                jmp far ptr player22_shl_address_byte_no_turn
                            sal_address_byte_player22:                  ; inc ------------------------
                                sal data_segment_1[si],cl
                                jmp far ptr player22_shl_address_byte_no_turn
                            sar_address_byte_player22:                  ; dec ------------------------
                                sar data_segment_1[si],cl
                                jmp far ptr player22_shl_address_byte_no_turn  
                    player22_shl_address_byte_no_turn:
                        cmp player_turn1,1
                        jz player11_shl_address_byte_turn
                        jmp far ptr end_shl_address_player2
                        player11_shl_address_byte_turn:     
                            
                            mov bl,src_index_val
                            mov ch,Player2_Data_Register[bx]
                            mov cl,Player2_Data_Register[bx+1]
                            mov si,cx 
                            mov bl, dest_index_val  
                            mov cl, Player2_Data_Register[bx]
                            mov ch,0                            
                            cmp instruction_index,10
                            jz shl_address_byte_player11
                            cmp instruction_index,9
                            jz shr_address_byte_player11
                            cmp instruction_index,11
                            jz ror_address_byte_player11 
                            cmp instruction_index,12
                            jz rol_address_byte_player11
                            cmp instruction_index,8
                            jz sal_address_byte_player11
                            cmp instruction_index,13
                            jz sar_address_byte_player11
                            shl_address_byte_player11:                  ; div ------------------------
                                shl data_segment_2[si],cl
                                jmp far ptr end_shl_address_player2
                            shr_address_byte_player11:                  ; mul ------------------------
                                shr data_segment_2[si],cl
                                jmp far ptr end_shl_address_player2
                            ror_address_byte_player11:                  ; idiv ------------------------
                                ror data_segment_2[si],cl
                                jmp far ptr end_shl_address_player2 
                            rol_address_byte_player11:                  ; imul ------------------------
                                rol data_segment_2[si],cl
                                jmp far ptr end_shl_address_player2
                            sal_address_byte_player11:                  ; inc ------------------------
                                sal data_segment_2[si],cl
                                jmp far ptr end_shl_address_player2
                            sar_address_byte_player11:                  ; dec ------------------------
                                sar data_segment_2[si],cl
                                jmp far ptr end_shl_address_player2  

            
              
    lose_point_shl_address_player2:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0
    
    end_shl_address_player2:
    
    ret
    shl_shr_ror_rol_address_player2 endp 




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