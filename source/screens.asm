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
    PUSHA                                 ;Takes a character and displays it
    mov dl,  Char
    mov ah,  2h
    int 21h
    POPA
endm

DrawRec Macro Xb,Yb,Xen,Yen  
    local back1, back2, back3, back4 
    PUSHA
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
    POPA 
ENDM 
Print macro Stringo   
    PUSHA                                          ;Takes a string and prints it 
    mov AH, 09h 
    mov dx, offset Stringo 
    int 21h 
    POPA    
endm Print
DrawRegisterNAME macro Stringo
        local loop4,ENDED
        PUSHA
        mov di,0    
        mov cL,'$'
        loop4:
            CMP CL,STRINGO[DI]
            JZ ENDED
            printCharacter Stringo[di]
            inc di
            JMP LOOP4
        ENDED:
        POPA
ENDM
movCursor MACRO x, y
        ; Push all used regeister in stack to get their original value after the operation
        PUSHA
        
        ; Intrrupt to mov the cursor to determined position
        mov ah, 2h
        mov dl, x
        mov dh, y
        int 10h
        
        POPA
        
ENDM movCursor

;description:
; the first screen will make the user choose between register
firstScreen MACRO
    ;ClearScreen 0,0,50,20
    MOVCURSOR 14,9
    DRAWREGISTERNAME address
    DrawRec 130,90,170,160

    movCursor 14,14
    DRAWREGISTERNAME REGISTER
    DRAWREC 210,90,250,160
ENDM

;THE SECOND SCREEN WILL MAKE THE USER CHOOSE BETWEEN REGISTER AND VALUE AND ADRESS
SECONDSCREEN MACRO
    MOVCURSOR 14,9
    DRAWREGISTERNAME VALUE
    DrawRec 130,90,170,160
    
    movCursor 14,14
    DRAWREGISTERNAME REGISTER
    DRAWREC 210,90,250,160

    movCursor 14,19
    DRAWREGISTERNAME ADDRESS
    DRAWREC 290,90,330,160

ENDM

MAIN PROC
    MOV AX,@DATA 
    MOV DS,AX 
    
    ; AH=0h: Set video mode 
    mov al, 12h ; Video mode number 
    mov ah, 0h 
    int 10h 
    firstscreen
MAIN ENDP
END MAIN