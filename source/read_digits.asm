.model small 
.stack 64
.data
value Db ?
ONE db ?         
TEMP1 DB ?
TEMP2 DB ?
TEMP3 DB ?
TEMP4 DB ?
TWO db ?
FOURDIGITS DB 2 DUB(?)
er db 'error','$'


.code 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printCharacter macro Char                                     ;Takes a character and displays it 
        mov dl,  Char 
        mov ah,  2h 
        int 21h 
    endm printCharacter
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DrawRegisterNAME macro Stringo 
local loop4 
mov di,0     
mov cx,5 
loop4: 
    printCharacter Stringo[di] 
    inc di 
    loop loop4 
endm 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
readonedgit MACRO digit    
    local    alphabet,next  ,notcapital,error 
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

mov ah,07
int 21h
mov ah,2
mov dl,al
int 21h
mov digit,al
cmp digit, 30h
jb alphabet
cmp digit,39h
ja alphabet
;if not alphabet :
sub digit,30h
jmp next

alphabet:
cmp digit,41h 
jb notcapital
cmp digit,46h
ja notcapital
sub digit,37h
jmp next

;if not capital 
notcapital:
cmp digit,61h
jb error
cmp digit,66h
ja error
sub digit,57h
jmp next


;if enter in valid number
error:
DrawRegisterNAME er 
next:      
 POP DX
    POP CX
    POP BX
    POP AX

; you need to jump zero after the macro jz mov_instruction  
ENDM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

readtwodigits MACRO TWODIGITS 
     PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    readonedgit TEMP
    readonedgit TWODIGITS 
    MOV AL,TEMP
    MOV CL,10H
    MUL CL     
    ADD TWODIGITS,AL 
    POP DX
    POP CX
    POP BX
    POP AX
ENDM 
READFOURDIGIT MACRO FOUR 
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    readonedgit TEMP1
    readonedgit TEMP2
    readonedgit TEMP3
    readonedgit TEMP4
    
    MOV AL,TEMP1
    MOV CL,10H
    MUL CL
    ADD AL,TEMP2
    MOV FOUR[1],AL
    
    MOV AL,TEMP3
    MUL CL
    ADD AL,TEMP4
    MOV FOUR,AL
 

    POP DX
    POP CX
    POP BX
    POP AX
ENDM 
main proc far
mov ax,@DATA
mov ds,ax      

READFOURDIGIT FOURDIGITS;test
MOV AX,WORD PTR FOURDIGITS;test

main endp
end main