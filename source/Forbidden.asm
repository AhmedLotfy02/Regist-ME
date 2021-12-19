.model small
.Data
; All instructions, digits and registers
instructoins db "mov", "add", "sub", "mul", "div", "and", "or", "nor", "xor", "shr", "shl", "ror", "rol", "push", "pop", "inc", "dec"  
registers db "ax", "al", "ah", "bx", "bh", "bl", "cx", "cl", "ch", "dx", "dl", "dh", "si", "di", "sp", "bp","val"
Player1_Data_Register dw '0000','0000','0000','0000','0000','0000','0000','0000','0000'
;------------------------- Ax-----BX-----CX-----DX-----SI-----DI-----SP-----BP----value-----  
Player2_Data_Register dw '0000','0000','0000','0000','0000','0000','0000','0000','0000'
;------------------------- Ax-----BX-----CX-----DX-----SI-----DI-----SP-----BP----value-----
digits db "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"  
index1 db ?
index2 db ?
index3 db ?
index4 db ?   
count_bit_1 db ?   
count_bit_2 db ?

;Forbidden Arrays to check if it is forbidden or not, if the corresponding index has value 1, it is forbidden  
Forbidden_digits db '0000000000'
Forbidden_Registers '0000000000000000'
Forbidden_instruction db '00000000000000000'
Forbidden_char1 db 'o'
Forbidden_char2 db '0'   

 
;Comp_size to check if forbidden character is in array or not
; if 0 means its not there
; else  you should jump to lose_point label
check_forbidden PROC NEAR Forbidden_array,index
    push Ax
    push bx
    mov bh,0
    mov bl,index  
    mov ah,Forbidden_array+bx ;compare position at index in forbidden array
    cmp ah,'1' ; compare        
    pop bx  
    pop Ax
    jz lose_point    ; jmp here or outside ?! to be discussed later
Endp check_forbidden

set_forbidden PROC NEAR instruction_name,Forbidden_array,Forbidden_char,size,index
    local Set_bit
    local Dont_Set_bit
    push DI
    push Ax
    push Cx 
    push bx 
    
    mov DI,offset instruction_name 
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
Endp check_forbidden

.code

main proc far
    mov ax,@data
    mov ds,ax     
    mov ES,AX
    ; get forbidden character
    
    ; loop on 17 instruction to set 
    
    ; loop on numbers
    
    ; loop on regsiter 16
    
    
    
    ;  

    Mov_instruction: 
        check_forbidden Forbidden_instruction,0 
        
        ; call macro that check register & value & addressing mode
        ; bolbol index1,index2,index3,index4 
        
        check_forbidden Forbidden_Registers,index1
        
        ; call bolbol function
        ; check if index2 is value or register
        mov al, index2
        cmp al,16
        jz check_forbidden_digit_mov
        jnz check_forbidden_regsiter_mov 
        check_forbidden_digit_mov:
            check_forbidden Forbidden_digits,0 
            ;jmp to next calculation 
        check_forbidden_regsiter_mov:
            check_forbidden Forbidden_Registers,index2  
            
               
    
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
    