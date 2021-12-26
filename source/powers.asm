.model small 
.stack 64
.Data
; All instructions, digits and registers
instructions db "mov ", "add ", "sub ", "mul ", "div ", "and ", "or ", "nor ", "xor ", "shr ", "shl ", "ror ", "rol ", "push ", "pop ", "inc ", "dec "  
registers db "ax ", "al ", "ah ", "bx ", "bl ", "bh ", "cx ", "cl ", "ch ", "dx ", "dl ", "dh ", "si ", "di ", "sp ", "bp ","val ","address "
Player1_Data_Register dw 0001h,0002h,0003h,0004h,0005h,0006h,0007h,0008h,0000h,0005h
;-------------------------Ax----BX-----CX---DX-----SI----DI---SP---BP----value-addressvalue----  
Player2_Data_Register dw  0009h,0000h,0000h,0000h,0000h,0000h,0000h,0000h,0000h,0005h
;-------------------------Ax----BX-----CX---DX-----SI----DI---SP---BP----value-addressvalue----    
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

 
intial_points_player1 db 60
intial_points_player2 db 60 


power3_player1_used db 0
power3_player2_used db 0

power5_player1_used db 0
power5_player2_used db 0
 
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
  
    call power5_player1 
    call power5_player2     

    hlt
    main endp                                                                                                

; power up 3 change forbidden character ----------------------------------------------------------------------------
power3_player1 proc near                                             
    
   

    cmp power3_player1_used,1
    jz power3_used_by_player1
    ; check if intial points are greater than 30 so that can use power 
    cmp intial_points_player1,30
    jb not_enough_points_3_player1    
    mov cx,8
    mov si,0
    mov power3_player1_used ,1 
    sub intial_points_player1,8  
    ; read a character from user ----------------------
    
        ; subcode to put later
    
    ;
    ;mov Forbidden_char2,  read_character
    
    
    ; cannot be executed -----------------------------
    not_enough_points_3_player1:
     
    power3_used_by_player1:  
    
    ret
    power3_player1 endp

power3_player2 proc near                                             
    
   

    cmp power3_player2_used,1
    jz power3_used_by_player2
    ; check if intial points are greater than 30 so that can use power 
    cmp intial_points_player2,30
    jb not_enough_points_3_player2    
    mov cx,8
    mov si,0
    mov power3_player2_used ,1 
    sub intial_points_player2,8  
    ; read a character from user ----------------------
    
        ; subcode to put later
    
    ;
    ;mov Forbidden_char1,  read_character
    
    
    ; cannot be executed -----------------------------
    not_enough_points_3_player2:
     
    power3_used_by_player2:  
    
    ret
    power3_player2 endp
; power up 5 clear all registers ----------------------------------------------------------------------------
power5_player1 proc near                                             
    cmp power5_player1_used,1
    jz power5_used_by_player1
    ; check if intial points are greater than 30 so that can use power 
    cmp intial_points_player1,30
    jb not_enough_points_player1    
    mov cx,8
    mov si,0
    mov power5_player1_used ,1 
    sub intial_points_5_player1,30
    clear_registers_player1:
        mov Player1_Data_Register[si],0
        add si,2  
        dec cx
    jnz clear_registers_player1
    ; cannot be executed -----------------------------
    not_enough_points_5_player1:
     
    power5_used_by_player1:
    ret
    power5_player1 endp
power5_player2 proc near                                             
    
    cmp power5_player2_used,1
    jz power5_used_by_player2
    ; check if intial points are greater than 30 so that can use power 
    cmp intial_points_player2,30
    jb not_enough_points_5_player2    
    mov cx,8
    mov si,0
    mov power5_player2_used ,1 
    sub intial_points_player2,30
    clear_registers_player2:
        mov Player2_Data_Register[si],0
        add si,2  
        dec cx
    jnz clear_registers_player2
    
    ; cannot be executed -----------------------------
    not_enough_points_5_player2:
     
    power5_used_by_player2:
    ret
    power5_player2 endp
end main