;----------------------------------------------------------------
; Title initialization function
;----------------------------------------------------------------
TitleInit:
	LDA buttonsP1
	PHA
	LDA buttonsP1Old
	PHA
	LDA buttonsP2
	PHA
	LDA buttonsP2Old
	PHA
	
	JSR ClearMemory
	
	LDA #$01 ;load title
	STA gameState
	STA gameStateOld
	
	LDA #$A0 ;set chr0 bank
	STA pointerHi
	LDA #%00000000
	STA value
	JSR MMC1WriteRegister
	
	LDA #$C0 ;set chr1 bank
	STA pointerHi
	LDA #%00000001
	STA value
	JSR MMC1WriteRegister
	
	
	
	LDA $FFF0
	;Load nametable 1 ($2000)
	LDA #<(nametableTitle)
	STA pointerLow
	LDA #>(nametableTitle)
	STA pointerHi
	LDA #$00
	STA addressLow
	LDA #$20
	STA addressHi
	LDA #$FF
	STA lengthLow
	LDA #$03
	STA lengthHi
	JSR WriteToPPU
	LDA $FFF1
	;Load attributetable 1 ($23C0)
	LDA #<(attributetableTitle)
	STA pointerLow
	LDA #>(attributetableTitle)
	STA pointerHi
	LDA #$C0
	STA addressLow
	LDA #$23
	STA addressHi
	LDA #$3F
	STA lengthLow
	LDA #$00
	STA lengthHi
	JSR WriteToPPU
	
	LDA #$01
	STA titleBGColorsFlagsCurrent
	STA titleAttrValuesFlagsPeriod
	STA titleAttrValuesFlagsCurrent
	
	PLA
	STA buttonsP2Old	
	PLA
	STA buttonsP2
	PLA
	STA buttonsP1Old
	PLA
	STA buttonsP1
	
	;Load sprites tank right
	LDA #$02 ;type
	STA spriteType
	LDA #$60 ;x
	STA spriteX
	LDA #$60 ;y
	STA spriteY
	LDA #$04 ;anim
	STA spriteStateAnim
	LDA #$00 ;action
	STA spriteStateAction
	LDA #$00 ;timer
	STA spriteTimerAnim
	STA spriteTimerAction
	JSR SpritesAdd
	;Load sprites gun
	LDA #$04 ;type
	STA spriteType
	LDA #$77 ;x
	STA spriteX
	LDA #$64 ;y
	STA spriteY
	LDA #$00 ;anim
	STA spriteStateAnim
	LDA #$01 ;action
	STA spriteStateAction
	LDA #$00 ;timer
	STA spriteTimerAnim
	STA spriteTimerAction
	JSR SpritesAdd
	;Load sprites tank left
	LDA #$02 ;type
	STA spriteType
	LDA #$90 ;x
	STA spriteX
	LDA #$60 ;y
	STA spriteY
	LDA #$01 ;anim
	STA spriteStateAnim
	LDA #$00 ;action
	STA spriteStateAction
	LDA #$00 ;timer
	STA spriteTimerAnim
	STA spriteTimerAction
	JSR SpritesAdd
	
	LDA #$01
	STA ppuEnableFlag
	LDA #%10010000 ;enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
	STA $2000
	
	RTS

LoadTitleSprites:
	LDX titleBGColorsFlagsCurrent
	;Load sprites tank right
	LDA TitleSprite1Type, X ;type
	STA spriteType
	LDA TitleSprite1X, X ;x
	STA spriteX
	LDA TitleSprite1Y, X ;y
	STA spriteY
	LDA TitleSprite1Anim, X ;anim
	STA spriteStateAnim
	LDA TitleSprite1Action, X ;action
	STA spriteStateAction
	LDA #$00 ;timer
	STA spriteTimerAnim
	STA spriteTimerAction
	JSR SpritesAdd
	LDX titleBGColorsFlagsCurrent
	;Load sprites gun
	LDA TitleSprite2Type, X ;type
	STA spriteType
	LDA TitleSprite2X, X ;x
	STA spriteX
	LDA TitleSprite2Y, X ;y
	STA spriteY
	LDA TitleSprite2Anim, X ;anim
	STA spriteStateAnim
	LDA TitleSprite2Action, X ;action
	STA spriteStateAction
	LDA #$00 ;timer
	STA spriteTimerAnim
	STA spriteTimerAction
	JSR SpritesAdd
	LDX titleBGColorsFlagsCurrent
	;Load sprites tank left
	LDA TitleSprite3Type, X ;type
	STA spriteType
	LDA TitleSprite3X, X ;x
	STA spriteX
	LDA TitleSprite3Y, X ;y
	STA spriteY
	LDA TitleSprite3Anim, X ;anim
	STA spriteStateAnim
	LDA TitleSprite3Action, X ;action
	STA spriteStateAction
	LDA #$00 ;timer
	STA spriteTimerAnim
	STA spriteTimerAction
	JSR SpritesAdd
	RTS
;----------------------------------------------------------------
; Adding sprite to the sprite manager function
;----------------------------------------------------------------
SpritesAdd:
	LDX spritesLength
	CPX #$40
	BEQ +
		LDA spriteType
		STA spritesType, X
	
		LDA spriteX
		STA spritesX, X
	
		LDA spriteY
		STA spritesY, X
	
		LDA spriteStateAnim
		STA spritesStateAnim, X
	
		LDA spriteStateAction
		STA spritesStateAction, X
	
		LDA spriteTimerAnim
		STA spritesTimerAnim, X
	
		LDA spriteTimerAction
		STA spritesTimerAction, X
	
		INC spritesLength
	+
	
	RTS
;----------------------------------------------------------------
; Remove sprite from special index
;----------------------------------------------------------------
SpritesRemove:
	LDA spritesLength
	CMP #$00
	BEQ +
		INC index
		LDA spritesLength
		CMP index
		BMI ++
			LDX index
			DEX
			LDY index
			CPY spritesLength
			BNE +++
				JMP ClearRemainingSpritesInManager
				+++
				-	
				LDA spritesType, Y
				STA spritesType, X
				
				LDA spritesX, Y
				STA spritesX, X
				
				LDA spritesY, Y
				STA spritesY, X
				
				LDA spritesTimerAnim, Y
				STA spritesTimerAnim, X
				
				LDA spritesTimerAction, Y
				STA spritesTimerAction, X
				
				LDA spritesStateAnim, Y
				STA spritesStateAnim, X
				
				LDA spritesStateAction, Y
				STA spritesStateAction, X
				
				INX
				INY
				CPY spritesLength
			BNE -
			ClearRemainingSpritesInManager:
			LDA #$00
			STA spritesType, X
			STA spritesX, X
			STA spritesY, X
			STA spritesTimerAnim, X
			STA spritesTimerAction, X
			STA spritesStateAnim, X
			STA spritesStateAction, X
			
			DEC spritesLength
			++			
	+
	
	RTS

;----------------------------------------------------------------
; Draw all sprites into $200
;----------------------------------------------------------------
SpritesDraw:
	LDA #$00
	STA addressLow
	LDA #$02
	STA addressHi
	
	LDA spritesLength
	CMP #$00
	BNE +
		LDA #$FE
		LDY #$00
		JMP ClearRemainingSpritesFromZero
		+
	LDX #$00
		-
			LDA #$00
			STA counter
			--			
			;change y			
			LDY spritesType, X
			LDA SpriteTypesMoveTilesYLowLow, Y
			STA pointerLow
			LDA SpriteTypesMoveTilesYLowHi, Y
			STA pointerHi
			LDA SpriteTypesMoveTilesYHiLow, Y
			STA pointer2Low
			LDA SpriteTypesMoveTilesYHiHi, Y
			STA pointer2Hi
			LDY spritesStateAction, X
			LDA (pointerLow), Y
			STA pointerLow
			LDA (pointer2Low), Y
			STA pointerHi
			LDY counter
			LDA (pointerLow), Y
			CLC
			ADC spritesY, X		
			LDY #$00
			STA (addressLow), Y
			INC addressLow
			
			;load tile index
			LDY spritesType, X
			LDA SpriteTypesAnimsTilesLowLow, Y
			STA pointerLow
			LDA SpriteTypesAnimsTilesLowHi, Y
			STA pointerHi
			LDA SpriteTypesAnimsTilesHiLow, Y
			STA pointer2Low
			LDA SpriteTypesAnimsTilesHiHi, Y
			STA pointer2Hi
			LDY spritesStateAnim, X
			LDA (pointerLow), Y
			STA pointerLow
			LDA (pointer2Low), Y
			STA pointerHi
			LDY counter
			LDA (pointerLow), Y
			LDY #$00
			STA (addressLow), Y
			INC addressLow
			
			;load tile attributes
			LDY spritesType, X
			LDA SpriteTypesAnimsAttrLowLow, Y
			STA pointerLow
			LDA SpriteTypesAnimsAttrLowHi, Y
			STA pointerHi
			LDA SpriteTypesAnimsAttrHiLow, Y
			STA pointer2Low
			LDA SpriteTypesAnimsAttrHiHi, Y
			STA pointer2Hi
			LDY spritesStateAnim, X
			LDA (pointerLow), Y
			STA pointerLow
			LDA (pointer2Low), Y
			STA pointerHi
			LDY counter
			LDA (pointerLow), Y
			LDY #$00
			STA (addressLow), Y
			INC addressLow
			
			;load sprite x
			LDY spritesType, X
			LDA SpriteTypesMoveTilesXLowLow, Y
			STA pointerLow
			LDA SpriteTypesMoveTilesXLowHi, Y
			STA pointerHi
			LDA SpriteTypesMoveTilesXHiLow, Y
			STA pointer2Low
			LDA SpriteTypesMoveTilesXHiHi, Y
			STA pointer2Hi
			LDY spritesStateAction, X
			LDA (pointerLow), Y
			STA pointerLow
			LDA (pointer2Low), Y
			STA pointerHi
			LDY counter
			LDA (pointerLow), Y
			CLC
			ADC spritesX, X		
			LDY #$00
			STA (addressLow), Y
			INC addressLow
			
			LDY spritesType, X
			LDA SpriteTypesLengthTiles, Y
			INC counter
			CMP counter
		BEQ +
			JMP --
			+		
		INX
		CPX spritesLength
	BEQ +
		JMP -
		+
	
	LDA #$FE
	LDY #$00
	ClearRemainingSprites:
	LDX addressLow
	CPX #$00
	BEQ +
		ClearRemainingSpritesFromZero:
		STA (addressLow), Y
		INC addressLow
		
		STA (addressLow), Y
		INC addressLow
		
		STA (addressLow), Y
		INC addressLow
		
		STA (addressLow), Y
		INC addressLow
		
		JMP ClearRemainingSprites
		+
	
	RTS

;----------------------------------------------------------------
; Change x and y coordinates
;----------------------------------------------------------------
SpritesUpdateXY:
	LDA #$AAA7
	LDA spritesLength
	CMP #$00
	BEQ +
		LDX #$00
			-
			LDA #$00
			STA counter
				--
				;change x
				LDY spritesType, X
				LDA SpriteTypesMoveTilesXLowLow, Y
				STA pointerLow
				LDA SpriteTypesMoveTilesXLowHi, Y
				STA pointerHi
				LDA SpriteTypesMoveTilesXHiLow, Y
				STA pointer2Low
				LDA SpriteTypesMoveTilesXHiHi, Y
				STA pointer2Hi
				LDY spritesStateAction, X
				LDA (pointerLow), Y
				STA pointerLow
				LDA (pointer2Low), Y
				STA pointerHi
				LDY counter
				LDA (pointerLow), Y
				CLC
				ADC spritesX, X
				STA spritesX, X
				
				;change y
				LDY spritesType, X
				LDA SpriteTypesMoveTilesYLowLow, Y
				STA pointerLow
				LDA SpriteTypesMoveTilesYLowHi, Y
				STA pointerHi
				LDA SpriteTypesMoveTilesYHiLow, Y
				STA pointer2Low
				LDA SpriteTypesMoveTilesYHiHi, Y
				STA pointer2Hi
				LDY spritesStateAction, X
				LDA (pointerLow), Y
				STA pointerLow
				LDA (pointer2Low), Y
				STA pointerHi
				LDY counter
				LDA (pointerLow), Y
				CLC
				ADC spritesY, X
				STA spritesY, X
				
				LDY spritesType, X
				LDA SpriteTypesLengthTiles, Y
				INC counter
				CMP counter
			BNE --
			INX
			CPX spritesLength
		BNE -
		+
	
	RTS
	
;----------------------------------------------------------------
; Change actions index
;----------------------------------------------------------------
SpritesSetActions:
	LDA #$AAA9
	LDA spritesLength
	CMP #$00
	BEQ +
		LDX #$00
			-
			LDY spritesType, X
			LDA SpriteTypesMoveFunctionsLow, Y
			STA pointerLow
			LDA SpriteTypesMoveFunctionsHi, Y
			STA pointerHi
			JMP (pointerLow)
			SpritesUpdateActionsReturn:
			INX
			CPX spritesLength
		BNE -
		+
	
	RTS

;----------------------------------------------------------------
; Update action index and timer
;----------------------------------------------------------------
SpritesUpdateActions:
	LDA #$AAAF
	LDA spritesLength
	CMP #$00
	BEQ +
		LDX #$00
			-
			;compare timers
			LDY spritesType, X
			LDA SpriteTypesMoveTimesLow, Y
			STA pointerLow
			LDA SpriteTypesMoveTimesHi, Y
			STA pointerHi
			LDY spritesStateAction, X
			LDA (pointerLow), Y
			CMP spritesTimerAction, X
			BNE ++
				;check if anim time = 00
				CMP #$00
				BNE +++
					JMP ++
					+++

					;cycle anim state
					LDY spritesType, X
					LDA SpriteTypesMoveFramesLow, Y
					STA pointerLow
					LDA SpriteTypesMoveFramesHi, Y
					STA pointerHi
					LDY spritesStateAction, X
					LDA spritesStateAction, X
					CLC
					SEC
					SBC (pointerLow), Y
					STA spritesStateAction, X
					INC spritesStateAction, X
					
					;reset timer
					LDA #$00
					STA spritesTimerAction, X
				++
			INX
			CPX spritesLength
		BNE -
		+
	RTS

;----------------------------------------------------------------
; Increase all sprite timers by 1
;----------------------------------------------------------------
SpritesUpdateTimers:
	LDA spritesLength
	CMP #$00
	BEQ +
		LDX #$00
			-
			INC spritesTimerAnim, X
			INC spritesTimerAction, X
			INX
			CPX spritesLength
		BNE -
		+
	
	RTS

;----------------------------------------------------------------
; Update sprites tiles and attributes
;----------------------------------------------------------------
SpritesUpdateAnim:
	LDA spritesLength
	CMP #$00
	BEQ +
		LDX #$00
			-
			;compare timers
			LDY spritesType, X
			LDA SpriteTypesAnimsTimesLow, Y
			STA pointerLow
			LDA SpriteTypesAnimsTimesHi, Y
			STA pointerHi
			LDY spritesStateAnim, X
			LDA (pointerLow), Y
			CMP spritesTimerAnim, X
			BNE ++
				;check if anim time = 00
				CMP #$00
				BNE +++
					JMP ++
					+++
					;cycle anim state
					LDY spritesType, X
					LDA SpriteTypesAnimsFramesLow, Y
					STA pointerLow
					LDA SpriteTypesAnimsFramesHi, Y
					STA pointerHi
					LDY spritesStateAnim, X
					LDA spritesStateAnim, X
					CLC
					SEC
					SBC (pointerLow), Y
					STA spritesStateAnim, X
					INC spritesStateAnim, X
					
					;reset timer
					LDA #$00
					STA spritesTimerAnim, X
				++
			INX
			CPX spritesLength
		BNE -
		+

	RTS
;----------------------------------------------------------------
; Level1 initialization function
;----------------------------------------------------------------
Level1Init:
	LDA buttonsP1
	PHA
	LDA buttonsP1Old
	PHA
	LDA buttonsP2
	PHA
	LDA buttonsP2Old
	PHA
	
	JSR ClearMemory
	
	LDA #$02 ;load level1
	STA gameState
	STA gameStateOld
	
	LDA #$A0 ;set chr0 bank
	STA pointerHi
	LDA #%00000000
	STA value
	JSR MMC1WriteRegister
	
	LDA #$C0 ;set chr1 bank
	STA pointerHi
	LDA #%00000010
	STA value
	JSR MMC1WriteRegister
	
	
	
	;Load nametable 1 ($2000)
	LDA #<(nametableLevel1)
	STA pointerLow
	LDA #>(nametableLevel1)
	STA pointerHi
	LDA #$00
	STA addressLow
	LDA #$20
	STA addressHi
	LDA #$FF
	STA lengthLow
	LDA #$03
	STA lengthHi
	JSR WriteToPPU
	
	;Load attributetable 1 ($23C0)
	LDA #<(attributetableLevel1)
	STA pointerLow
	LDA #>(attributetableLevel1)
	STA pointerHi
	LDA #$C0
	STA addressLow
	LDA #$23
	STA addressHi
	LDA #$3F
	STA lengthLow
	LDA #$00
	STA lengthHi
	JSR WriteToPPU
	
	PLA
	STA buttonsP2Old	
	PLA
	STA buttonsP2
	PLA
	STA buttonsP1Old
	PLA
	STA buttonsP1
	
	LDA #$01
	STA ppuEnableFlag
	LDA #%10010000 ;enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
	STA $2000
	
	RTS

;----------------------------------------------------------------
; Info initialization function
;----------------------------------------------------------------
InfoInit:
	LDA buttonsP1
	PHA
	LDA buttonsP1Old
	PHA
	LDA buttonsP2
	PHA
	LDA buttonsP2Old
	PHA
	
	JSR ClearMemory
	
	LDA #$03 ;load Info
	STA gameState
	STA gameStateOld
	
	LDA #$A0 ;set chr0 bank
	STA pointerHi
	LDA #%00000000
	STA value
	JSR MMC1WriteRegister
	
	LDA #$C0 ;set chr1 bank
	STA pointerHi
	LDA #%00000001
	STA value
	JSR MMC1WriteRegister
	
	
	
	;Load nametable 1 ($2000)
	LDA #<(nametableInfo)
	STA pointerLow
	LDA #>(nametableInfo)
	STA pointerHi
	LDA #$00
	STA addressLow
	LDA #$20
	STA addressHi
	LDA #$FF
	STA lengthLow
	LDA #$03
	STA lengthHi
	JSR WriteToPPU
	
	;Load attributetable 1 ($23C0)
	LDA #<(attributetableInfo)
	STA pointerLow
	LDA #>(attributetableInfo)
	STA pointerHi
	LDA #$C0
	STA addressLow
	LDA #$23
	STA addressHi
	LDA #$3F
	STA lengthLow
	LDA #$00
	STA lengthHi
	JSR WriteToPPU
	
	PLA
	STA buttonsP2Old	
	PLA
	STA buttonsP2
	PLA
	STA buttonsP1Old
	PLA
	STA buttonsP1
	
	LDA #$01
	STA ppuEnableFlag
	LDA #%10010000 ;enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
	STA $2000
	
	RTS

;----------------------------------------------------------------
; Title function
;----------------------------------------------------------------
Title:
	LDA buttonsP1
	ORA buttonsP1Old
	AND Start
	CMP Start
	BNE +
		LDA buttonsP1
		AND Start
		STA buttonsTemp
		LDA buttonsP1Old
		AND Start
		CMP buttonsTemp
		BNE ++
			;button still pressed do nothing
			JMP +
			++
		BPL +++
			;button pressed first time
			LDA flagAttrTable
			CMP #$00
			BNE ++++
				LDA #$00
				STA ppuEnableFlag
				LDA #$02
				STA gameState
				JMP TitleEnd
				++++
			LDA #$00
			STA ppuEnableFlag
			LDA #$03
			STA gameState
			JMP TitleEnd	
			JMP +
			+++
		;button unpressed
		+
	
	LDA buttonsP1
	ORA buttonsP1Old
	AND Down
	CMP Down
	BNE +
		LDA buttonsP1
		AND Down
		STA buttonsTemp
		LDA buttonsP1Old
		AND Down
		CMP buttonsTemp
		BNE ++
			;button still pressed do nothing
			JMP +
			++
		BPL +++
			;button pressed first time
			INC flagAttrTable
			JMP +
			+++
		;button unpressed
		+
	LDA flagAttrTable
	CMP #$04
	BNE +
		LDA #$03
		STA flagAttrTable
		+
	LDA buttonsP1
	ORA buttonsP1Old
	AND Up
	CMP Up
	BNE +
		LDA buttonsP1
		AND Up
		STA buttonsTemp
		LDA buttonsP1Old
		AND Up
		CMP buttonsTemp
		BNE ++
			;button still pressed do nothing
			JMP +
			++
		BPL +++
			;button pressed first time
			DEC flagAttrTable
			JMP +
			+++
		;button unpressed
		+
	LDA flagAttrTable
	CMP #$FF
	BNE +
		LDA #$00
		STA flagAttrTable
		+
	
	LDA flagAttrTable
	CMP #$00
	BNE +
		JSR ChangeAttributeValues
		+
	LDA flagAttrTable
	CMP #$01
	BNE +
		LDA #$01 ;first string disabled
		STA titleAttrValuesFlagsPeriod
		STA titleAttrValuesFlagsCurrent
		LDA #$48
		STA timerTitleAttrChange
		JSR ChangeAttributeValues
		
		LDA #$00 ; second string enabled
		STA titleAttrValuesFlagsPeriod
		LDA #$02
		STA titleAttrValuesFlagsCurrent
		LDA #$20
		STA timerTitleAttrChange
		JSR ChangeAttributeValues
		
		LDA #$01
		STA titleAttrValuesFlagsPeriod
		LDA #$03
		STA titleAttrValuesFlagsCurrent
		LDA #$03
		STA flagAttrTable
		
		LDA #$01 ;move braces
		STA titleNtblValuesFlagsPeriod
		LDA #$01
		STA titleNtblValuesFlagsCurrent
		JSR ChangeNametableValues
		+
	LDA flagAttrTable
	CMP #$02
	BNE +
		LDA #$00 ;first string enabled
		STA titleAttrValuesFlagsPeriod
		STA titleAttrValuesFlagsCurrent
		LDA #$20
		STA timerTitleAttrChange
		JSR ChangeAttributeValues
		
		LDA #$01 ;second string disabled
		STA titleAttrValuesFlagsPeriod
		LDA #$03
		STA titleAttrValuesFlagsCurrent
		LDA #$48
		STA timerTitleAttrChange
		JSR ChangeAttributeValues
		
		LDA #$01
		STA titleAttrValuesFlagsPeriod
		STA titleAttrValuesFlagsCurrent
		LDA #$00
		STA flagAttrTable
		
		LDA #$00 ;move braces
		STA titleNtblValuesFlagsPeriod
		LDA #$00
		STA titleNtblValuesFlagsCurrent
		JSR ChangeNametableValues
		+
	LDA flagAttrTable
	CMP #$03
	BNE +
		JSR ChangeAttributeValues
		+
	
	;change sprites
	LDA timerTitleBGColorChangeHi
	CMP #$01
	BNE +
		LDA timerTitleBGColorChangeLow
		CMP #$A4
		BNE ++
			LDA #$00
			STA index
			JSR SpritesRemove
			LDA #$00
			STA index
			JSR SpritesRemove
			LDA #$00
			STA index
			JSR SpritesRemove
			++
		+
	
	JSR ChangeTitleColor
	;JSR SpritesSetActions
	JSR SpritesUpdateActions
	JSR SpritesUpdateAnim
	;JSR SpritesUpdateXY
	LDA #$CCCC
	JSR SpritesDraw
	
	LDA timerTitleBGColorChangeLow
	STA bit16Low
	LDA timerTitleBGColorChangeHi
	STA bit16Hi
	JSR Bit16Inc
	LDA bit16Low
	STA timerTitleBGColorChangeLow
	LDA bit16Hi
	STA timerTitleBGColorChangeHi

	INC timerTitleAttrChange
	
	JSR SpritesUpdateTimers
	
	TitleEnd:	
	RTS

;----------------------------------------------------------------
; Info function
;----------------------------------------------------------------
InfoRun:
	LDA #$AAAD
	LDA buttonsP1
	ORA buttonsP1Old
	AND Start
	CMP Start
	BNE +
		LDA buttonsP1
		AND Start
		STA buttonsTemp
		LDA buttonsP1Old
		AND Start
		CMP buttonsTemp
		BNE ++
			;button still pressed do nothing
			JMP +
			++
		BPL +++
			;button pressed first time
			LDA #$00
			STA ppuEnableFlag
			LDA #$01
			STA gameState
			JMP InfoRunEnd	
			JMP +
			+++
		;button unpressed
		+
	
	InfoRunEnd:
	RTS

;----------------------------------------------------------------
; Write data from selected address to selected address in PPU
;----------------------------------------------------------------
WriteToPPU:
	LDA $2002 	   ;read PPU status to reset the high/low latch
	LDA addressHi
	STA $2006 	   ;write the high byte of address
	LDA addressLow
	STA $2006 	   ;write the low byte of address
	LDX #$FF
	LDY #$FF
		-
		INX
			--
			INY
			LDA (pointerLow), Y	 ;load data from address (pointerLow + the value in y)
			STA $2007 			 ;write to PPU
			CPY lengthLow
		BNE --
		INC pointerHi
		CPX lengthHi 
	BNE -
	
	RTS

;----------------------------------------------------------------
; Change title colour function
;----------------------------------------------------------------
ChangeTitleColor:
	LDA timerTitleBGColorChangeHi
	CMP #$01
	BNE +
		LDA timerTitleBGColorChangeLow
		CMP #$A4
		BNE ++
			JSR LoadTitleSprites
			LDA #$00
			STA counter
			LDX titleBGColorsFlagsCurrent
			LDY TitleBGColorsFlags, X
				-
				LDA TitleBGColors, Y
				LDX palColorsLength
				STA palColors, X
			
				LDA TitleBGColorsAddrLow, Y
				LDX palColorsLength
				STA palAddrLow, X
			
				LDA TitleBGColorsAddrHi, Y
				LDX palColorsLength
				STA palAddrHi, X
			
				INC palColorsLength
				INY
				
				INC counter
				LDA counter
				CMP TitleBGColorsNum
			BNE -
			
			INC titleBGColorsFlagsCurrent
			LDA titleBGColorsFlagsCurrent
			CMP TitleBGColorsLength
			BNE +++
				LDA #$00
				STA titleBGColorsFlagsCurrent
				+++
			
			LDA TRUE
			STA palChangeFlag
			
			LDA #$00
			STA timerTitleBGColorChangeLow
			STA timerTitleBGColorChangeHi
			++
		+
	
	RTS

;----------------------------------------------------------------
; Change attribute values function
;----------------------------------------------------------------
ChangeAttributeValues:
	LDA timerTitleAttrChange
	LDX titleAttrValuesFlagsPeriod
	CPX #$00 ;different time for different colours
	BNE +
		CMP #$20
		JMP ++
		+
	CMP #$48
	++
	BNE +
		LDA #$00
		STA counter
		LDX titleAttrValuesFlagsCurrent
		LDY TitleAttrValuesFlags, X
			-
			LDA TitleAttrValues, Y
			LDX attrValuesLength
			STA attrValues, X
		
			LDA TitleAttrValuesAddrLow, Y
			LDX attrValuesLength
			STA attrAddrLow, X
		
			LDA TitleAttrValuesAddrHi, Y
			LDX attrValuesLength
			STA attrAddrHi, X
				
			INC attrValuesLength
			INY
			
			INC counter
			LDA counter
			CMP TitleAttrValuesNum
		BNE -
		
		INC titleAttrValuesFlagsCurrent
		INC titleAttrValuesFlagsPeriod
		LDA titleAttrValuesFlagsPeriod
		CMP TitleAttrValuesLength
		BNE +++
			CLC
			SEC
			LDA titleAttrValuesFlagsCurrent
			SBC titleAttrValuesFlagsPeriod
			STA titleAttrValuesFlagsCurrent
			LDA #$00
			STA titleAttrValuesFlagsPeriod
			+++
		
		LDA TRUE
		STA attrChangeFlag
		
		LDA #$00
		STA timerTitleAttrChange
		+
	
	RTS

;----------------------------------------------------------------
; Change nametable values function
;----------------------------------------------------------------
ChangeNametableValues:
	LDA #$00
	STA counter
	LDX titleNtblValuesFlagsCurrent
	LDY TitleNtblValuesFlags, X
		-
		LDA TitleNtblValues, Y
		LDX ntblValuesLength
		STA ntblValues, X
	
		LDA TitleNtblValuesAddrLow, Y
		LDX ntblValuesLength
		STA ntblAddrLow, X
	
		LDA TitleNtblValuesAddrHi, Y
		LDX ntblValuesLength
		STA ntblAddrHi, X
			
		INC ntblValuesLength
		INY
		
		INC counter
		LDA counter
		CMP TitleNtblValuesNum
	BNE -
	
	INC titleNtblValuesFlagsCurrent
	INC titleNtblValuesFlagsPeriod
	LDA titleNtblValuesFlagsPeriod
	CMP TitleNtblValuesLength
	BNE +
		CLC
		SEC
		LDA titleNtblValuesFlagsCurrent
		SBC titleNtblValuesFlagsPeriod
		STA titleNtblValuesFlagsCurrent
		LDA #$00
		STA titleNtblValuesFlagsPeriod
		+
	
	LDA TRUE
	STA ntblChangeFlag
	
	RTS

;----------------------------------------------------------------
; 16 bit inc, dec function
;----------------------------------------------------------------
Bit16Dec:
	CLC
	SEC
	LDA bit16Low
	SBC #$01
	STA bit16Low
	BCS ++++
	LDA bit16Hi
	SBC #$00
	STA bit16Hi
	++++
	RTS
	
Bit16Inc:
	CLC
	LDA bit16Low
	ADC #$01
	STA bit16Low
	LDA bit16Hi
	ADC #$00
	STA bit16Hi
	RTS
	
;----------------------------------------------------------------
; Controller reading function
;----------------------------------------------------------------
ReadController1:
	LDA #$01
	STA $4016
	LDA #$00
	STA $4016
	LDX #$08
		-
		LDA $4016
		LSR A		  ;bit0 -> Carry
		ROL buttonsP1 ;bit0 <- Carry
		DEX
		BNE -
	RTS

ReadController2:
	LDA #$01
	STA $4016
	LDA #$00
	STA $4016
	LDX #$08
		-
		LDA $4017
		LSR A		  ;bit0 -> Carry
		ROL buttonsP2 ;bit0 <- Carry
		DEX
		BNE -
	RTS
