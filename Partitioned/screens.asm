;here we will onsert the interactive screens in the program
; the first screen will make the user choose between register

.model huge
.data
VALUE DB 'VALUE','$'
REGISTER DB 'REGISTER','$'
ADDRESS DB 'ADDRESS','$'
.code 
ClearScreen MACRO beginCol,beginRow,endCol,endRow 
    ; Push all used regeister in stack to get their original value after the operation 
    PUSHA
    mov ax,0600h
    mov bh,0
    ; assign registers to detrmined clear area
    mov cl,beginCol
    mov ch,beginRow
    mov dl,endCol
    mov dh,endRow
    ;interrupt to clear dtermined screen
    int 10h
    POPA        
ENDM

printCharacter macro Char    
    PUSH dx
    push ax                                 ;Takes a character and displays it

    mov dl,  Char
    mov ah,  2h
    int 21h

    POP ax
    pop dx
endm

DrawRec Macro Xb,Yb,Xen,Yen 
    local back1, back2, back3, back4
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
Print macro Stringo   
    PUSHA                                          ;Takes a string and prints it 
    mov AH, 09h 
    mov dx, offset Stringo 
    int 21h 
    POPA    
endm Print
DrawButtonMessage macro String
        local loop4
        pusha

        mov di,0   
        mov bh, '$' 
        loop4:
            printCharacter String[di]
            inc di
            mov bl, String[di]
            cmp bl, bh
        jne loop4

        popa
ENDM
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

;description:
; the first screen will make the user choose between register
FIRSTSCREEN PROC FAR
    movCursor 14,9
    DrawRec 130,90,170,190
    DrawButtonMessage ADDRESS
    

    movCursor 14,14
    DrawRec 210,90,250,190
    DrawButtonMessage REGISTER
    RET
FIRSTSCREEN ENDP

;THE SECOND SCREEN WILL MAKE THE USER CHOOSE BETWEEN REGISTER AND VALUE AND ADRESS
SECONDSCREEN PROC FAR
    movCursor 14,9
    DrawButtonMessage VALUE
    DrawRec 130,90,170,190
    
    movCursor 14,14
    DrawButtonMessage REGISTER
    DrawRec 210,90,250,190

    movCursor 14,19
    DrawButtonMessage ADDRESS
    DrawRec 290,90,330,190

    RET
SECONDSCREEN ENDP

MAIN PROC
    MOV AX,@DATA 
    MOV DS,AX 
    
    ;AH=0h: Set video mode 
    mov al, 12h ; Video mode number 
    mov ah, 0h 
    int 10h 
    CALL SECONDSCREEN
    RET    
MAIN ENDP
END MAIN