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

moveToRightLabel MACRO
    local noTADD,noTCLC,noTDEC,noTINC,noTNOP,noTPOP,noTPUSH,noTRCL,noTRCR,noTROL,noTROR,notSAR,notSBB,notSHL,notSHR,notSUB,notXOR
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    GETMOUSEPOSITION MOUSEPOSITION_X,MOUSEPOSITION_Y
    MOV AX,MOUSEPOSITION_X
    MOV BX,MOUSEPOSITION_Y
    



    CMP AX,MOVCORDINATES[0]
    jl notmov
    cmp AX,MOVCORDINATES[2]
    jg notmov
    cmp bx,MOVCORDINATES[1]
    jl notmov
    cmp bx,MOVCORDINATES[3]
    jg notmov
    jump movlabel
    notmov:
    

    
    CMP AX,ADDCORDINATES[0]
    jl notADD
    cmp AX,ADDCORDINATES[2]
    jg notADD
    cmp bx,ADDCORDINATES[1]
    jl notADD
    cmp bx,ADDCORDINATES[3]
    jg noTADD
    jump ADDabel
    notADD:



    CMP AX,ADCCORDINATES[0]
    jl notADC
    cmp AX,ADCCORDINATES[2]
    jg notADC
    cmp bx,ADCCORDINATES[1]
    jl notADC
    cmp bx,ADCCORDINATES[3]
    jg notADC
    jump ADCLabel
    notADC:




    CMP AX,SUBCORDINATES[0]
    jl notSUB
    cmp AX,SUBCORDINATES[2]
    jg notSUB
    cmp bx,SUBCORDINATES[1]
    jl notSUB
    cmp bx,SUBCORDINATES[3]
    jg notSUB
    jump SUBLabel
    notSUB:




    CMP AX,SBBCORDINATES[0]
    jl notSBB
    cmp AX,SBBCORDINATES[2]
    jg notSBB
    cmp bx,SBBCORDINATES[1]
    jl notSBB
    cmp bx,SBBCORDINATES[3]
    jg notSBB
    jump SBBlabel
    notSBB:




    CMP AX,XORCORDINATES[0]
    jl notXOR
    cmp AX,XORCORDINATES[2]
    jg notXOR
    cmp bx,XORCORDINATES[1]
    jl noTXOR
    cmp bx,XORCORDINATES[3]
    jg notXOR
    jump XORlabel
    notXOR:



    CMP AX,ANDCORDINATES[0]
    jl notAND
    cmp AX,ANDCORDINATES[2]
    jg notAND
    cmp bx,ANDCORDINATES[1]
    jl notAND
    cmp bx,ANDCORDINATES[3]
    jg notAND
    jump ANDlabel
    notAND:


    CMP AX,ORCORDINATES[0]
    jl notOR
    cmp AX,ORCORDINATES[2]
    jg notOR
    cmp bx,ORCORDINATES[1]
    jl notOR
    cmp bx,ORCORDINATES[3]
    jg notOR
    jump ORlabel
    notOR:



    CMP AX,NOPCORDINATES[0]
    jl notNOP
    cmp AX,NOPCORDINATES[2]
    jg notNOP
    cmp bx,NOPCORDINATES[1]
    jl notNOP
    cmp bx,NOPCORDINATES[3]
    jg notNOP
    jump NOPlabel
    noTNOP:



    CMP AX,SHRCORDINATES[0]
    jl notSHR
    cmp AX,SHRCORDINATES[2]
    jg notSHR
    cmp bx,SHRCORDINATES[1]
    jl notSHR
    cmp bx,SHRCORDINATES[3]
    jg notSHR
    jump SHRlabel
    noTSHR:


    CMP AX,SHLCORDINATES[0]
    jl notSHL
    cmp AX,SHLCORDINATES[2]
    jg notSHL
    cmp bx,SHLCORDINATES[1]
    jl notSHL
    cmp bx,SHLCORDINATES[3]
    jg notSHL
    jump SHLlabel
    noTSHL:



CMP AX,SARCORDINATES[0]
    jl notSAR
    cmp AX,SARCORDINATES[2]
    jg notSAR
    cmp bx,SARCORDINATES[1]
    jl notSAR
    cmp bx,SARCORDINATES[3]
    jg notSAR
    jump SARlabel
    noTSAR:



CMP AX,CLCCORDINATES[0]
    jl notCLC
    cmp AX,CLCCORDINATES[2]
    jg notCLC
    cmp bx,CLCCORDINATES[1]
    jl notCLC
    cmp bx,CLCCORDINATES[3]
    jg notCLC
    jump CLClabel
    noTCLC:



CMP AX,RORCORDINATES[0]
    jl notROR
    cmp AX,RORCORDINATES[2]
    jg notROR
    cmp bx,RORCORDINATES[1]
    jl notROR
    cmp bx,RORCORDINATES[3]
    jg notROR
    jump RORlabel
    noTROR:

CMP AX,ROLCORDINATES[0]
    jl notROL
    cmp AX,ROLCORDINATES[2]
    jg notROL
    cmp bx,ROLCORDINATES[1]
    jl notROL
    cmp bx,ROLCORDINATES[3]
    jg notROL
    jump ROLlabel
    noTROL:


CMP AX,RCLCORDINATES[0]
    jl notRCL
    cmp AX,RCLCORDINATES[2]
    jg notRCL
    cmp bx,RCLCORDINATES[1]
    jl notRCL
    cmp bx,RCLCORDINATES[3]
    jg notRCL
    jump RCLlabel
    noTRCL:



CMP AX,RCRCORDINATES[0]
    jl notRCR
    cmp AX,RCRCORDINATES[2]
    jg notRCR
    cmp bx,RCRCORDINATES[1]
    jl notRCR
    cmp bx,RCRCORDINATES[3]
    jg notRCR
    jump RCRlabel
    noTRCR:

CMP AX,PUSHCORDINATES[0]
    jl notPUSH
    cmp AX,PUSHCORDINATES[2]
    jg notPUSH
    cmp bx,PUSHCORDINATES[1]
    jl notPUSH
    cmp bx,PUSHCORDINATES[3]
    jg notPUSH
    jump PUSHlabel
    noTPUSH:



CMP AX,POPCORDINATES[0]
    jl notPOP
    cmp AX,POPCORDINATES[2]
    jg notPOP
    cmp bx,POPCORDINATES[1]
    jl notPOP
    cmp bx,POPCORDINATES[3]
    jg notPOP
    jump POPlabel
    noTPOP:



CMP AX,INCCORDINATES[0]
    jl notINC
    cmp AX,INCCORDINATES[2]
    jg notINC
    cmp bx,INCCORDINATES[1]
    jl notINC
    cmp bx,INCCORDINATES[3]
    jg notINC
    jump INClabel
    noTINC:


CMP AX,DECCORDINATES[0]
    jl notDEC
    cmp AX,DECCORDINATES[2]
    jg notDEC
    cmp bx,DECCORDINATES[1]
    jl notDEC
    cmp bx,DECCORDINATES[3]
    jg notDEC
    jump DEClabel
    noTDEC:

    POP DX
    POP CX
    POP BX
    POP AX    
ENDM



