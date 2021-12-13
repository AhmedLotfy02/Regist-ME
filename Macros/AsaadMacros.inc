;Author: Ahmed Asaad
;Date: 13th December, 2021

movCursor MACRO x, y
    ; Push all used regeister in stack to get their original value after the operation
    push ax
    push dx
    
    ; Intrrupt to mov the cursor to determined position
    mov ah, 2
    mov dl, x
    mov dh, y
    int 10h
    
    pop dx
    pop ax
    
ENDM movCursor

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
readString MACRO str
    ; Push all used regeister in stack to get their original value after the operation
    push ax
    push dx
    
    ; Intrrupt to read specific string from the keyboard
    mov ah, 0Ah
    mov dx, offset str
    int 21h
    
    pop dx
    pop ax
        
readString ENDM 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getMousePosition Macro x, y, stat
     ; Push all used regeister in stack to get their original value after the operation
     push ax
     push cx
     push bx
     push dx
     
     ;Intrrupt to get the mouse position x in CX, y in DX, Mouse status in BX
     mov ah, 3
     int 33h
     
     mov x, cx
     mov y, dx
     mov stat, bx
     
     pop dx
     pop bx
     pop cx
     pop ax

getMousePosition Endm
