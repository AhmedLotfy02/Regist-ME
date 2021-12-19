
.model huge

.stack 64



.data    
Y_Begin_Box dw 0010 
Y_END_Box dw 0035
X_Begin_Box dw 0010
X_END_Box dw 0030
Y_Begin_Ins dw 0002 
LeftIns_X dw 0002
RightIns_X dw 0007 
Clear_X db 00
Clear_Y db 00
MovIns db 'MOV','$' 
ADDIns db 'ADD','$'
ADCIns db 'ADC','$'
SUBIns db 'SUB','$'
SBBIns db 'SBB','$'
XORIns db 'XOR','$'   
ANDIns db 'AND','$'
ORIns db 'OR','$'
NOPIns db 'NOP','$'
SHRIns db 'SHR','$'
SHLIns db 'SHL','$'
SARIns db 'SAR','$'
CLCIns db 'CLC','$'
RORIns db 'ROR','$'
RCLIns db 'RCL','$'
RCRIns db 'RCR','$'
PUSHIns db 'PUSH','$'
POPIns db 'POP','$'
INCIns db 'INC','$'
DECIns db 'DEC','$'




.code       




Print_Ins MACRO ins1,ins2,y
        LOCAL loop1 ,loop2
        push ax
        push dx
        push cx
        
    mov cx,03  
    mov di,0 
            mov dl, byte ptr   LeftIns_X
     mov dh,byte ptr    Y_Begin_Ins  
     
    movCursor dl  ,dh
     loop1:
        
      
      mov ah,2
mov dl,ins1[di]
int 21h    
inc di
       dec cx 
       
      jnz loop1  
      
    
      
       mov cx,03  
    mov di,0 
     mov dl, byte ptr   RightIns_X
     mov dh,byte ptr    Y_Begin_Ins  
     
    movCursor dl  ,dh  
     loop2:
        
      
      mov ah,2
mov dl,ins2[di]
int 21h    
inc di
       dec cx 
       
      jnz loop2  
                 add  Y_Begin_Ins,2 
      
        pop ax
        pop dx
    
    endm

 Clear_Ins MACRO  
    push dx
    push ax
    push bx
    push cx
                         mov dx,24 
          loop1:   
          movCursor Clear_X,Clear_Y  
             
             
        mov ah,9 ;Display
mov bh,0 ;Page 0
mov al,44h ;Letter D
mov cx,10h ;5 times
mov bl,0000h ;Green (A) on white(F) background
int 10h  
      inc   Clear_Y
      dec dx
      jnz loop1 
      pop cx
      pop bx
      pop ax
      pop dx
      endm

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

DrawRec Macro Xb,Yb,Xen,Yen  
    LOCAL backone,back2,back3,back4
    push ax
    push dx
    push cx
    
mov cx,Yb ;Column
mov dx,Xb ;Row
mov al,5 ;Pixel color
mov ah,0ch ;Draw Pixel Command



backone: int 10h
inc cx
cmp cx,Yen
jnz backone 

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

pop cx
pop dx
pop ax
endm
  drawIns MACRO ins1,ins2 ,y
    push ax
    push dx  
    mov ah,2 
     mov dh,byte ptr y
    mov dl,byte ptr   LeftIns_X
;mov dx,0302h
int 10h
    mov ah, 9
    mov dx, offset ins1
    int 21h  
    
       
    ;DrawRec X_Begin_Box,Y_Begin_Box,X_END_Box,Y_END_Box
    ;add Y_Begin_Box,40
    ;add Y_END_Box,40
    
    mov ah,2
    mov dh,byte ptr y
    mov dl,byte ptr RightIns_X
;mov dx,0307h
int 10h
    mov ah, 9
    mov dx, offset ins2
    int 21h  
    
  add  Y_Begin_Ins,2
        
       ;DrawRec X_Begin_Box,Y_Begin_Box,X_END_Box,Y_END_Box
              
             ; sub Y_Begin_Box,40
    ;sub Y_END_Box,40
       
            ;add X_Begin_Box,30  
    ;add X_END_Box,30      
     mov dl, byte ptr   LeftIns_X
     mov dh,byte ptr    Y_Begin_Ins  
     mov ah,byte ptr        RightIns_X
    
    pop dx
    pop ax
endm



main proc far
     mov ax,@data
     mov ds,ax
            
    
 mov ah,0
mov al,12h 
int 10h        

        ;Draw Instructions 
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
        drawIns MOVIns,ADDIns,Y_Begin_Ins

       drawIns MOVIns,ADDIns,Y_Begin_Ins   
       
       drawIns ADCIns,SUBIns,Y_Begin_Ins   
        ;                       
          
       drawIns SBBIns,XORIns,Y_Begin_Ins
        
        drawIns ANDIns,ORIns,Y_Begin_Ins
        
       drawIns NOPIns,SHRIns,Y_Begin_Ins     
      
        drawIns SHLIns,SARIns,Y_Begin_Ins
         
        
       drawIns CLCIns,RORIns,Y_Begin_Ins
      ; 
        
        drawIns RCLIns,RCRIns,Y_Begin_Ins
         
        drawIns PUSHIns,POPIns,Y_Begin_Ins
        drawIns INCIns,DECIns,Y_Begin_Ins  
          Clear_Ins   
        
      
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        ;
         ;End Draw Instructions
         
main endp


end main