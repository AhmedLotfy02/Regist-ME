.model small
.Data
; All instructions, digits and registers
instructions db "mov ", "add ", "sub ", "mul ", "div ", "and ", "or ", "nor ", "xor ", "shr ", "shl ", "ror ", "rol ", "push ", "pop ", "inc ", "dec "  
registers db "ax ", "al ", "ah ", "bx ", "bl ", "bh ", "cx ", "cl ", "ch ", "dx ", "dl ", "dh ", "si ", "di ", "sp ", "bp ","val ","address "
Player1_Data_Register dw '0000','0000','0000','0000','0000','0000','0000','0000','0000','0000'
;------------------------- Ax-----BX-----CX-----DX-----SI-----DI-----SP-----BP----value-addressvalue----  
Player2_Data_Register dw '0000','0000','0000','0000','0000','0000','0000','0000','0000','0000'
;------------------------- Ax-----BX-----CX-----DX-----SI-----DI-----SP-----BP----value-addressvalue----
digits db "0 ", "1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 "  
src_index_reg db ?
dest_index_reg db ?
src_index_val db ?
dest_index_val db ?   
count_bit_1 db ?   
count_bit_2 db ?

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
check_forbidden macro Forbidden_array,index
    push Ax
    push bx
    mov bh,0
    mov bl,index  
    mov ah,Forbidden_array+bx ;compare position at index in forbidden array
    cmp ah,'1' ; compare        
    pop bx  
    pop Ax
    jz lose_point    ; jmp here or outside ?! to be discussed later
Endm check_forbidden

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
            mov Forbidden_array+bx,'1' ; forbidden for instruction with index = index 
    Dont_Set_bit:
    pop bx  
    pop Cx
    pop Ax
    pop Di
Endm set_forbidden 

.code

main proc far
    mov ax,@data
    mov ds,ax     
    mov ES,AX
    ; get forbidden character
    
    ; loop on 17 instruction to set 
    
    ; loop on numbers
    
    ; loop on regsiter 16
    
    
    
    ; call lotfy code power up or instruction

    Mov_instruction: 
        check_forbidden Forbidden_instruction,0 
        
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4,numberbytes1,numberbytes2 
        ; index1 for source register  
        ; index2 for destination register(value)  
        ; index3 for source register value  
        ; index4 for destination register(value) value 
        
        check_forbidden Forbidden_Registers,index1
        
        ; call bolbol function
        ; check if index2 is value or register
        mov al, index2
        cmp al,16                        ; index to value
        jz check_forbidden_digit_mov 
        jnz check_forbidden_regsiter_mov 
        check_forbidden_digit_mov:
            check_forbidden Forbidden_digits,0 
            ;jmp to next calculation 
        check_forbidden_regsiter_mov:
            check_forbidden Forbidden_Registers,index2      
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
;
;
;
;                                                                                                            
                                                                                                            
    ADD_instruction:  
        check_forbidden Forbidden_instruction,1
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        ;check_forbidden Forbidden_digits,0         
        
        check_forbidden Forbidden_instruction,1
    Sub_instruction:                               
        check_forbidden Forbidden_instruction,2
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,0         
        
        
    MUL_instruction:                               
        check_forbidden Forbidden_instruction,3
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,0         
        
        
    DIV_instruction: 
        check_forbidden Forbidden_instruction,4
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,0     
    AND_instruction: 
        check_forbidden Forbidden_instruction,5
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,0     
    OR_instruction: 
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,0                     
        check_forbidden Forbidden_instruction,6
    
    NOR_instruction: 
                                                                   
        check_forbidden Forbidden_instruction,7
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,0     
    XOR_instruction: 
        check_forbidden Forbidden_instruction,8    
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,0     
    SHR_instruction: 
        check_forbidden Forbidden_instruction,9    
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,0     
    SHL_instruction: 
        check_forbidden Forbidden_instruction,10    
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,0     
    ROR_instruction: 
        check_forbidden Forbidden_instruction,11    
    
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,0     
    ROL_instruction: 
        check_forbidden Forbidden_instruction,12     
    
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,0     
    PUSH_instruction: 
        check_forbidden Forbidden_instruction,13   
    
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,0     
    POP_instruction: 
        check_forbidden Forbidden_instruction,14    
    
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,14    
    INC_instruction: 
        check_forbidden Forbidden_instruction,15    
    
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,15     
    DEC_instruction: 
        check_forbidden Forbidden_instruction,16
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4
        check_forbidden Forbidden_Registers,index1 
        check_forbidden Forbidden_digits,16         
        
        
    ;------------------------------------------------------------------------------      
    lose_point:  
     
    
    
    
    hlt
    main endp
end main
    