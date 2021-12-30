.model large 
.stack 64
.Data 
; general variables ----------------------------------------------------------------------------------------------
; All instructions, digits and registers
instructions db "MOV ", "ADD ", "SUB ", "MUL ", "DIV ", "INC ", "DEC ", "NOP ", "SAL ", "SHR ", "SHL ", "ROR ", "ROL ", "SAR ","IDIV ", "IMUL "  
registers db "AX ", "AL ", "AH ", "BX ", "BL ", "BH ", "CX ", "CL ", "CH ", "DX ", "DL ", "DH ", "SI ", "DI ", "SP ", "BP ","val ","address "
digits db "0 ", "1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 ","A ","B ","C ","D ","E ","F "  

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
Forbidden_digits_1 db '0000000000000000'
Forbidden_Registers_1 db '0000000000000000'
Forbidden_instruction_1 db '0000000000000000' 
Forbidden_char1 db 'B'
intial_points_player1 db 60
losepoint_player1 db 0

data_segment_1 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 
Player1_Data_Register db 11h,22h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,05h
;------------------------AH  -Al -BH-Bl -CH  -CL-DH  -DL-  SI -     DI --   SP    - BP   -value-addressvalue----

; player2 Data variables --------------------------------------------------------------

Forbidden_digits_2 db '0000000000000000'
Forbidden_Registers_2 db '0000000000000000'
Forbidden_instruction_2 db '0000000000000000'
Forbidden_char2 db 'A'  
intial_points_player2 db 60
losepoint_player2 db 0

data_segment_2 db 0,0,0,0,0,9,0,0,0,0,0,0,0,0,0,0
Player2_Data_Register db 03h,02h,00h,07h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,05h,05h,00h,05h
;------------------------AH  -Al -BH-Bl -CH  -CL-DH  -DL-  SI -     DI --   SP    - BP   -value-addressvalue----   
 
;Comp_size to check if forbidden character is in array or not
; if 0 means its not there
; else  you should jump to lose_point label
check_forbidden macro Forbidden_array,index
    push Ax
    push bx
    mov bh,0
    mov bl,index  
    mov ah,Forbidden_array[bx] ;compare position at index in forbidden array
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
            mov Forbidden_array[bx],'1' ; forbidden for instruction with index = index 
    Dont_Set_bit:
    pop bx  
    pop Cx
    pop Ax
    pop Di
Endm check_forbidden


.code
           
           
set_forbidden_player1 proc near
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
        cmp si,56
        jnz loop_set_instruction  
        
        lea cx ,instructions[24] 
        set_forbidden cx ,Forbidden_instruction_2,Forbidden_char2,3,6 
        
        mov si,56
        mov dl,14
    loop_set_instruction2: 
        lea cx ,instructions[si]
        set_forbidden cx,Forbidden_instruction_2,Forbidden_char2,5,dl
        inc dl
        add si,5              
        cmp si,66
        jnz loop_set_instruction2     
           
;------------- loop on numbers ----------------------------------------------      
    mov si,0
    mov dl,0 
    loop_set_numbers: 
        lea cx ,digits[si]
        set_forbidden cx,Forbidden_digits_2,Forbidden_char2,2,dl
        inc dl
        add si,2              
        cmp si,32
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
    set_forbidden_player1 endp

set_forbidden_player2 proc near   ; player2 setforbidden for player1
;--------------------------- assume we have it Read it Later in Forbidden_Char2-----------------------------------------;     
    
    ; loop on 17 instruction to set 
;------instructoins,Forbidden_instruction,Forbidden_char2,17,------------------------------- 
    mov si,0
    mov dl,0 
    loop_set2_instruction: 
        lea cx ,instructions[si]
        set_forbidden cx,Forbidden_instruction_1,Forbidden_char1,4,dl
        inc dl
        add si,4              
        cmp si,56
        jnz loop_set2_instruction  
        
        lea cx ,instructions[24] 
        set_forbidden cx ,Forbidden_instruction_1,Forbidden_char1,3,6 
        
        mov si,56
        mov dl,14
    loop_set2_instruction2: 
        lea cx ,instructions[si]
        set_forbidden cx,Forbidden_instruction_1,Forbidden_char1,5,dl
        inc dl
        add si,5              
        cmp si,66
        jnz loop_set2_instruction2     
           
;------------- loop on numbers ----------------------------------------------      
    mov si,0
    mov dl,0 
    loop_set2_numbers: 
        lea cx ,digits[si]
        set_forbidden cx,Forbidden_digits_1,Forbidden_char1,2,dl
        inc dl
        add si,2              
        cmp si,32
        jnz loop_set2_numbers  
                                                                         
                                                                            
;------------- loop on regsiter 16------------------------------------------    

    mov si,0
    mov dl,0 
    loop_set2_registers: 
        lea cx ,registers[si]
        set_forbidden cx,Forbidden_Registers_1,Forbidden_char1,3,dl
        inc dl
        add si,3              
        cmp si,48
        jnz loop_set2_registers         
    ret
    set_forbidden_player2 endp

set_zero_forbidden_player1 proc near  
    
     mov cx,12
     mov si,0
     loop_set_zero_player1_reg:
     
     mov Forbidden_Registers_2[si],0
         inc si
         dec cx
     jnz  loop_set_zero_player1_reg
     mov cx,16
     mov si,0
     loop_set_zero_player1_digits:    
         mov Forbidden_digits_2[si],0
         inc si
         dec cx
     jnz  loop_set_zero_player1_digits
     mov cx,16
     mov si,0    
     loop_set_zero_player1_instructions:
         mov Forbidden_instruction_2[si],0
         inc si
         dec cx 
     jnz  loop_set_zero_player1_instructions    
    
     ret
     set_zero_forbidden_player1 endp
set_zero_forbidden_player2 proc near  
    
     mov cx,12
     mov si,0
     loop_set_zero_player2_reg:
     
     mov Forbidden_Registers_1[si],0
         inc si
         dec cx
     jnz  loop_set_zero_player2_reg
     mov cx,16
     mov si,0
     loop_set_zero_player2_digits:    
         mov Forbidden_digits_1[si],0
         inc si
         dec cx
     jnz  loop_set_zero_player2_digits
     mov cx,16
     mov si,0    
     loop_set_zero_player2_instructions:
         mov Forbidden_instruction_1[si],0
         inc si
         dec cx 
     jnz  loop_set_zero_player2_instructions    
    
     ret
     set_zero_forbidden_player2 endp
main proc far
    mov ax,@data
    mov ds,ax     
    mov ES,AX
    
    ; get forbidden character      
    
;--------------------------- assume we have it Read it Later in Forbidden_Char2-----------------------------------------;     
       call set_forbidden_player1
    
       call set_forbidden_player2
    
        call   set_zero_forbidden_player2
    
    
    
    
    
    hlt
    main endp
end main