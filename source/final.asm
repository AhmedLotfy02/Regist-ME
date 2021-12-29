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
src_index_val db 1
dest_index_val db 18 
address_mode db 0 
address_mode2 db 1  
count_bit_1 db 1   
count_bit_2 db 1
 
losepoint db 0


; player1 Data variables -----------------------------------------------------------------------------------
Forbidden_digits_1 db '0000000000'
Forbidden_Registers_1 db '0000000000000000'
Forbidden_instruction_1 db '00000000000000000' 
Forbidden_char1 db 'o'
intial_points_player1 db 60
losepoint_player1 db 0

data_segment_1 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 
Player1_Data_Register db 11h,22h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,05h
;------------------------AH  -Al -BH-Bl -CH  -CL-DH  -DL-  SI -     DI --   SP    - BP   -value-addressvalue----

; player2 Data variables --------------------------------------------------------------

Forbidden_digits_2 db '0000000000'
Forbidden_Registers_2 db '0000000000000000'
Forbidden_instruction_2 db '00000000000000000'
Forbidden_char2 db 'h'  
intial_points_player2 db 60
losepoint_player2 db 0

data_segment_2 db 0,0,0,0,0,9,0,0,0,0,0,0,0,0,0,0
Player2_Data_Register db 03h,02h,00h,07h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,05h,05h,00h,05h
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
                                                                                              
                                                                                                               
        
        jmp DIV_instruction    
    
    Mov_instruction: 
             
        ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,0
            mov al,address_mode
            cmp al,1
            jz address_mode_mov1
            jmp reg_mode_mov1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_mov1:  
            ;call  mov_address_player1
        reg_mode_mov1:
            ;call  mov_register_player1 
      jmp far ptr end_instruction_player1   

    ADD_instruction:
        ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,1
            mov al,address_mode
            cmp al,1
            jz address_mode_add1
            jmp reg_mode_add1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_add1:  
            ;call  mov_address_player1
        reg_mode_add1:      
            ;call  mov_register_player1    
      jmp far ptr end_instruction_player1 
    Sub_instruction: 
                                  
        ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,2
            mov al,address_mode
            cmp al,1
            jz address_mode_sub1
            jmp reg_mode_sub1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_sub1:  
            ;call  mov_address_player1
        reg_mode_sub1:                
            ;call  mov_register_player1    
      jmp far ptr end_instruction_player1 
    MUL_instruction:                               
        ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,3
            mov al,address_mode
            cmp al,1
            jz address_mode_mul1
            jmp reg_mode_mul1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_mul1:  
            call  div_mul_inc_dec_address_player1
        reg_mode_mul1:
            call  div_mul_inc_dec_register_player1 
      jmp far ptr end_instruction_player1                
        
    DIV_instruction:                     
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,4
            mov al,address_mode
            cmp al,1
            jz address_mode_div1
            jmp reg_mode_div1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_div1:  
            call  div_mul_inc_dec_address_player1
        reg_mode_div1:
            call  div_mul_inc_dec_register_player1 
      jmp far ptr end_instruction_player1
     
    Idiv_instruction:
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,15
            mov al,address_mode
            cmp al,1
            jz address_mode_idiv1
            jmp reg_mode_idiv1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_idiv1:  
            call  div_mul_inc_dec_address_player1
        reg_mode_idiv1:
            call  div_mul_inc_dec_register_player1 
      jmp far ptr end_instruction_player1 
     
    Imul_instruction:
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,16
            mov al,address_mode
            cmp al,1
            jz address_mode_imul1
            jmp reg_mode_imul1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_imul1:  
            call  div_mul_inc_dec_address_player1
        reg_mode_imul1:
            call  div_mul_inc_dec_register_player1 
      jmp far ptr end_instruction_player1 
    
    INC_instruction:
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,6
            mov al,address_mode
            cmp al,1
            jz address_mode_inc1
            jmp reg_mode_inc1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_inc1:  
            call  div_mul_inc_dec_address_player1
        reg_mode_inc1:
            call  div_mul_inc_dec_register_player1 
      jmp far ptr end_instruction_player1 
     
    DEC_instruction:
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,7
            mov al,address_mode
            cmp al,1
            jz address_mode_dec1
            jmp reg_mode_dec1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_dec1:  
            call  div_mul_inc_dec_address_player1
        reg_mode_dec1:
            call  div_mul_inc_dec_register_player1 
      jmp far ptr end_instruction_player1 

    

    NOP_instruction:
        jmp far ptr end_instruction_player1 
    SAR_instruction: 
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,13
            mov al,address_mode
            cmp al,1
            jz address_mode_sar1
            jmp reg_mode_sar1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_sar1:  
            call  shl_shr_ror_rol_address_player1
        reg_mode_sar1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr end_instruction_player1
    SAL_instruction:  
                ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,8
            mov al,address_mode
            cmp al,1
            jz address_mode_sal1
            jmp reg_mode_sal1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_sal1:  
            call  shl_shr_ror_rol_address_player1
        reg_mode_sal1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr end_instruction_player1
    
    SHR_instruction:
                ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,9
            mov al,address_mode
            cmp al,1
            jz address_mode_shr1
            jmp reg_mode_shr1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_shr1:  
            call  shl_shr_ror_rol_address_player1
        reg_mode_shr1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr end_instruction_player1 
     
    SHL_instruction: 
                ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,10
            mov al,address_mode
            cmp al,1
            jz address_mode_shl1
            jmp reg_mode_shl1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_shl1:  
            call  shl_shr_ror_rol_address_player1
        reg_mode_shl1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr end_instruction_player1
    ROR_instruction: 
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,11
            mov al,address_mode
            cmp al,1
            jz address_mode_ror1
            jmp reg_mode_ror1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_ror1:  
            call  shl_shr_ror_rol_address_player1
        reg_mode_ror1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr end_instruction_player1
    
    ROL_instruction: 
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            mov instruction_index,12
            mov al,address_mode
            cmp al,1
            jz address_mode_rol1
            jmp reg_mode_rol1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_rol1:  
            call  shl_shr_ror_rol_address_player1
        reg_mode_rol1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr end_instruction_player1    

    
             
    end_instruction_player1:             


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
                
                check_word_valid ax, Forbidden_digits_2 ;<----------- working should be uncomment when we solve jump problem
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
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_player1_dest 
                jmp final_address_mode_mov_dest 
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
                        jmp far ptr end_dest_mov_player1
                    add_address_byte_player1_dest:                  ; add ------------------------
                        mov cl,data_segment_2[si] 
                        add Player2_Data_Register[bx],cl 
                        ;add Player2_Data_Register[bx],ah
                        jmp far ptr end_dest_mov_player1
                    sub_address_byte_player1_dest:                  ; sub ------------------------
                        mov cl,data_segment_2[si] 
                        sub Player2_Data_Register[bx],cl 
                        ;sub Player2_Data_Register[bx],ah
                        jmp far ptr end_dest_mov_player1
 
    lose_point_dest_player11_mov:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_dest_mov_player1:
    
    ret
    mov_reg_des_player1 endp
;----------------------------mov to a register ---------------------------------------------------
mov_register_player1 proc near
    
    check_forbidden Forbidden_instruction_2,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_2,bl

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
                check_byte_valid al, Forbidden_digits_2 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1 
                
                jz  forbidden_digit_mov_player1 
                jmp final_reg_mode_mov
                forbidden_digit_mov_player1:
                    jmp far ptr end_mov_reg_player1 
            check_forbidden_regsiter_reg_mov2:        
            
                check_forbidden Forbidden_Registers_2,bl
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  forbidden_reg_mov_player1
                jmp final_reg_mode_mov
                forbidden_reg_mov_player1:
                    jmp far ptr end_mov_reg_player1   
              
                                
                ;mov ah,count_bit_2

            ; now its valid instruction ----------------------------------
            final_reg_mode_mov:
                mov bh,0
                mov bl,dest_index_val 
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1]
                mov si,ax
                mov bl,src_index_val
            
                ;mov cx,Player2_Data_Register[bx]  
                ; check if its two byte or not 
                mov dl,count_bit_2
                mov dh,0
                cmp dl,2
                jz word_mov_reg_player1
                    cmp instruction_index,0
                    jz mov_reg_byte_player1
                    cmp instruction_index,1
                    jz add_reg_byte_player1
                    cmp instruction_index,2
                    jz sub_reg_byte_player1
                    mov_reg_byte_player1:                  ; mov ------------------------
                        mov Player2_Data_Register[bx],ah
                        jmp far ptr end_mov_reg_player1
                    add_reg_byte_player1:                  ; add ------------------------
                        add Player2_Data_Register[bx],ah
                        jmp far ptr end_mov_reg_player1
                    sub_reg_byte_player1:                  ; sub ------------------------
                        sub Player2_Data_Register[bx],ah
                        jmp far ptr end_mov_reg_player1                                    
                word_mov_reg_player1:
                    cmp instruction_index,0
                    jz mov_reg_word_player1
                    cmp instruction_index,1
                    jz add_reg_word_player1
                    cmp instruction_index,2
                    jz sub_reg_word_player1
                    mov_reg_word_player1:                  ; mov ------------------------
                        mov Player2_Data_Register[bx+1],al
                        mov Player2_Data_Register[bx],ah
                        jmp far ptr end_mov_reg_player1
                    add_reg_word_player1:                  ; add ------------------------
                        add Player2_Data_Register[bx+1],al
                        adc Player2_Data_Register[bx],ah
                        jmp far ptr end_mov_reg_player1
                    sub_reg_word_player1:                  ; sub ------------------------
                        sub Player2_Data_Register[bx+1],al
                        sbb Player2_Data_Register[bx],ah
                        jmp far ptr end_mov_reg_player1             
                                                            ; lose point because of invalid instruction
    lose_point_reg_mov_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_mov_reg_player1:
     
    ret 
    mov_register_player1 endp
;---------------------------------------------------  mov to datasegment  -----------------------------------------------------------------
mov_address_player1  proc near
    
        check_forbidden Forbidden_instruction_2,instruction_index       
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
                
                check_word_valid ax, Forbidden_digits_2 <----------- working should be uncomment when we solve jump problem
                ;check_forbidden Forbidden_digits_2,0    <----------- not working should be removed later
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
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_player1 
                jmp cont_address_mode_mov 
                lose_point_2_player1:
                jmp far ptr lose_point_player1                 
         cont_address_mode_mov:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_3_player1  ; out of index of data segment -> should be error 
            jmp cont_address_mode_mov2 
            lose_point_3_player1:
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
                check_word_valid ax, Forbidden_digits_2 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
  
                jz  forbidden_address_mov_player1
                jmp final_address_mode_mov
                forbidden_address_mov_player1:
                    jmp far ptr end_mov_address_player1  
            
            check_forbidden_regsiter_mov2:        
            
                check_forbidden Forbidden_Registers_2,bl
                 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                ;jz  lose_point_player1   
                jz end_mov_address_player1
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
            jz lose_point_player1
            ; paste here      
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
                        jmp far ptr end_mov_address_player1
                    add_address_byte_player1:                  ; add ------------------------
                        mov cl,Player2_Data_Register[bx]
                        add data_segment_2[si],cl
                        ;add Player2_Data_Register[bx],ah
                        jmp far ptr end_mov_address_player1
                    sub_address_byte_player1:                  ; sub ------------------------
                        mov cl,Player2_Data_Register[bx]
                        sub data_segment_2[si],cl
                        ;sub Player2_Data_Register[bx],ah
                        jmp far ptr end_mov_address_player1                                    
              
    lose_point_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_mov_address_player1:
    
    ret
    mov_address_player1 endp 
;----------------------------div mul reg ---------------------------------------------------
div_mul_inc_dec_register_player1 proc near
    
    check_forbidden Forbidden_instruction_2,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_2,bl

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
                    cmp instruction_index,4
                    jz div_reg_byte_player1
                    cmp instruction_index,3
                    jz mul_reg_byte_player1
                    cmp instruction_index,15
                    jz idiv_reg_byte_player1 
                    cmp instruction_index,16
                    jz imul_reg_byte_player1
                    cmp instruction_index,6
                    jz inc_reg_byte_player1
                    cmp instruction_index,7
                    jz dec_reg_byte_player1
                    div_reg_byte_player1:                  ; div ------------------------
                        div cx
                        mov Player2_Data_Register[0],dl
                        mov Player2_Data_Register[1],al
                        jmp far ptr end_div_reg_player1
                    mul_reg_byte_player1:                  ; mul ------------------------
                        mul cl
                        mov Player2_Data_Register[0],ah
                        mov Player2_Data_Register[1],al 
                        jmp far ptr end_div_reg_player1
                    idiv_reg_byte_player1:                  ; idiv ------------------------
                        idiv cx
                        mov Player2_Data_Register[0],dl
                        mov Player2_Data_Register[1],al
                        jmp far ptr end_div_reg_player1 
                    imul_reg_byte_player1:                  ; imul ------------------------
                        imul cl
                        mov Player2_Data_Register[0],ah
                        mov Player2_Data_Register[1],al
                        jmp far ptr end_div_reg_player1
                    inc_reg_byte_player1:                  ; inc ------------------------
                        inc cl
                        mov Player2_Data_Register[bx],cl
                        jmp far ptr end_div_reg_player1
                    dec_reg_byte_player1:                  ; dec ------------------------
                        dec cx
                        mov Player2_Data_Register[bx],cl
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
                    cmp instruction_index,4
                    jz div_reg_word_player1
                    cmp instruction_index,3
                    jz mul_reg_word_player1
                    cmp instruction_index,15
                    jz idiv_reg_word_player1 
                    cmp instruction_index,16
                    jz imul_reg_word_player1
                    cmp instruction_index,6
                    jz inc_reg_word_player1
                    cmp instruction_index,7
                    jz dec_reg_word_player1
                    div_reg_word_player1:                  ; div ------------------------
                        div cx
                        mov Player2_Data_Register[0],ah
                        mov Player2_Data_Register[1],al
                        mov Player2_Data_Register[6],dh
                        mov Player2_Data_Register[7],dl
                        jmp far ptr end_div_reg_player1
                    mul_reg_word_player1:                  ; mul ------------------------
                        mul cx
                        mov Player2_Data_Register[0],ah
                        mov Player2_Data_Register[1],al
                        mov Player2_Data_Register[6],dh
                        mov Player2_Data_Register[7],dl
                        jmp far ptr end_div_reg_player1 
                    idiv_reg_word_player1:                  ; idiv ------------------------
                        idiv cx
                        mov Player2_Data_Register[0],ah
                        mov Player2_Data_Register[1],al 
                        mov Player2_Data_Register[6],dh
                        mov Player2_Data_Register[7],dl
                        jmp far ptr end_div_reg_player1 
                    imul_reg_word_player1:                  ; imul ------------------------
                        imul cx
                        mov Player2_Data_Register[0],ah
                        mov Player2_Data_Register[1],al
                        mov Player2_Data_Register[6],dh
                        mov Player2_Data_Register[7],dl
                        jmp far ptr end_div_reg_player1
                    inc_reg_word_player1:                  ; inc ------------------------
                        inc cx
                        mov Player2_Data_Register[bx],ch
                        mov Player2_Data_Register[bx+1],cl
                        jmp far ptr end_div_reg_player1
                    dec_reg_word_player1:                  ; dec ------------------------
                        dec cx
                        mov Player2_Data_Register[bx],ch
                        mov Player2_Data_Register[bx+1],cl
                        jmp far ptr end_div_reg_player1 
    
    end_div_reg_player1:
     
    ret 
    div_mul_inc_dec_register_player1 endp
;---------------------------------------------------  mov to datasegment  -----------------------------------------------------------------
div_mul_inc_dec_address_player1  proc near
    
        check_forbidden Forbidden_instruction_2,instruction_index                   
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 18                      ; index to address value -> choose which value ?!
            jz check_forbidden_digit_address_div 
            jnz check_forbidden_regsiter_address_div 
            check_forbidden_digit_address_div:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1]
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_2 
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
           check_forbidden_regsiter_address_div:
                check_forbidden Forbidden_Registers_2,bl
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
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_3_div_address_player1  ; out of index of data segment -> should be error 
            jmp final_address_mode_div 
            lose_point_3_div_address_player1:
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
                    cmp instruction_index,4
                    jz div_address_byte_player1
                    cmp instruction_index,3
                    jz mul_address_byte_player1
                    cmp instruction_index,15
                    jz idiv_address_byte_player1 
                    cmp instruction_index,16
                    jz imul_address_byte_player1
                    cmp instruction_index,6
                    jz inc_address_byte_player1
                    cmp instruction_index,7
                    jz dec_address_byte_player1
                    div_address_byte_player1:                  ; div ------------------------
                        div cx
                        mov Player2_Data_Register[0],dh
                        mov Player2_Data_Register[1],al
                        jmp far ptr end_div_address_player1
                    mul_address_byte_player1:                  ; mul ------------------------
                        mul cl
                        mov Player2_Data_Register[0],ah
                        mov Player2_Data_Register[1],al 
                        jmp far ptr end_div_address_player1
                    idiv_address_byte_player1:                  ; idiv ------------------------
                        idiv cx
                        mov Player2_Data_Register[0],dh
                        mov Player2_Data_Register[1],al
                        jmp far ptr end_div_address_player1 
                    imul_address_byte_player1:                  ; imul ------------------------
                        imul cl
                        mov Player2_Data_Register[0],ah
                        mov Player2_Data_Register[1],al
                        jmp far ptr end_div_address_player1
                    inc_address_byte_player1:                  ; inc ------------------------
                        inc cl
                        mov data_segment_2[si],cl
                        jmp far ptr end_div_address_player1
                    dec_address_byte_player1:                  ; dec ------------------------
                        dec cx
                        mov data_segment_2[si],cl
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
    
    check_forbidden Forbidden_instruction_2,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_2,bl

            mov al,losepoint 
            mov losepoint_player1,al 
            cmp losepoint_player1,1
            jz   lose_point_2_reg_shl_player1 
            jmp cont_reg_mode_shl 
            lose_point_2_reg_shl_player1:
            jmp far ptr end_shl_reg_player1                 
         cont_reg_mode_shl:
         
           ; check if value or cl is valid 
           
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
                        jmp far ptr end_shl_reg_player1
                    shr_reg_byte_player1:                  ; mul ------------------------
                        shr Player2_Data_Register[bx],cl
                        jmp far ptr end_shl_reg_player1
                    ror_reg_byte_player1:                  ; idiv ------------------------
                        ror Player2_Data_Register[bx],cl
                        jmp far ptr end_shl_reg_player1 
                    rol_reg_byte_player1:                  ; imul ------------------------
                        rol Player2_Data_Register[bx],cl
                        jmp far ptr end_shl_reg_player1
                    sal_reg_byte_player1:                  ; inc ------------------------
                        sal Player2_Data_Register[bx],cl
                        jmp far ptr end_shl_reg_player1
                    sar_reg_byte_player1:                  ; dec ------------------------
                        sar Player2_Data_Register[bx],cl
                        jmp far ptr end_shl_reg_player1 
            word_shl_reg_player1:
                    mov bh,0   
                    mov bl,dest_index_val
                    mov cl,Player2_Data_Register[bx]
                    mov bl,src_index_val
                    mov ah,Player2_Data_Register[bx]
                    mov al,Player2_Data_Register[bx+1]
                                  
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
                        jmp far ptr end_shl_reg_player1
                    shr_reg_word_player1:                  ; mul ------------------------
                        shr ax,cl
                        mov Player2_Data_Register[bx],ah
                        mov Player2_Data_Register[bx+1],al
                        jmp far ptr end_shl_reg_player1 
                    ror_reg_word_player1:                  ; idiv ------------------------
                        ror ax,cl
                        mov Player2_Data_Register[bx],ah
                        mov Player2_Data_Register[bx+1],al
                        jmp far ptr end_shl_reg_player1 
                    rol_reg_word_player1:                  ; imul ------------------------
                        rol ax,cl
                        mov Player2_Data_Register[bx],ah
                        mov Player2_Data_Register[bx+1],al
                        jmp far ptr end_shl_reg_player1
                    sal_reg_word_player1:                  ; inc ------------------------
                        sal ax,cl
                        mov Player2_Data_Register[bx],ah
                        mov Player2_Data_Register[bx+1],al
                        jmp far ptr end_shl_reg_player1
                    sar_reg_word_player1:                  ; dec ------------------------
                        sar ax,cl
                        mov Player2_Data_Register[bx],ah
                        mov Player2_Data_Register[bx+1],al
                        jmp far ptr end_shl_reg_player1
    
    end_shl_reg_player1:
     
    ret 
    shl_shr_ror_rol_register_player1 endp
;---------------------------------------------------  shl to datasegment  -----------------------------------------------------------------
shl_shr_ror_rol_address_player1  proc near
    
        check_forbidden Forbidden_instruction_2,instruction_index                   
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 18                      ; index to address value -> choose which value ?!
            jz check_forbidden_digit_address_shl 
            jnz check_forbidden_regsiter_address_shl 
            check_forbidden_digit_address_shl:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1]
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_2 
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
           check_forbidden_regsiter_address_shl:
                check_forbidden Forbidden_Registers_2,bl
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
            ; if lotfy didnt handle it 
            ; check for value or register cl or lose point
            final_address_mode_shl:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,Player2_Data_Register[bx]
                    mov cl,Player2_Data_Register[bx+1]
                    mov si,cx 
                    mov bl, dest_index_val  
                    mov cl, Player2_Data_Register[bx]
                    mov ch,0            
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
                        jmp far ptr end_shl_address_player1
                    shr_address_byte_player1:                  ; mul ------------------------
                        shr data_segment_2[si],cl
                        jmp far ptr end_shl_address_player1
                    ror_address_byte_player1:                  ; idiv ------------------------
                        ror data_segment_2[si],cl
                        jmp far ptr end_shl_address_player1 
                    rol_address_byte_player1:                  ; imul ------------------------
                        rol data_segment_2[si],cl
                        jmp far ptr end_shl_address_player1
                    sal_address_byte_player1:                  ; inc ------------------------
                        sal data_segment_2[si],cl
                        jmp far ptr end_shl_address_player1
                    sar_address_byte_player1:                  ; dec ------------------------
                        sar data_segment_2[si],cl
                        jmp far ptr end_shl_address_player1 

            
              
    lose_point_shl_address_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_shl_address_player1:
    
    ret
    shl_shr_ror_rol_address_player1 endp 
    
   
   
   
   
    
end main