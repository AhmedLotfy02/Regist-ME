.model large 
.stack 64
.Data 
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
main proc far
    mov ax,@data
    mov ds,ax     
    mov ES,AX
                                                                                              
                                                                                                               
        
    Mov_instruction: 
    
        ; set variable to number then compaer
        mov al,address_mode
        cmp al,1
        jz address_mode_mov1
        jmp reg_mode_mov1        
; address mode processing ---------------------------------------------------------         
    address_mode_mov1: 
        call  add_address_player1
    reg_mode_mov1:
        call  add_register_player1
            


    hlt
    main endp


;-------------------------------------sub instruction -----------------------------------------------------------
sub_reg_des_player1 proc near
            
            cmp count_bit_1,2
            jz dest_lose_point_player1_sub
            jmp here_dest_sub_player1
            dest_lose_point_player1_sub:
            jmp far ptr  lose_point_dest_player11_sub
            here_dest_sub_player1:
            mov bl,dest_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if dest_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 17                      ; index to address value -> choose which value ?!
            jz check_forbidden_digit_sub_add2 
            jnz check_forbidden_regsiter_sub_add2 
            check_forbidden_digit_sub_add2:
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
                jz  lose_point_1_player1_dest_sub
                jmp cont_address_dest_mode_sub2 
                lose_point_1_player1_dest_sub:
                jmp far ptr lose_point_dest_player11_sub
; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp final_address_mode_sub_dest 
          check_forbidden_regsiter_sub_add2:
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_player1_dest_sub 
                jmp final_address_mode_sub_dest 
                lose_point_2_player1_dest_sub:
                jmp far ptr lose_point_dest_player11_sub                 
         cont_address_dest_mode_sub2:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,dest_index_val
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_dest_player1_sub  ; out of index of data segment -> should be error 
            jmp final_address_mode_sub_dest 
            lose_point_dest_player1_sub:
            jmp far ptr lose_point_dest_player11_sub 
            ;----------------------------------- 
            ; now its valid instruction ----------------------------------
       final_address_mode_sub_dest:
            mov bh,0
            mov bl,dest_index_val 
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1]
            mov si,ax
            mov bl,src_index_val
            ;mov cx,Player2_Data_Register[bx]  
            ; check if its two byte or not 
            mov cl,data_segment_2[si] 
            sub Player2_Data_Register[bx],cl
            jmp end_dest_sub_player1   
    lose_point_dest_player11_sub:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_dest_sub_player1:
    
    ret
    sub_reg_des_player1 endp
sub_register_player1 proc near
    
    check_forbidden Forbidden_instruction_2,2       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_2,bl

            mov al,losepoint 
            mov losepoint_player1,al 
            cmp losepoint_player1,1
            jz   lose_point_2_reg_player1_sub 
            jmp cont_reg_mode_sub 
            lose_point_2_reg_player1_sub:
            jmp far ptr lose_point_reg_sub_player1                 
         cont_reg_mode_sub:
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
            jnz lose_point_reg_sub_player1_temp 
            jmp to_this_sub_player1
            lose_point_reg_sub_player1_temp:
            jmp far ptr lose_point_reg_sub_player1
            to_this_sub_player1:
            cmp address_mode2,1 
            
            jz address_mode_sub_des_player1
            jmp address_mode_sub_des_no_player1
            address_mode_sub_des_player1:
            call sub_reg_des_player1
            jmp far ptr end_sub_reg_player1  
            address_mode_sub_des_no_player1:
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_reg_sub2 
            jnz check_forbidden_regsiter_reg_sub2
            check_forbidden_digit_reg_sub2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1] 
                ; call macro that check if value in ax is correct
                
                check_byte_valid al, Forbidden_digits_2 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  lose_point_reg_sub_player1 
                jmp final_reg_mode_sub
            check_forbidden_regsiter_reg_sub2:        
            
                check_forbidden Forbidden_Registers_2,bl
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  lose_point_reg_sub_player1                   
                mov ah,count_bit_2

            ; now its valid instruction ----------------------------------
            final_reg_mode_sub:
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
            jz word_sub_reg_player1  
                sub Player2_Data_Register[bx],ah
                jmp end_sub_reg_player1
            word_sub_reg_player1:
            sub Player2_Data_Register[bx+1],al
            sbb Player2_Data_Register[bx],ah  
            jmp end_sub_reg_player1
    lose_point_reg_sub_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_sub_reg_player1: 
    ret 
    sub_register_player1 endp
;--------------------------------------------------- address mov -----------------------------------------------------------------
sub_address_player1  proc near
    
        check_forbidden Forbidden_instruction_2,0       
;-----------------------------i have all indexes-------------------------------------------- 
; ---------------------------- assume bolbol will send byte indicate if its address or not (two address modes for destination & source)
            
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 18                      ; index to address value -> choose which value ?!
            jz check_forbidden_digit_sub 
            jnz check_forbidden_regsiter_sub 
            check_forbidden_digit_sub:
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
                jz  lose_point_1_player1_sub
                jmp cont_address_mode_sub 
                lose_point_1_player1_sub:
                jmp far ptr lose_point_player1_sub
; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp cont_address_mode_sub 
                check_forbidden_regsiter_sub:
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_player1_sub 
                jmp cont_address_mode_sub 
                lose_point_2_player1_sub:
                jmp far ptr lose_point_player1_sub                 
         cont_address_mode_sub:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_3_player1_sub  ; out of index of data segment -> should be error 
            jmp cont_address_mode_sub2 
            lose_point_3_player1_sub:
            jmp far ptr lose_point_player1_sub 
            ; check other operand------------------ 
            cont_address_mode_sub2:
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_sub2 
            jnz check_forbidden_regsiter_sub2
            check_forbidden_digit_sub2:
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
                jz  lose_point_player1_sub 
                jmp final_address_mode_sub
            check_forbidden_regsiter_sub2:        
            
                check_forbidden Forbidden_Registers_2,bl
                 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  lose_point_player1_sub   
                
                ;mov bh,0
                ;mov bl,dest_index_val
                ;mov ah,Player2_Data_Register[bx]
                ;mov al,Player2_Data_Register[bx+1]

            ; now its valid instruction ----------------------------------
            final_address_mode_sub:
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
            jz word_sub_address_player1  
                mov cl,Player2_Data_Register[bx]
                sub data_segment_2[si],cl
                jmp end_sub_player1
            word_sub_address_player1:
            mov cl ,Player2_Data_Register[bx+1]
            mov ch ,Player2_Data_Register[bx]
            sub data_segment_2 [si],cl
            sbb data_segment_2 [si+1],ch   
    lose_point_player1_sub:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_sub_player1:
    
    ret
    sub_address_player1 endp 



;-------------------------------------add instruction -----------------------------------------------------------
add_reg_des_player1 proc near
            
            cmp count_bit_1,2
            jz dest_lose_point_player1_add
            jmp here_dest_add_player1
            dest_lose_point_player1_add:
            jmp far ptr  lose_point_dest_player11_add
            here_dest_add_player1:
            mov bl,dest_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if dest_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 17                      ; index to address value -> choose which value ?!
            jz check_forbidden_digit_add_add2 
            jnz check_forbidden_regsiter_add_add2 
            check_forbidden_digit_add_add2:
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
                jz  lose_point_1_player1_dest_add
                jmp cont_address_dest_mode_add2 
                lose_point_1_player1_dest_add:
                jmp far ptr lose_point_dest_player11_add
; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp final_address_mode_add_dest 
          check_forbidden_regsiter_add_add2:
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_player1_dest_add 
                jmp final_address_mode_add_dest 
                lose_point_2_player1_dest_add:
                jmp far ptr lose_point_dest_player11_add                 
         cont_address_dest_mode_add2:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,dest_index_val
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_dest_player1_add  ; out of index of data segment -> should be error 
            jmp final_address_mode_add_dest 
            lose_point_dest_player1_add:
            jmp far ptr lose_point_dest_player11_add 
            ;----------------------------------- 
            ; now its valid instruction ----------------------------------
       final_address_mode_add_dest:
            mov bh,0
            mov bl,dest_index_val 
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1]
            mov si,ax
            mov bl,src_index_val
            ;mov cx,Player2_Data_Register[bx]  
            ; check if its two byte or not 
            mov cl,data_segment_2[si] 
            add Player2_Data_Register[bx],cl
            jmp end_dest_add_player1   
    lose_point_dest_player11_add:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_dest_add_player1:
    
    ret
    add_reg_des_player1 endp
add_register_player1 proc near
    
    check_forbidden Forbidden_instruction_2,0       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_2,bl

            mov al,losepoint 
            mov losepoint_player1,al 
            cmp losepoint_player1,1
            jz   lose_point_2_reg_player1_add 
            jmp cont_reg_mode_add 
            lose_point_2_reg_player1_add:
            jmp far ptr lose_point_reg_add_player1                 
         cont_reg_mode_add:
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
            jnz lose_point_reg_add_player1_temp 
            jmp to_this_add_player1
            lose_point_reg_add_player1_temp:
            jmp far ptr lose_point_reg_add_player1
            to_this_add_player1:
            cmp address_mode2,1 
            
            jz address_mode_add_des_player1 
            jmp  address_mode_add_des_no_player1
            address_mode_add_des_player1:

            call add_reg_des_player1
            jmp far ptr end_add_reg_player1
            address_mode_add_des_no_player1:
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_reg_add2 
            jnz check_forbidden_regsiter_reg_add2
            check_forbidden_digit_reg_add2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1] 
                ; call macro that check if value in ax is correct
                
                check_byte_valid al, Forbidden_digits_2 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  lose_point_reg_add_player1 
                jmp final_reg_mode_add
            check_forbidden_regsiter_reg_add2:        
            
                check_forbidden Forbidden_Registers_2,bl
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  lose_point_reg_add_player1                   
                mov ah,count_bit_2

            ; now its valid instruction ----------------------------------
            final_reg_mode_add:
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
            jz word_add_reg_player1  
                add Player2_Data_Register[bx],ah
                jmp end_add_reg_player1
            word_add_reg_player1:
            add Player2_Data_Register[bx+1],al
            adc Player2_Data_Register[bx],ah  
            jmp end_add_reg_player1
    lose_point_reg_add_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_add_reg_player1: 
    ret 
    add_register_player1 endp
;--------------------------------------------------- address mov -----------------------------------------------------------------
add_address_player1  proc near
    
        check_forbidden Forbidden_instruction_2,0       
;-----------------------------i have all indexes-------------------------------------------- 
; ---------------------------- assume bolbol will send byte indicate if its address or not (two address modes for destination & source)
            
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 18                      ; index to address value -> choose which value ?!
            jz check_forbidden_digit_add 
            jnz check_forbidden_regsiter_add 
            check_forbidden_digit_add:
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
                jz  lose_point_1_player1_add
                jmp cont_address_mode_add 
                lose_point_1_player1_add:
                jmp far ptr lose_point_player1_add
; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp cont_address_mode_add 
                check_forbidden_regsiter_add:
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_player1_add 
                jmp cont_address_mode_add 
                lose_point_2_player1_add:
                jmp far ptr lose_point_player1_add                 
         cont_address_mode_add:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_3_player1_add  ; out of index of data segment -> should be error 
            jmp cont_address_mode_add2 
            lose_point_3_player1_add:
            jmp far ptr lose_point_player1_add 
            ; check other operand------------------ 
            cont_address_mode_add2:
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_add2 
            jnz check_forbidden_regsiter_add2
            check_forbidden_digit_add2:
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
                jz  lose_point_player1_add 
                jmp final_address_mode_add
            check_forbidden_regsiter_add2:        
            
                check_forbidden Forbidden_Registers_2,bl
                 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  lose_point_player1_add   
                
                ;mov bh,0
                ;mov bl,dest_index_val
                ;mov ah,Player2_Data_Register[bx]
                ;mov al,Player2_Data_Register[bx+1]

            ; now its valid instruction ----------------------------------
            final_address_mode_add:
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
            jz word_add_address_player1  
                mov cl,Player2_Data_Register[bx]
                add data_segment_2[si],cl
                jmp end_add_player1
            word_add_address_player1:
            mov cl ,Player2_Data_Register[bx+1]
            mov ch ,Player2_Data_Register[bx]
            add data_segment_2 [si],cl
            adc data_segment_2 [si+1],ch   
    lose_point_player1_add:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_add_player1:
    
    ret
    add_address_player1 endp 

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
            mov cl,data_segment_2[si] 
            mov Player2_Data_Register[bx],cl
            jmp end_dest_mov_player1   
    lose_point_dest_player11_mov:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_dest_mov_player1:
    
    ret
    mov_reg_des_player1 endp
mov_register_player1 proc near
    
    check_forbidden Forbidden_instruction_2,0       
             
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
                
                check_byte_valid al, Forbidden_digits_2 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  lose_point_reg_mov_player1 
                jmp final_reg_mode_mov
            check_forbidden_regsiter_reg_mov2:        
            
                check_forbidden Forbidden_Registers_2,bl
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  lose_point_reg_mov_player1                   
                mov ah,count_bit_2

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
                mov Player2_Data_Register[bx],ah
                jmp end_mov_reg_player1
            word_mov_reg_player1:
            mov Player2_Data_Register[bx+1],al
            mov Player2_Data_Register[bx],ah  
            jmp end_mov_reg_player1
    lose_point_reg_mov_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_mov_reg_player1: 
    ret 
    mov_register_player1 endp
;--------------------------------------------------- address mov -----------------------------------------------------------------
mov_address_player1  proc near
    
        check_forbidden Forbidden_instruction_2,0       
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
                jmp far ptr end_mov_player1
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
                jz  lose_point_player1 
                jmp final_address_mode_mov
            check_forbidden_regsiter_mov2:        
            
                check_forbidden Forbidden_Registers_2,bl
                 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                ;jz  lose_point_player1   
                jz end_mov_player1
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
            jz word_mov_address_player1  
                mov cl,Player2_Data_Register[bx]
                mov data_segment_2[si],cl
                jmp end_mov_player1
            word_mov_address_player1:
            mov cl ,Player2_Data_Register[bx+1]
            mov ch ,Player2_Data_Register[bx]
            mov data_segment_2 [si],cl
            mov data_segment_2 [si+1],ch   
    lose_point_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_mov_player1:
    
    ret
    mov_address_player1 endp 
    
end main