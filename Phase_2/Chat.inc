
;---------------------------------- PROCEDURES ----------------------------------------------------
    drawHorizontalLine proc NEAR
        mov cx, 79
        setTextCursor 0, 12
        Draw:
            printCharacter '_'
        loop Draw
        ret 
    drawHorizontalLine endp

    getCursorPosition  PROC NEAR
        mov ah,3h
        mov bh,0h
        int 10h
        ret 
    getCursorPosition ENDP
    
    sendChar proc near
        mov dx , 3FDH		
        AGAIN:  
            In al , dx 			
            AND al , 00100000b
            jz finishSendChar
            resumeSend:
            mov dx , 3F8H		
            mov  al,CHAR
            out dx , al
        finishSendChar:
            ret
    sendChar endp

    receiveChar proc NEAR 
        mov dx , 3FDH
        CHK: in al , dx
        AND al , 1
        Jnz resumeRec
        jmp far ptr chatLoop
        resumeRec:
        mov dx , 03F8H
        in al , dx
        mov CHAR , al
        ret
    receiveChar endp

    sender proc NEAR
        mov ah,1 ;check if there is a char to read
        int 16h
        jnz readBuffer
        jmp finishSend; if not, go to receive
        readBuffer:
        mov ah,0; read the character from buffer
        int 16h
        mov CHAR,al        
        call SendChar
        
        cmp CHAR, 1BH; if ESC, close chat
        jne continueChecking
        jmp ExitChat
        continueChecking: 
        cmp CHAR, 13; if enter, endline
        je newLine

        cmp CHAR, 08h; if it is backspace, print space ' '
        jne notSendBackSpace
        jmp SendBackSpace
        
        notSendBackSpace:
        setTextCursor currsendcol, currsendrow
        printCharacter CHAR
        call getCursorPosition
        mov currsendrow, dh
        mov currsendcol, dl
        cmp currsendcol, 79
        jne finishsend
        newLine:inc currsendrow
        cmp currsendrow, 11
        jb continueSend 

        scrollUP 0, 0, 79, 11
        mov currsendrow, 10
        continueSend:
            mov currsendcol, 0
            jmp finishSend

        SendBackSpace: 
            cmp currsendcol, 0
            jne printSpace
            jmp finishSend
            printSpace: dec currsendcol
            setTextCursor currsendcol, currsendrow
            printCharacter ' '
        finishSend:
        ret
    sender endp

    
    receiver proc near
        
        call receiveChar
        cmp CHAR, 13; if enter, end line
        je newLineRec 
        cmp CHAR, 1BH; if ESC, close chat
        jne  resumeReceiving
        jmp ExitChat   
        
        cmp CHAR, 08h; if it is backspace, print space ' '
        jne resumeReceiving
        jmp RecBackSpace
        
        resumeReceiving:
        setTextCursor CurrRecCol,currRecRow
        printCharacter CHAR
        call getCursorPosition
        mov currRecRow, dh
        mov currReccol, dl
        cmp currReccol, 79
        jne finishreceive
        newLineRec:inc currrecrow
        cmp currRecrow, 24
        jb continuereceive  
        scrollUP 0, 13, 79, 24
        mov currRecrow, 23
        continuereceive:
            mov currReccol, 0
            jmp finishReceive

        RecBackSpace:
            cmp currreccol, 0
            jne printBacSpace1
            jmp finishreceive
            printBacSpace1:
                dec currreccol
                setTextCursor currRecCol, currRecRow
                printCharacter ' '
                
        finishreceive:
        ret
    receiver endp 

    MainChatting PROC NEAR 
        CLEARsCREEN 0,0, 79, 24
        CALL drawHorizontalLine
        chatLoop:
            call Sender
            call Receiver 
        jmp chatloop
        ExitChat:
            CLEARsCREEN 0,0, 79, 24
            jmp return_after_finish
        ret
    MainChatting ENDP 
 