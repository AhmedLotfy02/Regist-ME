.model small
.Data
; All instructions, digits and registers
instructions db "mov ", "add ", "sub ", "mul ", "div ", "and ", "or ", "nor ", "xor ", "shr ", "shl ", "ror ", "rol ", "push ", "pop ", "inc ", "dec "  
registers db "ax ", "al ", "ah ", "bx ", "bl ", "bh ", "cx ", "cl ", "ch ", "dx ", "dl ", "dh ", "si ", "di ", "sp ", "bp ","val "
Player1_Data_Register dw '0000','0000','0000','0000','0000','0000','0000','0000','0000'
;------------------------- Ax-----BX-----CX-----DX-----SI-----DI-----SP-----BP----value-----  
Player2_Data_Register dw '0000','0000','0000','0000','0000','0000','0000','0000','0000'
;------------------------- Ax-----BX-----CX-----DX-----SI-----DI-----SP-----BP----value-----
digits db "0 ", "1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 "  
index1 db ?
index2 db ?
index3 db ?
index4 db ?   
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
Endm check_forbidden

set_forbidden_digit macro 
    push DI
    push Ax
    push Cx 
    push bx 


    endm set_forbidden_digit

.code
           
           
set_forbidden_proc proc near
;--------------------------- assume we have it Read it Later in Forbidden_Char2-----------------------------------------;     
    
    ; loop on 17 instruction to set 
;------instructoins,Forbidden_instruction,Forbidden_char2,17,------------------------------- 
    mov si,0
    mov dl,0 
    loop_set_instruction: 
        lea cx ,instructions[si]
        set_forbidden cx,Forbidden_instruction_2,Forbidden_char2,4,dl
        inc dl
        add si,4              
        cmp si,24
        jnz loop_set_instruction  
        
        lea cx ,instructions[24] 
        set_forbidden cx ,Forbidden_instruction_2,Forbidden_char2,3,6 
        
        mov si,27
        mov dl,7
    loop_set_instruction2: 
        lea cx ,instructions[si]
        set_forbidden cx,Forbidden_instruction_2,Forbidden_char2,4,dl
        inc dl
        add si,4              
        cmp si,51
        jnz loop_set_instruction2     
        
        lea cx ,instructions[51] 
        set_forbidden cx ,Forbidden_instruction_2,Forbidden_char2,5,13 

        mov si,56
        
        mov dl,14
    loop_set_instruction3: 
        lea cx ,instructions[si]
        set_forbidden cx,Forbidden_instruction_2,Forbidden_char2,4,dl
        inc dl
        add si,4              
        cmp si,68
        jnz loop_set_instruction3    
;------------- loop on numbers ----------------------------------------------      
    mov si,0
    mov dl,0 
    loop_set_numbers: 
        lea cx ,digits[si]
        set_forbidden cx,Forbidden_digits_2,Forbidden_char2,2,dl
        inc dl
        add si,2              
        cmp si,10
        jnz loop_set_numbers  
                                                                         
                                                                            
;------------- loop on regsiter 16------------------------------------------    

    mov si,0
    mov dl,0 
    loop_set_registers: 
        lea cx ,registers[si]
        set_forbidden cx,Forbidden_Registers_2,Forbidden_char2,3,dl
        inc dl
        add si,3              
        cmp si,48
        jnz loop_set_registers         
    ret
    set_forbidden_proc endp           
main proc far
    mov ax,@data
    mov ds,ax     
    mov ES,AX
    
    ; get forbidden character      
    
;--------------------------- assume we have it Read it Later in Forbidden_Char2-----------------------------------------;     
       call set_forbidden_proc
    
    
    
    
    
    
    
    
    
    hlt
    main endp
end main