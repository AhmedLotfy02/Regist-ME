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
getMousePosition Macro x, y
     ; Push all used regeister in stack to get their original value after the operation 
     ShowMouse
     local Mypos
     push ax
     push cx
     push bx
     push dx
     
     ;Intrrupt to get the mouse position x in CX, y in DX, Mouse status in BX
     mov ax, 3
     mov bx,0
     Mypos:int 33h
     cmp bx,1           ; on click will close the loop
     ;jz print 
     jnz print          ; should jump to print_other_user_Commands after 
     mov x, cx
     mov y, dx
     
     pop dx
     pop bx
     pop cx
     pop ax              ; you need to jump zero after the macro jz mov_instruction  
     HideMouse

getMousePosition Endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HideMouse macro
    push ax
    mov ax,2
    int 33h
    pop ax
ENDM HideMouse

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ClearScreen MACRO beginCol,beginRow,endCol,endRow 
    ; Push all used regeister in stack to get their original value after the operation 
    push ax
    push bx
    push cx
    push dx
    mov ax,0600h
    mov bh,07
    ; assign registers to detrmined clear area
    mov cl,beginCol
    mov ch,beginRow
    mov dl,endCol
    mov dh,endRow
    ;interrupt to clear dtermined screen
    int 10h
    pop dx
    pop cx
    pop bx
    pop ax
    
ENDM

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
movCursorToRightPosition MACRO 
    push ax
    push bx
    push cx
    push dx


    ; check if mouse position in text box in click 
    getMousePosition cx,dx,bx
    cmp cx,10
    jl notinbox
    cmp cx,70
    jg notinbox
    cmp dx,20
    jl notinbox
    ;if it in the text box will move the cursor to text box 
    movCursor 10,70

    notinbox: 

    pop dx
    pop cx
    pop bx
    pop ax
ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DrawRec Macro Xb,Yb,Xen,Yen 
PUSH AX
PUSH DX
PUSH CX
mov cx,Yb ;Column
mov dx,Xb ;Row
mov al,5 ;Pixel color
mov ah,0ch ;Draw Pixel Command



back1: int 10h
inc cx
cmp cx,Yen
jnz back1 

mov cx,Yb ;Column
mov dx,Xen ;Row

back2: int 10h
inc cx
cmp cx,Yen
jnz back2 

mov cx,Yb ;Column
mov dx,Xb ;Row
         
back3: int 10h
inc dx
cmp dx,xen
jnz back3

mov cx,Yen ;Column
mov dx,Xb ;Row
         
back4: int 10h
inc dx
cmp dx,xen
jnz back4
POP CX 
POP DX
POP AX

ENDM
