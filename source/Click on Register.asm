;we will use the variables of the coordinates of the registers in the GUI
CickedRegister MACRO Name,value,NumberOfBytes
    local notAX,notAL,notAH,notBX,notBL,notBH,notCX,notCL,notCH,notDX,notDL,notDH,notSI,notDI,notSP,notBP
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    GETMOUSEPOSITION MOUSEPOSITION_X,MOUSEPOSITION_Y
    MOV AX,MOUSEPOSITION_X
    MOV BX,MOUSEPOSITION_Y


    ;AX
    CMP AX,AXCORDINATES[0]
    jl notAX
    cmp AX,AXCORDINATES[2]
    jg notAX
    cmp bx,AXCORDINATES[1]
    jl notAX
    cmp bx,AXCORDINATES[3]
    jg notAX
    Name=0
    value=0
    NumberOfBytes=2
    notAX:


    ;AL
    CMP AX,ALCORDINATES[0]
    jl notAL
    cmp AX,ALCORDINATES[2]
    jg notAL
    cmp bx,ALCORDINATES[1]
    jl notAL
    cmp bx,ALCORDINATES[3]
    jg notAL
    Name=1
    value=1
    NumberOfBytes=1
    notAL:

    ;AH
    CMP AX,AHCORDINATES[0]
    jl notAH
    cmp AX,AHCORDINATES[2]
    jg notAH
    cmp bx,AHCORDINATES[1]
    jl notAH
    cmp bx,AHCORDINATES[3]
    jg notAH
    Name=2
    value=0
    NumberOfBytes=1
    notAH:

    ;BX
    CMP AX,BXCORDINATES[0]
    jl notBX 
    cmp AX,BXCORDINATES[2]
    jg notBX 
    cmp bx,BXCORDINATES[1]
    jl notBX
    cmp bx,BXCORDINATES[3]
    jg notBX
    Name=3
    value=3
    NumberOfBytes=2
    notBX:

    
    ;BL
    CMP AX,BLCORDINATES[0]
    jl notBL
    cmp AX,BLCORDINATES[2]
    jg notBL
    cmp bx,BLCORDINATES[1]
    jl notBL
    cmp bx,BLCORDINATES[3]
    jg notBL
    Name=4
    value=3
    NumberOfBytes=1
    notBL:

    ;BH
    CMP AX,BHCORDINATES[0]
    jl notBH
    cmp AX,BHCORDINATES[2]
    jg notBH
    cmp bx,BHCORDINATES[1]
    jl notBH
    cmp bx,BHCORDINATES[3]
    jg notBH
    Name=5
    value=2
    NumberOfBytes=1
    notBH:

    ;CX
    CMP AX,CXCORDINATES[0]
    jl notCX
    cmp AX,CXCORDINATES[2]
    jg notCX
    cmp bx,CXCORDINATES[1]
    jl notCX
    cmp bx,CXCORDINATES[3]
    jg notCX
    Name=6
    value=4
    NumberOfBytes=2
    notCX:

    ;CL
    CMP AX,CLCORDINATES[0]
    jl notCL
    cmp AX,CLCORDINATES[2]
    jg notCL
    cmp bx,AXCORDINATES[1]
    jl notCL
    cmp bx,CLCORDINATES[3]
    jg notCL
    Name=7
    value=5
    NumberOfBytes=1
    notCL:

    ;CH
    CMP AX,CHCORDINATES[0]
    jl notCH
    cmp AX,CHCORDINATES[2]
    jg notCH
    cmp bx,CHCORDINATES[1]
    jl notCH
    cmp bx,CHCORDINATES[3]
    jg notCH
    Name=8
    value=4
    NumberOfBytes=1
    notCH:

    ;DX
    CMP AX,DXCORDINATES[0]
    jl notDX
    cmp AX,DXCORDINATES[2]
    jg notDX
    cmp bx,DXCORDINATES[1]
    jl notDX
    cmp bx,DXCORDINATES[3]
    jg notDX
    Name=9
    value=6
    NumberOfBytes=2
    notDX:

    ;DL
    CMP AX,DLCORDINATES[0]
    jl notDL
    cmp AX,DLCORDINATES[2]
    jg notDL
    cmp bx,DLCORDINATES[1]
    jl notDL
    cmp bx,DLCORDINATES[3]
    jg notDL
    Name=10
    value=7
    NumberOfBytes=1
    notDL:

    ;DH
    CMP AX,DHCORDINATES[0]
    jl notDH
    cmp AX,DHCORDINATES[2]
    jg notDH
    cmp bx,DHCORDINATES[1]
    jl notDH
    cmp bx,DHCORDINATES[3]
    jg notDH
    Name=11
    value=6
    NumberOfBytes=1
    notDH:

    ;SI
    CMP AX,SICORDINATES[0]
    jl notSI
    cmp AX,SICORDINATES[2]
    jg notSI
    cmp bx,SICORDINATES[1]
    jl notSI
    cmp bx,SICORDINATES[3]
    jg notSI
    Name=12
    value=8
    NumberOfBytes=2
    notSI:

    ;DI
    CMP AX,DICORDINATES[0]
    jl notDI
    cmp AX,DICORDINATES[2]
    jg notDI
    cmp bx,DICORDINATES[1]
    jl notDI
    cmp bx,DICORDINATES[3]
    jg notDI
    Name=13
    value=10
    NumberOfBytes=2
    notDI:

    ;SP
    CMP AX,SPCORDINATES[0]
    jl notSP
    cmp AX,SPCORDINATES[2]
    jg notSP
    cmp bx,SPCORDINATES[1]
    jl notSP
    cmp bx,SPCORDINATES[3]
    jg notSP
    Name=14
    value=12
    NumberOfBytes=2
    notSP:

    ;BP
    CMP AX,BPCORDINATES[0]
    jl notBP
    cmp AX,BPCORDINATES[2]
    jg notBP
    cmp bx,BPCORDINATES[1]
    jl notBP
    cmp bx,BPCORDINATES[3]
    jg notBP
    Name=15
    value=14
    NumberOfBytes=2
    notBP:



    
    
    POP DX
    POP CX
    POP BX
    POP AX
    
ENDM