print2Number MACRO num
    local numerical,next,numerical2,next2
    pusha
    mov al,byte ptr num
    mov ah,0
    mov cl,10h
    div cl
    cmp al,0ah
    jb numerical
    add al,37h     
    mov dl,  al 
    push ax
    mov ah,  2h
    int 21h 
    pop ax
    jmp next
    numerical:
    add al,30h 
   
    mov dl,  al
    push ax
    mov ah,  2h
    int 21h 
    pop ax
    next:
    cmp ah,0ah
    jb numerical2
    add ah,37h     
    mov dl,  ah 
    push ax
    mov ah,  2h
    int 21h
    pop ax 
    jmp next2
    numerical2:
    add ah,30h 
    mov dl,  ah
    push ax
    mov ah,  2h
    int 21h
    pop ax
    next2:
    
    popa

ENDM   

print4number macro num
    print2number num[1]
    print2number num[0]
endm
