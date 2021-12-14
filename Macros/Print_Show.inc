;-----------------MACROS------
Print_Msg MACRO msg ; variable defined above with '$'at end
            push ax
            ;push dx      ;does we need to push dx?!
            mov ah,9h
            mov dx,offset msg 
            int 21h
            ;pop dx
            pop ax
ENDM Print_Msg

Show_mouse Macro 
    push ax
    mov ax,1
    int 33h    
    pop ax
Endm Show_mouse   
Clear_Screen macro

    ;push ax
    ;push cx
    mov ax,0600h 
    mov bh,07
    mov cx,0 
    mov dx,184FH
    int 10h
    ;pop cx
    ;pop ax
endm Clear_Scren=en