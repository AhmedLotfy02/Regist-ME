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


DisplayChar macro x,y,char
    ; Push all used regeister in stack to get their original value after the operation 
    push ax
    push bx
    ; assign two registers with location of displayed char to call mov Cursor
    mov ah,x
    mov al,y
    ; mov cursor to detrmined location
    movCursor ah,al
    ;interrupt to display char
    mov  al, char
    mov  bh, 0    ;Display page
    mov  ah, 0Eh  ;Teletype
    int  10h
    pop bx
    pop ax   
ENDM DisplayChar


GetKeyPressed macro 
    push ax
    CHECK: mov ah,1
    int 16h
    ;will store the results in the related variables 
    mov KeyPressedScanCode,ah
    mov KeyPressedAsciiCode,al
    jz CHECK
    pop ax
ENDM GetKeyPressed




HideMouse macro
    push ax
    mov ax,2
    int 33h
    pop ax
ENDM HideMouse