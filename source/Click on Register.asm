;we will use the variables of the coordinates of the registers in the GUI
CickedRegister MACRO Name,value,NumberOfBytes
    local notAX,notAL,notAH,notBX,notBL,notBH,notCX,notCL,notCH,notDX,notDL,notDH,notSI,notDI,notSP,notBP
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    GETMOUSEPOSITION y,x
    mov ax,x
    mov bx,y

    ;AX
    CMP AX,word ptr AXCORDINATES[0]
    jl notAX
    cmp AX,word ptr AXCORDINATES[4]
    jg notAX
    cmp bx,word ptr AXCORDINATES[2]
    jl notAX
    cmp bx,word ptr AXCORDINATES[6]
    jg notAX
    mov Name,0
    mov value,0
    mov NumberOfBytes,2
    notAX:


    ;AL
    CMP AX,word ptr ALCORDINATES[0]
    jl notAL
    cmp AX,word ptr ALCORDINATES[4]
    jg notAL
    cmp bx,word ptr ALCORDINATES[2]
    jl notAL
    cmp bx,word ptr ALCORDINATES[6]
    jg notAL
    mov Name,1
    mov value,1
    mov NumberOfBytes,1
    notAL:

    ;AH
    CMP AX,word ptr AHCORDINATES[0]
    jl notAH
    cmp AX,word ptr AHCORDINATES[4]
    jg notAH
    cmp bx,word ptr AHCORDINATES[2]
    jl notAH
    cmp bx,word ptr AHCORDINATES[6]
    jg notAH
    mov Name,2
    mov value,0
    mov NumberOfBytes,1
    notAH:

    ;BX
    CMP AX,word ptr BXCORDINATES[0]
    jl notBX 
    cmp AX,word ptr BXCORDINATES[4]
    jg notBX 
    cmp bx,word ptr BXCORDINATES[2]
    jl notBX
    cmp bx,word ptr BXCORDINATES[6]
    jg notBX
    mov Name,3
    mov value,3
    mov NumberOfBytes,2
    notBX:

    
    ;BL
    CMP AX,word ptr BLCORDINATES[0]
    jl notBL
    cmp AX,word ptr BLCORDINATES[4]
    jg notBL
    cmp bx,word ptr BLCORDINATES[2]
    jl notBL
    cmp bx,word ptr BLCORDINATES[6]
    jg notBL
    mov Name,4
    mov value,3
    mov NumberOfBytes,1
    notBL:

    ;BH
    CMP AX,word ptr BHCORDINATES[0]
    jl notBH
    cmp AX,word ptr BHCORDINATES[4]
    jg notBH
    cmp bx,word ptr BHCORDINATES[2]
    jl notBH
    cmp bx,word ptr BHCORDINATES[6]
    jg notBH
    mov Name,5
    mov value,2
    mov NumberOfBytes,1
    notBH:

    ;CX
    CMP AX,word ptr CXCORDINATES[0]
    jl notCX
    cmp AX,word ptr CXCORDINATES[4]
    jg notCX
    cmp bx,word ptr CXCORDINATES[2]
    jl notCX
    cmp bx,word ptr CXCORDINATES[6]
    jg notCX
    mov Name,6
    mov value,4
    mov NumberOfBytes,2
    notCX:

    ;CL
    CMP AX,word ptr CLCORDINATES[0]
    jl notCL
    cmp AX,word ptr CLCORDINATES[4]
    jg notCL
    cmp bx,word ptr CLCORDINATES[2]
    jl notCL
    cmp bx,word ptr CLCORDINATES[6]
    jg notCL
    mov Name,7
    mov value,5
    mov NumberOfBytes,1
    notCL:

    ;CH
    CMP AX,word ptr CHCORDINATES[0]
    jl notCH
    cmp AX,word ptr CHCORDINATES[4]
    jg notCH
    cmp bx,word ptr CHCORDINATES[2]
    jl notCH
    cmp bx,word ptr CHCORDINATES[6]
    jg notCH
    mov Name,8
    mov value,4
    mov NumberOfBytes,1
    notCH:

    ;DX
    CMP AX,word ptr DXCORDINATES[0]
    jl notDX
    cmp AX,word ptr DXCORDINATES[4]
    jg notDX
    cmp bx,word ptr DXCORDINATES[2]
    jl notDX
    cmp bx,word ptr DXCORDINATES[6]
    jg notDX
    mov Name,9
    mov value,6
    mov NumberOfBytes,2
    notDX:

    ;DL
    CMP AX,word ptr DLCORDINATES[0]
    jl notDL
    cmp AX,word ptr DLCORDINATES[4]
    jg notDL
    cmp bx,word ptr DLCORDINATES[2]
    jl notDL
    cmp bx,word ptr DLCORDINATES[6]
    jg notDL
    mov Name,10
    mov value,7
    mov NumberOfBytes,1
    notDL:

    ;DH
    CMP AX,word ptr DHCORDINATES[0]
    jl notDH
    cmp AX,word ptr DHCORDINATES[4]
    jg notDH
    cmp bx,word ptr DHCORDINATES[2]
    jl notDH
    cmp bx,word ptr DHCORDINATES[6]
    jg notDH
    mov Name,11
    mov value,6
    mov NumberOfBytes,1
    notDH:

    ;SI
    CMP AX,word ptr SICORDINATES[0]
    jl notSI
    cmp AX,word ptr SICORDINATES[4]
    jg notSI
    cmp bx,word ptr SICORDINATES[2]
    jl notSI
    cmp bx,word ptr SICORDINATES[6]
    jg notSI
    mov Name,12
    mov value,8
    mov NumberOfBytes,2
    notSI:

    ;DI
    CMP AX,word ptr DICORDINATES[0]
    jl notDI
    cmp AX,word ptr DICORDINATES[4]
    jg notDI
    cmp bx,word ptr DICORDINATES[2]
    jl notDI
    cmp bx,word ptr DICORDINATES[6]
    jg notDI
    mov Name,13
    mov value,10
    mov NumberOfBytes,2
    notDI:

    ;SP
    CMP AX,word ptr SPCORDINATES[0]
    jl notSP
    cmp AX,word ptr SPCORDINATES[4]
    jg notSP
    cmp bx,word ptr SPCORDINATES[2]
    jl notSP
    cmp bx,word ptr SPCORDINATES[6]
    jg notSP
    mov Name,14
    mov value,12
    mov NumberOfBytes,2
    notSP:

    ;BP
    CMP AX,word ptr BPCORDINATES[0]
    jl notBP
    cmp AX,word ptr BPCORDINATES[4]
    jg notBP
    cmp bx,word ptr BPCORDINATES[2]
    jl notBP
    cmp bx,word ptr BPCORDINATES[6]
    jg notBP
    mov Name,15
    mov value,14
    mov NumberOfBytes,2
    notBP:



    
    
    POP DX
    POP CX
    POP BX
    POP AX
    
ENDM