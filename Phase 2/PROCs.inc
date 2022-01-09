MOVPLAYER1PR PROC NEAR
            ; call draw function or proc of player1
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
            call change_src_dest
            
            cmp power_up_player1,1
            jz mov_power_up1_player1
            cmp power_up_player1,2
            jz mov_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_mov_player1 
            mov_power_up1_player1: 
                cmp intial_points_player1,5
                JB nopoints_mov_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_mov_powerup1_p1 
                nopoints_mov_powerup1_p1:
                jmp far ptr end_MOV_instruction_player1
                can_perform_mov_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1 
                    sub intial_points_player1,5
                    jmp perform_mov_player1 
            mov_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_mov_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_mov_powerup2_p1 
                nopoints_mov_powerup2_p1:
                jmp far ptr end_MOV_instruction_player1
                can_perform_mov_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_mov_player1
                perform_mov_player1:
                        CMP FORBIDDEN_INSTRUCTION_1[0],'1'
                        JZ end_MOV_instruction_player1
                        mov instruction_index,0
                        mov al,address_mode
                        cmp al,1
                        jz address_mode_mov1
                        jmp reg_mode_mov1                
                    address_mode_mov1:  
                        call  mov_address_player1
                        jmp far ptr end_MOV_instruction_player1
                    reg_mode_mov1:
                        call  mov_register_player1 
                jmp far ptr end_MOV_instruction_player1
		end_MOV_instruction_player1:   
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player1,0
		
		RET
MOVPLAYER1PR ENDP

ADDPLAYER1PR  PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
            call change_src_dest
        cmp power_up_player1,1
            jz add_power_up1_player1
            cmp power_up_player1,2
            jz add_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_add_player1 
            add_power_up1_player1: 
                cmp intial_points_player1,5
                JB nopoints_add_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_add_powerup1_p1 
                nopoints_add_powerup1_p1:
                jmp far ptr endADD_instruction_player1
                can_perform_add_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1
                    sub intial_points_player1,5
                    jmp perform_add_player1 
            add_power_up2_player1:  
                cmp intial_points_player1,3
                JB nopoints_add_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_add_powerup2_p1 
                nopoints_add_powerup2_p1:
                jmp far ptr endADD_instruction_player1
                can_perform_add_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1 
                    sub intial_points_player1,3
                    jmp perform_add_player1
                perform_add_player1:
                                        CMP FORBIDDEN_INSTRUCTION_1[1],'1'
            JZ endADD_instruction_player1
                        mov instruction_index,1
                        mov al,address_mode
                        cmp al,1
                        jz address_mode_add1
                        jmp reg_mode_add1                 
                    address_mode_add1:  
                        call  mov_address_player1
                        jmp far ptr endADD_instruction_player1
                    reg_mode_add1:      
                        call  mov_register_player1    
                  jmp far ptr endADD_instruction_player1
		endADD_instruction_player1:
        	;mov address_mode ,0
	; mov address_mode2 ,0
	 mov power_up_player1,0
		RET
ADDPLAYER1PR  ENDP
SUBPLAYER1PR  PROC NEAR
; call drawing and clicking procedure --------------------------------

            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest          
 cmp power_up_player1,1
            jz sub_power_up1_player1
            cmp power_up_player1,2
            jz sub_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_sub_player1 
            sub_power_up1_player1:
                cmp intial_points_player1,5
                JB nopoints_Sub_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Sub_powerup1_p1 
                nopoints_Sub_powerup1_p1:
                jmp far ptr endSUB_instruction_player1
                can_perform_Sub_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1   
                    sub intial_points_player1,5
                    jmp perform_sub_player1 
            sub_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_Sub_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Sub_powerup2_p1 
                nopoints_Sub_powerup2_p1:
                jmp far ptr endSUB_instruction_player1
                can_perform_Sub_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1 
                    sub intial_points_player1,3
                    jmp perform_sub_player1
            perform_sub_player1:
                                    CMP FORBIDDEN_INSTRUCTION_1[2],'1'
            JZ endSUB_instruction_player1
                        mov instruction_index,2
                        mov al,address_mode
                        cmp al,1
                        jz address_mode_sub1
                        jmp reg_mode_sub1        
                        ; address mode processing ---------------------------------------------------------         
                    address_mode_sub1:  
                        call  mov_address_player1
                        jmp far ptr endSUB_instruction_player1
                    reg_mode_sub1:                
                        call  mov_register_player1    
                  jmp far ptr endSUB_instruction_player1
	endSUB_instruction_player1:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player1,0
	RET
SUBPLAYER1PR endp

MULPLAYER1PR PROC NEAR
            CALL SHOW_1ST_OPERAND

call change_src_dest 
cmp power_up_player1,1
            jz mul_power_up1_player1
            cmp power_up_player1,2
            jz mul_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_mul_player1 
            mul_power_up1_player1:
                cmp intial_points_player1,5
                JB nopoints_mul_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_mul_powerup1_p1 
                nopoints_mul_powerup1_p1:
                jmp far ptr endMUL_instruction_player1
                can_perform_mul_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1
                    sub intial_points_player1,5
                    jmp perform_mul_player1 
            mul_power_up2_player1: 
                cmp intial_points_player1,3
                JB nopoints_mul_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_mul_powerup2_p1 
                nopoints_mul_powerup2_p1:
                jmp far ptr endMUL_instruction_player1
                can_perform_mul_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_mul_player1
            perform_mul_player1:
                                    CMP FORBIDDEN_INSTRUCTION_1[3],'1'
            JZ endMUL_instruction_player1
                    mov instruction_index,3
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_mul1
                    jmp reg_mode_mul1        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_mul1:  
                    call  div_mul_inc_dec_address_player1
                    jmp far ptr endMUL_instruction_player1
                reg_mode_mul1:
                    call  div_mul_inc_dec_register_player1 
              jmp far ptr endMUL_instruction_player1

	endMUL_instruction_player1:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player1,0
RET
MULPLAYER1PR  ENDP

DIVPLAYER1PR  PROC NEAR
            CALL SHOW_1ST_OPERAND
        
call change_src_dest 
 cmp power_up_player1,1
            jz div_power_up1_player1
            cmp power_up_player1,2
            jz div_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_div_player1 
            div_power_up1_player1: 
                cmp intial_points_player1,5
                JB nopoints_div_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_div_powerup1_p1 
                nopoints_div_powerup1_p1:
                jmp far ptr endDIV_instruction_player1
                can_perform_div_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1 
                    sub intial_points_player1,5
                    jmp perform_div_player1 
            div_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_div_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_div_powerup2_p1 
                nopoints_div_powerup2_p1:
                jmp far ptr endDIV_instruction_player1
                can_perform_div_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_div_player1
            perform_div_player1:   
                                    CMP FORBIDDEN_INSTRUCTION_1[4],'1'
            JZ endDIV_instruction_player1        
                        mov instruction_index,4
                        mov al,address_mode
                        cmp al,1
                        jz address_mode_div1
                        jmp reg_mode_div1        
                        ; address mode processing ---------------------------------------------------------         
                    address_mode_div1:  
                        call  div_mul_inc_dec_address_player1 
                        jmp far ptr endDIV_instruction_player1
                    reg_mode_div1:
                        call  div_mul_inc_dec_register_player1 
                  jmp far ptr endDIV_instruction_player1

	endDIV_instruction_player1:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player1,0
	RET 
DIVPLAYER1PR   ENDP

IDIVPLAYER1PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            
 call change_src_dest 
            cmp power_up_player1,1
            jz idiv_power_up1_player1
            cmp power_up_player1,2
            jz idiv_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_idiv_player1 
            idiv_power_up1_player1:
                cmp intial_points_player1,3
                JB nopoints_idiv_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_idiv_powerup1_p1 
                nopoints_idiv_powerup1_p1:
                jmp far ptr endIDIV_instruction_player1
                can_perform_idiv_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1
                    sub intial_points_player1,5
                    jmp perform_idiv_player1 
            idiv_power_up2_player1:                                                                      
                cmp intial_points_player1,3
                JB nopoints_idiv_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_idiv_powerup2_p1 
                nopoints_idiv_powerup2_p1:
                jmp far ptr endIDIV_instruction_player1
                can_perform_idiv_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1 
                    sub intial_points_player1,3
                    jmp perform_idiv_player1
            perform_idiv_player1:  
                                    CMP FORBIDDEN_INSTRUCTION_1[14],'1'
            JZ endIDIV_instruction_player1          
                    mov instruction_index,14
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_idiv1
                    jmp reg_mode_idiv1        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_idiv1:  
                    call  div_mul_inc_dec_address_player1 
                    jmp far ptr endIDIV_instruction_player1
                reg_mode_idiv1:
                    call  div_mul_inc_dec_register_player1 
              jmp far ptr endIDIV_instruction_player1
     

	endIDIV_instruction_player1:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player1,0
RET
IDIVPLAYER1PR  ENDP  

IMULPLAYER1PR PROC NEAR
; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
                        CALL SHOW_1ST_OPERAND

call change_src_dest             
cmp power_up_player1,1
            jz imul_power_up1_player1
            cmp power_up_player1,2
            jz imul_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_imul_player1 
            imul_power_up1_player1:
                cmp intial_points_player1,5
                JB nopoints_Imul_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Imul_powerup1_p1 
                nopoints_Imul_powerup1_p1:
                jmp far ptr endIMUL_instruction_player1
                can_perform_Imul_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1 
                    sub intial_points_player1,5
                    jmp perform_imul_player1 
            imul_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_Imul_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Imul_powerup2_p1 
                nopoints_Imul_powerup2_p1:
                jmp far ptr endIMUL_instruction_player1
                can_perform_Imul_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_imul_player1
            perform_imul_player1:
                                    CMP FORBIDDEN_INSTRUCTION_1[15],'1'
            JZ endIMUL_instruction_player1
                    mov instruction_index,15
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_imul1
                    jmp reg_mode_imul1        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_imul1:  
                    call  div_mul_inc_dec_address_player1
                    jmp far ptr endIMUL_instruction_player1
                reg_mode_imul1:
                    call  div_mul_inc_dec_register_player1 
              jmp far ptr endIMUL_instruction_player1


	endIMUL_instruction_player1:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player1,0
RET
IMULPLAYER1PR  ENDP

INCPLAYER1PR  PROC NEAR
            CALL SHOW_1ST_OPERAND

call change_src_dest 
 cmp power_up_player1,1
            jz INC_power_up1_player1
            cmp power_up_player1,2
            jz INC_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_INC_player1 
            INC_power_up1_player1:
                cmp intial_points_player1,5
                JB nopoints_INC_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_INC_powerup1_p1 
                nopoints_INC_powerup1_p1:
                jmp far ptr endINC_instruction_player1
                can_perform_INC_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1
                    sub intial_points_player1,5
                    jmp perform_INC_player1 
            INC_power_up2_player1:                           
                cmp intial_points_player1,3
                JB nopoints_INC_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_INC_powerup2_p1 
                nopoints_INC_powerup2_p1:
                jmp far ptr endINC_instruction_player1
                can_perform_INC_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1   
                    sub intial_points_player1,3
                    jmp perform_INC_player1
            perform_INC_player1:
                                    CMP FORBIDDEN_INSTRUCTION_1[5],'1'
            JZ endINC_instruction_player1
            mov instruction_index,5
            mov al,address_mode
            cmp al,1
            jz address_mode_inc1
            jmp reg_mode_inc1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_inc1:  
            call  div_mul_inc_dec_address_player1
            jmp far ptr endINC_instruction_player1
        reg_mode_inc1:
            call  div_mul_inc_dec_register_player1 
      jmp far ptr endINC_instruction_player1


	endINC_instruction_player1:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player1,0
RET
INCPLAYER1PR  ENDP

DECPLAYER1PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            
call change_src_dest 
cmp power_up_player1,1
            jz DEC_power_up1_player1
            cmp power_up_player1,2
            jz DEC_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_DEC_player1 
            DEC_power_up1_player1:    
                cmp intial_points_player1,5
                JB nopoints_DEC_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_DEC_powerup1_p1 
                nopoints_DEC_powerup1_p1:
                jmp far ptr endDEC_instruction_player1
                can_perform_DEC_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1   
                    sub intial_points_player1,5
                    jmp perform_DEC_player1 
            DEC_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_DEC_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_DEC_powerup2_p1 
                nopoints_DEC_powerup2_p1:
                jmp far ptr endDEC_instruction_player1
                can_perform_DEC_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_DEC_player1
            perform_DEC_player1:
                                    CMP FORBIDDEN_INSTRUCTION_1[6],'1'
            JZ endDEC_instruction_player1
            mov instruction_index,6
            mov al,address_mode
            cmp al,1
            jz address_mode_dec1
            jmp reg_mode_dec1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_dec1:  
            call  div_mul_inc_dec_address_player1
            jmp far ptr endDEC_instruction_player1
        reg_mode_dec1:
            call  div_mul_inc_dec_register_player1 
      jmp far ptr endDEC_instruction_player1


	endDEC_instruction_player1:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player1,0
RET
DECPLAYER1PR  ENDP

SARPLAYER1PR PROC NEAR
; set variable to number then compare
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest 
            cmp power_up_player1,1
            jz SAR_power_up1_player1
            cmp power_up_player1,2
            jz SAR_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_SAR_player1 
            SAR_power_up1_player1:
                cmp intial_points_player1,5
                JB nopoints_SAR_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_SAR_powerup1_p1 
                nopoints_SAR_powerup1_p1:
                jmp far ptr endSAR_instruction_player1
                can_perform_SAR_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1
                    sub intial_points_player1,5
                    jmp perform_SAR_player1 
            SAR_power_up2_player1: 
                cmp intial_points_player1,3
                JB nopoints_SAR_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_SAR_powerup2_p1 
                nopoints_SAR_powerup2_p1:
                jmp far ptr endSAR_instruction_player1
                can_perform_SAR_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_SAR_player1
            perform_SAR_player1:
                                    CMP FORBIDDEN_INSTRUCTION_1[13],'1'
            JZ endSAR_instruction_player1
            mov instruction_index,13
            mov al,address_mode
            cmp al,1
            jz address_mode_sar1
            jmp reg_mode_sar1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_sar1:  
            call  shl_shr_ror_rol_address_player1
            jmp far ptr endSAR_instruction_player1
        reg_mode_sar1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr endSAR_instruction_player1

	endSAR_instruction_player1:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player1,0
RET
SARPLAYER1PR  ENDP

SALPLAYER1PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest 
  cmp power_up_player1,1
            jz sal_power_up1_player1
            cmp power_up_player1,2
            jz sal_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_SAL_player1 
            sal_power_up1_player1:
                cmp intial_points_player1,5
                JB nopoints_sal_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_sal_powerup1_p1 
                nopoints_sal_powerup1_p1:
                jmp far ptr endSAL_instruction_player1
                can_perform_sal_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1 
                    sub intial_points_player1,5
                    jmp perform_SAL_player1 
            sal_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_sal_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_sal_powerup2_p1 
                nopoints_sal_powerup2_p1:
                jmp far ptr endSAL_instruction_player1
                can_perform_sal_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_SAL_player1
            perform_SAL_player1:
                                    CMP FORBIDDEN_INSTRUCTION_1[8],'1'
            JZ endSAL_instruction_player1
            mov instruction_index,8
            mov al,address_mode
            cmp al,1
            jz address_mode_sal1
            jmp reg_mode_sal1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_sal1:  
            call  shl_shr_ror_rol_address_player1
            jmp far ptr endSAL_instruction_player1
        reg_mode_sal1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr endSAL_instruction_player1

	endSAL_instruction_player1:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player1,0
RET
SALPLAYER1PR  ENDP

SHRPLAYER1PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest 
 cmp power_up_player1,1
            jz SHR_power_up1_player1
            cmp power_up_player1,2
            jz SHR_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_SHR_player1 
            SHR_power_up1_player1: 
                cmp intial_points_player1,5
                JB nopoints_SHR_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_SHR_powerup1_p1 
                nopoints_SHR_powerup1_p1:
                jmp far ptr endSHR_instruction_player1
                can_perform_SHR_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1  
                    sub intial_points_player1,5
                    jmp perform_SHR_player1 
            SHR_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_SHR_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_SHR_powerup2_p1 
                nopoints_SHR_powerup2_p1:
                jmp far ptr endSHR_instruction_player1
                can_perform_SHR_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1 
                    sub intial_points_player1,3
                    jmp perform_SHR_player1
            perform_SHR_player1:
                                    CMP FORBIDDEN_INSTRUCTION_1[9],'1'
            JZ endSHR_instruction_player1
            mov instruction_index,9
            mov al,address_mode
            cmp al,1
            jz address_mode_shr1
            jmp reg_mode_shr1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_shr1:  
            call  shl_shr_ror_rol_address_player1 
            jmp far ptr endSHR_instruction_player1
        reg_mode_shr1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr endSHR_instruction_player1

	endSHR_instruction_player1:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player1,0
RET
SHRPLAYER1PR  ENDP

SHLPLAYER1PR PROC NEAR

            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest  
cmp power_up_player1,1
            jz SHL_power_up1_player1
            cmp power_up_player1,2
            jz SHL_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_SHL_player1 
            SHL_power_up1_player1: 
                cmp intial_points_player1,5
                JB nopoints_SHL_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_SHL_powerup1_p1 
                nopoints_SHL_powerup1_p1:
                jmp far ptr endSHL_instruction_player1
                can_perform_SHL_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1
                    sub intial_points_player1,5
                    jmp perform_SHL_player1 
            SHL_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_SHL_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_SHL_powerup2_p1 
                nopoints_SHL_powerup2_p1:
                jmp far ptr endSHL_instruction_player1
                can_perform_SHL_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1   
                    sub intial_points_player1,3
                    jmp perform_SHL_player1
            perform_SHL_player1:
                                    CMP FORBIDDEN_INSTRUCTION_1[10],'1'
            JZ endSHL_instruction_player1
                    mov instruction_index,10
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_shl1
                    jmp reg_mode_shl1        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_shl1:  
                    call  shl_shr_ror_rol_address_player1
                    jmp far ptr endSHL_instruction_player1
                reg_mode_shl1:
                    call  shl_shr_ror_rol_register_player1 
              jmp far ptr endSHL_instruction_player1


	endSHL_instruction_player1:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player1,0
RET
SHLPLAYER1PR  ENDP

RORPLAYER1PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest 
cmp power_up_player1,1
            jz ror_power_up1_player1
            cmp power_up_player1,2
            jz ror_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_ror_player1 
            ror_power_up1_player1:
                cmp intial_points_player1,5
                JB nopoints_ror_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Ror_powerup1_p1 
                nopoints_ror_powerup1_p1:
                jmp far ptr endROR_instruction_player1
                can_perform_Ror_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1
                    sub intial_points_player1,5
                    jmp perform_ror_player1 
            ror_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_ror_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Ror_powerup2_p1 
                nopoints_ror_powerup2_p1:
                jmp far ptr endROR_instruction_player1
                can_perform_Ror_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_ror_player1
            perform_ror_player1:
                        CMP FORBIDDEN_INSTRUCTION_1[11],'1'
            JZ endROR_instruction_player1
            mov instruction_index,11
            mov al,address_mode
            cmp al,1
            jz address_mode_ror1
            jmp reg_mode_ror1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_ror1:  
            call  shl_shr_ror_rol_address_player1 
            jmp far ptr endROR_instruction_player1
        reg_mode_ror1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr endROR_instruction_player1


	endROR_instruction_player1:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player1,0
RET
RORPLAYER1PR  ENDP

ROLPLAYER1PR PROC NEAR
            CALL SHOW_1ST_OPERAND
            CALL SHOW_2ND_OPERAND
call change_src_dest 
cmp power_up_player1,1
            jz rol_power_up1_player1
            cmp power_up_player1,2
            jz rol_power_up2_player1
                mov player_turn1,1
                mov player_turn2,0
                jmp perform_rol_player1 
            rol_power_up1_player1:
               cmp intial_points_player1,5
                JB nopoints_rol_powerup1_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Rol_powerup1_p1 
                nopoints_rol_powerup1_p1:
                jmp far ptr endROL_instruction_player1
                can_perform_Rol_powerup1_p1:
                    mov player_turn1,0
                    mov player_turn2,1  
                    sub intial_points_player1,5
                    jmp perform_rol_player1 
            rol_power_up2_player1:
                cmp intial_points_player1,3
                JB nopoints_rol_powerup2_p1 ;-> end instruction of this player because of no points enough
                jmp can_perform_Rol_powerup2_p1 
                nopoints_rol_powerup2_p1:
                jmp far ptr endROL_instruction_player1
                can_perform_Rol_powerup2_p1:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player1,3
                    jmp perform_rol_player1
            perform_rol_player1:
            CMP FORBIDDEN_INSTRUCTION_1[12],'1'
            JZ endROL_instruction_player1
            mov instruction_index,12
            mov al,address_mode
            cmp al,1
            jz address_mode_rol1
            jmp reg_mode_rol1        
            ; address mode processing ---------------------------------------------------------         
        address_mode_rol1:  
            call  shl_shr_ror_rol_address_player1
            jmp far ptr endROL_instruction_player1
        reg_mode_rol1:
            call  shl_shr_ror_rol_register_player1 
      jmp far ptr endROL_instruction_player1


	endROL_instruction_player1:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player1,0
RET
ROLPLAYER1PR  ENDP




;--------------------------- INSTRUCTIONS -----------------------------------

        mov_reg_des_player1 proc near
            
            cmp count_bit_1,2
            jz dest_lose_point_player1_mov
            jmp here_dest_player1
            dest_lose_point_player1_mov:
            jmp far ptr  lose_point_dest_player11_mov
            here_dest_player1:
            mov bl,dest_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if dest_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 17                      ; index to address value -> choose which value ?!
            jz check_forbidden_digit_mov_add2 
            jnz check_forbidden_regsiter_mov_add2 
            check_forbidden_digit_mov_add2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1]
                
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_1 ;<----------- working should be uncomment when we solve jump problem
                ;check_forbidden Forbidden_digits_2,0    <----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz  lose_point_1_player1_dest
                jmp cont_address_dest_mode_mov2 
                lose_point_1_player1_dest:
                jmp far ptr lose_point_dest_player11_mov
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp final_address_mode_mov_dest 
          check_forbidden_regsiter_mov_add2:
                check_forbidden Forbidden_Registers_1,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_player1_dest 
                jmp cont_address_dest_mode_mov2 
                lose_point_2_player1_dest:
                jmp far ptr lose_point_dest_player11_mov                 
         cont_address_dest_mode_mov2:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,dest_index_val
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_dest_player1_mov  ; out of index of data segment -> should be error 
            jmp final_address_mode_mov_dest 
            lose_point_dest_player1_mov:
            jmp far ptr lose_point_dest_player11_mov 
            ;----------------------------------- 
            ; now its valid instruction ----------------------------------
       final_address_mode_mov_dest:
            mov bh,0
            mov bl,dest_index_val 
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1]
            mov si,ax
            mov bl,src_index_val
            ;mov cx,Player2_Data_Register[bx]  
            ; check if its two byte or not
                    cmp player_turn1,1
                    jz player1_mov_byte_dest_turn
                    jmp far ptr player1_mov_byte_dest_no_turn
                    player1_mov_byte_dest_turn:
                        cmp instruction_index,0
                        jz mov_address_byte_player1_dest
                        cmp instruction_index,1
                        jz add_address_byte_player1_dest
                        cmp instruction_index,2
                        jz sub_address_byte_player1_dest
                        mov_address_byte_player1_dest: 
                            mov cl,data_segment_2[si] 
                            mov Player2_Data_Register[bx],cl                 ; mov ------------------------
                            ;mov Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_byte_dest_no_turn
                        add_address_byte_player1_dest:                  ; add ------------------------
                            mov cl,data_segment_2[si] 
                            add Player2_Data_Register[bx],cl 
                            ;add Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_byte_dest_no_turn
                        sub_address_byte_player1_dest:                  ; sub ------------------------
                            mov cl,data_segment_2[si] 
                            sub Player2_Data_Register[bx],cl 
                            ;sub Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_byte_dest_no_turn
                   player1_mov_byte_dest_no_turn:
                    cmp player_turn2,1
                    jz player2_mov_byte_dest_turn
                    jmp far ptr end_dest_mov_player1 
                    player2_mov_byte_dest_turn:
                        mov bl,dest_index_val 
                        mov ah,Player1_Data_Register[bx]
                        mov al,Player1_Data_Register[bx+1]
                        cmp ax,000fh
                            JA lose_point_dest2_player1_mov  ; out of index of data segment -> should be error 
                            jmp cont_final_address_mode_mov_dest 
                            lose_point_dest2_player1_mov:
                            jmp far ptr lose_point_dest_player11_mov
                        cont_final_address_mode_mov_dest:
                        mov si,ax
                        mov bl,src_index_val
                        cmp instruction_index,0
                        jz mov_address_byte_player2_dest
                        cmp instruction_index,1
                        jz add_address_byte_player2_dest
                        cmp instruction_index,2
                        jz sub_address_byte_player2_dest
                        mov_address_byte_player2_dest: 
                            mov cl,data_segment_1[si] 
                            mov Player1_Data_Register[bx],cl                 ; mov ------------------------
                            ;mov Player2_Data_Register[bx],ah
                            jmp far ptr end_dest_mov_player1
                        add_address_byte_player2_dest:                  ; add ------------------------
                            mov cl,data_segment_1[si] 
                            add Player1_Data_Register[bx],cl 
                            ;add Player2_Data_Register[bx],ah
                            jmp far ptr end_dest_mov_player1
                        sub_address_byte_player2_dest:                  ; sub ------------------------
                            mov cl,data_segment_1[si] 
                            sub Player1_Data_Register[bx],cl 
                            ;sub Player2_Data_Register[bx],ah
                            jmp far ptr end_dest_mov_player1

    lose_point_dest_player11_mov:
        ;cmp player_turn ,1
        ;jz player1_lose_mov_dest_reg 
        ;dec intial_points_player2
        ;mov losepoint_player2,0 
        ;mov losepoint,0
        ;jmp end_dest_mov_player1
        ;player1_lose_mov_dest_reg:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_dest_mov_player1:
    
    ret
    mov_reg_des_player1 endp
;----------------------------mov to a register ---------------------------------------------------
mov_register_player1 proc near
    
    check_forbidden Forbidden_instruction_1,instruction_index       
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz  LOSREGMOVSRCP1
                jmp STARTMOVADDSRCP1 
                LOSREGMOVSRCP1:
                ;jmp far ptr lose_point_player1
                jmp far ptr end_mov_reg_player1 

            STARTMOVADDSRCP1:
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_1,bl

            mov al,losepoint 
            mov losepoint_player1,al 
            cmp losepoint_player1,1
            jz   lose_point_2_reg_player1 
            jmp cont_reg_mode_mov 
            lose_point_2_reg_player1:
            jmp far ptr lose_point_reg_mov_player1                 
         cont_reg_mode_mov:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            
            ; check other operand------------------ 

            ; call lotfy code to get second operand 
            mov ah,count_bit_2
            mov al,count_bit_1
            cmp ah,al ;---------------------------------------------------
            jnz lose_point_reg_mov_player1_temp 
            jmp to_this_mov_player1
            lose_point_reg_mov_player1_temp:
            jmp far ptr lose_point_reg_mov_player1
            to_this_mov_player1:
            cmp address_mode2,1 
            
            jz address_mode_mov_des_player1
            jmp  address_mode_mov_des_no_player1
            address_mode_mov_des_player1:
                call mov_reg_des_player1
            jmp far ptr end_mov_reg_player1
            
            address_mode_mov_des_no_player1:
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_reg_mov2 
            jnz check_forbidden_regsiter_reg_mov2
            check_forbidden_digit_reg_mov2:
                ; macro needed to check if value has a forbidden digit or not
                
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1] 
                ; call macro that check if value in ax is correct
                ; check if value is 2 bytes or 1 byte so that can call its function
                check_byte_valid al, Forbidden_digits_1 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1 
                
                jz  forbidden_digit_mov_player1 
                jmp final_reg_mode_mov
                forbidden_digit_mov_player1:
                    jmp far ptr end_mov_reg_player1 
            check_forbidden_regsiter_reg_mov2:        
            
                check_forbidden Forbidden_Registers_1,bl
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  forbidden_reg_mov_player1
                jmp final_reg_mode_mov
                forbidden_reg_mov_player1:
                    jmp far ptr end_mov_reg_player1   
              
                                

            ; now its valid instruction ----------------------------------
            final_reg_mode_mov:
            
                ;mov cx,Player2_Data_Register[bx]  
                ; check if its two byte or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1]
                mov bl,src_index_val  
                mov dl,count_bit_2
                mov dh,0
                cmp dl,2
                jz word_mov_reg_Temp_player1
                jmp byte_mov_reg_temp_player1
                word_mov_reg_Temp_player1:
                jmp far ptr word_mov_reg_player1
                byte_mov_reg_temp_player1: 
                    cmp player_turn1,1
                    jz player1_mov_byte_turn
                    jmp player1_mov_byte_no_turn 
                    player1_mov_byte_turn:
                        mov bl,src_index_val 
                        cmp instruction_index,0
                        jz mov_reg_byte_player1
                        cmp instruction_index,1
                        jz add_reg_byte_player1
                        cmp instruction_index,2
                        jz sub_reg_byte_player1
                        mov_reg_byte_player1:                  ; mov ------------------------
                            mov Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_byte_no_turn
                        add_reg_byte_player1:                  ; add ------------------------
                            add Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_byte_no_turn
                        sub_reg_byte_player1:                  ; sub ------------------------
                            sub Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_byte_no_turn
                    player1_mov_byte_no_turn:
                        cmp player_turn2,1
                        jz player2_mov_byte_turn
                        jmp far ptr end_mov_reg_player1
                        player2_mov_byte_turn:
                            mov bl,dest_index_val 
                            mov ah,Player1_Data_Register[bx]
                            mov al,Player1_Data_Register[bx+1]
                            mov bl,src_index_val  
                            cmp instruction_index,0
                            jz mov_reg_byte_player2
                            cmp instruction_index,1
                            jz add_reg_byte_player2
                            cmp instruction_index,2
                            jz sub_reg_byte_player2
                            mov_reg_byte_player2:                  ; mov ------------------------
                                mov Player1_Data_Register[bx],ah
                                jmp far ptr end_mov_reg_player1
                            add_reg_byte_player2:                  ; add ------------------------
                                add Player1_Data_Register[bx],ah
                                jmp far ptr end_mov_reg_player1
                            sub_reg_byte_player2:                  ; sub ------------------------
                                sub Player1_Data_Register[bx],ah
                                jmp far ptr end_mov_reg_player1
                                                        
                word_mov_reg_player1:
                    cmp player_turn1,1
                    jz player1_mov_word_turn
                    jmp player1_mov_word_no_turn 
                    player1_mov_word_turn:
                    
                        cmp instruction_index,0
                        jz mov_reg_word_player1
                        cmp instruction_index,1
                        jz add_reg_word_player1
                        cmp instruction_index,2
                        jz sub_reg_word_player1
                        mov_reg_word_player1:                  ; mov ------------------------
                            mov Player2_Data_Register[bx+1],al
                            mov Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_word_no_turn
                        add_reg_word_player1:                  ; add ------------------------
                            add Player2_Data_Register[bx+1],al
                            adc Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_word_no_turn
                        sub_reg_word_player1:                  ; sub ------------------------
                            sub Player2_Data_Register[bx+1],al
                            sbb Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_word_no_turn             
                                                            ; lose point because of invalid instruction
    
                    player1_mov_word_no_turn:
                        cmp player_turn2,1
                        jz player2_mov_word_turn
                        jmp far ptr end_mov_reg_player1
                        player2_mov_word_turn:
                        mov bl,dest_index_val 
                        mov ah,Player1_Data_Register[bx]
                        mov al,Player1_Data_Register[bx+1]
                        mov bl,src_index_val
                        cmp instruction_index,0
                        jz mov_reg_word_player2
                        cmp instruction_index,1
                        jz add_reg_word_player2
                        cmp instruction_index,2
                        jz sub_reg_word_player2
                        mov_reg_word_player2:                  ; mov ------------------------
                            mov Player1_Data_Register[bx+1],al
                            mov Player1_Data_Register[bx],ah
                            jmp far ptr end_mov_reg_player1
                        add_reg_word_player2:                  ; add ------------------------
                            add Player1_Data_Register[bx+1],al
                            adc Player1_Data_Register[bx],ah
                            jmp far ptr end_mov_reg_player1
                        sub_reg_word_player2:                  ; sub ------------------------
                            sub Player1_Data_Register[bx+1],al
                            sbb Player1_Data_Register[bx],ah
                            jmp far ptr end_mov_reg_player1 
    
    
    lose_point_reg_mov_player1:
        ;cmp player_turn ,1
        ;jz player1_lose_mov_reg 
        ;dec intial_points_player2
        ;mov losepoint_player2,0 
        ;mov losepoint,0
        ;jmp end_mov_reg_player1
        ;player1_lose_mov_reg:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_mov_reg_player1:
     
    ret 
    mov_register_player1 endp
;---------------------------------------------------  mov to datasegment  -----------------------------------------------------------------
mov_address_player1  proc near
    
        check_forbidden Forbidden_instruction_1,instruction_index   
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz  LOSMOVREGSRCP1
                jmp STARTMOVREGSRCP1 
                LOSMOVREGSRCP1:
                ;jmp far ptr lose_point_player1
                jmp far ptr end_mov_address_player1 

            STARTMOVREGSRCP1:
            CMP ADDRESS_MODE2,1
            JZ thabora
            
            JMP START2MOVREGSRCP1
            thabora: jmp far ptr lose_point_player1
            START2MOVREGSRCP1:
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 18                      ; index to address value -> choose which value ?!
            jz check_forbidden_digit_mov 
            jnz check_forbidden_regsiter_mov 
            check_forbidden_digit_mov:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1]
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_1 ;<----------- working should be uncomment when we solve jump problem
                mov Player1_Data_Register[bx+1],al
                mov Player1_Data_Register[bx],ah 
                ;check_forbidden Forbidden_digits_2,0   ;<----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz  lose_point_1_player1
                jmp cont_address_mode_mov 
                lose_point_1_player1:
                ;jmp far ptr lose_point_player1
                jmp far ptr end_mov_address_player1
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp cont_address_mode_mov 
            check_forbidden_regsiter_mov:
                check_forbidden Forbidden_Registers_1,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_player1 
                jmp cont_address_mode_mov 
                lose_point_2_player1:
                jmp far ptr lose_point_player1                 
         cont_address_mode_mov:
            ;check if value in ax is less than f for two turns player1_turn & player2_turn
            mov bh,0
            mov bl,src_index_val
            cmp player_turn1,1              ;-> player1 turn 
            jz player1_check_address_mov
            jmp cont_check_address_mode_mov2
            player1_check_address_mov:
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_3_player1  ; out of index of data segment -> should be error 
            jmp cont_check_address_mode_mov2 
            lose_point_3_player1:
            jmp far ptr lose_point_player1
        cont_check_address_mode_mov2:
            cmp player_turn2,1              ;-> player1 turn 
            jz player2_check_address_mov
            jmp cont_address_mode_mov2
            player2_check_address_mov:
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            cmp ax,000fh  
            JA lose_point_4_player1  ; out of index of data segment -> should be error 
            jmp cont_address_mode_mov2 
            lose_point_4_player1:
            jmp far ptr lose_point_player1
            ; check other operand------------------ 
            cont_address_mode_mov2:
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_mov2 
            jnz check_forbidden_regsiter_mov2
            check_forbidden_digit_mov2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1] 
                ; call macro that check if value in ax is correct
                check_word_valid ax, Forbidden_digits_1 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
  
                jz  forbidden_address_mov_player1
                jmp final_address_mode_mov
                forbidden_address_mov_player1:
                    jmp far ptr end_mov_address_player1  
            
            check_forbidden_regsiter_mov2:        
            
                check_forbidden Forbidden_Registers_1,bl
                 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                ;jz  lose_point_player1   
                jz temp_end_mov_address_player1   ; -> jump far here
                jmp  final_address_mode_mov
                temp_end_mov_address_player1:
                jmp far ptr end_mov_address_player1
                ;mov bh,0
                ;mov bl,dest_index_val
                ;mov ah,Player2_Data_Register[bx]
                ;mov al,Player2_Data_Register[bx+1]

            ; now its valid instruction ----------------------------------
            final_address_mode_mov:
            mov bh,0
            mov bl,src_index_val 
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1]
            mov si,ax
            mov bl,dest_index_val
            ;mov cx,Player2_Data_Register[bx]  
            ; check if its two byte or not 
            mov dl,count_bit_2
            mov dh,0
            cmp dl,2
            jz lose_point_plyer1       ;-> should jmp far
            jmp not_lose_point_plyer1
            lose_point_plyer1:
            jmp far ptr lose_point_player1
            ; paste here  
            not_lose_point_plyer1:
                    cmp player_turn1,1              ;-> player1 turn 
                    jz player1_mov_address_byte_turn
                    jmp player1_mov_address_byte_no_turn 
                    player1_mov_address_byte_turn:      
                        cmp instruction_index,0
                        jz mov_address_byte_player1
                        cmp instruction_index,1
                        jz add_address_byte_player1
                        cmp instruction_index,2
                        jz sub_address_byte_player1
                        mov_address_byte_player1:                  ; mov ------------------------
                            mov cl,Player2_Data_Register[bx]
                            mov data_segment_2[si],cl
                            ;mov Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_address_byte_no_turn
                        add_address_byte_player1:                  ; add ------------------------
                            mov cl,Player2_Data_Register[bx]
                            add data_segment_2[si],cl
                            ;add Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_address_byte_no_turn
                        sub_address_byte_player1:                  ; sub ------------------------
                            mov cl,Player2_Data_Register[bx]
                            sub data_segment_2[si],cl
                            ;sub Player2_Data_Register[bx],ah
                            jmp far ptr player1_mov_address_byte_no_turn
                            
                     player1_mov_address_byte_no_turn:
                        cmp player_turn2,1
                        jz player2_mov_address_byte_turn
                        jmp far ptr end_mov_address_player1
                        player2_mov_address_byte_turn:
                            mov bl,src_index_val 
                            mov ah,Player1_Data_Register[bx]
                            mov al,Player1_Data_Register[bx+1]
                            mov si,ax
                            mov bl,dest_index_val
                            cmp instruction_index,0
                            jz mov_address_byte_player2
                            cmp instruction_index,1
                            jz add_address_byte_player2
                            cmp instruction_index,2
                            jz sub_address_byte_player2
                            mov_address_byte_player2:                  ; mov ------------------------
                                mov cl,Player1_Data_Register[bx]
                                mov data_segment_1[si],cl
                                jmp far ptr end_mov_address_player1
                            add_address_byte_player2:                  ; add ------------------------
                                mov cl,Player1_Data_Register[bx]
                                add data_segment_1[si],cl
                                jmp far ptr end_mov_address_player1
                            sub_address_byte_player2:                  ; sub ------------------------
                                mov cl,Player1_Data_Register[bx]
                                sub data_segment_1[si],cl
                                jmp far ptr end_mov_address_player1                                    
              
    lose_point_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_mov_address_player1:
    
    ret
    mov_address_player1 endp 

;----------------------------div mul inc dec imul idiv reg ---------------------------------------------------
div_mul_inc_dec_register_player1 proc near
    
    check_forbidden Forbidden_instruction_1,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_1,bl

            mov al,losepoint 
            mov losepoint_player1,al 
            cmp losepoint_player1,1
            jz   lose_point_2_reg_div_player1 
            jmp cont_reg_mode_div 
            lose_point_2_reg_div_player1:
            jmp far ptr end_div_reg_player1                 
         cont_reg_mode_div:
            mov dl,count_bit_1
            mov dh,0
            cmp dl,2
            jz temp_word_div_reg_player1
            jmp temp_byte_div_reg_player1
            temp_word_div_reg_player1:
            jmp far ptr word_div_reg_player1
            temp_byte_div_reg_player1:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,0
                    mov cl,Player2_Data_Register[bx]            
                    mov ah,Player2_Data_Register[0]
                    mov al,Player2_Data_Register[1]
                    mov dx,0 
                    ; add player turn here : 
                    cmp player_turn1,1
                    jz player1_div_byte_turn
                    jmp player1_div_byte_no_turn 
                    player1_div_byte_turn:    
                        cmp instruction_index,4
                        jz div_reg_byte_player1
                        cmp instruction_index,3
                        jz mul_reg_byte_player1
                        cmp instruction_index,14
                        jz idiv_reg_byte_player1 
                        cmp instruction_index,15
                        jz imul_reg_byte_player1
                        cmp instruction_index,5
                        jz inc_reg_byte_player1
                        cmp instruction_index,6
                        jz dec_reg_byte_player1
                        div_reg_byte_player1:                  ; div ------------------------
                            cmp cx,0
                            jz div_zero_byte_reg_p1
                            jmp not_div_zero_byte_reg_p1
                            div_zero_byte_reg_p1:
                            jmp far ptr lose_point_div_player1
                            not_div_zero_byte_reg_p1:
                            div cx
                            mov Player2_Data_Register[0],dl
                            mov Player2_Data_Register[1],al
                            jmp far ptr player1_div_byte_no_turn
                        mul_reg_byte_player1:                  ; mul ------------------------
                            mul cl
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al 
                            jmp far ptr player1_div_byte_no_turn
                        idiv_reg_byte_player1:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv_zero_byte_reg_p1
                            jmp not_idiv_zero_byte_reg_p1
                            idiv_zero_byte_reg_p1:
                            jmp far ptr lose_point_div_player1
                            not_idiv_zero_byte_reg_p1:
                            idiv cx
                            mov Player2_Data_Register[0],dl
                            mov Player2_Data_Register[1],al
                            jmp far ptr player1_div_byte_no_turn 
                        imul_reg_byte_player1:                  ; imul ------------------------
                            imul cl
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            jmp far ptr player1_div_byte_no_turn
                        inc_reg_byte_player1:                  ; inc ------------------------
                            inc cl
                            mov Player2_Data_Register[bx],cl
                            jmp far ptr player1_div_byte_no_turn
                        dec_reg_byte_player1:                  ; dec ------------------------
                            dec cx
                            mov Player2_Data_Register[bx],cl
                            jmp far ptr player1_div_byte_no_turn
                    
                    player1_div_byte_no_turn:        
                    cmp player_turn2,1
                    jz player2_div_byte_turn
                    jmp far ptr end_div_reg_player1 
                    player2_div_byte_turn:
                        mov cl,Player1_Data_Register[bx]            
                        mov ah,Player1_Data_Register[0]
                        mov al,Player1_Data_Register[1]    
                        cmp instruction_index,4
                        jz div_reg_byte_player2
                        cmp instruction_index,3
                        jz mul_reg_byte_player2
                        cmp instruction_index,14
                        jz idiv_reg_byte_player1 
                        cmp instruction_index,15
                        jz imul_reg_byte_player2
                        cmp instruction_index,5
                        jz inc_reg_byte_player2
                        cmp instruction_index,6
                        jz dec_reg_byte_player2
                        div_reg_byte_player2:                  ; div ------------------------
                            cmp cx,0
                            jz div_zero_byte_reg_p2
                            jmp not_div_zero_byte_reg_p2
                            div_zero_byte_reg_p2:
                            jmp far ptr lose_point_div_player1
                            not_div_zero_byte_reg_p2:
                            div cx
                            mov Player1_Data_Register[0],dl
                            mov Player1_Data_Register[1],al
                            jmp far ptr end_div_reg_player1
                        mul_reg_byte_player2:                  ; mul ------------------------
                            mul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al 
                            jmp far ptr end_div_reg_player1
                        idiv_reg_byte_player2:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv_zero_byte_reg_p2
                            jmp not_idiv_zero_byte_reg_p2
                            idiv_zero_byte_reg_p2:
                            jmp far ptr lose_point_div_player1
                            not_idiv_zero_byte_reg_p2:
                            idiv cx
                            mov Player1_Data_Register[0],dl
                            mov Player1_Data_Register[1],al
                            jmp far ptr end_div_reg_player1 
                        imul_reg_byte_player2:                  ; imul ------------------------
                            imul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            jmp far ptr end_div_reg_player1
                        inc_reg_byte_player2:                  ; inc ------------------------
                            inc cl
                            mov Player1_Data_Register[bx],cl
                            jmp far ptr end_div_reg_player1
                        dec_reg_byte_player2:                  ; dec ------------------------
                            dec cx
                            mov Player1_Data_Register[bx],cl
                            jmp far ptr end_div_reg_player1     
            word_div_reg_player1:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,Player2_Data_Register[bx]
                    mov cl,Player2_Data_Register[bx+1]             
                    mov ah,Player2_Data_Register[0]
                    mov al,Player2_Data_Register[1]
                    mov dh,Player2_Data_Register[6]
                    mov dl,Player2_Data_Register[7] 
                    ; add player turn here
                     
                    cmp player_turn1,1
                    jz player1_div_word_turn
                    jmp player1_div_word_no_turn 
                    player1_div_word_turn: 
                        cmp instruction_index,4
                        jz div_reg_word_player1
                        cmp instruction_index,3
                        jz mul_reg_word_player1
                        cmp instruction_index,14
                        jz idiv_reg_word_player1 
                        cmp instruction_index,15
                        jz imul_reg_word_player1
                        cmp instruction_index,5
                        jz inc_reg_word_player1
                        cmp instruction_index,6
                        jz dec_reg_word_player1
                        div_reg_word_player1:                  ; div ------------------------
                            cmp cx,0
                            jz div_zero_word_reg_p1
                            div cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr player1_div_word_no_turn
                            div_zero_word_reg_p1:
                            jmp far ptr lose_point_div_player1
                            not_div_zero_word_reg_p1:

                        mul_reg_word_player1:                  ; mul ------------------------
                            mul cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr player1_div_word_no_turn 
                        idiv_reg_word_player1:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv_zero_word_reg_p1
                            jmp not_idiv_zero_word_reg_p1
                            idiv_zero_word_reg_p1:
                            jmp far ptr lose_point_div_player1
                            not_idiv_zero_word_reg_p1:
                            idiv cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al 
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr player1_div_word_no_turn 
                        imul_reg_word_player1:                  ; imul ------------------------
                            imul cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr player1_div_word_no_turn
                        inc_reg_word_player1:                  ; inc ------------------------
                            inc cx
                            mov Player2_Data_Register[bx],ch
                            mov Player2_Data_Register[bx+1],cl
                            jmp far ptr player1_div_word_no_turn
                        dec_reg_word_player1:                  ; dec ------------------------
                            dec cx
                            mov Player2_Data_Register[bx],ch
                            mov Player2_Data_Register[bx+1],cl
                            jmp far ptr player1_div_word_no_turn 
                    
                    ; add player turn here 
                    player1_div_word_no_turn:
                    cmp player_turn2,1
                    jz player2_div_word_turn
                    jmp far ptr end_div_reg_player1
                    player2_div_word_turn:
                        
                        mov ch,Player1_Data_Register[bx]
                        mov cl,Player1_Data_Register[bx+1]             
                        mov ah,Player1_Data_Register[0]
                        mov al,Player1_Data_Register[1]
                        mov dh,Player1_Data_Register[6]
                        mov dl,Player1_Data_Register[7] 
                        cmp instruction_index,4
                        jz div_reg_word_player2
                        cmp instruction_index,3
                        jz mul_reg_word_player2
                        cmp instruction_index,14
                        jz idiv_reg_word_player2 
                        cmp instruction_index,15
                        jz imul_reg_word_player2
                        cmp instruction_index,5
                        jz inc_reg_word_player2
                        cmp instruction_index,6
                        jz dec_reg_word_player2
                        div_reg_word_player2:                  ; div ------------------------
                            cmp cx,0
                            jz div_zero_word_reg_p2
                            div cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr end_div_reg_player1
                            div_zero_word_reg_p2:
                            jmp far ptr lose_point_div_player1

                        mul_reg_word_player2:                  ; mul ------------------------
                            mul cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr end_div_reg_player1 
                        idiv_reg_word_player2:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv_zero_word_reg_p2
                            jmp not_idiv_zero_word_reg_p2
                            idiv_zero_word_reg_p2:
                            jmp far ptr lose_point_div_player1
                            not_idiv_zero_word_reg_p2:
                            idiv cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al 
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr end_div_reg_player1 
                        imul_reg_word_player2:                  ; imul ------------------------
                            imul cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr end_div_reg_player1
                        inc_reg_word_player2:                  ; inc ------------------------
                            inc cx
                            mov Player1_Data_Register[bx],ch
                            mov Player1_Data_Register[bx+1],cl
                            jmp far ptr end_div_reg_player1
                        dec_reg_word_player2:                  ; dec ------------------------
                            dec cx
                            mov Player1_Data_Register[bx],ch
                            mov Player1_Data_Register[bx+1],cl
                            jmp far ptr end_div_reg_player1 
                    
    
   lose_point_div_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0                
    end_div_reg_player1:
     
    ret 
    div_mul_inc_dec_register_player1 endp
;---------------------------------------------------  mov to datasegment  -----------------------------------------------------------------
div_mul_inc_dec_address_player1  proc near
    
        check_forbidden Forbidden_instruction_1,instruction_index                   
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 18                      ; index to address value -> choose which value ?!
            jz forbidden_digit_address_div 
            jnz forbidden_regsiter_address_div 
            forbidden_digit_address_div:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1]
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_1 
                ;check_forbidden Forbidden_digits_2,0    <----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz  lose_point_1_div_address_player1
                jmp cont_address_mode_div 
                lose_point_1_div_address_player1:
                ;jmp far ptr lose_point_player1
                jmp far ptr end_div_address_player1
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp cont_address_mode_div 
           forbidden_regsiter_address_div:
                check_forbidden Forbidden_Registers_1,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_div_address_player1 
                jmp cont_address_mode_div 
                lose_point_2_div_address_player1:
                jmp far ptr lose_point_div_address_player1                 
         cont_address_mode_div:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val 
            cmp player_turn1,1              ;-> player1 turn 
            jz player1_check_address_div
            jmp cont_check_address_mode_div2
            player1_check_address_div:
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_3_div_address_player1  ; out of index of data segment -> should be error 
            jmp cont_check_address_mode_div2 
            lose_point_3_div_address_player1:
            jmp far ptr lose_point_div_address_player1
            cont_check_address_mode_div2:
            cmp player_turn2,1              ;-> player1 turn 
            jz player2_check_address_div
            jmp final_address_mode_div
            player2_check_address_div:
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            cmp ax,000fh  
            JA lose_point_4_div_address_player1  ; out of index of data segment -> should be error 
            jmp final_address_mode_div 
            lose_point_4_div_address_player1:
            jmp far ptr lose_point_div_address_player1
            final_address_mode_div:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,Player2_Data_Register[bx]
                    mov cl,Player2_Data_Register[bx+1]
                    mov si,cx
                    mov cl,data_segment_2[si]
                    mov ch,0            
                    mov ah,Player2_Data_Register[0]
                    mov al,Player2_Data_Register[1]
                    
                    ; paste here
                    cmp player_turn1,1              ;-> player1 turn 
                    jz player1_div_address_byte_turn
                    jmp player1_div_address_byte_no_turn 
                    player1_div_address_byte_turn:
                        cmp instruction_index,4
                        jz div_address_byte_player1
                        cmp instruction_index,3
                        jz mul_address_byte_player1
                        cmp instruction_index,14
                        jz idiv_address_byte_player1 
                        cmp instruction_index,15
                        jz imul_address_byte_player1
                        cmp instruction_index,5
                        jz inc_address_byte_player1
                        cmp instruction_index,6
                        jz dec_address_byte_player1
                        div_address_byte_player1:                  ; div ------------------------
                            cmp cx,0
                            jz div_zero_address_reg_p1
                            jmp not_div_zero_address_reg_p1
                            div_zero_address_reg_p1:
                            jmp far ptr lose_point_div_player1
                            not_div_zero_address_reg_p1:
                            div cx
                            mov Player2_Data_Register[0],dh
                            mov Player2_Data_Register[1],al
                            jmp far ptr player1_div_address_byte_no_turn
                        mul_address_byte_player1:                  ; mul ------------------------
                            mul cl
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al 
                            jmp far ptr player1_div_address_byte_no_turn
                        idiv_address_byte_player1:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv_zero_address_reg_p1
                            jmp not_idiv_zero_address_reg_p1
                            idiv_zero_address_reg_p1:
                            jmp far ptr lose_point_div_player1
                            not_idiv_zero_address_reg_p1:
                            idiv cx
                            mov Player2_Data_Register[0],dh
                            mov Player2_Data_Register[1],al
                            jmp far ptr player1_div_address_byte_no_turn 
                        imul_address_byte_player1:                  ; imul ------------------------
                            imul cl
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            jmp far ptr player1_div_address_byte_no_turn
                        inc_address_byte_player1:                  ; inc ------------------------
                            inc cl
                            mov data_segment_2[si],cl
                            jmp far ptr player1_div_address_byte_no_turn
                        dec_address_byte_player1:                  ; dec ------------------------
                            dec cx
                            mov data_segment_2[si],cl
                            jmp far ptr player1_div_address_byte_no_turn 

                                        
                    player1_div_address_byte_no_turn:
                        cmp player_turn2,1
                        jz player2_div_address_byte_turn
                        jmp far ptr end_div_address_player1
                        player2_div_address_byte_turn:
                            mov ch,Player1_Data_Register[bx]
                            mov cl,Player1_Data_Register[bx+1]
                            mov si,cx
                            mov cl,data_segment_1[si]
                            mov ch,0            
                            mov ah,Player1_Data_Register[0]
                            mov al,Player1_Data_Register[1]
                            cmp instruction_index,4
                            jz div_address_byte_player2
                            cmp instruction_index,3
                            jz mul_address_byte_player2
                            cmp instruction_index,14
                            jz idiv_address_byte_player2 
                            cmp instruction_index,15
                            jz imul_address_byte_player2
                            cmp instruction_index,5
                            jz inc_address_byte_player2
                            cmp instruction_index,6
                            jz dec_address_byte_player2
                            div_address_byte_player2:                  ; div ------------------------
                                cmp cx,0
                                jz div_zero_address_reg_p2
                                jmp not_div_zero_address_reg_p2
                                div_zero_address_reg_p2:
                                jmp far ptr lose_point_div_player1
                                not_div_zero_address_reg_p2:
                                div cx
                                mov Player1_Data_Register[0],dh
                                mov Player1_Data_Register[1],al
                                jmp far ptr end_div_address_player1
                            mul_address_byte_player2:                  ; mul ------------------------
                                mul cl
                                mov Player1_Data_Register[0],ah
                                mov Player1_Data_Register[1],al 
                                jmp far ptr end_div_address_player1
                            idiv_address_byte_player2:                  ; idiv ------------------------
                                cmp cx,0
                                jz idiv_zero_address_reg_p2
                                jmp not_idiv_zero_address_reg_p2
                                idiv_zero_address_reg_p2:
                                jmp far ptr lose_point_div_player1
                                not_idiv_zero_address_reg_p2:
                                idiv cx
                                mov Player1_Data_Register[0],dh
                                mov Player1_Data_Register[1],al
                                jmp far ptr end_div_address_player1 
                            imul_address_byte_player2:                  ; imul ------------------------
                                imul cl
                                mov Player1_Data_Register[0],ah
                                mov Player1_Data_Register[1],al
                                jmp far ptr end_div_address_player1
                            inc_address_byte_player2:                  ; inc ------------------------
                                inc cl
                                mov data_segment_1[si],cl
                                jmp far ptr end_div_address_player1
                            dec_address_byte_player2:                  ; dec ------------------------
                                dec cx
                                mov data_segment_1[si],cl
                                jmp far ptr end_div_address_player1 
                    
              
    lose_point_div_address_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_div_address_player1:
    
    ret
    div_mul_inc_dec_address_player1 endp
    
    shl_shr_ror_rol_register_player1 proc near
    
    check_forbidden Forbidden_instruction_1,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_1,bl

            mov al,losepoint 
            mov losepoint_player1,al 
            cmp losepoint_player1,1
            jz   lose_point_2_reg_shl_player1 
            jmp cont_reg_mode_shl 
            lose_point_2_reg_shl_player1:
            jmp far ptr end_shl_reg_player1                 
         cont_reg_mode_shl:
         
           ; check if value or cl is valid 
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_reg_shl2 
            jnz check_forbidden_regsiter_reg_shl2
            check_forbidden_digit_reg_shl2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player2_Data_Register[bx]
                mov Player1_Data_Register[bx],ah
 
                ; call macro that check if value in ax is correct
                check_byte_valid ah, Forbidden_digits_1 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  forbidden_reg_shl_player1
                jmp cont_reg_mode_shl2
                forbidden_reg_shl_player1:
                jmp far ptr end_shl_reg_player1  
            
            check_forbidden_regsiter_reg_shl2:        
                
                cmp bl,7
                jnz lose_point_not_reg_cl_p1
                check_forbidden Forbidden_Registers_1,bl                 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1   
                jz temp_end_shl_reg_player1   ; -> jump far here
                jmp  cont_reg_mode_shl2
                temp_end_shl_reg_player1:
                jmp far ptr end_shl_reg_player1
                lose_point_not_reg_cl_p1:
                jmp far ptr lose_point_shl_address_player1 
         cont_reg_mode_shl2:
            mov dl,count_bit_1
            mov dh,0
            cmp dl,2
            jz temp_word_shl_reg_player1
            jmp temp_byte_shl_reg_player1
            temp_word_shl_reg_player1:
            jmp far ptr word_shl_reg_player1
            temp_byte_shl_reg_player1:
                    mov bh,0
                    mov bl,dest_index_val
                    mov ch,0
                    mov cl,Player2_Data_Register[bx]
                    mov bl, src_index_val
                                 
                    ; paste here
                    cmp player_turn1,1
                    jz player1_shl_byte_turn
                    jmp player1_shl_byte_no_turn 
                    player1_shl_byte_turn:
                        cmp instruction_index,10
                        jz shl_reg_byte_player1
                        cmp instruction_index,9
                        jz shr_reg_byte_player1
                        cmp instruction_index,11
                        jz ror_reg_byte_player1 
                        cmp instruction_index,12
                        jz rol_reg_byte_player1
                        cmp instruction_index,8
                        jz sal_reg_byte_player1
                        cmp instruction_index,13
                        jz sar_reg_byte_player1
                        shl_reg_byte_player1:                  ; div ------------------------
                            shl Player2_Data_Register[bx],cl
                            jmp far ptr player1_shl_byte_no_turn
                        shr_reg_byte_player1:                  ; mul ------------------------
                            shr Player2_Data_Register[bx],cl
                            jmp far ptr player1_shl_byte_no_turn
                        ror_reg_byte_player1:                  ; idiv ------------------------
                            ror Player2_Data_Register[bx],cl
                            jmp far ptr player1_shl_byte_no_turn 
                        rol_reg_byte_player1:                  ; imul ------------------------
                            rol Player2_Data_Register[bx],cl
                            jmp far ptr player1_shl_byte_no_turn
                        sal_reg_byte_player1:                  ; inc ------------------------
                            sal Player2_Data_Register[bx],cl
                            jmp far ptr player1_shl_byte_no_turn
                        sar_reg_byte_player1:                  ; dec ------------------------
                            sar Player2_Data_Register[bx],cl
                            jmp far ptr player1_shl_byte_no_turn
                   ; paste here     
                    player1_shl_byte_no_turn:        
                    cmp player_turn2,1
                    jz player2_shl_byte_turn
                    jmp far ptr end_shl_reg_player1 
                    player2_shl_byte_turn:
                        mov bl,dest_index_val
                        mov ch,0
                        mov cl,Player1_Data_Register[bx]
                        mov bl, src_index_val
                        cmp instruction_index,10
                        jz shl_reg_byte_player2
                        cmp instruction_index,9
                        jz shr_reg_byte_player2
                        cmp instruction_index,11
                        jz ror_reg_byte_player2 
                        cmp instruction_index,12
                        jz rol_reg_byte_player2
                        cmp instruction_index,8
                        jz sal_reg_byte_player2
                        cmp instruction_index,13
                        jz sar_reg_byte_player2
                        shl_reg_byte_player2:                  ; div ------------------------
                            shl Player1_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player1
                        shr_reg_byte_player2:                  ; mul ------------------------
                            shr Player1_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player1
                        ror_reg_byte_player2:                  ; idiv ------------------------
                            ror Player1_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player1 
                        rol_reg_byte_player2:                  ; imul ------------------------
                            rol Player1_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player1
                        sal_reg_byte_player2:                  ; inc ------------------------
                            sal Player1_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player1
                        sar_reg_byte_player2:                  ; dec ------------------------
                            sar Player1_Data_Register[bx],cl
                            jmp far ptr end_shl_reg_player1
                         
                         
            word_shl_reg_player1:
                    mov bh,0   
                    mov bl,dest_index_val
                    mov cl,Player2_Data_Register[bx]
                    mov bl,src_index_val
                    mov ah,Player2_Data_Register[bx]
                    mov al,Player2_Data_Register[bx+1]
                                  
                    ; paste here
                    cmp player_turn1,1
                    jz player1_shl_word_turn
                    jmp player1_shl_word_no_turn 
                    player1_shl_word_turn: 
                        cmp instruction_index,10
                        jz shl_reg_word_player1
                        cmp instruction_index,9
                        jz shr_reg_word_player1
                        cmp instruction_index,11
                        jz ror_reg_word_player1 
                        cmp instruction_index,12
                        jz rol_reg_word_player1
                        cmp instruction_index,8
                        jz sal_reg_word_player1
                        cmp instruction_index,13
                        jz sar_reg_word_player1 
                        shl_reg_word_player1:              ; div ------------------------
                            shl ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr player1_shl_word_no_turn
                        shr_reg_word_player1:                  ; mul ------------------------
                            shr ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr player1_shl_word_no_turn 
                        ror_reg_word_player1:                  ; idiv ------------------------
                            ror ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr player1_shl_word_no_turn 
                        rol_reg_word_player1:                  ; imul ------------------------
                            rol ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr player1_shl_word_no_turn
                        sal_reg_word_player1:                  ; inc ------------------------
                            sal ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr player1_shl_word_no_turn
                        sar_reg_word_player1:                  ; dec ------------------------
                            sar ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr player1_shl_word_no_turn
                  
                  ; paste here
                    player1_shl_word_no_turn:
                    cmp player_turn2,1
                    jz player2_shl_word_turn
                    jmp far ptr end_shl_reg_player1
                    player2_shl_word_turn: 
                        mov bl,dest_index_val
                        mov cl,Player1_Data_Register[bx]
                        mov bl,src_index_val
                        mov ah,Player1_Data_Register[bx]
                        mov al,Player1_Data_Register[bx+1]
                        cmp instruction_index,10
                        jz shl_reg_word_player2
                        cmp instruction_index,9
                        jz shr_reg_word_player2
                        cmp instruction_index,11
                        jz ror_reg_word_player2 
                        cmp instruction_index,12
                        jz rol_reg_word_player2
                        cmp instruction_index,8
                        jz sal_reg_word_player2
                        cmp instruction_index,13
                        jz sar_reg_word_player2 
                        shl_reg_word_player2:              ; div ------------------------
                            shl ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player1
                        shr_reg_word_player2:                  ; mul ------------------------
                            shr ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player1 
                        ror_reg_word_player2:                  ; idiv ------------------------
                            ror ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player1 
                        rol_reg_word_player2:                  ; imul ------------------------
                            rol ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player1
                        sal_reg_word_player2:                  ; inc ------------------------
                            sal ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player1
                        sar_reg_word_player2:                  ; dec ------------------------
                            sar ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr end_shl_reg_player1
                  
    lose_point_shl_reg_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
            
    end_shl_reg_player1:
     
    ret 
    shl_shr_ror_rol_register_player1 endp
;---------------------------------------------------  shl to datasegment  -----------------------------------------------------------------
shl_shr_ror_rol_address_player1  proc near
    
        check_forbidden Forbidden_instruction_1,instruction_index                   
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 17                      ; index to address value -> choose which value ?!
            jz forbidden_digit_address_shl 
            jnz forbidden_regsiter_address_shl 
            forbidden_digit_address_shl:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ah,Player2_Data_Register[bx]
                mov al,Player2_Data_Register[bx+1]
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_1 
                ;check_forbidden Forbidden_digits_2,0    <----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz  lose_point_1_shl_address_player1
                jmp cont_address_mode_shl 
                lose_point_1_shl_address_player1:
                ;jmp far ptr lose_point_player1
                jmp far ptr end_shl_address_player1
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp cont_address_mode_shl 
           forbidden_regsiter_address_shl:
                check_forbidden Forbidden_Registers_1,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   lose_point_2_shl_address_player1 
                jmp cont_address_mode_shl 
                lose_point_2_shl_address_player1:
                jmp far ptr lose_point_shl_address_player1                 
         cont_address_mode_shl:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose_point_3_shl_address_player1  ; out of index of data segment -> should be error 
            jmp cont_address_mode_shl2 
            lose_point_3_shl_address_player1:
            jmp far ptr lose_point_shl_address_player1 
            
            cont_address_mode_shl2:
           ; check if value or cl is valid 
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check_forbidden_digit_address_shl2 
            jnz check_forbidden_regsiter_address_shl2
            check_forbidden_digit_address_shl2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player2_Data_Register[bx]
                mov Player1_Data_Register[bx],ah
 
                ; call macro that check if value in ax is correct
                check_byte_valid ah, Forbidden_digits_1 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                jz  forbidden_address_shl_player1
                jmp final_address_mode_shl
                forbidden_address_shl_player1:
                jmp far ptr end_shl_address_player1  
            
            check_forbidden_regsiter_address_shl2:        
                
                cmp bl,7
                jnz lose_point_not_address_cl_p1
                check_forbidden Forbidden_Registers_1,bl                 
                mov al,losepoint 
                mov losepoint_player1,al  
                cmp losepoint_player1,1
                ;jz  lose_point_player1   
                jz temp_end_shl_address_player1   ; -> jump far here
                jmp  final_address_mode_shl
                temp_end_shl_address_player1:
                jmp far ptr end_shl_address_player1
                jmp final_address_mode_shl
                 lose_point_not_address_cl_p1:
                 jmp far ptr lose_point_shl_address_player1
            final_address_mode_shl:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,Player2_Data_Register[bx]
                    mov cl,Player2_Data_Register[bx+1]
                    mov si,cx 
                    mov bl, dest_index_val  
                    mov cl, Player2_Data_Register[bx]
                    mov ch,0            
                    
                    cmp player_turn1,1              ;-> player1 turn 
                    jz player1_shl_address_byte_turn
                    jmp player1_shl_address_byte_no_turn 
                    player1_shl_address_byte_turn:       
                            cmp instruction_index,10
                            jz shl_address_byte_player1
                            cmp instruction_index,9
                            jz shr_address_byte_player1
                            cmp instruction_index,11
                            jz ror_address_byte_player1 
                            cmp instruction_index,12
                            jz rol_address_byte_player1
                            cmp instruction_index,8
                            jz sal_address_byte_player1
                            cmp instruction_index,13
                            jz sar_address_byte_player1
                            shl_address_byte_player1:                  ; div ------------------------
                                shl data_segment_2[si],cl
                                jmp far ptr player1_shl_address_byte_no_turn
                            shr_address_byte_player1:                  ; mul ------------------------
                                shr data_segment_2[si],cl
                                jmp far ptr player1_shl_address_byte_no_turn
                            ror_address_byte_player1:                  ; idiv ------------------------
                                ror data_segment_2[si],cl
                                jmp far ptr player1_shl_address_byte_no_turn 
                            rol_address_byte_player1:                  ; imul ------------------------
                                rol data_segment_2[si],cl
                                jmp far ptr player1_shl_address_byte_no_turn
                            sal_address_byte_player1:                  ; inc ------------------------
                                sal data_segment_2[si],cl
                                jmp far ptr player1_shl_address_byte_no_turn
                            sar_address_byte_player1:                  ; dec ------------------------
                                sar data_segment_2[si],cl
                                jmp far ptr player1_shl_address_byte_no_turn  
                    player1_shl_address_byte_no_turn:
                        cmp player_turn2,1
                        jz player2_shl_address_byte_turn
                        jmp far ptr end_shl_address_player1
                        player2_shl_address_byte_turn:     
                            
                            mov bl,src_index_val
                            mov ch,Player1_Data_Register[bx]
                            mov cl,Player1_Data_Register[bx+1]
                            mov si,cx 
                            mov bl, dest_index_val  
                            mov cl, Player1_Data_Register[bx]
                            mov ch,0                            
                            cmp instruction_index,10
                            jz shl_address_byte_player2
                            cmp instruction_index,9
                            jz shr_address_byte_player2
                            cmp instruction_index,11
                            jz ror_address_byte_player2 
                            cmp instruction_index,12
                            jz rol_address_byte_player2
                            cmp instruction_index,8
                            jz sal_address_byte_player2
                            cmp instruction_index,13
                            jz sar_address_byte_player2
                            shl_address_byte_player2:                  ; div ------------------------
                                shl data_segment_1[si],cl
                                jmp far ptr end_shl_address_player1
                            shr_address_byte_player2:                  ; mul ------------------------
                                shr data_segment_1[si],cl
                                jmp far ptr end_shl_address_player1
                            ror_address_byte_player2:                  ; idiv ------------------------
                                ror data_segment_1[si],cl
                                jmp far ptr end_shl_address_player1 
                            rol_address_byte_player2:                  ; imul ------------------------
                                rol data_segment_1[si],cl
                                jmp far ptr end_shl_address_player1
                            sal_address_byte_player2:                  ; inc ------------------------
                                sal data_segment_1[si],cl
                                jmp far ptr end_shl_address_player1
                            sar_address_byte_player2:                  ; dec ------------------------
                                sar data_segment_1[si],cl
                                jmp far ptr end_shl_address_player1  

            
              
    lose_point_shl_address_player1:
        dec intial_points_player1
        mov losepoint_player1,0 
        mov losepoint,0
    
    end_shl_address_player1:
    
    ret
    shl_shr_ror_rol_address_player1 endp 




;------------------------------- PLAYER 2 -------------------


MOVPLAYER2PR PROC NEAR
            
            cmp power_up_player2,1
            jz mov_power_up1_player2
            cmp power_up_player2,2
            jz mov_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_mov_player2 
            mov_power_up1_player2: 
                cmp intial_points_player2,5
                JB nopoints_mov_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_mov_powerup1_p2 
                nopoints_mov_powerup1_p2:
                jmp far ptr endMOV_instruction_player2
                can_perform_mov_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player1,5
                    jmp perform_mov_player2 
            mov_power_up2_player2:
                cmp intial_points_player2,3
                JB nopoints_mov_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_mov_powerup2_p2 
                nopoints_mov_powerup2_p2:
                jmp far ptr endMOV_instruction_player2
                can_perform_mov_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_mov_player2
                perform_mov_player2:
                CMP FORBIDDEN_INSTRUCTION_2[0],'1'
                    JZ endMOV_instruction_player2
                        mov instruction_index,0
                        mov al,address_mode
                        cmp al,1
                        jz address_mode_mov2
                        jmp reg_mode_mov2                
                    address_mode_mov2:  
                        call  mov_address_player2
                        jmp far ptr endMOV_instruction_player2
                    reg_mode_mov2:
                        call  mov_register_player2 
                jmp far ptr endMOV_instruction_player2

	endMOV_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
RET
MOVPLAYER2PR  ENDP





ADDPLAYER2PR PROC NEAR
             
		cmp power_up_player1,1
            jz add_power_up1_player2
            cmp power_up_player1,2
            jz add_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_add_player2 
            add_power_up1_player2: 
                cmp intial_points_player2,5
                JB nopoints_add_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_add_powerup1_p2 
                nopoints_add_powerup1_p2:
                jmp far ptr endADD_instruction_player2
                can_perform_add_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0
                    sub intial_points_player2,5
                    jmp perform_add_player2 
            add_power_up2_player2:  
                cmp intial_points_player2,3
                JB nopoints_add_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_add_powerup2_p2 
                nopoints_add_powerup2_p2:
                jmp far ptr endADD_instruction_player2
                can_perform_add_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1 
                    sub intial_points_player2,3
                    jmp perform_add_player2
                perform_add_player2:
                                CMP FORBIDDEN_INSTRUCTION_2[1],'1'
                    JZ endMOV_instruction_player2
                        mov instruction_index,1
                        mov al,address_mode
                        cmp al,1
                        jz address_mode_add2
                        jmp reg_mode_add2                 
                    address_mode_add2:  
                        call  mov_address_player2
                        jmp far ptr endADD_instruction_player2
                    reg_mode_add2:      
                        call  mov_register_player2    
                  jmp far ptr endADD_instruction_player2

	endADD_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
RET
ADDPLAYER2PR  ENDP

SUBPLAYER2PR  PROC NEAR
; call drawing and clicking procedure --------------------------------
            
           cmp power_up_player2,1
            jz sub_power_up1_player2
            cmp power_up_player1,2
            jz sub_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_sub_player2 
            sub_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_Sub_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_Sub_powerup1_p2 
                nopoints_Sub_powerup1_p2:
                jmp far ptr endSUB_instruction_player2	
                can_perform_Sub_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0   
                    sub intial_points_player2,5
                    jmp perform_sub_player2 
            sub_power_up2_player2:
                cmp intial_points_player2,3
                JB nopoints_Sub_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_Sub_powerup2_p2 
                nopoints_Sub_powerup2_p2:
                jmp far ptr endSUB_instruction_player2	
                can_perform_Sub_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1 
                    sub intial_points_player2,3
                    jmp perform_sub_player2
            perform_sub_player2:
                            CMP FORBIDDEN_INSTRUCTION_2[2],'1'
                    JZ endSUB_instruction_player2
                        mov instruction_index,2
                        mov al,address_mode
                        cmp al,1
                        jz address_mode_sub2
                        jmp reg_mode_sub2        
                        ; address mode processing ---------------------------------------------------------         
                    address_mode_sub2:  
                        call  mov_address_player2
                        jmp far ptr endSUB_instruction_player2	
                    reg_mode_sub2:                
                        call  mov_register_player2    
                  jmp far ptr endSUB_instruction_player2	
	endSUB_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
	RET
SUBPLAYER2PR endp

MULPLAYER2PR PROC NEAR
            
	cmp power_up_player2,1
            jz mul_power_up1_player2
            cmp power_up_player2,2
            jz mul_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_mul_player2 
            mul_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_mul_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_mul_powerup1_p2 
                nopoints_mul_powerup1_p2:
                jmp far ptr endMUL_instruction_player2
                can_perform_mul_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_mul_player2 
            mul_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_mul_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_mul_powerup2_p2 
                nopoints_mul_powerup2_p2:
                jmp far ptr endMUL_instruction_player2
                can_perform_mul_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_mul_player2
            perform_mul_player2:
                            CMP FORBIDDEN_INSTRUCTION_2[3],'1'
                    JZ endMUL_instruction_player2
                    mov instruction_index,3
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_mul2
                    jmp reg_mode_mul2        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_mul2:  
                    call  divmulincdecaddressplayer2
                    jmp far ptr endMUL_instruction_player2
                reg_mode_mul2:
                    call  divmulincdecregisterplayer2 
              jmp far ptr endMUL_instruction_player2
	endMUL_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
RET
MULPLAYER2PR  ENDP

DIVPLAYER2PR  PROC NEAR
               
cmp power_up_player2,1
            jz div_power_up1_player2
            cmp power_up_player2,2
            jz div_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_div_player2 
            div_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_div_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_div_powerup1_p2 
                nopoints_div_powerup1_p2:
                jmp far ptr endDIV_instruction_player2
                can_perform_div_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_div_player2 
            div_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_div_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_div_powerup2_p2 
                nopoints_div_powerup2_p2:
                jmp far ptr endDIV_instruction_player2
                can_perform_div_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_div_player2
            perform_div_player2:
                                        CMP FORBIDDEN_INSTRUCTION_2[4],'1'
                    JZ endDIV_instruction_player2
                    mov instruction_index,4
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_div2
                    jmp reg_mode_div2        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_div2:  
                    call  divmulincdecaddressplayer2
                    jmp far ptr endDIV_instruction_player2
                reg_mode_div2:
                    call  divmulincdecregisterplayer2 
              jmp far ptr endDIV_instruction_player2
 	endDIV_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
	RET 
DIVPLAYER2PR   ENDP

IDIVPLAYER2PR PROC NEAR
            
  cmp power_up_player2,1
            jz Idiv_power_up1_player2
            cmp power_up_player2,2
            jz Idiv_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_Idiv_player2 
            Idiv_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_Idiv_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_Idiv_powerup1_p2 
                nopoints_Idiv_powerup1_p2:
                jmp far ptr endIDIV_instruction_player2
                can_perform_Idiv_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_Idiv_player2 
            Idiv_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_Idiv_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_Idiv_powerup2_p2 
                nopoints_Idiv_powerup2_p2:
                jmp far ptr endIDIV_instruction_player2
                can_perform_Idiv_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_Idiv_player2
            perform_Idiv_player2:
                                        CMP FORBIDDEN_INSTRUCTION_2[14],'1'
                    JZ endIDIV_instruction_player2
                    mov instruction_index,14
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_Idiv2
                    jmp reg_mode_Idiv2        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_Idiv2:  
                    call  divmulincdecaddressplayer2
                    jmp far ptr endIDIV_instruction_player2
                reg_mode_Idiv2:
                    call  divmulincdecregisterplayer2 
              jmp far ptr endIDIV_instruction_player2
           

	endIDIV_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
RET
IDIVPLAYER2PR  ENDP  

IMULPLAYER2PR PROC NEAR
             
cmp power_up_player2,1
            jz imul_power_up1_player2
            cmp power_up_player2,2
            jz imul_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_imul_player2 
            imul_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_imul_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_imul_powerup1_p2 
                nopoints_imul_powerup1_p2:
                jmp far ptr endIMUL_instruction_player2
                can_perform_imul_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_imul_player2 
            imul_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_imul_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_imul_powerup2_p2 
                nopoints_imul_powerup2_p2:
                jmp far ptr endIMUL_instruction_player2
                can_perform_imul_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_imul_player2
            perform_imul_player2:
                                        CMP FORBIDDEN_INSTRUCTION_2[15],'1'
                    JZ endIMUL_instruction_player2
                    mov instruction_index,15
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_imul2
                    jmp reg_mode_imul2        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_imul2:  
                    call  divmulincdecaddressplayer2
                    jmp far ptr endIMUL_instruction_player2
                reg_mode_imul2:
                    call  divmulincdecregisterplayer2 
              jmp far ptr endIMUL_instruction_player2
    
	endIMUL_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
RET
IMULPLAYER2PR  ENDP

INCPLAYER2PR  PROC NEAR
            
 cmp power_up_player2,1
            jz INC_power_up1_player2
            cmp power_up_player2,2
            jz INC_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_INC_player2 
            INC_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_INC_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_INC_powerup1_p2 
                nopoints_INC_powerup1_p2:
                jmp far ptr endINC_instruction_player2
                can_perform_INC_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_INC_player2 
            INC_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_INC_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_INC_powerup2_p2 
                nopoints_INC_powerup2_p2:
                jmp far ptr endINC_instruction_player2
                can_perform_INC_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_INC_player2
            perform_INC_player2:
                                        CMP FORBIDDEN_INSTRUCTION_2[5],'1'
                    JZ endINC_instruction_player2
                    mov instruction_index,5
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_INC2
                    jmp reg_mode_INC2        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_INC2:  
                    call  divmulincdecaddressplayer2
                    jmp far ptr endINC_instruction_player2
                reg_mode_INC2:
                    call  divmulincdecregisterplayer2 
              jmp far ptr endINC_instruction_player2
        
      	
	endINC_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
RET
INCPLAYER2PR  ENDP

DECPLAYER2PR PROC NEAR
              
cmp power_up_player2,1
            jz DEC_power_up1_player2
            cmp power_up_player2,2
            jz DEC_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_DEC_player2 
            DEC_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_DEC_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_DEC_powerup1_p2 
                nopoints_DEC_powerup1_p2:
                jmp far ptr endDEC_instruction_player2
                can_perform_DEC_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_DEC_player2 
            DEC_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_DEC_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_DEC_powerup2_p2 
                nopoints_DEC_powerup2_p2:
                jmp far ptr endDEC_instruction_player2
                can_perform_DEC_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_DEC_player2
            perform_DEC_player2:
                                        CMP FORBIDDEN_INSTRUCTION_2[6],'1'
                    JZ endDEC_instruction_player2
                    mov instruction_index,6
                    mov al,address_mode
                    cmp al,1
                    jz address_mode_DEC2
                    jmp reg_mode_DEC2        
                    ; address mode processing ---------------------------------------------------------         
                address_mode_DEC2:  
                    call  divmulincdecaddressplayer2
                    jmp far ptr endDEC_instruction_player2
                reg_mode_DEC2:
                    call  divmulincdecregisterplayer2 
              jmp far ptr endDEC_instruction_player2

	endDEC_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
RET
DECPLAYER2PR  ENDP

SARPLAYER2PR PROC NEAR
            ; call drawing and clicking procedure --------------------------------
            ; set variable to number then compare
            
            cmp power_up_player2,1
            jz SAR_power_up1_player2
            cmp power_up_player2,2
            jz SAR_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_SAR_player2 
            SAR_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_SAR_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SAR_powerup1_p2 
                nopoints_SAR_powerup1_p2:
                jmp far ptr endSAR_instruction_player2
                can_perform_SAR_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_SAR_player2 
            SAR_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_SAR_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SAR_powerup2_p2 
                nopoints_SAR_powerup2_p2:
                jmp far ptr endSAR_instruction_player2
                can_perform_SAR_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_SAR_player2
            perform_SAR_player2:
                                        CMP FORBIDDEN_INSTRUCTION_2[13],'1'
                    JZ endSAR_instruction_player2
            mov instruction_index,13
            mov al,address_mode
            cmp al,1
            jz address_mode_sar2
            jmp reg_mode_sar2        
            ; address mode processing ---------------------------------------------------------         
        address_mode_sar2:  
            call  shlshrrorroladdressplayer2
            jmp far ptr endSAR_instruction_player2
        reg_mode_sar2:
            call  shlshrrorrolregisterplayer2 
      jmp far ptr endSAR_instruction_player2

          
	endSAR_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
RET
SARPLAYER2PR  ENDP

SALPLAYER2PR PROC NEAR
            
cmp power_up_player2,1
            jz SAL_power_up1_player2
            cmp power_up_player2,2
            jz SAL_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_SAL_player2 
            SAL_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_SAL_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SAL_powerup1_p2 
                nopoints_SAL_powerup1_p2:
                jmp far ptr endSAL_instruction_player2
                can_perform_SAL_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_SAL_player2 
            SAL_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_SAL_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SAL_powerup2_p2 
                nopoints_SAL_powerup2_p2:
                jmp far ptr endSAL_instruction_player2
                can_perform_SAL_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_SAL_player2
            perform_SAL_player2:
                                        CMP FORBIDDEN_INSTRUCTION_2[8],'1'
                    JZ endSAL_instruction_player2
            mov instruction_index,8
            mov al,address_mode
            cmp al,1
            jz address_mode_sal2
            jmp reg_mode_sal2        
            ; address mode processing ---------------------------------------------------------         
        address_mode_sal2:  
            call  shlshrrorroladdressplayer2
            jmp far ptr endSAL_instruction_player2
        reg_mode_sal2:
            call  shlshrrorrolregisterplayer2 
      jmp far ptr endSAL_instruction_player2
    

  	endSAL_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
RET
SALPLAYER2PR  ENDP

SHRPLAYER2PR PROC NEAR
            
cmp power_up_player2,1
            jz SHR_power_up1_player2
            cmp power_up_player2,2
            jz SHR_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_SHR_player2 
            SHR_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_SHR_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SAR_powerup1_p2 
                nopoints_SHR_powerup1_p2:
                jmp far ptr endSHR_instruction_player2
                can_perform_SHR_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_SHR_player2 
            SHR_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_SHR_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SHR_powerup2_p2 
                nopoints_SHR_powerup2_p2:
                jmp far ptr endSHR_instruction_player2
                can_perform_SHR_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_SHR_player2
            perform_SHR_player2:
                                        CMP FORBIDDEN_INSTRUCTION_2[9],'1'
                    JZ endSHR_instruction_player2
            mov instruction_index,9
            mov al,address_mode
            cmp al,1
            jz address_mode_SHR2
            jmp reg_mode_SHR2        
            ; address mode processing ---------------------------------------------------------         
        address_mode_SHR2:  
            call  shlshrrorroladdressplayer2
            jmp far ptr endSHR_instruction_player2
        reg_mode_SHR2:
            call  shlshrrorrolregisterplayer2 
      jmp far ptr endSHR_instruction_player2

 	endSHR_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
RET
SHRPLAYER2PR  ENDP

SHLPLAYER2PR PROC NEAR
            
cmp power_up_player2,1
            jz SHL_power_up1_player2
            cmp power_up_player2,2
            jz SHL_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_SHL_player2 
            SHL_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_SHL_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SHL_powerup1_p2 
                nopoints_SHL_powerup1_p2:
                jmp far ptr endSHL_instruction_player2
                can_perform_SHL_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_SHL_player2 
            SHL_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_SHL_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_SHL_powerup2_p2 
                nopoints_SHL_powerup2_p2:
                jmp far ptr endSHL_instruction_player2
                can_perform_SHL_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_SHL_player2
            perform_SHL_player2:
                                        CMP FORBIDDEN_INSTRUCTION_2[10],'1'
                    JZ endSHL_instruction_player2
            mov instruction_index,10
            mov al,address_mode
            cmp al,1
            jz address_mode_SHL2
            jmp reg_mode_SHL2        
            ; address mode processing ---------------------------------------------------------         
        address_mode_SHL2:  
            call  shlshrrorroladdressplayer2
            jmp far ptr endSHL_instruction_player2
        reg_mode_SHL2:
            call  shlshrrorrolregisterplayer2 
      jmp far ptr endSHL_instruction_player2
  

	endSHL_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
RET
SHLPLAYER2PR  ENDP

RORPLAYER2PR PROC NEAR
           
  cmp power_up_player2,1
            jz ROR_power_up1_player2
            cmp power_up_player2,2
            jz ROR_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_ROR_player2 
            ROR_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_ROR_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_ROR_powerup1_p2 
                nopoints_ROR_powerup1_p2:
                jmp far ptr endROR_instruction_player2
                can_perform_ROR_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_ROR_player2 
            ROR_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_ROR_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_ROR_powerup2_p2 
                nopoints_ROR_powerup2_p2:
                jmp far ptr endROR_instruction_player2
                can_perform_ROR_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_ROR_player2
            perform_ROR_player2:
                                        CMP FORBIDDEN_INSTRUCTION_2[11],'1'
                    JZ endROR_instruction_player2
            mov instruction_index,11
            mov al,address_mode
            cmp al,1
            jz address_mode_ROR2
            jmp reg_mode_ROR2        
            ; address mode processing ---------------------------------------------------------         
        address_mode_ROR2:  
            call  shlshrrorroladdressplayer2
            jmp far ptr endROR_instruction_player2
        reg_mode_ROR2:
            call  shlshrrorrolregisterplayer2 
      jmp far ptr endROR_instruction_player2


	endROR_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
RET
RORPLAYER2PR  ENDP

ROLPLAYER2PR PROC NEAR
                   
        cmp power_up_player2,1
            jz ROL_power_up1_player2
            cmp power_up_player2,2
            jz ROL_power_up2_player2
                mov player_turn1,0
                mov player_turn2,1
                jmp perform_ROL_player2 
            ROL_power_up1_player2:
                cmp intial_points_player2,5
                JB nopoints_ROL_powerup1_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_ROL_powerup1_p2 
                nopoints_ROL_powerup1_p2:
                jmp far ptr endROL_instruction_player2
                can_perform_ROL_powerup1_p2:
                    mov player_turn1,1
                    mov player_turn2,0 
                    sub intial_points_player2,5
                    jmp perform_ROL_player2 
            ROL_power_up2_player2: 
                cmp intial_points_player2,3
                JB nopoints_ROL_powerup2_p2 ;-> end instruction of this player because of no points enough
                jmp can_perform_ROL_powerup2_p2 
                nopoints_ROL_powerup2_p2:
                jmp far ptr endROL_instruction_player2
                can_perform_ROL_powerup2_p2:
                    mov player_turn1,1
                    mov player_turn2,1
                    sub intial_points_player2,3
                    jmp perform_ROL_player2
            perform_ROL_player2:
                                        CMP FORBIDDEN_INSTRUCTION_2[12],'1'
                    JZ endROL_instruction_player2
            mov instruction_index,12
            mov al,address_mode
            cmp al,1
            jz address_mode_ROL2
            jmp reg_mode_ROL2        
            ; address mode processing ---------------------------------------------------------         
        address_mode_ROL2:  
            call  shlshrrorroladdressplayer2
            jmp far ptr endROL_instruction_player2
        reg_mode_ROL2:
            call  shlshrrorrolregisterplayer2 
      jmp far ptr endROL_instruction_player2
    
	endROL_instruction_player2:
	; mov address_mode ,0
	; mov address_mode2 ,0
	mov power_up_player2,0	
RET
ROLPLAYER2PR  ENDP







;-------------------------------------mov instruction -----------------------------------------------------------
mov_reg_des_player2 proc near
            
            cmp count_bit_1,2
            jz dest2_lose_point_player2_mov
            jmp here2_dest_player2
            dest2_lose_point_player2_mov:
            jmp far ptr  lose2_point_dest_player22_mov
            here2_dest_player2:
            mov bl,dest_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if dest_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 17                      ; index to address value -> choose which value ?!
            jz check2_forbidden_digit_mov_add22 
            jnz check2_forbidden_regsiter_mov_add22 
            check2_forbidden_digit_mov_add22:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player1_Data_Register[bx]
                mov al,Player1_Data_Register[bx+1]
                
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_2 ;<----------- working should be uncomment when we solve jump problem
                ;check_forbidden Forbidden_digits_2,0    <----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz  lose2_point_1_player2_dest
                jmp cont2_address_dest_mode_mov22 
                lose2_point_1_player2_dest:
                jmp far ptr lose2_point_dest_player22_mov
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp final2_address_mode_mov2_dest 
          check2_forbidden_regsiter_mov_add22:
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz   lose2_point_2_player2_dest 
                jmp cont2_address_dest_mode_mov22 
                lose2_point_2_player2_dest:
                jmp far ptr lose2_point_dest_player22_mov                 
         cont2_address_dest_mode_mov22:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,dest_index_val
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose2_point_dest_player2_mov  ; out of index of data segment -> should be error 
            jmp final2_address_mode_mov2_dest 
            lose2_point_dest_player2_mov:
            jmp far ptr lose2_point_dest_player22_mov 
            ;----------------------------------- 
            ; now its valid instruction ----------------------------------
       final2_address_mode_mov2_dest:
            mov bh,0
            mov bl,dest_index_val 
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1]
            mov si,ax
            mov bl,src_index_val
            ;mov cx,Player2_Data_Register[bx]  
            ; check if its two byte or not
                    cmp player_turn2,1
                    jz player222_mov_byte_dest_turn
                    jmp far ptr player222_mov_byte_dest_no_turn
                    player222_mov_byte_dest_turn:
                        cmp instruction_index,0
                        jz mov2_address_byte_player22_dest
                        cmp instruction_index,1
                        jz add2_address_byte_player22_dest
                        cmp instruction_index,2
                        jz sub2_address_byte_player22_dest
                        mov2_address_byte_player22_dest: 
                            mov cl,data_segment_1[si] 
                            mov Player1_Data_Register[bx],cl                 ; mov ------------------------
                            ;mov Player2_Data_Register[bx],ah
                            jmp far ptr player222_mov_byte_dest_no_turn
                        add2_address_byte_player22_dest:                  ; add ------------------------
                            mov cl,data_segment_1[si] 
                            add Player1_Data_Register[bx],cl 
                            ;add Player2_Data_Register[bx],ah
                            jmp far ptr player222_mov_byte_dest_no_turn
                        sub2_address_byte_player22_dest:                  ; sub ------------------------
                            mov cl,data_segment_1[si] 
                            sub Player1_Data_Register[bx],cl 
                            ;sub Player2_Data_Register[bx],ah
                            jmp far ptr player222_mov_byte_dest_no_turn
                   player222_mov_byte_dest_no_turn:
                    cmp player_turn1,1
                    jz player211_mov_byte_dest_turn
                    jmp far ptr end2_dest_mov_player2 
                    player211_mov_byte_dest_turn:
                        mov bl,dest_index_val 
                        mov ah,Player2_Data_Register[bx]
                        mov al,Player2_Data_Register[bx+1]
                        cmp ax,000fh
                            JA lose2_point_dest2_player22_mov  ; out of index of data segment -> should be error 
                            jmp cont2_final_address_mode_mov2_dest 
                            lose2_point_dest2_player22_mov:
                            jmp far ptr lose2_point_dest_player22_mov
                        cont2_final_address_mode_mov2_dest:
                        mov si,ax
                        mov bl,src_index_val
                        cmp instruction_index,0
                        jz mov2_address_byte_player11_dest
                        cmp instruction_index,1
                        jz add2_address_byte_player11_dest
                        cmp instruction_index,2
                        jz sub2_address_byte_player11_dest
                        mov2_address_byte_player11_dest: 
                            mov cl,data_segment_2[si] 
                            mov Player2_Data_Register[bx],cl                 ; mov ------------------------
                            ;mov Player2_Data_Register[bx],ah
                            jmp far ptr end2_dest_mov_player2
                        add2_address_byte_player11_dest:                  ; add ------------------------
                            mov cl,data_segment_2[si] 
                            add Player2_Data_Register[bx],cl 
                            ;add Player2_Data_Register[bx],ah
                            jmp far ptr end2_dest_mov_player2
                        sub2_address_byte_player11_dest:                  ; sub ------------------------
                            mov cl,data_segment_2[si] 
                            sub Player2_Data_Register[bx],cl 
                            ;sub Player2_Data_Register[bx],ah
                            jmp far ptr end2_dest_mov_player2

    lose2_point_dest_player22_mov:
        ;cmp player_turn ,1
        ;jz player1_lose_mov_dest_reg 
        ;dec intial_points_player2
        ;mov losepoint_player2,0 
        ;mov losepoint,0
        ;jmp end_dest_mov_player1
        ;player1_lose_mov_dest_reg:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0
    
    end2_dest_mov_player2:
    
    ret
    mov_reg_des_player2 endp
;----------------------------mov to a register ---------------------------------------------------
mov_register_player2 proc near
    
    check_forbidden Forbidden_instruction_2,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_2,bl

            mov al,losepoint 
            mov losepoint_player2,al 
            cmp losepoint_player2,1
            jz   lose2_point_2_reg_player2 
            jmp cont2_reg2_mode_mov 
            lose2_point_2_reg_player2:
            jmp far ptr lose2_point_reg_mov_player2                 
         cont2_reg2_mode_mov:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            
            ; check other operand------------------ 

            ; call lotfy code to get second operand 
            mov ah,count_bit_2
            mov al,count_bit_1
            cmp ah,al ;---------------------------------------------------
            jnz lose2_point_reg_mov_player2_temp 
            jmp to2_this_mov_player2
            lose2_point_reg_mov_player2_temp:
            jmp far ptr lose2_point_reg_mov_player2
            to2_this_mov_player2:
            cmp address_mode2,1 
            
            jz address2_mode_mov_des_player2
            jmp  address2_mode_mov_des_no_player2
            address2_mode_mov_des_player2:
                call mov_reg_des_player2
            jmp far ptr end2_mov_reg_player2
            
            address2_mode_mov_des_no_player2:
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check2_forbidden_digit_reg_mov22 
            jnz check2_forbidden_regsiter_reg_mov22
            check2_forbidden_digit_reg_mov22:
                ; macro needed to check if value has a forbidden digit or not
                
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player1_Data_Register[bx]
                mov al,Player1_Data_Register[bx+1] 
                ; call macro that check if value in ax is correct
                ; check if value is 2 bytes or 1 byte so that can call its function
                check_byte_valid al, Forbidden_digits_2 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1 
                
                jz  forbidden2_digit_mov_player2 
                jmp final2_reg_mode_mov2
                forbidden2_digit_mov_player2:
                    jmp far ptr end2_mov_reg_player2 
            check2_forbidden_regsiter_reg_mov22:        
            
                check_forbidden Forbidden_Registers_2,bl
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1
                jz  forbidden2_reg_mov_player2
                jmp final2_reg_mode_mov2
                forbidden2_reg_mov_player2:
                    jmp far ptr end2_mov_reg_player2   
              
                                

            ; now its valid instruction ----------------------------------
            final2_reg_mode_mov2:
            
                ;mov cx,Player2_Data_Register[bx]  
                ; check if its two byte or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player1_Data_Register[bx]
                mov al,Player1_Data_Register[bx+1]
                mov bl,src_index_val  
                mov dl,count_bit_2
                mov dh,0
                cmp dl,2
                jz word2_mov_reg_Temp_player2
                jmp byte2_mov_reg_temp_player2
                word2_mov_reg_Temp_player2:
                jmp far ptr word2_mov_reg_player2
                byte2_mov_reg_temp_player2: 
                    cmp player_turn2,1
                    jz player222_mov_byte_turn
                    jmp player222_mov_byte_no_turn 
                    player222_mov_byte_turn:
                        mov bl,src_index_val 
                        cmp instruction_index,0
                        jz mov2_reg_byte_player22
                        cmp instruction_index,1
                        jz add2_reg_byte_player22
                        cmp instruction_index,2
                        jz sub2_reg_byte_player22
                        mov2_reg_byte_player22:                  ; mov ------------------------
                            mov Player1_Data_Register[bx],ah
                            jmp far ptr player222_mov_byte_no_turn
                        add2_reg_byte_player22:                  ; add ------------------------
                            add Player1_Data_Register[bx],ah
                            jmp far ptr player222_mov_byte_no_turn
                        sub2_reg_byte_player22:                  ; sub ------------------------
                            sub Player1_Data_Register[bx],ah
                            jmp far ptr player222_mov_byte_no_turn
                    player222_mov_byte_no_turn:
                        cmp player_turn1,1
                        jz player211_mov_byte_turn
                        jmp far ptr end2_mov_reg_player2
                        player211_mov_byte_turn:
                            mov bl,dest_index_val 
                            mov ah,Player2_Data_Register[bx]
                            mov al,Player2_Data_Register[bx+1]
                            mov bl,src_index_val  
                            cmp instruction_index,0
                            jz mov2_reg_byte_player11
                            cmp instruction_index,1
                            jz add2_reg_byte_player11
                            cmp instruction_index,2
                            jz sub2_reg_byte_player11
                            mov2_reg_byte_player11:                  ; mov ------------------------
                                mov Player2_Data_Register[bx],ah
                                jmp far ptr end2_mov_reg_player2
                            add2_reg_byte_player11:                  ; add ------------------------
                                add Player2_Data_Register[bx],ah
                                jmp far ptr end2_mov_reg_player2
                            sub2_reg_byte_player11:                  ; sub ------------------------
                                sub Player2_Data_Register[bx],ah
                                jmp far ptr end2_mov_reg_player2
                                                        
                word2_mov_reg_player2:
                    cmp player_turn2,1
                    jz player222_mov_word_turn
                    jmp player222_mov_word_no_turn 
                    player222_mov_word_turn:
                    
                        cmp instruction_index,0
                        jz mov2_reg_word_player22
                        cmp instruction_index,1
                        jz add2_reg_word_player22
                        cmp instruction_index,2
                        jz sub2_reg_word_player22
                        mov2_reg_word_player22:                  ; mov ------------------------
                            mov Player1_Data_Register[bx+1],al
                            mov Player1_Data_Register[bx],ah
                            jmp far ptr player222_mov_word_no_turn
                        add2_reg_word_player22:                  ; add ------------------------
                            add Player1_Data_Register[bx+1],al
                            adc Player1_Data_Register[bx],ah
                            jmp far ptr player222_mov_word_no_turn
                        sub2_reg_word_player22:                  ; sub ------------------------
                            sub Player1_Data_Register[bx+1],al
                            sbb Player1_Data_Register[bx],ah
                            jmp far ptr player222_mov_word_no_turn             
                                                            ; lose point because of invalid instruction
    
                    player222_mov_word_no_turn:
                        cmp player_turn1,1
                        jz player211_mov_word_turn
                        jmp far ptr end2_mov_reg_player2
                        player211_mov_word_turn:
                        mov bl,dest_index_val 
                        mov ah,Player2_Data_Register[bx]
                        mov al,Player2_Data_Register[bx+1]
                        mov bl,src_index_val
                        cmp instruction_index,0
                        jz mov2_reg_word_player11
                        cmp instruction_index,1
                        jz add2_reg_word_player11
                        cmp instruction_index,2
                        jz sub2_reg_word_player11
                        mov2_reg_word_player11:                  ; mov ------------------------
                            mov Player2_Data_Register[bx+1],al
                            mov Player2_Data_Register[bx],ah
                            jmp far ptr end2_mov_reg_player2
                        add2_reg_word_player11:                  ; add ------------------------
                            add Player2_Data_Register[bx+1],al
                            adc Player2_Data_Register[bx],ah
                            jmp far ptr end2_mov_reg_player2
                        sub2_reg_word_player11:                  ; sub ------------------------
                            sub Player2_Data_Register[bx+1],al
                            sbb Player2_Data_Register[bx],ah
                            jmp far ptr end2_mov_reg_player2 
    
    
    lose2_point_reg_mov_player2:
        ;cmp player_turn ,1
        ;jz player1_lose_mov_reg 
        ;dec intial_points_player2
        ;mov losepoint_player2,0 
        ;mov losepoint,0
        ;jmp end_mov_reg_player1
        ;player1_lose_mov_reg:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0
    
    end2_mov_reg_player2:
     
    ret 
    mov_register_player2 endp
;---------------------------------------------------  mov to datasegment  -----------------------------------------------------------------
mov_address_player2  proc near
    
        check_forbidden Forbidden_instruction_2,instruction_index       
;-----------------------------i have all indexes-------------------------------------------- 
; ---------------------------- assume bolbol will send byte indicate if its address or not (two address modes for destination & source)
            CMP ADDRESS_MODE2,1
            JZ lose2_point_player2_temp
            jmp Asaad_Label
            
            lose2_point_player2_temp: jmp far ptr lose2_point_player2
            Asaad_Label:
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 18                      ; index to address value -> choose which value ?!
            jz check22_forbidden_digit_mov 
            jnz check22_forbidden_regsiter_mov 
            check22_forbidden_digit_mov:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ah,Player1_Data_Register[bx]
                mov al,Player1_Data_Register[bx+1]
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_2 ;<----------- working should be uncomment when we solve jump problem
                mov Player2_Data_Register[bx+1],al
                mov Player2_Data_Register[bx],ah 
                ;check_forbidden Forbidden_digits_2,0   ;<----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz  lose2_point_1_player2
                jmp cont22_address_mode_mov 
                lose2_point_1_player2:
                ;jmp far ptr lose_point_player1
                jmp far ptr end2_mov_address_player2
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp cont22_address_mode_mov 
            check22_forbidden_regsiter_mov:
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz   lose2_point_2_player2 
                jmp cont22_address_mode_mov 
                lose2_point_2_player2:
                jmp far ptr lose2_point_player2                 
         cont22_address_mode_mov:
            ;check if value in ax is less than f for two turns player1_turn & player2_turn
            mov bh,0
            mov bl,src_index_val
            cmp player_turn2,1              ;-> player1 turn 
            jz player222_check_address_mov
            jmp cont2_check_address_mode_mov22
            player222_check_address_mov:
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            cmp ax,000fh
            JA lose2_point_3_player22  ; out of index of data segment -> should be error 
            jmp cont2_check_address_mode_mov22 
            lose2_point_3_player22:
            jmp far ptr lose2_point_player2
            cont2_check_address_mode_mov22:
            cmp player_turn1,1              ;-> player1 turn 
            jz player211_check_address_mov
            jmp cont2_address_mode_mov22
            player211_check_address_mov:
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh  
            JA lose2_point_4_player22  ; out of index of data segment -> should be error 
            jmp cont2_address_mode_mov22 
            lose2_point_4_player22:
            jmp far ptr lose2_point_player2
            ; check other operand------------------ 
            cont2_address_mode_mov22:
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz check2_forbidden_digit_mov22 
            jnz check2_forbidden_regsiter_mov22
            check2_forbidden_digit_mov22:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player1_Data_Register[bx]
                mov al,Player1_Data_Register[bx+1] 
                ; call macro that check if value in ax is correct
                check_word_valid ax, Forbidden_digits_2 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1
  
                jz  forbidden2_address_mov_player2
                jmp final2_address_mode_mov2
                forbidden2_address_mov_player2:
                    jmp far ptr end2_mov_address_player2  
            
            check2_forbidden_regsiter_mov22:        
            
                check_forbidden Forbidden_Registers_2,bl
                 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1
                ;jz  lose_point_player1   
                jz temp2_end_mov_address_player2   ; -> jump far here
                jmp  final2_address_mode_mov2
                temp2_end_mov_address_player2:
                jmp far ptr end2_mov_address_player2
                ;mov bh,0
                ;mov bl,dest_index_val
                ;mov ah,Player2_Data_Register[bx]
                ;mov al,Player2_Data_Register[bx+1]

            ; now its valid instruction ----------------------------------
            final2_address_mode_mov2:
            mov bh,0
            mov bl,src_index_val 
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1]
            mov si,ax
            mov bl,dest_index_val
            ;mov cx,Player2_Data_Register[bx]  
            ; check if its two byte or not 
            mov dl,count_bit_2
            mov dh,0
            cmp dl,2
            jz lose2_point_plyer2       ;-> should jmp far
            jmp not2_lose_point_plyer2
            lose2_point_plyer2:
            jmp far ptr lose2_point_player2
            ; paste here  
            not2_lose_point_plyer2:
                    cmp player_turn2,1              ;-> player1 turn 
                    jz player222_mov_address_byte_turn
                    jmp player222_mov_address_byte_no_turn 
                    player222_mov_address_byte_turn:      
                        cmp instruction_index,0
                        jz mov2_address_byte_player22
                        cmp instruction_index,1
                        jz add2_address_byte_player22
                        cmp instruction_index,2
                        jz sub2_address_byte_player22
                        mov2_address_byte_player22:                  ; mov ------------------------
                            mov cl,Player1_Data_Register[bx]
                            mov data_segment_1[si],cl
                            ;mov Player2_Data_Register[bx],ah
                            jmp far ptr player222_mov_address_byte_no_turn
                        add2_address_byte_player22:                  ; add ------------------------
                            mov cl,Player1_Data_Register[bx]
                            add data_segment_1[si],cl
                            ;add Player2_Data_Register[bx],ah
                            jmp far ptr player222_mov_address_byte_no_turn
                        sub2_address_byte_player22:                  ; sub ------------------------
                            mov cl,Player1_Data_Register[bx]
                            sub data_segment_1[si],cl
                            ;sub Player2_Data_Register[bx],ah
                            jmp far ptr player222_mov_address_byte_no_turn
                            
                     player222_mov_address_byte_no_turn:
                        cmp player_turn1,1
                        jz player211_mov_address_byte_turn
                        jmp far ptr end2_mov_address_player2
                        player211_mov_address_byte_turn:
                            mov bl,src_index_val 
                            mov ah,Player2_Data_Register[bx]
                            mov al,Player2_Data_Register[bx+1]
                            mov si,ax
                            mov bl,dest_index_val
                            cmp instruction_index,0
                            jz mov2_address_byte_player11
                            cmp instruction_index,1
                            jz add2_address_byte_player11
                            cmp instruction_index,2
                            jz sub2_address_byte_player11
                            mov2_address_byte_player11:                  ; mov ------------------------
                                mov cl,Player2_Data_Register[bx]
                                mov data_segment_2[si],cl
                                jmp far ptr end2_mov_address_player2
                            add2_address_byte_player11:                  ; add ------------------------
                                mov cl,Player2_Data_Register[bx]
                                add data_segment_2[si],cl
                                jmp far ptr end2_mov_address_player2
                            sub2_address_byte_player11:                  ; sub ------------------------
                                mov cl,Player2_Data_Register[bx]
                                sub data_segment_2[si],cl
                                jmp far ptr end2_mov_address_player2                                    
              
    lose2_point_player2:
        dec intial_points_player2
        mov losepoint_player1,0 
        mov losepoint,0
    
    end2_mov_address_player2:
    
    ret
    mov_address_player2 endp 
;----------------------------div mul inc dec imul idiv reg ---------------------------------------------------
divmulincdecregisterplayer2 proc near
    
    check_forbidden Forbidden_instruction_2,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_2,bl

            mov al,losepoint 
            mov losepoint_player2,al 
            cmp losepoint_player2,1
            jz   lose2point2regdivplayer2 
            jmp cont2regmode2div 
            lose2point2regdivplayer2:
            jmp far ptr end2divregplayer2                 
         cont2regmode2div:
            mov dl,count_bit_1
            mov dh,0
            cmp dl,2
            jz temp2worddivregplayer2
            jmp temp2bytedivregplayer2
            temp2worddivregplayer2:
            jmp far ptr word2divregplayer2
            temp2bytedivregplayer2:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,0
                    mov cl,Player1_Data_Register[bx]            
                    mov ah,Player1_Data_Register[0]
                    mov al,Player1_Data_Register[1]
                    mov dx,0 
                    ; add player turn here : 
                    cmp player_turn2,1
                    jz player222divbyteturn
                    jmp player222divbytenoturn 
                    player222divbyteturn:    
                        cmp instruction_index,4
                        jz div2regbyteplayer22
                        cmp instruction_index,3
                        jz mul2regbyteplayer22
                        cmp instruction_index,14
                        jz idiv2regbyteplayer22 
                        cmp instruction_index,15
                        jz imul2regbyteplayer22
                        cmp instruction_index,5
                        jz inc2regbyteplayer22
                        cmp instruction_index,6
                        jz dec2regbyteplayer22
                        div2regbyteplayer22:                  ; div ------------------------
                            cmp cx,0
                            jz div2zerobyteregp22
                            jmp not2divzerobyteregp22
                            div2zerobyteregp22:
                            jmp far ptr lose2pointdivplayer2
                            not2divzerobyteregp22:
                            div cx
                            mov Player1_Data_Register[0],dl
                            mov Player1_Data_Register[1],al
                            jmp far ptr player222divbytenoturn
                        mul2regbyteplayer22:                  ; mul ------------------------
                            mul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al 
                            jmp far ptr player222divbytenoturn
                        idiv2regbyteplayer22:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv2zerobyteregp22
                            jmp not2idivzerobyteregp22
                            idiv2zerobyteregp22:
                            jmp far ptr lose2pointdivplayer2
                            not2idivzerobyteregp22:
                            idiv cx
                            mov Player1_Data_Register[0],dl
                            mov Player1_Data_Register[1],al
                            jmp far ptr player222divbytenoturn 
                        imul2regbyteplayer22:                  ; imul ------------------------
                            imul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            jmp far ptr player222divbytenoturn
                        inc2regbyteplayer22:                  ; inc ------------------------
                            inc cl
                            mov Player1_Data_Register[bx],cl
                            jmp far ptr player222divbytenoturn
                        dec2regbyteplayer22:                  ; dec ------------------------
                            dec cx
                            mov Player1_Data_Register[bx],cl
                            jmp far ptr player222divbytenoturn
                    
                    player222divbytenoturn:        
                    cmp player_turn1,1
                    jz player211divbyteturn
                    jmp far ptr end2divregplayer2 
                    player211divbyteturn:
                        mov cl,Player2_Data_Register[bx]            
                        mov ah,Player2_Data_Register[0]
                        mov al,Player2_Data_Register[1]    
                        cmp instruction_index,4
                        jz div2regbyteplayer11
                        cmp instruction_index,3
                        jz mul2regbyteplayer11
                        cmp instruction_index,14
                        jz idiv2regbyteplayer11 
                        cmp instruction_index,15
                        jz imul2regbyteplayer11
                        cmp instruction_index,5
                        jz inc2regbyteplayer11
                        cmp instruction_index,6
                        jz dec2regbyteplayer11
                        div2regbyteplayer11:                  ; div ------------------------
                            cmp cx,0
                            jz div2zerobyteregp11
                            jmp not2divzerobyteregp11
                            div2zerobyteregp11:
                            jmp far ptr lose2pointdivplayer2
                            not2divzerobyteregp11:
                            div cx
                            mov Player2_Data_Register[0],dl
                            mov Player2_Data_Register[1],al
                            jmp far ptr end2divregplayer2
                        mul2regbyteplayer11:                  ; mul ------------------------
                            mul cl
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al 
                            jmp far ptr end2divregplayer2
                        idiv2regbyteplayer11:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv2zerobyteregp11
                            jmp not2idivzerobyteregp11
                            idiv2zerobyteregp11:
                            jmp far ptr lose2pointdivplayer2
                            not2idivzerobyteregp11:
                            idiv cx
                            mov Player2_Data_Register[0],dl
                            mov Player2_Data_Register[1],al
                            jmp far ptr end2divregplayer2 
                        imul2regbyteplayer11:                  ; imul ------------------------
                            imul cl
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            jmp far ptr end2divregplayer2
                        inc2regbyteplayer11:                  ; inc ------------------------
                            inc cl
                            mov Player2_Data_Register[bx],cl
                            jmp far ptr end2divregplayer2
                        dec2regbyteplayer11:                  ; dec ------------------------
                            dec cx
                            mov Player2_Data_Register[bx],cl
                            jmp far ptr end2divregplayer2     
            word2divregplayer2:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,Player1_Data_Register[bx]
                    mov cl,Player1_Data_Register[bx+1]             
                    mov ah,Player1_Data_Register[0]
                    mov al,Player1_Data_Register[1]
                    mov dh,Player1_Data_Register[6]
                    mov dl,Player1_Data_Register[7] 
                    ; add player turn here
                     
                    cmp player_turn2,1
                    jz player222divwordturn
                    jmp player222divwordnoturn 
                    player222divwordturn: 
                        cmp instruction_index,4
                        jz div2regwordplayer22
                        cmp instruction_index,3
                        jz mul2regwordplayer22
                        cmp instruction_index,14
                        jz idiv2regwordplayer22 
                        cmp instruction_index,15
                        jz imul2regwordplayer22
                        cmp instruction_index,5
                        jz inc2regwordplayer22
                        cmp instruction_index,6
                        jz dec2regwordplayer22
                        div2regwordplayer22:                  ; div ------------------------
                            cmp cx,0
                            jz div2zerowordregp22
                            div cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr player222divwordnoturn
                            div2zerowordregp22:
                            jmp far ptr lose2pointdivplayer2
                            not2divzerowordregp22:

                        mul2regwordplayer22:                  ; mul ------------------------
                            mul cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr player222divwordnoturn 
                        idiv2regwordplayer22:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv2zerowordregp22
                            jmp not2idivzerowordregp22
                            idiv2zerowordregp22:
                            jmp far ptr lose2pointdivplayer2
                            not2idivzerowordregp22:
                            idiv cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al 
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr player222divwordnoturn 
                        imul2regwordplayer22:                  ; imul ------------------------
                            imul cx
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            mov Player1_Data_Register[6],dh
                            mov Player1_Data_Register[7],dl
                            jmp far ptr player222divwordnoturn
                        inc2regwordplayer22:                  ; inc ------------------------
                            inc cx
                            mov Player1_Data_Register[bx],ch
                            mov Player1_Data_Register[bx+1],cl
                            jmp far ptr player222divwordnoturn
                        dec2regwordplayer22:                  ; dec ------------------------
                            dec cx
                            mov Player1_Data_Register[bx],ch
                            mov Player1_Data_Register[bx+1],cl
                            jmp far ptr player222divwordnoturn 
                    
                    ; add player turn here 
                    player222divwordnoturn:
                    cmp player_turn1,1
                    jz player211divwordturn
                    jmp far ptr end2divregplayer2
                    player211divwordturn:
                        
                        mov ch,Player2_Data_Register[bx]
                        mov cl,Player2_Data_Register[bx+1]             
                        mov ah,Player2_Data_Register[0]
                        mov al,Player2_Data_Register[1]
                        mov dh,Player2_Data_Register[6]
                        mov dl,Player2_Data_Register[7] 
                        cmp instruction_index,4
                        jz div2regwordplayer11
                        cmp instruction_index,3
                        jz mul2regwordplayer11
                        cmp instruction_index,14
                        jz idiv2regwordplayer11 
                        cmp instruction_index,15
                        jz imul2regwordplayer11
                        cmp instruction_index,5
                        jz inc2regwordplayer11
                        cmp instruction_index,6
                        jz dec2regwordplayer11
                        div2regwordplayer11:                  ; div ------------------------
                            cmp cx,0
                            jz div2zerowordregp11
                            div cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr end2divregplayer2
                            div2zerowordregp11:
                            jmp far ptr lose2pointdivplayer2

                        mul2regwordplayer11:                  ; mul ------------------------
                            mul cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr end2divregplayer2 
                        idiv2regwordplayer11:                  ; idiv ------------------------
                            cmp cx,0
                            jz idiv2zerowordregp11
                            jmp not2idivzerowordregp11
                            idiv2zerowordregp11:
                            jmp far ptr lose2pointdivplayer2
                            not2idivzerowordregp11:
                            idiv cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al 
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr end2divregplayer2 
                        imul2regwordplayer11:                  ; imul ------------------------
                            imul cx
                            mov Player2_Data_Register[0],ah
                            mov Player2_Data_Register[1],al
                            mov Player2_Data_Register[6],dh
                            mov Player2_Data_Register[7],dl
                            jmp far ptr end2divregplayer2
                        inc2regwordplayer11:                  ; inc ------------------------
                            inc cx
                            mov Player2_Data_Register[bx],ch
                            mov Player2_Data_Register[bx+1],cl
                            jmp far ptr end2divregplayer2
                        dec2regwordplayer11:                  ; dec ------------------------
                            dec cx
                            mov Player2_Data_Register[bx],ch
                            mov Player2_Data_Register[bx+1],cl
                            jmp far ptr end2divregplayer2 
                    
    
   lose2pointdivplayer2:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0                
    end2divregplayer2:
     
    ret 
    divmulincdecregisterplayer2 endp
    

divmulincdecaddressplayer2  proc near
    
        check_forbidden Forbidden_instruction_2,instruction_index                   
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 18                      ; index to address value -> choose which value ?!
            jz forbiddendigitaddress2div 
            jnz forbiddenregsiteraddress2div 
            forbiddendigitaddress2div:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ah,Player1_Data_Register[bx]
                mov al,Player1_Data_Register[bx+1]
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_2 
                ;check_forbidden Forbidden_digits_2,0    <----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz  losepoint1divaddressplayer2
                jmp contaddressmode2div 
                losepoint1divaddressplayer2:
                ;jmp far ptr lose_point_player1
                jmp far ptr enddivaddressplayer2
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp contaddressmode2div 
           forbiddenregsiteraddress2div:
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz   losepoint2divaddressplayer2 
                jmp contaddressmode2div 
                losepoint2divaddressplayer2:
                jmp far ptr losepointdivaddressplayer2                 
         contaddressmode2div:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val 
            cmp player_turn2,1              ;-> player1 turn 
            jz player22checkaddressdiv
            jmp contcheckaddressmode2div2
            player22checkaddressdiv:
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            cmp ax,000fh
            JA losepoint3divaddressplayer2  ; out of index of data segment -> should be error 
            jmp contcheckaddressmode2div2 
            losepoint3divaddressplayer2:
            jmp far ptr losepointdivaddressplayer2
            contcheckaddressmode2div2:
            cmp player_turn1,1              ;-> player1 turn 
            jz player11checkaddressdiv
            jmp finaladdressmode2div
            player11checkaddressdiv:
            mov ah,Player2_Data_Register[bx]
            mov al,Player2_Data_Register[bx+1] 
            cmp ax,000fh  
            JA losepoint4divaddressplayer2  ; out of index of data segment -> should be error 
            jmp finaladdressmode2div 
            losepoint4divaddressplayer2:
            jmp far ptr losepointdivaddressplayer2
            finaladdressmode2div:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,Player1_Data_Register[bx]
                    mov cl,Player1_Data_Register[bx+1]
                    mov si,cx
                    mov cl,data_segment_1[si]
                    mov ch,0            
                    mov ah,Player1_Data_Register[0]
                    mov al,Player1_Data_Register[1]
                    
                    ; paste here
                    cmp player_turn2,1              ;-> player1 turn 
                    jz player22divaddressbyteturn
                    jmp player22divaddressbytenoturn 
                    player22divaddressbyteturn:
                        cmp instruction_index,4
                        jz divaddressbyteplayer22
                        cmp instruction_index,3
                        jz muladdressbyteplayer22
                        cmp instruction_index,14
                        jz idivaddressbyteplayer22 
                        cmp instruction_index,15
                        jz imuladdressbyteplayer22
                        cmp instruction_index,5
                        jz incaddressbyteplayer22
                        cmp instruction_index,6
                        jz decaddressbyteplayer22
                        divaddressbyteplayer22:                  ; div ------------------------
                            cmp cx,0
                            jz divzeroaddressregp22
                            jmp notdivzeroaddressregp22
                            divzeroaddressregp22:
                            jmp far ptr losepointdivaddressplayer2
                            notdivzeroaddressregp22:
                            div cx
                            mov Player1_Data_Register[0],dh
                            mov Player1_Data_Register[1],al
                            jmp far ptr player22divaddressbytenoturn
                        muladdressbyteplayer22:                  ; mul ------------------------
                            mul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al 
                            jmp far ptr player22divaddressbytenoturn
                        idivaddressbyteplayer22:                  ; idiv ------------------------
                            cmp cx,0
                            jz idivzeroaddressregp22
                            jmp notidivzeroaddressregp22
                            idivzeroaddressregp22:
                            jmp far ptr losepointdivaddressplayer2
                            notidivzeroaddressregp22:
                            idiv cx
                            mov Player1_Data_Register[0],dh
                            mov Player1_Data_Register[1],al
                            jmp far ptr player22divaddressbytenoturn 
                        imuladdressbyteplayer22:                  ; imul ------------------------
                            imul cl
                            mov Player1_Data_Register[0],ah
                            mov Player1_Data_Register[1],al
                            jmp far ptr player22divaddressbytenoturn
                        incaddressbyteplayer22:                  ; inc ------------------------
                            inc cl
                            mov data_segment_1[si],cl
                            jmp far ptr player22divaddressbytenoturn
                        decaddressbyteplayer22:                  ; dec ------------------------
                            dec cx
                            mov data_segment_1[si],cl
                            jmp far ptr player22divaddressbytenoturn 

                                        
                    player22divaddressbytenoturn:
                        cmp player_turn1,1
                        jz player11divaddressbyteturn
                        jmp far ptr enddivaddressplayer2
                        player11divaddressbyteturn:
                            mov ch,Player2_Data_Register[bx]
                            mov cl,Player2_Data_Register[bx+1]
                            mov si,cx
                            mov cl,data_segment_2[si]
                            mov ch,0            
                            mov ah,Player2_Data_Register[0]
                            mov al,Player2_Data_Register[1]
                            cmp instruction_index,4
                            jz divaddressbyteplayer11
                            cmp instruction_index,3
                            jz muladdressbyteplayer11
                            cmp instruction_index,14
                            jz idivaddressbyteplayer11 
                            cmp instruction_index,15
                            jz imuladdressbyteplayer11
                            cmp instruction_index,5
                            jz incaddressbyteplayer11
                            cmp instruction_index,6
                            jz decaddressbyteplayer11
                            divaddressbyteplayer11:                  ; div ------------------------
                                cmp cx,0
                                jz divzeroaddressregp11
                                jmp notdivzeroaddressregp11
                                divzeroaddressregp11:
                                jmp far ptr losepointdivaddressplayer2
                                notdivzeroaddressregp11:
                                div cx
                                mov Player2_Data_Register[0],dh
                                mov Player2_Data_Register[1],al
                                jmp far ptr enddivaddressplayer2
                            muladdressbyteplayer11:                  ; mul ------------------------
                                mul cl
                                mov Player2_Data_Register[0],ah
                                mov Player2_Data_Register[1],al 
                                jmp far ptr enddivaddressplayer2
                            idivaddressbyteplayer11:                  ; idiv ------------------------
                                cmp cx,0
                                jz idivzeroaddressregp11
                                jmp notidivzeroaddressregp11
                                idivzeroaddressregp11:
                                jmp far ptr losepointdivaddressplayer2
                                notidivzeroaddressregp11:
                                idiv cx
                                mov Player2_Data_Register[0],dh
                                mov Player2_Data_Register[1],al
                                jmp far ptr enddivaddressplayer2 
                            imuladdressbyteplayer11:                  ; imul ------------------------
                                imul cl
                                mov Player2_Data_Register[0],ah
                                mov Player2_Data_Register[1],al
                                jmp far ptr enddivaddressplayer2
                            incaddressbyteplayer11:                  ; inc ------------------------
                                inc cl
                                mov data_segment_2[si],cl
                                jmp far ptr enddivaddressplayer2
                            decaddressbyteplayer11:                  ; dec ------------------------
                                dec cx
                                mov data_segment_2[si],cl
                                jmp far ptr enddivaddressplayer2 
                    
              
    losepointdivaddressplayer2:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0
    
    enddivaddressplayer2:
    
    ret
    divmulincdecaddressplayer2 endp




;----------------------------shl  reg ---------------------------------------------------
shlshrrorrolregisterplayer2 proc near
    
    check_forbidden Forbidden_instruction_2,instruction_index       
             
            mov bl,src_index_reg
            mov bh,0 
                
            check_forbidden Forbidden_Registers_2,bl

            mov al,losepoint 
            mov losepoint_player2,al 
            cmp losepoint_player2,1
            jz   losepoint2regshlplayer2 
            jmp contregmode2shl 
            losepoint2regshlplayer2:
            jmp far ptr endshlregplayer2                 
         contregmode2shl:
         
           ; check if value or cl is valid 
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz checkforbiddendigitreg2shl2 
            jnz checkforbiddenregsiterreg2shl2
            checkforbiddendigitreg2shl2:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player1_Data_Register[bx]
                mov Player2_Data_Register[bx],ah
 
                ; call macro that check if value in ax is correct
                check_byte_valid ah, Forbidden_digits_2 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1
                jz  forbiddenregshlplayer2
                jmp contregmode2shl2
                forbiddenregshlplayer2:
                jmp far ptr endshlregplayer2  
            
            checkforbiddenregsiterreg2shl2:        
                
                cmp bl,7
                jnz losepointnotregclp2
                check_forbidden Forbidden_Registers_2,bl                 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1   
                jz tempendshlregplayer2   ; -> jump far here
                jmp  contregmode2shl2
                tempendshlregplayer2:
                jmp far ptr endshlregplayer2
                losepointnotregclp2:
                jmp far ptr losepointshlregplayer2 
         contregmode2shl2:
            mov dl,count_bit_1
            mov dh,0
            cmp dl,2
            jz tempwordshlregplayer2
            jmp tempbyteshlregplayer2
            tempwordshlregplayer2:
            jmp far ptr wordshlregplayer2
            tempbyteshlregplayer2:
                    mov bh,0
                    mov bl,dest_index_val
                    mov ch,0
                    mov cl,Player1_Data_Register[bx]
                    mov bl, src_index_val
                                 
                    ; paste here
                    cmp player_turn2,1
                    jz player22shlbyteturn
                    jmp player22shlbytenoturn 
                    player22shlbyteturn:
                        cmp instruction_index,10
                        jz shlregbyteplayer22
                        cmp instruction_index,9
                        jz shrregbyteplayer22
                        cmp instruction_index,11
                        jz rorregbyteplayer22 
                        cmp instruction_index,12
                        jz rolregbyteplayer22
                        cmp instruction_index,8
                        jz salregbyteplayer22
                        cmp instruction_index,13
                        jz sarregbyteplayer22
                        shlregbyteplayer22:                  ; div ------------------------
                            shl Player1_Data_Register[bx],cl
                            jmp far ptr player22shlbytenoturn
                        shrregbyteplayer22:                  ; mul ------------------------
                            shr Player1_Data_Register[bx],cl
                            jmp far ptr player22shlbytenoturn
                        rorregbyteplayer22:                  ; idiv ------------------------
                            ror Player1_Data_Register[bx],cl
                            jmp far ptr player22shlbytenoturn 
                        rolregbyteplayer22:                  ; imul ------------------------
                            rol Player1_Data_Register[bx],cl
                            jmp far ptr player22shlbytenoturn
                        salregbyteplayer22:                  ; inc ------------------------
                            sal Player1_Data_Register[bx],cl
                            jmp far ptr player22shlbytenoturn
                        sarregbyteplayer22:                  ; dec ------------------------
                            sar Player1_Data_Register[bx],cl
                            jmp far ptr player22shlbytenoturn
                   ; paste here     
                    player22shlbytenoturn:        
                    cmp player_turn1,1
                    jz player11shlbyteturn
                    jmp far ptr endshlregplayer2 
                    player11shlbyteturn:
                        mov bl,dest_index_val
                        mov ch,0
                        mov cl,Player2_Data_Register[bx]
                        mov bl, src_index_val
                        cmp instruction_index,10
                        jz shlregbyteplayer11
                        cmp instruction_index,9
                        jz shrregbyteplayer11
                        cmp instruction_index,11
                        jz rorregbyteplayer11 
                        cmp instruction_index,12
                        jz rolregbyteplayer11
                        cmp instruction_index,8
                        jz salregbyteplayer11
                        cmp instruction_index,13
                        jz sarregbyteplayer11
                        shlregbyteplayer11:                  ; div ------------------------
                            shl Player2_Data_Register[bx],cl
                            jmp far ptr endshlregplayer2
                        shrregbyteplayer11:                  ; mul ------------------------
                            shr Player2_Data_Register[bx],cl
                            jmp far ptr endshlregplayer2
                        rorregbyteplayer11:                  ; idiv ------------------------
                            ror Player2_Data_Register[bx],cl
                            jmp far ptr endshlregplayer2 
                        rolregbyteplayer11:                  ; imul ------------------------
                            rol Player2_Data_Register[bx],cl
                            jmp far ptr endshlregplayer2
                        salregbyteplayer11:                  ; inc ------------------------
                            sal Player2_Data_Register[bx],cl
                            jmp far ptr endshlregplayer2
                        sarregbyteplayer11:                  ; dec ------------------------
                            sar Player2_Data_Register[bx],cl
                            jmp far ptr endshlregplayer2
                         
                         
            wordshlregplayer2:
                    mov bh,0   
                    mov bl,dest_index_val
                    mov cl,Player1_Data_Register[bx]
                    mov bl,src_index_val
                    mov ah,Player1_Data_Register[bx]
                    mov al,Player1_Data_Register[bx+1]
                                  
                    ; paste here
                    cmp player_turn2,1
                    jz player22shlwordturn
                    jmp player22shlwordnoturn 
                    player22shlwordturn: 
                        cmp instruction_index,10
                        jz shlregwordplayer22
                        cmp instruction_index,9
                        jz shrregwordplayer22
                        cmp instruction_index,11
                        jz rorregwordplayer22
                        cmp instruction_index,12
                        jz rolregwordplayer22
                        cmp instruction_index,8
                        jz salregwordplayer22
                        cmp instruction_index,13
                        jz sarregwordplayer22 
                        shlregwordplayer22:              ; div ------------------------
                            shl ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22shlwordnoturn
                        shrregwordplayer22:                  ; mul ------------------------
                            shr ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22shlwordnoturn 
                        rorregwordplayer22:                  ; idiv ------------------------
                            ror ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22shlwordnoturn 
                        rolregwordplayer22:                  ; imul ------------------------
                            rol ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22shlwordnoturn
                        salregwordplayer22:                  ; inc ------------------------
                            sal ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22shlwordnoturn
                        sarregwordplayer22:                  ; dec ------------------------
                            sar ax,cl
                            mov Player1_Data_Register[bx],ah
                            mov Player1_Data_Register[bx+1],al
                            jmp far ptr player22shlwordnoturn
                  
                  ; paste here
                    player22shlwordnoturn:
                    cmp player_turn1,1
                    jz player11shlwordturn
                    jmp far ptr endshlregplayer2
                    player11shlwordturn: 
                        mov bl,dest_index_val
                        mov cl,Player2_Data_Register[bx]
                        mov bl,src_index_val
                        mov ah,Player2_Data_Register[bx]
                        mov al,Player2_Data_Register[bx+1]
                        cmp instruction_index,10
                        jz shlregwordplayer11
                        cmp instruction_index,9
                        jz shrregwordplayer11
                        cmp instruction_index,11
                        jz rorregwordplayer11 
                        cmp instruction_index,12
                        jz rolregwordplayer11
                        cmp instruction_index,8
                        jz salregwordplayer11
                        cmp instruction_index,13
                        jz sarregwordplayer11
                        shlregwordplayer11:              ; div ------------------------
                            shl ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr endshlregplayer2
                        shrregwordplayer11:                  ; mul ------------------------
                            shr ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr endshlregplayer2 
                        rorregwordplayer11:                  ; idiv ------------------------
                            ror ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr endshlregplayer2 
                        rolregwordplayer11:                  ; imul ------------------------
                            rol ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr endshlregplayer2
                        salregwordplayer11:                  ; inc ------------------------
                            sal ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr endshlregplayer2
                        sarregwordplayer11:                  ; dec ------------------------
                            sar ax,cl
                            mov Player2_Data_Register[bx],ah
                            mov Player2_Data_Register[bx+1],al
                            jmp far ptr endshlregplayer2
                  
    losepointshlregplayer2:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0
            
    endshlregplayer2:
     
    ret 
    shlshrrorrolregisterplayer2 endp
;---------------------------------------------------  shl to datasegment  -----------------------------------------------------------------
shlshrrorroladdressplayer2  proc near
    
        check_forbidden Forbidden_instruction_2,instruction_index                   
            mov bl,src_index_reg
            mov bh,0     
            ; check if is forbidden or not 
            ; check if src_index_reg is value or register
            ;cmp bl,17                        ; index to value
            cmp bl , 17                      ; index to address value -> choose which value ?!
            jz forbiddendigitaddress22shl 
            jnz forbiddenregsiteraddress22shl 
            forbiddendigitaddress22shl:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,src_index_val
                mov ah,Player1_Data_Register[bx]
                mov al,Player1_Data_Register[bx+1]
                ; call macro that check if value in ax is correct 
                
                check_word_valid ax, Forbidden_digits_2 
                ;check_forbidden Forbidden_digits_2,0    <----------- not working should be removed later
                mov al,losepoint 
                mov losepoint_player2,al 
                cmp losepoint_player2,1
                jz  losepoint1shladdressplayer2
                jmp contaddressmode2shl 
                losepoint1shladdressplayer2:
                ;jmp far ptr lose_point_player1
                jmp far ptr endshladdressplayer2
        ; destination now is correct  value ------------------------------------------------------------------------------                 
                jmp contaddressmode2shl 
           forbiddenregsiteraddress22shl:
                check_forbidden Forbidden_Registers_2,bl
                ; need macro to check if this register is not bx or di or si to make later -> should jmp lose_point
                mov al,losepoint 
                mov losepoint_player1,al 
                cmp losepoint_player1,1
                jz   losepoint2shladdressplayer2 
                jmp contaddressmode2shl 
                losepoint2shladdressplayer2:
                jmp far ptr losepointshladdressplayer2                 
         contaddressmode2shl:
            ;check if value in ax is less than f
            mov bh,0
            mov bl,src_index_val
            mov ah,Player1_Data_Register[bx]
            mov al,Player1_Data_Register[bx+1] 
            cmp ax,000fh
            JA losepoint3shladdressplayer2  ; out of index of data segment -> should be error 
            jmp contaddressmodeshl22 
            losepoint3shladdressplayer2:
            jmp far ptr losepointshladdressplayer2 
            
            contaddressmodeshl22:
           ; check if value or cl is valid 
            ; call lotfy code to get second operand 
            mov bl,dest_index_reg
            mov bh,0
            cmp bl,16                        ; index to value
            jz checkforbiddendigitaddressshl22 
            jnz checkforbiddenregsiteraddressshl22
            checkforbiddendigitaddressshl22:
                ; macro needed to check if value has a forbidden digit or not
                mov bh,0
                mov bl,dest_index_val
                mov ah,Player1_Data_Register[bx]
                mov Player2_Data_Register[bx],ah
 
                ; call macro that check if value in ax is correct
                check_byte_valid ah, Forbidden_digits_2 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1
                jz  forbiddenaddressshlplayer2
                jmp finaladdressmodeshl2
                forbiddenaddressshlplayer2:
                jmp far ptr endshladdressplayer2  
            
            checkforbiddenregsiteraddressshl22:        
                
                cmp bl,7
                jnz losepointnotaddressclp2
                check_forbidden Forbidden_Registers_2,bl                 
                mov al,losepoint 
                mov losepoint_player2,al  
                cmp losepoint_player2,1
                ;jz  lose_point_player1   
                jz tempendshladdressplayer2   ; -> jump far here
                jmp  finaladdressmodeshl2
                tempendshladdressplayer2:
                jmp far ptr endshladdressplayer2
                jmp finaladdressmodeshl2
                 losepointnotaddressclp2:
                 jmp far ptr losepointshladdressplayer2
            finaladdressmodeshl2:
                    mov bh,0
                    mov bl,src_index_val
                    mov ch,Player1_Data_Register[bx]
                    mov cl,Player1_Data_Register[bx+1]
                    mov si,cx 
                    mov bl, dest_index_val  
                    mov cl, Player1_Data_Register[bx]
                    mov ch,0            
                    
                    cmp player_turn2,1              ;-> player1 turn 
                    jz player22shladdressbyteturn
                    jmp player22shladdressbytenoturn 
                    player22shladdressbyteturn:       
                            cmp instruction_index,10
                            jz shladdressbyteplayer22
                            cmp instruction_index,9
                            jz shraddressbyteplayer22
                            cmp instruction_index,11
                            jz roraddressbyteplayer22 
                            cmp instruction_index,12
                            jz roladdressbyteplayer22
                            cmp instruction_index,8
                            jz saladdressbyteplayer22
                            cmp instruction_index,13
                            jz saraddressbyteplayer22
                            shladdressbyteplayer22:                  ; div ------------------------
                                shl data_segment_1[si],cl
                                jmp far ptr player22shladdressbytenoturn
                            shraddressbyteplayer22:                  ; mul ------------------------
                                shr data_segment_1[si],cl
                                jmp far ptr player22shladdressbytenoturn
                            roraddressbyteplayer22:                  ; idiv ------------------------
                                ror data_segment_1[si],cl
                                jmp far ptr player22shladdressbytenoturn 
                            roladdressbyteplayer22:                  ; imul ------------------------
                                rol data_segment_1[si],cl
                                jmp far ptr player22shladdressbytenoturn
                            saladdressbyteplayer22:                  ; inc ------------------------
                                sal data_segment_1[si],cl
                                jmp far ptr player22shladdressbytenoturn
                            saraddressbyteplayer22:                  ; dec ------------------------
                                sar data_segment_1[si],cl
                                jmp far ptr player22shladdressbytenoturn  
                    player22shladdressbytenoturn:
                        cmp player_turn1,1
                        jz player11shladdressbyteturn
                        jmp far ptr endshladdressplayer2
                        player11shladdressbyteturn:     
                            
                            mov bl,src_index_val
                            mov ch,Player2_Data_Register[bx]
                            mov cl,Player2_Data_Register[bx+1]
                            mov si,cx 
                            mov bl, dest_index_val  
                            mov cl, Player2_Data_Register[bx]
                            mov ch,0                            
                            cmp instruction_index,10
                            jz shladdressbyteplayer11
                            cmp instruction_index,9
                            jz shraddressbyteplayer11
                            cmp instruction_index,11
                            jz roraddressbyteplayer11 
                            cmp instruction_index,12
                            jz roladdressbyteplayer11
                            cmp instruction_index,8
                            jz saladdressbyteplayer11
                            cmp instruction_index,13
                            jz saraddressbyteplayer11
                            shladdressbyteplayer11:                  ; div ------------------------
                                shl data_segment_2[si],cl
                                jmp far ptr endshladdressplayer2
                            shraddressbyteplayer11:                  ; mul ------------------------
                                shr data_segment_2[si],cl
                                jmp far ptr endshladdressplayer2
                            roraddressbyteplayer11:                  ; idiv ------------------------
                                ror data_segment_2[si],cl
                                jmp far ptr endshladdressplayer2 
                            roladdressbyteplayer11:                  ; imul ------------------------
                                rol data_segment_2[si],cl
                                jmp far ptr endshladdressplayer2
                            saladdressbyteplayer11:                  ; inc ------------------------
                                sal data_segment_2[si],cl
                                jmp far ptr endshladdressplayer2
                            saraddressbyteplayer11:                  ; dec ------------------------
                                sar data_segment_2[si],cl
                                jmp far ptr endshladdressplayer2  

            
              
    losepointshladdressplayer2:
        dec intial_points_player2
        mov losepoint_player2,0 
        mov losepoint,0
    
    endshladdressplayer2:
    
    ret
    shlshrrorroladdressplayer2 endp 

change_src_dest proc near      
    mov al, src_index_reg
    mov bl, dest_index_reg
    mov src_index_reg,bl
    mov dest_index_reg,al 
    
    mov al, src_index_val
    mov bl, dest_index_val
    mov src_index_val,bl
    mov dest_index_val,al  
    ret
    change_src_dest endp     
    Reach_target_player2 proc near
    
    mov ax, target
    mov si,0
    mov di,8
    mov dx,0
    loop_on_registers_2:
        
        mov ch,Player2_Data_Register[si]
        mov cl,Player2_Data_Register[si+1]
        cmp ax,cx   ; compare target and each register of player2 so that to check if player 1 wins or not
        jz reached_win_player1  
        jmp not_reached_player1
        reached_win_player1:
        mov dx,1
        mov di,1
        not_reached_player1:
        add si,2
        dec di 
        
    jnz loop_on_registers_2
    
    cmp dx,1
    ; jz                  ; player1 wins 
    ; jnz                 ; player1 doesnt win yet
    ; set variable win_player1 to 1 or 0
    jz player1_wins
    jmp continue_playing_player2 
    player1_wins:
        mov win_player1,dl
    continue_playing_player2:
    
    ret
    Reach_target_player2 endp

Reach_target_player1 proc near
    
    mov ax, target
    mov si,0
    mov di,8
    mov dx,0
    loop_on_registers_1:
        
        mov ch,Player1_Data_Register[si]
        mov cl,Player1_Data_Register[si+1]
        cmp ax,cx   ; compare target and each register of player2 so that to check if player 1 wins or not
        jz reached_win_player2  
        jmp not_reached_player2
        reached_win_player2:
        mov dx,1
        mov di,1
        not_reached_player2:
        add si,2
        dec di 
        
    jnz loop_on_registers_1
    
    cmp dx,1
    ; jz                  ; player1 wins 
    ; jnz                 ; player1 doesnt win yet
    ; set variable win_player1 to 1 or 0
    jz player2_wins
    jmp continue_playing_player1 
    player2_wins:
        mov win_player2,dl
    continue_playing_player1:
    
    ret
    Reach_target_player1 endp

zero_points_player1 proc near
    
    cmp intial_points_player1,0
    jz player1_lose_zeropoints
    jmp player1_not_lose_zeropoints
    player1_lose_zeropoints:
        mov win_player2,1
    player1_not_lose_zeropoints: 
    ret
    zero_points_player1 endp 

zero_points_player2 proc near
    
    cmp intial_points_player2,0
    jz player2_lose_zeropoints
    jmp player2_not_lose_zeropoints
    player2_lose_zeropoints:
        mov win_player1,1
    player2_not_lose_zeropoints: 
    ret
    zero_points_player2 endp
power5_player1 proc near                                             
    cmp power5_player1_used,1
    jz power5_used_by_player1
    ; check if intial points are greater than 30 so that can use power 
    cmp intial_points_player1,30
    jb not_enough_points_5_player1    
    mov cx,8
    mov si,0
    mov power5_player1_used ,1 
    sub intial_points_player1,30
    clear_registers_player1:
        mov Player1_Data_Register[si],0
                mov Player1_Data_Register[si+1],0

        add si,2  
        dec cx
    jnz clear_registers_player1
    ; cannot be executed -----------------------------
    not_enough_points_5_player1:
     
    power5_used_by_player1:
    ret
    power5_player1 endp
power5_player2 proc near                                             
    
    cmp power5_player2_used,1
    jz power5_used_by_player2
    ; check if intial points are greater than 30 so that can use power 
    cmp intial_points_player2,30
    jb not_enough_points_5_player2    
    mov cx,8
    mov si,0
    mov power5_player2_used ,1 
    sub intial_points_player2,30
    clear_registers_player2:
        mov Player2_Data_Register[si],0
        mov Player2_Data_Register[si+1],0
        add si,2  
        dec cx
    jnz clear_registers_player2
    
    ; cannot be executed -----------------------------
    not_enough_points_5_player2:
     
    power5_used_by_player2:
    ret
    power5_player2 endp

;----------------------------shl  reg ---------------------------------------------------
power6_p1 proc near
    
    mov al,is_changed_p1
    mov is_changed ,al
    mov det_p6,1
    call power6_both
    mov is_changed_p1,1


    ret 
    power6_p1 endp  
power6_p2 proc near
    
    mov al,is_changed_p2
    mov is_changed ,al
    mov det_p6,2
    call power6_both
    mov is_changed_p2,2
    
    
    
    ret 
    power6_p2 endp

power6_both proc near
     
    ;mov al,is_changed_p1
    ;mov is_changed ,al
    
    cmp is_changed ,1
    jz used_power6_p1
    jmp far ptr check_p2
    used_power6_p1:
    jmp far ptr end_power6
    check_p2:
    cmp is_changed ,2
    jz used_power6_p2
    jmp far ptr not_used_power6
    used_power6_p2:
    jmp far ptr end_power6
    
    not_used_power6:
    
    ; ------------ loop on all registers of player1 16 byte  ------------------
    
    
    mov cx,8
    mov si,0
    mov dx,changed_target
    p1_targetE:
               
               cmp Player1_Data_Register[si],dh
               jz  other_byte_p1
               jmp not_equal_p1
               other_byte_p1: 
               cmp Player1_Data_Register[si+1],dl
               jz end_power6
               not_equal_p1:
               add si,2
               dec cx
               jnz p1_targetE
    
        
    ; ------------ loop on all registers of player2 ------------------
    mov cx,8
    mov si,0
    p2_targetE:
               cmp Player2_Data_Register[si],dh
               jz  other_byte_p2
               jmp not_equal_p2
               other_byte_p2: 
               cmp Player2_Data_Register[si+1],dl
               jz end_power6
               not_equal_p2:
               add si,2
               dec cx
               jnz p2_targetE          
     
     jmp can_change 
     
     can_change:
     mov target,dx
     cmp det_p6,1
     jz dec_p1_30
     jmp not_dec_p1_30 
     dec_p1_30:
     sub intial_points_player1,30

     not_dec_p1_30:
     cmp det_p6,2
     jz dec_p2_30
     jmp not_dec_p2_30 
     dec_p2_30:
     sub intial_points_player2,30
     not_dec_p2_30:
     end_power6:     
     
     ret
     power6_both endp


     
     set_zero_forbidden_player1 proc near  
    
     mov cx,12
     mov si,0
     loop_set_zero_player1_reg:
     
     mov Forbidden_Registers_2[si],0
         inc si
         dec cx
     jnz  loop_set_zero_player1_reg
     mov cx,16
     mov si,0
     loop_set_zero_player1_digits:    
         mov Forbidden_digits_2[si],0
         inc si
         dec cx
     jnz  loop_set_zero_player1_digits
     mov cx,16
     mov si,0    
     loop_set_zero_player1_instructions:
         mov Forbidden_instruction_2[si],0
         inc si
         dec cx 
     jnz  loop_set_zero_player1_instructions    
    
     ret
     set_zero_forbidden_player1 endp
set_zero_forbidden_player2 proc near  
    
     mov cx,12
     mov si,0
     loop_set_zero_player2_reg:
     
     mov Forbidden_Registers_1[si],0
         inc si
         dec cx
     jnz  loop_set_zero_player2_reg
     mov cx,16
     mov si,0
     loop_set_zero_player2_digits:    
         mov Forbidden_digits_1[si],0
         inc si
         dec cx
     jnz  loop_set_zero_player2_digits
     mov cx,16
     mov si,0    
     loop_set_zero_player2_instructions:
         mov Forbidden_instruction_1[si],0
         inc si
         dec cx 
     jnz  loop_set_zero_player2_instructions    
    
     ret
     set_zero_forbidden_player2 endp

    set_forbidden_player1 proc near
;--------------------------- assume we have it Read it Later in Forbidden_Char2-----------------------------------------;     
    
    ; loop on 17 instruction to set 
;------instructoins,Forbidden_instruction,Forbidden_char2,17,------------------------------- 
    mov si,0
    mov dl,0 
    loop_set_instruction: 
        lea cx ,instructions[si]
        set_forbidden cx,Forbidden_instruction_2,Forbidden_char2,4,dl
        inc dl
        add si,4              
        cmp si,56
        jnz loop_set_instruction  
        
        ;lea cx ,instructions[24] 
        ;set_forbidden cx ,Forbidden_instruction_2,Forbidden_char2,3,6 
        
        mov si,56
        mov dl,14
    loop_set_instruction2: 
        lea cx ,instructions[si]
        set_forbidden cx,Forbidden_instruction_2,Forbidden_char2,5,dl
        inc dl
        add si,5              
        cmp si,66
        jnz loop_set_instruction2     
           
;------------- loop on numbers ----------------------------------------------      
    mov si,0
    mov dl,0 
    loop_set_numbers: 
        lea cx ,digits[si]
        set_forbidden cx,Forbidden_digits_2,Forbidden_char2,2,dl
        inc dl
        add si,2              
        cmp si,32
        jnz loop_set_numbers  
                                                                         
                                                                            
;------------- loop on regsiter 16------------------------------------------    

    mov si,0
    mov dl,0 
    loop_set_registers: 
        lea cx ,registers[si]
        set_forbidden cx,Forbidden_Registers_2,Forbidden_char2,3,dl
        inc dl
        add si,3              
        cmp si,48
        jnz loop_set_registers         
    ret
    set_forbidden_player1 endp

set_forbidden_player2 proc near   ; player2 setforbidden for player1
;--------------------------- assume we have it Read it Later in Forbidden_Char2-----------------------------------------;     
    
    ; loop on 17 instruction to set 
;------instructoins,Forbidden_instruction,Forbidden_char2,17,------------------------------- 
    mov si,0
    mov dl,0 
    loop_set2_instruction: 
        lea cx ,instructions[si]
        set_forbidden cx,Forbidden_instruction_1,Forbidden_char1,4,dl
        inc dl
        add si,4              
        cmp si,56
        jnz loop_set2_instruction  
        
        lea cx ,instructions[24] 
        set_forbidden cx ,Forbidden_instruction_1,Forbidden_char1,3,6 
        
        mov si,56
        mov dl,14
    loop_set2_instruction2: 
        lea cx ,instructions[si]
        set_forbidden cx,Forbidden_instruction_1,Forbidden_char1,5,dl
        inc dl
        add si,5              
        cmp si,66
        jnz loop_set2_instruction2     
           
;------------- loop on numbers ----------------------------------------------      
    mov si,0
    mov dl,0 
    loop_set2_numbers: 
        lea cx ,digits[si]
        set_forbidden cx,Forbidden_digits_1,Forbidden_char1,2,dl
        inc dl
        add si,2              
        cmp si,32
        jnz loop_set2_numbers  
                                                                         
                                                                            
;------------- loop on regsiter 16------------------------------------------    

    mov si,0
    mov dl,0 
    loop_set2_registers: 
        lea cx ,registers[si]
        set_forbidden cx,Forbidden_Registers_1,Forbidden_char1,3,dl
        inc dl
        add si,3              
        cmp si,48
        jnz loop_set2_registers         
    ret
    set_forbidden_player2 endp




instOrPowUpofT2 proc near
    cmp sent_instruct_type,0
    jne notInstructionOfPlayer2
    mov power_up_player2,0
    Call chooseInstructions
    
    
    notInstructionOfPlayer2:
    cmp sent_instruct_type,1
    jne notPower1Ofplayer2
    call editedpowerUp1forPlayer2
    
    
    notPower1Ofplayer2:
    cmp sent_instruct_type,2
    jne notPower2Ofplayer2
    call editedpowerUp2forPlayer2



    notPower2Ofplayer2:
    cmp sent_instruct_type,3
    jne notPower3Ofplayer2
    call editedpowerUp3forPlayer2


     notPower3Ofplayer2:
    ; cmp sent_instruct_type,4
    ; jne notPower4Ofplayer2:
    ; ;[TODO]call editedpowerUp4forPlayer2
    
    
    ;notPower4Ofplayer2:
    cmp sent_instruct_type,5
    jne notPower5Ofplayer2
    call editedpowerUp5forPlayer2
    
    
    notPower5Ofplayer2:
    cmp sent_instruct_type,6
    jne notPower6Ofplayer2
    call editedpowerUp6forPlayer2
    
    
    notPower6Ofplayer2:
    cmp sent_instruct_type,7
    jne notChat
    ;[TODO]call inlineChat
    
    
    notChat:
    cmp sent_instruct_type,8
    jne player1didnotwin
    ;[TODO]call player1won
    
    
    player1didnotwin:
    cmp sent_instruct_type,9
    jne player2didnotwin
    ;[TODO]call player2won
    player2didnotwin:
    ret
instOrPowUpofT2 endp




chooseInstructions proc near
    cmp instucti0n_type,0
    jne notMOVofplayer2
    CALL MOVPLAYER2PR

    notMOVofplayer2:
    cmp instucti0n_type,1
    jne notADDofPlayer2
    CALL ADDPLAYER2PR


    notADDofplayer2:
    cmp instucti0n_type,2
    jne notSUBofPlayer2
    CALL SUBPLAYER2PR
    

    notSUBofplayer2:
    cmp instucti0n_type,3
    jne notMULofPlayer2
    CALL MULPLAYER2PR

    notMULofplayer2:
    cmp instucti0n_type,4
    jne notDIVofPlayer2
    CALL DIVPLAYER2PR


    notDIVofplayer2:
    cmp instucti0n_type,5
    jne notINCofPlayer2
    CALL INCPLAYER2PR


    notINCofplayer2:
    cmp instucti0n_type,6
    jne notDECofPlayer2
    CALL DECPLAYER2PR

    notDECofplayer2:
    cmp instucti0n_type,7
    jne notNOPofPlayer2


    notNOPofplayer2:
    cmp instucti0n_type,8
    jne notSALofPlayer2
    CALL SALPLAYER2PR


    notSALofplayer2:
    cmp instucti0n_type,9
    jne notSHRofPlayer2
    CALL SHRPLAYER2PR



    notSHRofplayer2:
    cmp instucti0n_type,10
    jne notSHLofPlayer2
    CALL SHLPLAYER2PR
    
    
    notSHLofplayer2:
    cmp instucti0n_type,11
    jne notRORofPlayer2
    CALL RORPLAYER2PR
    
    notRORofplayer2:
    cmp instucti0n_type,12
    jne notROLofPlayer2
    CALL ROLPLAYER2PR
    
    
    notROLofplayer2:
    cmp instucti0n_type,13
    jne notSARofPlayer2
    CALL SARPLAYER2PR


    notSARofplayer2:
    cmp instucti0n_type,14
    jne notIDIVofPlayer2
    CALL IDIVPLAYER2PR
    
    
    notIDIVofplayer2:
    cmp instucti0n_type,15 
    JNE FINISHOFCHOOSING
    CALL IMULPLAYER2PR
    FINISHOFCHOOSING:

    ret
chooseInstructions endp


editedpowerUp1forPlayer2 proc near
    CALL CLEAR_SCREEN
    mov power_up_player2,1
    CALL chooseInstructions
    ret
editedpowerUp1forPlayer2 endp


editedpowerUp2forPlayer2 PROC NEAR  
    CALL CLEAR_SCREEN 
    mov power_up_player2,2
    call chooseInstructions
 
    RET 
editedpowerUp2forPlayer2 ENDP 


editedpowerUp3forPlayer2 proc near  
    cmp intial_points_player2,8
    jb NOTALLOWED
    CMP power3_player2_used,1
    JZ NOTALLOWED
    JNZ RESUME12
    NOTALLOWED: JMP finishEditedpowerUp3forplayer2
    RESUME12: sub intial_points_player2,8
    MOV power3_player2_used,1
    CALL set_zero_forbidden_player2
    CALL set_forbidden_player2
    finishEditedpowerUp3forplayer2: 
    ret
editedpowerUp3forPlayer2 endp
editedpowerUp5forPlayer2 proc near
    cmp intial_points_player2,30
    jb NOTALLowedPowerUp5Player2
    ;sub intial_points_player2,30
    mov power5_player2_used,0
    call power5_player2 
    NOTALLowedPowerUp5Player2:  
    ret
editedpowerUp5forPlayer2 endp

editedpowerUp6forPlayer2 proc near
    CALL power6_p2
    ret
editedpowerUp6forPlayer2 endp
