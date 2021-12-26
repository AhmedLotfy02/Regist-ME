.model small 
.stack 64
.Data
; All instructions, digits and registers
instructions db "mov ", "add ", "sub ", "mul ", "div ", "and ", "or ", "nor ", "xor ", "shr ", "shl ", "ror ", "rol ", "push ", "pop ", "inc ", "dec "  
registers db "ax ", "al ", "ah ", "bx ", "bl ", "bh ", "cx ", "cl ", "ch ", "dx ", "dl ", "dh ", "si ", "di ", "sp ", "bp ","val ","address "
Player1_Data_Register dw 0000,0000,0000,0000,0000,0000,0000,0000,0000,0005
;-------------------------Ax---BX---CX---DX---SI---DI---SP---BP---value-addressvalue----  
Player2_Data_Register dw  0009,0000,0000,0000,0000,0000,0000,0000,0000,0005
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

 
;Comp_size to check if forbidden character is in array or not
; if 0 means its not there
; else  you should jump to lose_point label
;Comp_size to check if forbidden character is in array or not
; if 0 means its not there
; else  you should jump to lose_point label




 
.code   

check_forbidden macro Forbidden_array,index
    push Ax
    push bx
    mov bh,0
    mov bl,index  
    mov ah,Forbidden_array[bx] ;compare position at index in forbidden array
    cmp ah,'1' ; compare        
    pop bx  
    pop Ax
    ;jz lose_point    ; jmp here or outside ?! to be discussed later
;check_forbidden Endm 
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
    ; get forbidden character
    
    ; loop on 17 instruction to set 
    
    ; loop on numbers
    
    ; loop on regsiter 16
    
    
    
    ; call lotfy code power up or instruction

     
;---------------------------------logic instruction start -------------------------------------------------               
;           0) instruction or power up
;               1)  call lotfy code (address or register)
;                    subcodes  of gui                                                                                           
;                   2) if address show value button or register button
;                      3) if value read byte from user and but it in 'val'  
;                      4) if register select index of register
;                   5)if register show all registers of operand1 & select index of register
;               6)  same for operand 2 but with value
;               7)  process instruction 
;               8)  valid or not (lose point or not).
;               9)  jump to player2
;           10) go to power up
;               11)   
;
;            testing subcode & overall code  
;
;                                                                                                            
;---------------------------------logic instruction end  ------------------------------------------------- 
; --------------------------------sabry & assad -------------------------------------------------
;                 we have 6 indexes 
;                 register-> assad  or address -> sabry
                                                                                                          
                                                                                                        
        
        
    Mov_instruction: 
        check_forbidden Forbidden_instruction_2,0       
;-----------------------------i have all indexes-------------------------------------------- 
; ---------------------------- assume bolbol will send byte indicate if its address or not
        mov al,address_mode
        cmp al,1
        jz address_mode_mov1
        ; assad code
          
        ; address mode processing ---------------------------------------------------------         
        address_mode_mov1:             
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            cmp bl,17                        ; index to value
            jz check_forbidden_digit_mov 
            jnz check_forbidden_regsiter_mov 
            check_forbidden_digit_mov:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                ;check_forbidden Forbidden_digits_2,0 
                jmp cont_address_mode_mov 
            check_forbidden_regsiter_mov:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]                                   
         cont_address_mode_mov:
            ;check if value in ax is less than f
            cmp ax,000fh
            ;JA lose_point   ; out of index of data segment -> should be error
            ; check other operand------------------ 
            
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
                mov ax,Player2_Data_Register[bx] 
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                jmp final_address_mode_mov
            check_forbidden_regsiter_mov2:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx]

            ; now its valid instruction ----------------------------------
            final_address_mode_mov:
            mov bh,0
            mov bl,src_index_val
            mov si,Player2_Data_Register[bx]
            mov bl,dest_index_val
            mov cx,Player2_Data_Register[bx]
             
            ; check if its two byte or not 
            mov dl,count_bit_2
            mov dh,0
            loop_on_mov_bytes:
                mov data_segment_2[si],cl
                ;mov data_segment_2[si+1],cl 
                inc si
                mov cl,ch 
                dec dl
                jnz loop_on_mov_bytes
                
            ; check forbidden register
            ; check forbidden digit if value
            ; you need a macro to check if value has a number of forbidden
            

    ADD_instruction:
        check_forbidden Forbidden_instruction_2,1       
;-----------------------------i have all indexes-------------------------------------------- 
; ---------------------------- assume bolbol will send byte indicate if its address or not
        mov al,address_mode
        cmp al,1
        jz address_mode_add1
        ; assad code
          
        ; address mode processing ---------------------------------------------------------         
        address_mode_add1:             
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            cmp bl,17                        ; index to value
            jz check_forbidden_digit_add 
            jnz check_forbidden_regsiter_add 
            check_forbidden_digit_add:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2 
                jmp cont_address_mode_add 
            check_forbidden_regsiter_add:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]                                   
         cont_address_mode_add:
            ;check if value in ax is less than f
            cmp ax,000fh
            ;JA lose_point   ; out of index of data segment -> should be error
            ; check other operand------------------ 
            
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
                mov ax,Player2_Data_Register[bx] 
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                jmp final_address_mode_add
            check_forbidden_regsiter_add2:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx]

            ; now its valid instruction ----------------------------------
            final_address_mode_add:
            mov bh,0
            mov bl,src_index_val
            mov si,Player2_Data_Register[bx]
            mov bl,dest_index_val
            mov cx,Player2_Data_Register[bx]
            ;add data_segment_2[si+1],cl
            add data_segment_2[si],cl               

    Sub_instruction:                               
        check_forbidden Forbidden_instruction_2,2       
;-----------------------------i have all indexes-------------------------------------------- 
; ---------------------------- assume bolbol will send byte indicate if its address or not
        mov al,address_mode
        cmp al,1
        jz address_mode_sub1
        ; assad code
          
        ; address mode processing ---------------------------------------------------------         
        address_mode_sub1:             
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            cmp bl,17                        ; index to value
            jz check_forbidden_digit_sub 
            jnz check_forbidden_regsiter_sub 
            check_forbidden_digit_sub:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                jmp cont_address_mode_sub 
            check_forbidden_regsiter_sub:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]                                   
         cont_address_mode_sub:
            ;check if value in ax is less than f
            cmp ax,000fh
            ;JA lose_point   ; out of index of data segment -> should be error
            ; check other operand------------------ 
            
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
                mov ax,Player2_Data_Register[bx] 
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2 
                jmp final_address_mode_sub
            check_forbidden_regsiter_sub2:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx]

            ; now its valid instruction ----------------------------------
            final_address_mode_sub:
            mov bh,0
            mov bl,src_index_val
            mov si,Player2_Data_Register[bx]
            mov bl,dest_index_val
            mov cx,Player2_Data_Register[bx]
            ;sub data_segment_2[si+1],cl
            sub data_segment_2[si],cl                    
    MUL_instruction:
    check_forbidden Forbidden_instruction_2,3       
;-----------------------------i have all indexes-------------------------------------------- 
; ---------------------------- assume bolbol will send byte indicate if its address or not
        mov al,address_mode
        cmp al,1
        jz address_mode_mul1
        ; assad code
          
        ; address mode processing ---------------------------------------------------------         
        address_mode_mul1:             
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            cmp bl,17                        ; index to value
            jz check_forbidden_digit_mul 
            jnz check_forbidden_regsiter_mul 
            check_forbidden_digit_mul:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                jmp cont_address_mode_mul 
            check_forbidden_regsiter_mul:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]                                   
         cont_address_mode_mul:
            ;check if value in ax is less than f
            cmp ax,000fh
            ;JA lose_point   ; out of index of data segment -> should be error
            ; now its valid instruction ----------------------------------
            final_address_mode_mul:
            mov bh,0
            mov bl,src_index_val
            mov si,Player2_Data_Register[bx]
            mov ax,Player2_Data_Register[0]
            ;mul data_segment_2[si+1]
            mul data_segment_2[si]  
            mov Player2_Data_Register[0],ax                                    
        
    DIV_instruction: 
        check_forbidden Forbidden_instruction_2,4       
;-----------------------------i have all indexes-------------------------------------------- 
; ---------------------------- assume bolbol will send byte indicate if its address or not
        mov al,address_mode
        cmp al,1
        jz address_mode_div1
        ; assad code
          
        ; address mode processing ---------------------------------------------------------         
        address_mode_div1:             
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            cmp bl,17                        ; index to value
            jz check_forbidden_digit_div 
            jnz check_forbidden_regsiter_div 
            check_forbidden_digit_div:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]
                ; call macro that check if value in ax is correct
                ;check_word_valid ax ,Forbidden_digits_2
                jmp cont_address_mode_div 
            check_forbidden_regsiter_div:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]                                   
         cont_address_mode_div:
            ;check if value in ax is less than f
            cmp ax,000fh
            ;JA lose_point   ; out of index of data segment -> should be error
            ; now its valid instruction ----------------------------------
            final_address_mode_div:
            mov bh,0
            mov bl,src_index_val
            mov si,Player2_Data_Register[bx]
            mov ax,Player2_Data_Register[0]
            ;div data_segment_2[si+1]
            div data_segment_2[si]  
            mov Player2_Data_Register[0],ax                                      

;start and instruction ----------------------------------------------------------------------------       
    AND_instruction: 

         check_forbidden Forbidden_instruction_2,5       

        mov al,address_mode
        cmp al,1
        jz address_mode_and1
        ; assad code
          
        ; address mode processing ---------------------------------------------------------         
        address_mode_and1:             
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            cmp bl,17                        ; index to value
            jz check_forbidden_digit_and 
            jnz check_forbidden_regsiter_and 
            check_forbidden_digit_and:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                ;check_forbidden Forbidden_digits_2,0 
                jmp cont_address_mode_and 
            check_forbidden_regsiter_and:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]                                   
         cont_address_mode_and:
            ;check if value in ax is less than f
            cmp ax,000fh
            ;JA lose_point   ; out of index of data segment -> should be error
            ; check other operand------------------ 
            
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_and2 
            jnz check_forbidden_regsiter_and2
            check_forbidden_digit_and2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx] 
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                jmp final_address_mode_and
            check_forbidden_regsiter_and2:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx]

            ; now its valid instruction ----------------------------------
            final_address_mode_and:
            mov bh,0
            mov bl,src_index_val
            mov si,Player2_Data_Register[bx]
            mov bl,dest_index_val
            mov cx,Player2_Data_Register[bx]
            and data_segment_2[si],cl
 
    OR_instruction:
        check_forbidden Forbidden_instruction_2,6       

        mov al,address_mode
        cmp al,1
        jz address_mode_or1
        ; assad code
          
        ; address mode processing ---------------------------------------------------------         
        address_mode_or1:             
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            cmp bl,17                        ; index to value
            jz check_forbidden_digit_or 
            jnz check_forbidden_regsiter_or 
            check_forbidden_digit_or:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                ;check_forbidden Forbidden_digits_2,0 
                jmp cont_address_mode_or 
            check_forbidden_regsiter_or:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]                                   
         cont_address_mode_or:
            ;check if value in ax is less than f
            cmp ax,000fh
            ;JA lose_point   ; out of index of data segment -> should be error
            ; check other operand------------------ 
            
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_or2 
            jnz check_forbidden_regsiter_or2
            check_forbidden_digit_or2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx] 
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                jmp final_address_mode_or
            check_forbidden_regsiter_or2:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx]

            ; now its valid instruction ----------------------------------
            final_address_mode_or:
            mov bh,0
            mov bl,src_index_val
            mov si,Player2_Data_Register[bx]
            mov bl,dest_index_val
            mov cx,Player2_Data_Register[bx]
            or data_segment_2[si],cl

    NOP_instruction:      
    
        check_forbidden Forbidden_instruction_2,7       

        
    XOR_instruction:
        check_forbidden Forbidden_instruction_2,8       

        mov al,address_mode
        cmp al,1
        jz address_mode_xor1
        ; assad code
          
        ; address mode processing ---------------------------------------------------------         
        address_mode_xor1:             
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            cmp bl,17                        ; index to value
            jz check_forbidden_digit_xor 
            jnz check_forbidden_regsiter_xor 
            check_forbidden_digit_xor:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                ;check_forbidden Forbidden_digits_2,0 
                jmp cont_address_mode_xor 
            check_forbidden_regsiter_xor:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]                                   
         cont_address_mode_xor:
            ;check if value in ax is less than f
            cmp ax,000fh
            ;JA lose_point   ; out of index of data segment -> should be error
            ; check other operand------------------ 
            
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_xor2 
            jnz check_forbidden_regsiter_xor2
            check_forbidden_digit_xor2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx] 
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                jmp final_address_mode_xor
            check_forbidden_regsiter_xor2:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx]

            ; now its valid instruction ----------------------------------
            final_address_mode_xor:
            mov bh,0
            mov bl,src_index_val
            mov si,Player2_Data_Register[bx]
            mov bl,dest_index_val
            mov cx,Player2_Data_Register[bx]
            xor data_segment_2[si],cl
     
    SHR_instruction:   
            check_forbidden Forbidden_instruction_2,9       
;-----------------------------i have all indexes-------------------------------------------- 
; ---------------------------- assume bolbol will send byte indicate if its address or not
        mov al,address_mode
        cmp al,1
        jz address_mode_shr1
        ; assad code
          
        ; address mode processing ---------------------------------------------------------         
        address_mode_shr1:             
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            cmp bl,17                        ; index to value
            jz check_forbidden_digit_shr 
            jnz check_forbidden_regsiter_shr 
            check_forbidden_digit_shr:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                ;check_forbidden Forbidden_digits_2,0 
                jmp cont_address_mode_shr 
            check_forbidden_regsiter_shr:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]                                   
         cont_address_mode_shr:
            ;check if value in ax is less than f
            cmp ax,000fh
            ;JA lose_point   ; out of index of data segment -> should be error
            ; check other operand------------------ 
            
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_shr2 
            jnz check_forbidden_regsiter_shr2
            check_forbidden_digit_shr2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx] 
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                jmp final_address_mode_shr
            check_forbidden_regsiter_shr2:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx]

            ; now its valid instruction ----------------------------------
            final_address_mode_shr:
            mov bh,0
            mov bl,src_index_val
            mov si,Player2_Data_Register[bx]
            mov bl,dest_index_val
            mov cx,Player2_Data_Register[bx]
            shr data_segment_2[si],cl       
        
    SHL_instruction:
            check_forbidden Forbidden_instruction_2,10       
;-----------------------------i have all indexes-------------------------------------------- 
; ---------------------------- assume bolbol will send byte indicate if its address or not
        mov al,address_mode
        cmp al,1
        jz address_mode_shl1
        ; assad code
          
        ; address mode processing ---------------------------------------------------------         
        address_mode_shl1:             
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            cmp bl,17                        ; index to value
            jz check_forbidden_digit_shl 
            jnz check_forbidden_regsiter_shl 
            check_forbidden_digit_shl:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                ;check_forbidden Forbidden_digits_2,0 
                jmp cont_address_mode_shl 
            check_forbidden_regsiter_shl:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]                                   
         cont_address_mode_shl:
            ;check if value in ax is less than f
            cmp ax,000fh
            ;JA lose_point   ; out of index of data segment -> should be error
            ; check other operand------------------ 
            
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_shl2 
            jnz check_forbidden_regsiter_shl2
            check_forbidden_digit_shl2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx] 
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                jmp final_address_mode_shl
            check_forbidden_regsiter_shl2:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx]

            ; now its valid instruction ----------------------------------
            final_address_mode_shl:
            mov bh,0
            mov bl,src_index_val
            mov si,Player2_Data_Register[bx]
            mov bl,dest_index_val
            mov cx,Player2_Data_Register[bx]
            shl data_segment_2[si],cl 
        
    ROR_instruction: 
            check_forbidden Forbidden_instruction_2,11       
;-----------------------------i have all indexes-------------------------------------------- 
; ---------------------------- assume bolbol will send byte indicate if its address or not
        mov al,address_mode
        cmp al,1
        jz address_mode_ror1
        ; assad code
          
        ; address mode processing ---------------------------------------------------------         
        address_mode_ror1:             
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            cmp bl,17                        ; index to value
            jz check_forbidden_digit_ror 
            jnz check_forbidden_regsiter_ror 
            check_forbidden_digit_ror:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                ;check_forbidden Forbidden_digits_2,0 
                jmp cont_address_mode_ror 
            check_forbidden_regsiter_ror:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]                                   
         cont_address_mode_ror:
            ;check if value in ax is less than f
            cmp ax,000fh
            ;JA lose_point   ; out of index of data segment -> should be error
            ; check other operand------------------ 
            
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_ror2 
            jnz check_forbidden_regsiter_ror2
            check_forbidden_digit_ror2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx] 
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                jmp final_address_mode_ror
            check_forbidden_regsiter_ror2:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx]

            ; now its valid instruction ----------------------------------
            final_address_mode_ror:
            mov bh,0
            mov bl,src_index_val
            mov si,Player2_Data_Register[bx]
            mov bl,dest_index_val
            mov cx,Player2_Data_Register[bx]
            ror data_segment_2[si],cl
    
    ROL_instruction:
            check_forbidden Forbidden_instruction_2,12       
;-----------------------------i have all indexes-------------------------------------------- 
; ---------------------------- assume bolbol will send byte indicate if its address or not
        mov al,address_mode
        cmp al,1
        jz address_mode_ROL1
        ; assad code
          
        ; address mode processing ---------------------------------------------------------         
        address_mode_ROL1:             
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            cmp bl,17                        ; index to value
            jz check_forbidden_digit_ROL 
            jnz check_forbidden_regsiter_ROL 
            check_forbidden_digit_rol:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                ;check_forbidden Forbidden_digits_2,0 
                jmp cont_address_mode_ROL 
            check_forbidden_regsiter_ROL:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]                                   
         cont_address_mode_ROL:
            ;check if value in ax is less than f
            cmp ax,000fh
            ;JA lose_point   ; out of index of data segment -> should be error
            ; check other operand------------------ 
            
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_ROL2 
            jnz check_forbidden_regsiter_ROL2
            check_forbidden_digit_ROL2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx] 
                ; call macro that check if value in ax is correct
                ;check_word_valid ax, Forbidden_digits_2
                jmp final_address_mode_ROL
            check_forbidden_regsiter_ROL2:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,dest_index_val
                mov ax,Player2_Data_Register[bx]

            ; now its valid instruction ----------------------------------
            final_address_mode_ROL:
            mov bh,0
            mov bl,src_index_val
            mov si,Player2_Data_Register[bx]
            mov bl,dest_index_val
            mov cx,Player2_Data_Register[bx]
            ROL data_segment_2[si],cl
    
    PUSH_instruction: 
   
    POP_instruction: 
   
    INC_instruction:
    mov al,address_mode
        cmp al,1
        jz address_mode_inc1
        ; assad code
          
        ; address mode processing ---------------------------------------------------------         
        address_mode_inc1:             
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            cmp bl,17                        ; index to value
            jz check_forbidden_digit_inc 
            jnz check_forbidden_regsiter_inc 
            check_forbidden_digit_inc:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]
                ; call macro that check if value in ax is correct
                ;check_word_valid ax ,Forbidden_digits_2
                jmp cont_address_mode_inc 
            check_forbidden_regsiter_inc:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]                                   
         cont_address_mode_inc:
            ;check if value in ax is less than f
            cmp ax,000fh
            ;JA lose_point   ; out of index of data segment -> should be error
            ; now its valid instruction ----------------------------------
            final_address_mode_inc:
            mov bh,0
            mov bl,src_index_val
            mov si,Player2_Data_Register[bx]
            inc data_segment_2[si+1]  

     
    DEC_instruction:  
    
    
    mov al,address_mode
        cmp al,1
        jz address_mode_dec1
        ; assad code
          
        ; address mode processing ---------------------------------------------------------         
        address_mode_dec1:             
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            cmp bl,17                        ; index to value
            jz check_forbidden_digit_dec 
            jnz check_forbidden_regsiter_dec 
            check_forbidden_digit_dec:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]
                ; call macro that check if value in ax is correct
                ;check_word_valid ax ,Forbidden_digits_2
                jmp cont_address_mode_dec 
            check_forbidden_regsiter_dec:
                check_forbidden Forbidden_Registers_2,bl
                mov bh,0
                mov bl,src_index_val
                mov ax,Player2_Data_Register[bx]                                   
         cont_address_mode_dec:
            ;check if value in ax is less than f
            cmp ax,000fh
            ;JA lose_point   ; out of index of data segment -> should be error
            ; now its valid instruction ----------------------------------
            final_address_mode_dec:
            mov bh,0
            mov bl,src_index_val
            mov si,Player2_Data_Register[bx]
            dec data_segment_2[si+1]  

    ;------------------------------------------------------------------------------      
    lose_point:  
     
    
    
    
    ;hlt
    main endp
end main