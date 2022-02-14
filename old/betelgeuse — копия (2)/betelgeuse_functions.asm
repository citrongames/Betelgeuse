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
	
	LDA #$FF
	STA spritesDrawOffset2
	
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
	LDY spriteType ;health
	LDA SpritesTypesHealth, Y
	STA spriteHealth
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
	LDY spriteType ;health
	LDA SpritesTypesHealth, Y
	STA spriteHealth
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
	LDY spriteType ;health
	LDA SpritesTypesHealth, Y
	STA spriteHealth
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
	LDY spriteType ;health
	LDA SpritesTypesHealth, Y
	STA spriteHealth
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
	LDY spriteType ;health
	LDA SpritesTypesHealth, Y
	STA spriteHealth
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
	LDY spriteType ;health
	LDA SpritesTypesHealth, Y
	STA spriteHealth
	JSR SpritesAdd
	RTS
;----------------------------------------------------------------
; Adding sprite to the sprite manager function
;----------------------------------------------------------------
SpritesAdd:
	LDA spriteType
	CMP #$01 ;tripod
	BEQ +
		CMP #$02 ;tank
		BEQ +
			JMP ++
			+
			INC spawnAlready
				++
	LDY spritesLength
	CPY #$40
	BEQ +
		LDA spriteType
		STA spritesType, Y
	
		LDA spriteX
		STA spritesX, Y
	
		LDA spriteY
		STA spritesY, Y
	
		LDA spriteStateAnim
		STA spritesStateAnim, Y
	
		LDA spriteStateAction
		STA spritesStateAction, Y
	
		LDA spriteTimerAnim
		STA spritesTimerAnim, Y
	
		LDA spriteTimerAction
		STA spritesTimerAction, Y
		
		LDA #$00
		STA spritesTimerGlobal, Y
		
		LDA spriteHealth
		STA spritesHealth, Y

		INC spritesLength
	+
	
	RTS
;----------------------------------------------------------------
; Remove sprite from special index
;----------------------------------------------------------------
SpritesRemove:
	LDX index
	LDA spritesType, X
	CMP #$01 ;tripod
	BEQ +
		CMP #$02 ;tank
		BEQ +
			JMP ++
			+
			DEC spawnAlready
				++
	CMP #$03 ;heart
	BEQ +
		CMP #$0F ;trigun
		BEQ +
			JMP ++
			+
			DEC powerUpsOnLevel
				++
	CMP #$07 ;coin
	BEQ +
		JMP ++
		+
		DEC coinsOnLevel
			++

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
				
				LDA spritesTimerGlobal, Y
				STA spritesTimerGlobal, X
				
				LDA spritesHealth, Y
				STA spritesHealth, X

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
			STA spritesTimerGlobal, X
			STA spritesHealth, X
			
			DEC spritesLength
			++			
	+
	
	RTS

;----------------------------------------------------------------
; Draw all sprites into $200
;----------------------------------------------------------------
SpritesDraw:
	LDA spritesDrawDirection
	CMP #$00
	BEQ +
		JMP SpritesDrawOtherDirection
		+
	LDA spritesDrawOffset1
	STA addressLow
	LDA #$03
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
			;make first sprite always zero
			LDA addressLow
			CMP #$00 
			BNE +
				INC addressLow
				INC addressLow
				INC addressLow
				INC addressLow
				+
			
			;load sprite y	
			LDY spritesType, X
			LDA SpriteTypesYLow, Y
			STA pointerLow
			LDA SpriteTypesYHi, Y
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
			
			LDY spritesType, X
			CPY #$00 ;player type
			BNE +
				LDY playerHitTimer
				CPY #$00
				BEQ ++
					AND #$F0
					ORA PlayerInvincibilityPattern, Y
					++
				+
			LDY #$00
			STA (addressLow), Y
			INC addressLow
			
			;load sprite x
			LDY spritesType, X
			LDA SpriteTypesXLow, Y
			STA pointerLow
			LDA SpriteTypesXHi, Y
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
	CPX spritesDrawOffset1
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
	
	LDA spritesLength
	CMP #$00
	BEQ +
		LDA spritesDrawOffset1
		SEC
		SBC #$20
		STA spritesDrawOffset1
		CMP #$80
		BNE ++
			LDA #$00
			STA spritesDrawOffset1
			++
		+
	LDA #$01
	STA spritesDrawDirection
		
	LDA #$01
	STA colTimer
	
	;draw 0 sprite
	LDA #$00
	STA addressLow
	LDA #$03
	STA addressHi
	LDY #$00
	LDA #$CF ;y
	STA (addressLow), Y
	INY
	LDA #$FF
	STA (addressLow), Y
	LDA gameState
	CMP #$02
	BNE +
		LDA #$FD ;sprite
		STA (addressLow), Y
		+		
	INY
	LDA #$00 ;pal
	STA (addressLow), Y
	INY
	LDA #$00 ;x
	STA (addressLow), Y
	
	RTS
	
	SpritesDrawOtherDirection:
	
	LDA spritesDrawOffset2
	STA addressLow
	LDA #$02
	STA addressHi
	
	LDA spritesLength
	CMP #$00
	BNE +
		LDA #$FE
		LDY #$00
		JMP ClearRemainingSpritesFromZero2
		+
	LDX #$00
		-
			LDA #$00
			STA counter
			--
			;make first sprite always zero
			LDA addressLow
			CMP #$03 
			BNE +
				DEC addressLow
				DEC addressLow
				DEC addressLow
				DEC addressLow
				+
			
			;load sprite x
			LDY spritesType, X
			LDA SpriteTypesXLow, Y
			STA pointerLow
			LDA SpriteTypesXHi, Y
			STA pointerHi
			LDY counter
			LDA (pointerLow), Y
			CLC
			ADC spritesX, X	
			LDY #$00
			STA (addressLow), Y
			DEC addressLow
			
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
			LDY spritesType, X
			CPY #$00 ;player type
			BNE +
				LDY playerHitTimer
				CPY #$00
				BEQ ++
					AND #$F0
					ORA PlayerInvincibilityPattern, Y
					++
				+
			LDY #$00
			STA (addressLow), Y
			DEC addressLow
						
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
			DEC addressLow
			
			;change y		
			LDY spritesType, X
			LDA SpriteTypesYLow, Y
			STA pointerLow
			LDA SpriteTypesYHi, Y
			STA pointerHi
			LDY counter
			LDA (pointerLow), Y
			CLC
			ADC spritesY, X	
			LDY #$00
			STA (addressLow), Y
			DEC addressLow
			
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
	ClearRemainingSprites2:
	LDX addressLow
	CPX spritesDrawOffset2
	BEQ +
		ClearRemainingSpritesFromZero2:
		STA (addressLow), Y
		DEC addressLow
		
		STA (addressLow), Y
		DEC addressLow
		
		STA (addressLow), Y
		DEC addressLow
		
		STA (addressLow), Y
		DEC addressLow
		
		JMP ClearRemainingSprites2
		+
	
	LDA spritesLength
	CMP #$00
	BEQ +
		LDA spritesDrawOffset2
		CLC
		ADC #$20
		CMP #$7F
		STA spritesDrawOffset2
		BNE ++
			LDA #$FF
			STA spritesDrawOffset2
			++
		+
	LDA #$00
	STA spritesDrawDirection
		
	LDA #$01
	STA colTimer
	
	;draw 0 sprite
	LDA #$00
	STA addressLow
	LDA #$02
	STA addressHi
	LDY #$00
	LDA #$CF ;y
	STA (addressLow), Y
	INY
	LDA #$FF
	STA (addressLow), Y
	LDA gameState
	CMP #$02
	BNE +
		LDA #$FD ;sprite
		STA (addressLow), Y
		+		
	INY
	LDA #$00 ;pal
	STA (addressLow), Y
	INY
	LDA #$00 ;x
	STA (addressLow), Y

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
			CMP #$00
			BNE ++
				JMP SpritesUpdateActionsReturn1
				++
			JMP (pointerLow)
			SpritesUpdateActionsReturn1:
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
; Update sprites tiles, attributes, x, y
;----------------------------------------------------------------
SpritesUpdate:
	LDA spritesLength
	CMP #$00
	BNE +
		JMP SpritesUpdateEnd
		+
		LDX #$00
			SpritesUpdateCycle:
			INC spritesTimerGlobal, X
			;run action function
			LDY spritesType, X
			LDA SpriteTypesMoveFunctionsLow, Y
			STA pointerLow
			LDA SpriteTypesMoveFunctionsHi, Y
			STA pointerHi
			CMP #$00
			BNE +
				JMP SpritesUpdateReturn
				+
			STX currentIndex
			JMP (pointerLow)
			LDX currentIndex
			SpritesUpdateReturn:
			INC spritesTimerAction, X
			;compare action timers
			LDY spritesType, X
			LDA SpriteTypesMoveTimesLow, Y
			STA pointerLow
			LDA SpriteTypesMoveTimesHi, Y
			STA pointerHi
			LDY spritesStateAction, X
			LDA (pointerLow), Y
			CMP spritesTimerAction, X
			BEQ +
				JMP SpritesUpdateActionsNoTime
				+
				;check if action time = 00
				CMP #$00
				BNE +
					JMP SpritesUpdateActionsNoTime
					+					
					;cycle action state
					LDY spritesType, X
					LDA SpriteTypesMoveFramesLow, Y
					STA pointerLow
					LDA SpriteTypesMoveFramesHi, Y
					STA pointerHi
					LDY spritesStateAction, X
					LDA spritesStateAction, X
					SEC
					SBC (pointerLow), Y
					STA spritesStateAction, X
					INC spritesStateAction, X
					
					LDA spritesX, X
					STA spriteOldX
					LDA spritesY, X
					STA spriteOldY
					
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
					LDY #$00
					LDA (pointerLow), Y
					CLC
					ADC spritesX, X
					STA spriteNewX
					
					;run sprite col x function
					STX currentIndex
					LDY spritesType, X
					LDA SpriteTypesColXSpriteFunctionsLow, Y
					STA pointerLow
					LDA SpriteTypesColXSpriteFunctionsHi, Y
					STA pointerHi
					CMP #$00
					BNE +
						JMP SpritesColXReturn
						+
					JMP (pointerLow)
					SpritesColXReturn:				
					LDX currentIndex
					
					LDA spriteNewX
					STA spritesX, X
					
					LDA spritesX, X
					STA spriteOldX
					LDA spritesY, X
					STA spriteOldY
					
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
					LDY #$00
					LDA (pointerLow), Y
					CLC
					ADC spritesY, X
					STA spriteNewY
					
					;run sprite col y function
					STX currentIndex
					LDY spritesType, X
					LDA SpriteTypesColYSpriteFunctionsLow, Y
					STA pointerLow
					LDA SpriteTypesColYSpriteFunctionsHi, Y
					STA pointerHi
					CMP #$00
					BNE +
						JMP SpritesColYReturn
						+
					JMP (pointerLow)
					SpritesColYReturn:				
					LDX currentIndex
					
					LDA spriteNewY
					STA spritesY, X
					
					;reset timer
					LDA #$00
					STA spritesTimerAction, X
			SpritesUpdateActionsNoTime:
			INC spritesTimerAnim, X
			;compare anim timers
			LDY spritesType, X
			LDA SpriteTypesAnimsTimesLow, Y
			STA pointerLow
			LDA SpriteTypesAnimsTimesHi, Y
			STA pointerHi
			LDY spritesStateAnim, X
			LDA (pointerLow), Y
			CMP spritesTimerAnim, X
			BEQ +
				JMP SpritesUpdateAnimNoTime
				+
				;check if anim time = 00
				CMP #$00
				BNE +
					JMP SpritesUpdateAnimNoTime
					+
					;cycle anim state
					LDY spritesType, X
					LDA SpriteTypesAnimsFramesLow, Y
					STA pointerLow
					LDA SpriteTypesAnimsFramesHi, Y
					STA pointerHi
					LDY spritesStateAnim, X
					LDA spritesStateAnim, X
					SEC
					SBC (pointerLow), Y
					STA spritesStateAnim, X
					INC spritesStateAnim, X
					
					;reset timer
					LDA #$00
					STA spritesTimerAnim, X
			SpritesUpdateAnimNoTime:
			SpritesUpdateCycleEnd:
			INX
			SpritesUpdateCycleEndSkipINX:
			CPX spritesLength			
		BEQ +
			JMP SpritesUpdateCycle
			+
	RTS
			SpritesUpdateCycleEndDecX:
			DEX
			CPX spritesLength			
		BEQ +
			JMP SpritesUpdateCycle
			+
		SpritesUpdateEnd:
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
	AND Start
	PHA
	LDA buttonsP1Old
	PHA
	LDA buttonsP2
	PHA
	LDA buttonsP2Old
	PHA
	
	JSR ClearMemory
	
	LDA #$FF
	STA spritesDrawOffset2
	
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
	
	LDA #$10
	STA bulletsTime
	LDA #$32
	STA randomNum
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
	
	LDA #$10
	STA bulletsTime
		
	;Load sprites heart
	LDA #$03 ;type
	STA spriteType
	LDA #$10 ;x
	STA spriteX
	LDA #$D7 ;y
	STA spriteY
	LDA #$00 ;anim
	STA spriteStateAnim
	LDA #$00 ;action
	STA spriteStateAction
	LDA #$00 ;timer
	STA spriteTimerAnim
	STA spriteTimerAction
	LDY spriteType ;health
	LDA SpritesTypesHealth, Y
	STA spriteHealth
	JSR SpritesAdd
	;Load sprites coin
	LDA #$05 ;type
	STA spriteType
	LDA #$C1 ;x
	STA spriteX
	LDA #$D8 ;y
	STA spriteY
	LDA #$00 ;anim
	STA spriteStateAnim
	LDA #$00 ;action
	STA spriteStateAction
	LDA #$00 ;timer
	STA spriteTimerAnim
	STA spriteTimerAction
	JSR SpritesAdd
	
	;Load sprites player
	LDA #$00 ;type
	STA spriteType
	LDA #$80 ;x
	STA spriteX
	LDA #$30 ;y
	STA spriteY
	LDA #$0B ;anim
	STA spriteStateAnim
	LDA #$02 ;action
	STA spriteStateAction
	LDA #$00 ;timer
	STA spriteTimerAnim
	STA spriteTimerAction
	LDY spriteType ;health
	LDA SpritesTypesHealth, Y
	STA spriteHealth
	LDA #$FF
	STA healthHi
	STA healthLow
	JSR SpritesAdd
	
	;set scroll helper adresses
	LDA #$23
	STA sprite0NtblHi
	LDA #$40
	STA sprite0NtblLow
	
	LDX #$00
		-
		LDA #$E5		
		STA ntblValuesTemp, X
		LDA sprite0NtblHi
		STA ntblAddrHiTemp, X
		LDA NtblValuesBlockAddrLow, X
		STA ntblAddrLowTemp, X

		INX
		CPX #$02
	BNE -	
	LDA #$02
	STA ntblToAdd
	JSR ChangeNametableValuesManual	
	
	JSR UpdatePlayerHealth
	JSR UpdatePlayerCoins
	
	LDX #$00
	LDA #$BA
	STA ntblValuesTemp, X
	LDA sprite0NtblHi
	STA ntblAddrHiTemp, X
	LDA sprite0NtblLow
	STA ntblAddrLowTemp, X
	LDA #$01
	STA ntblToAdd	
	JSR ChangeNametableValuesManual	
	
	LDA #$20
	STA baseNametableAddrHi
	
	LDY roomNumber
	LDA Level1RoomsSpawnsNum, Y
	STA spawnNum
	LDY #$00
		--
		LDX roomNumber
		LDA Level1SpawnsXNameTableLow, X
		STA pointerLow
		LDA Level1SpawnsXNameTableHi, X
		STA pointerHi
		LDA (pointerLow), Y
		STA addressLow
		
		LDA Level1SpawnsYNameTableLow, X
		STA pointerLow
		LDA Level1SpawnsYNameTableHi, X
		STA pointerHi
		LDA (pointerLow), Y
		CLC
		ADC baseNametableAddrHi
		STA addressHi
		
		LDX #$00
			-		
			LDA SpawnNtblTile, X		
			STA ntblValuesTemp, X
			LDA addressHi
			STA ntblAddrHiTemp, X
			LDA addressLow
			CLC
			ADC SpawnNtblAddrAdd, X
			STA ntblAddrLowTemp, X
					
			INX
			CPX #$04
		BNE -	
		LDA #$04
		STA ntblToAdd
		TYA
		PHA
		JSR ChangeNametableValuesManual	
		PLA
		TAY
		INY
		CPY spawnNum
	BNE --
	
	;Load sprites boss up
	LDA #$0C ;type
	LDA #$7e ;x
	LDA #$4e ;y
	;Load sprites boss middle
	LDA #$0D ;type
	LDA #$76 ;x
	LDA #$66 ;y
	;Load sprites boss down
	LDA #$0E ;type
	LDA #$7e ;x
	LDA #$76 ;y
	
	JSR SpritesDraw
	
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
	
	LDA #$FF
	STA spritesDrawOffset2
	
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
TitleRun:
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
	;JSR SpritesUpdateTimers
	;JSR SpritesUpdateActions
	;JSR SpritesUpdateAnim
	JSR SpritesUpdate
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
	
	TitleEnd:	
	RTS

;----------------------------------------------------------------
; Level1 function
;----------------------------------------------------------------
Level1Run:	
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
			JMP Level1RunEnd	
			JMP +
			+++
		;button unpressed
		+
		
	JSR SpawnManager
	JSR UpdateRoom
	JSR SpritesUpdate
	JSR UpdatePlayerPowerUp
	
	JSR SpritesDraw	
	
	Level1RunEnd:
	RTS

;----------------------------------------------------------------
; Info function
;----------------------------------------------------------------
InfoRun:
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
	;JSR SpritesUpdate
	;JSR SpritesDraw	
	
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
	LDA FALSE
	STA palChangeFlag
	
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
					
			LDA #$00
			STA timerTitleBGColorChangeLow
			STA timerTitleBGColorChangeHi
			++
		+
	
	LDA TRUE
	STA palChangeFlag
	RTS

;----------------------------------------------------------------
; Change attribute values function
;----------------------------------------------------------------
ChangeAttributeValues:
	LDA FALSE
	STA attrChangeFlag
	
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
			SEC
			LDA titleAttrValuesFlagsCurrent
			SBC titleAttrValuesFlagsPeriod
			STA titleAttrValuesFlagsCurrent
			LDA #$00
			STA titleAttrValuesFlagsPeriod
			+++
				
		LDA #$00
		STA timerTitleAttrChange
		+
		
	LDA TRUE
	STA attrChangeFlag
	RTS

;----------------------------------------------------------------
; Change nametable values function
;----------------------------------------------------------------
ChangeNametableValues:
	LDA FALSE
	STA ntblChangeFlag
	
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
; Change nametable values function manual X, Y
;----------------------------------------------------------------
ChangeNametableValuesManual:
	LDA FALSE
	STA ntblChangeFlag
	
	LDA #$00
	STA counter
	LDY #$00
		-
		LDX ntblValuesLength
		
		LDA ntblValuesTemp, Y		
		STA ntblValues, X
	
		LDA ntblAddrLowTemp, Y
		STA ntblAddrLow, X
	
		LDA ntblAddrHiTemp, Y
		STA ntblAddrHi, X
				
		INC ntblValuesLength
		INY
		
		INC counter
		LDA counter
		CMP ntblToAdd
	BNE -
	
	LDA TRUE
	STA ntblChangeFlag
	RTS
;----------------------------------------------------------------
; Change attribute values manual function
;----------------------------------------------------------------
ChangeAttributeValuesManual:
	LDA FALSE
	STA attrChangeFlag

	LDA #$00
	STA counter
	LDY #$00
		-
		LDX attrValuesLength
		
		LDA ntblValuesTemp, Y			
		STA attrValues, X
	
		LDA ntblAddrLowTemp, Y
		STA attrAddrLow, X
		
		LDA ntblAddrHiTemp, Y
		STA attrAddrHi, X
				
		INC attrValuesLength
		INY
			
		INC counter
		LDA counter
		CMP ntblToAdd
	BNE -
		
	LDA TRUE
	STA attrChangeFlag
	RTS
;----------------------------------------------------------------
; 16 bit inc, dec function
;----------------------------------------------------------------
Bit16Dec:
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

;----------------------------------------------------------------
; Random function
;----------------------------------------------------------------
GetRandomNumber:
	LDA randomNum
	BEQ DoEOR
	ASL
	BEQ NoEOR ;if the input was $80, skip the EOR
	BCC NoEOR
	DoEOR:	EOR #$1D ;value for random change
	NoEOR:	STA randomNum
	RTS

;----------------------------------------------------------------
; Manager to spawn enemies
;----------------------------------------------------------------
SpawnManager:	
	;check if need load
	LDA loadNewRoom
	CMP TRUE
	BNE +
		RTS
		+
		LDY roomNumber
		LDA Level1RoomsSpawnsNum, Y
		STA spawnNum

		LDX #$00
		SMFS:		
		CPX spawnNum
		BNE +
			JMP SMRTS
			+
		LDA spawnAnimTimers, X
		CMP #$00
		BNE +
			LDY roomNumber
			LDA Level1SpawnsTimerHiLow, Y
			STA pointerLow
			LDA Level1SpawnsTimerHiHi, Y
			STA pointerHi
			TXA
			TAY
			LDA (pointerLow), Y
			CMP spawnGlobalTimerHi
			BEQ ++
				INX
				JMP SMFS
				++
			LDY roomNumber
			LDA Level1SpawnsTimerLowLow, Y
			STA pointerLow
			LDA Level1SpawnsTimerLowHi, Y
			STA pointerHi
			TXA
			TAY
			LDA (pointerLow), Y
			CMP spawnGlobalTimerLow
			BNE ++
				INC spawnAnimTimers, X
				INX
				JMP SMFS
				++
			INX
			JMP SMFS
			+
		CMP #$01
		BNE +
			LDY #$08
			JMP SMASBE
			+
		CMP #$04
		BNE +
			LDY #$0C
			JMP SMASBE
			+
		CMP #$07
		BNE +
			LDY #$10
			JMP SMASBE
			+
		CMP #$0A
		BNE +
			LDY #$14
			SMASBE:
			TXA
			PHA	
			LDX #$00
				-
				LDA TitleNtblValues, Y			
				STA ntblValuesTemp, X
				INY
				INX

				CPX #$04
				BNE -
			PLA
			TAX
			PHA
			LDY roomNumber
			LDA Level1SpawnsXNameTableLow, Y
			STA pointerLow
			LDA Level1SpawnsXNameTableHi, Y
			STA pointerHi
			TXA
			TAY ;spawn number
			LDA (pointerLow), Y ;read spawn x
			LDX #$00
			STA ntblAddrLowTemp, X
			INX
			CLC
			ADC #$01
			STA ntblAddrLowTemp, X
			INX
			CLC
			ADC #$1F
			STA ntblAddrLowTemp, X
			INX
			CLC
			ADC #$01
			STA ntblAddrLowTemp, X
			PLA
			TAX
			PHA
			LDY roomNumber
			LDA Level1SpawnsYNameTableLow, Y
			STA pointerLow
			LDA Level1SpawnsYNameTableHi, Y
			STA pointerHi
			TXA
			TAY ;spawn number
			LDA (pointerLow), Y ;read spawn y
			CLC
			ADC baseNametableAddrHi
			LDX #$00
			STA ntblAddrHiTemp, X
			INX
			STA ntblAddrHiTemp, X
			INX
			STA ntblAddrHiTemp, X
			INX
			STA ntblAddrHiTemp, X	
			LDA #$04
			STA ntblToAdd
			JSR ChangeNametableValuesManual
			PLA
			TAX
			INC spawnAnimTimers, X
			INX
			JMP SMFS
			+	
		CMP #$0A
		BPL +
			INC spawnAnimTimers, X
			INX
			JMP SMFS
			+
		
		LDY roomNumber
		LDA Level1SpawnsNumsLow, Y
		STA pointerLow
		LDA Level1SpawnsNumsHi, Y
		STA pointerHi
		TXA
		TAY
		LDA (pointerLow), Y
		STA spawnEnemyNum
		LDA spawnNums, X	
		CMP spawnEnemyNum
		BNE + 
			JMP SMFE
			+
		LDY roomNumber
		LDA Level1Room1SpawnsMaxEnemiesLow, Y
		STA pointerLow
		LDA Level1Room1SpawnsMaxEnemiesHi, Y
		STA pointerHi
		LDY #$00
		LDA (pointerLow), Y
		CMP spawnAlready
		BNE +	
			INX
			JMP SMFS
			+
		INC spawnTimers, X
		LDA spawnTimers, X
		CMP #$10 ;time to spawn between enemies + 1
		BNE +
			LDA #$00
			STA spawnTimers, X
			+	
		LDA spawnTimers, X
		CMP #$0F ;time to spawn between enemies
		BEQ +
			INX
			JMP SMFS
			+
		LDY roomNumber
		LDA Level1SpawnsTypeLowLow, Y
		STA pointerLow
		LDA Level1SpawnsTypeLowHi, Y
		STA pointerHi
		LDA Level1SpawnsTypeHiLow, Y
		STA pointer2Low
		LDA Level1SpawnsTypeHiHi, Y
		STA pointer2Hi
		TXA
		TAY ;spawn number
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY spawnNums, X ;read massive	
		LDA (pointerLow), Y ;read spawn type
		STA spriteType
		
		LDY roomNumber
		LDA Level1SpawnsXLow, Y
		STA pointerLow
		LDA Level1SpawnsXHi, Y
		STA pointerHi
		TXA
		TAY ;spawn number
		LDA (pointerLow), Y ;read spawn x
		STA spriteX
		
		LDY roomNumber
		LDA Level1SpawnsYLow, Y
		STA pointerLow
		LDA Level1SpawnsYHi, Y
		STA pointerHi
		TXA
		TAY ;spawn number
		LDA (pointerLow), Y ;read spawn y
		STA spriteY
		
		LDA spriteType
		CMP #$01
		BNE +
			LDA #$06 ;anim
			STA spriteStateAnim
			JMP SMABE
			+
		CMP #$02
		BNE +
			LDA #$04 ;anim
			STA spriteStateAnim
			JMP SMABE
			+
		SMABE:
		LDA #$04 ;action
		STA spriteStateAction
		LDA #$00 ;timer
		STA spriteTimerAnim
		STA spriteTimerAction
		LDY spriteType ;health
		LDA SpritesTypesHealth, Y
		STA spriteHealth
		JSR SpritesAdd
		
		;------------------
		;sprite add
		;------------------
		
		INC spawnNums, X
		INX
		JMP SMFS
		
		
		SMFE:	
		LDA spawnAnimTimers, X
		CMP #$0E
		BNE +
			LDY #$10
			JMP SMASBEE
			+
		CMP #$11
		BNE +
			LDY #$0C
			JMP SMASBEE
			+
		CMP #$14
		BNE +
			LDY #$08
			JMP SMASBEE
			+
		CMP #$17
		BNE +
			LDY #$18
			SMASBEE:
			TXA
			PHA	
			LDX #$00
				-
				LDA TitleNtblValues, Y			
				STA ntblValuesTemp, X
				INY
				INX

				CPX #$04
				BNE -
			PLA
			TAX
			PHA
			LDY roomNumber
			LDA Level1SpawnsXNameTableLow, Y
			STA pointerLow
			LDA Level1SpawnsXNameTableHi, Y
			STA pointerHi
			TXA
			TAY ;spawn number
			LDA (pointerLow), Y ;read spawn x
			LDX #$00
			STA ntblAddrLowTemp, X
			INX
			CLC
			ADC #$01
			STA ntblAddrLowTemp, X
			INX
			CLC
			ADC #$1F
			STA ntblAddrLowTemp, X
			INX
			CLC
			ADC #$01
			STA ntblAddrLowTemp, X
			PLA
			TAX
			PHA
			LDY roomNumber
			LDA Level1SpawnsYNameTableLow, Y
			STA pointerLow
			LDA Level1SpawnsYNameTableHi, Y
			STA pointerHi
			TXA
			TAY ;spawn number
			LDA (pointerLow), Y ;read spawn y
			CLC
			ADC baseNametableAddrHi
			LDX #$00
			STA ntblAddrHiTemp, X
			INX
			STA ntblAddrHiTemp, X
			INX
			STA ntblAddrHiTemp, X
			INX
			STA ntblAddrHiTemp, X		
			LDA #$04
			STA ntblToAdd
			JSR ChangeNametableValuesManual
			PLA
			TAX
			INC spawnAnimTimers, X
			INX
			JMP SMFS
			+	
		CMP #$17
		BPL +
			INC spawnAnimTimers, X
			INX
			JMP SMFS
			+
		INX
		JMP SMFS
		SMRTS:
		;update global spawn timer
		LDA spawnGlobalTimerLow
		STA bit16Low
		LDA spawnGlobalTimerHi
		STA bit16Hi
		JSR Bit16Inc
		LDA bit16Low
		STA spawnGlobalTimerLow
		LDA bit16Hi
		STA spawnGlobalTimerHi
	RTS

DecimalAdd:
	LDA tousandsDigit
	CMP #$09
	BNE +
		LDA hundredsDigit
		CMP #$09
		BNE +
			LDA tensDigit
			CMP #$09
			BNE +
				LDA onesDigit
				CMP #$09
				BNE +
					RTS
					+
AddOnes:
	LDA onesDigit      ; load the lowest digit of the number
	CLC 
	ADC onesAdd        ; add new number, no carry
	STA onesDigit
	CMP #$0A           ; check if digit went above 9. If accumulator >= $0A, carry is set
	BCC AddTens        ; if carry is clear, all done with ones digit
                       ; carry was set, so we need to handle wrapping
	LDA onesDigit
	SEC
	SBC #$0A           ; subtract off what doesnt fit in 1 digit
	STA onesDigit      ; then store the rest
	INC tensDigit      ; increment the tens digit
AddTens:
	LDA tensDigit      ; load the next digit
	CLC
	ADC tensAdd        ; add new number
	STA tensDigit
	CMP #$0A           ; check if digit went above 9
	BCC AddHundreds    ; no carry, digit done
	LDA tensDigit
	SEC
	SBC #$0A           ; subtract off what doesnt fit in 1 digit
	STA tensDigit      ; then store the rest
	INC hundredsDigit  ; increment the hundreds digit
AddHundreds:
	LDA hundredsDigit  ; load the next digit
	CLC
	ADC hundredsAdd    ; add new number
	STA hundredsDigit
	CMP #$0A           ; check if digit went above 9
	BCC AddTousands    ; no carry, digit done
	LDA hundredsDigit
	SEC
	SBC #$0A           ; subtract off what doesnt fit in 1 digit
	STA hundredsDigit  ; then store the rest
	INC tousandsDigit  ; increment the tousands digit
AddTousands:
	LDA tousandsDigit  ; load the next digit
	CLC
	ADC tousandsAdd    ; add new number
	STA tousandsDigit
	RTS
	
DecreasePlayerHealth:
	LDA healthHi
	CMP #$00
	BNE +
		LSR healthLow
		+
	LSR healthHi
	RTS

IncreasePlayerHealth:
	LDA healthLow
	CMP #$FF
	BNE +
		ASL healthHi
		LDA healthHi
		CLC
		ADC #$01
		STA healthHi
		+
	ASL healthLow
	LDA healthLow
	CLC
	ADC #$01
	STA healthLow
	RTS

UpdatePlayerHealth:
	;check if need load
	LDA loadNewRoom
	CMP TRUE
	BNE +
		RTS
		+
	LDA #$04
	STA ntblToAdd	
	LDA healthHi
	STA temp
	LDX #$00
		-		
		AND #$03
		CMP #$00
		BNE +
			LDA #$A9 ;empty
			JMP +++
			+	
		CMP #$01
		BNE +	
			LDA #$B9 ;half
			JMP +++
			+
		CMP #$03
		BNE +
			LDA #$E1 ;full
			+
		+++
		STA ntblValuesTemp, X
		LDA sprite0NtblHi
		STA ntblAddrHiTemp, X
		LDA NtblValuesHealthHiAddrLow, X
		STA ntblAddrLowTemp, X
		
		LSR temp
		LSR temp
		LDA temp
		INX		
		CPX ntblToAdd
	BNE -		
	JSR ChangeNametableValuesManual
	LDA #$04
	STA ntblToAdd	
	LDA healthLow
	STA temp
	LDX #$00
		-		
		AND #$03
		CMP #$00
		BNE +
			LDA #$A9 ;empty
			JMP +++
			+	
		CMP #$01
		BNE +	
			LDA #$B9 ;half
			JMP +++
			+
		CMP #$03
		BNE +
			LDA #$E1 ;full
			+
		+++
		STA ntblValuesTemp, X
		LDA sprite0NtblHi
		STA ntblAddrHiTemp, X
		LDA NtblValuesHealthLowAddrLow, X
		STA ntblAddrLowTemp, X
		
		LSR temp
		LSR temp
		LDA temp
		INX		
		CPX ntblToAdd
	BNE -		
	JSR ChangeNametableValuesManual
	RTS

UpdatePlayerCoins:
	;check if need load
	LDA loadNewRoom
	CMP TRUE
	BNE +
		RTS
		+
	LDA #$04
	STA ntblToAdd
	LDX #$00
		-
		LDA #$F6 ;digits offset in ppu
		CLC
		ADC onesDigit, X
		STA ntblValuesTemp, X
		LDA sprite0NtblHi
		STA ntblAddrHiTemp, X
		LDA NtblValuesCoinCountAddrLow, X
		STA ntblAddrLowTemp, X

		INX
		CPX ntblToAdd
	BNE -		
	JSR ChangeNametableValuesManual	
	RTS

UpdatePlayerPowerUp:
	;check if need load
	LDA loadNewRoom
	CMP TRUE
	BNE +
		RTS
		+
	LDA powerUpValue
	CMP #$00
	BNE +
		RTS
		+
	CMP #$FF
	BNE +
		LDA powerUpTimer
		CMP #$00
		BNE ++
			;load comma
			LDX #$00
			LDA #$E5		
			STA ntblValuesTemp, X
			LDA sprite0NtblHi
			STA ntblAddrHiTemp, X
			LDA #$72
			STA ntblAddrLowTemp, X
			LDA #$01
			STA ntblToAdd
			JSR ChangeNametableValuesManual
			
			LDA powerUpSprite
			CMP TRUE
			BEQ ++++
				LDA powerUpType
				CMP #$01 ;trigun type powerup
				BNE +++
					LDA #$0F ;type
					+++		
				STA spriteType
				LDA #$88 ;x
				STA spriteX
				LDA #$D7 ;y
				STA spriteY
				LDA #$00 ;anim
				STA spriteStateAnim
				LDA #$00 ;action
				STA spriteStateAction
				LDA #$00 ;timer
				STA spriteTimerAnim
				STA spriteTimerAction
				LDY spriteType ;health
				LDA SpritesTypesHealth, Y
				STA spriteHealth
				JSR SpritesAdd
				LDA TRUE
				STA powerUpSprite
				++++
			++
		+
			
	LDA powerUpTimer
	CMP #$B4
	BNE +
		LDA #$00
		STA powerUpTimer
		LSR powerUpValue
		+
	LDA powerUpValue ;check if time no more
	CMP #$00
	BNE +
		;remove comma
		LDX #$00
		LDA #$80		
		STA ntblValuesTemp, X
		LDA sprite0NtblHi
		STA ntblAddrHiTemp, X
		LDA #$72
		STA ntblAddrLowTemp, X
		LDA #$01
		STA ntblToAdd
		JSR ChangeNametableValuesManual
		
		;remove powerup sprite
		;LDA powerUpSpriteIndex
		;STA index
		;INC powerUpsOnLevel
		;JSR SpritesRemove
		
		;remove bg statusbar
		LDX #$00
		-
		LDA #$80 ;blank space		
		STA ntblValuesTemp, X
		LDA sprite0NtblHi
		STA ntblAddrHiTemp, X
		LDA NtblValuesPowerUpAddrLow, X
		STA ntblAddrLowTemp, X
		INX
		CPX #$04
		BNE -	
		LDA #$04
		STA ntblToAdd
		JSR ChangeNametableValuesManual
		
		LDA #$00 ;type none
		STA powerUpType
		RTS
		+
	LDA #$04
	STA ntblToAdd	
	LDA powerUpValue
	STA temp
	LDX #$00
		-		
		AND #$03
		CMP #$00
		BNE +
			CPX #$03
			BNE ++
				LDA #$F4
				JMP +++
				++
			CPX #$00
			BNE ++
				LDA #$F2
				JMP +++
				++
				LDA #$F3
				JMP +++
			+	
		CMP #$01
		BNE +	
			CPX #$03
			BNE ++
				LDA #$F5
				JMP +++
				++
			CPX #$00
			BNE ++
				LDA #$E3
				JMP +++
				++
				LDA #$F0
				JMP +++
			+
		CMP #$03
		BNE +
			CPX #$03
			BNE ++
				LDA #$E4
				JMP +++
				++
			CPX #$00
			BNE ++
				LDA #$E2
				JMP +++
				++
				LDA #$F1
			+
		+++
		STA ntblValuesTemp, X
		LDA sprite0NtblHi
		STA ntblAddrHiTemp, X
		LDA NtblValuesPowerUpAddrLow, X
		STA ntblAddrLowTemp, X
		
		LSR temp
		LSR temp
		LDA temp
		INX		
		CPX ntblToAdd
	BNE -		
	JSR ChangeNametableValuesManual
	RTS

UpdateRoom:
	;check if need load
	LDA loadNewRoom
	CMP TRUE
	BEQ +
		RTS
		+
	 ;remove all sprites
	LDA spritesCleared
	CMP FALSE
	BEQ +
		JMP ++++++
		+
		LDA #$00
		STA temp 
			-
			LDX temp
			LDA spritesType, X
			CMP #$03 ;heart
			BNE +
				LDA spritesStateAction, X
				CMP #$00
				BNE ++
					INC temp 
					JMP +++
					++
				+
			CMP #$05 ;small
			BNE +
				LDA spritesStateAction, X
				CMP #$00
				BNE ++
					INC temp 
					JMP +++
					++
				+
			CMP #$0F ;powerup
			BNE +
				LDA spritesStateAction, X
				CMP #$00
				BNE ++
					INC temp 
					JMP +++
					++
				+
			STX index
			JSR SpritesRemove
			+++
			;check if interface sprites
			LDX temp
			CPX spritesLength
		BNE -
		;add some finish initializations
		LDA TRUE
		STA spritesCleared
		
		LDA #<(bulletsNum)
		STA pointerLow
		LDA #$00
		STA pointerHi
		STA ntblValuesLength
		LDY #$00
			-
			STA (pointerLow), Y
			INY
			CPY #$29
		BNE -
		
		LDA FALSE
		STA ntblChangeFlag
		
		LDA #$00
		STA titleAttrValuesFlagsCurrent
		
		JSR Function_InitScrollVars
		RTS
	++++++
	LDA scrollDirection
	CMP #$00 ;up
	BEQ +
		JMP ++++++++++
		+
		RTS
	++++++++++
	CMP #$01 ;down
	BEQ +
		JMP ++++++++++
		+
		RTS
	++++++++++
	CMP #$02 ;left
	BEQ +
		JMP ++++++++++
		+
		JSR Function_ScrollRoomLeftRight
		RTS
	++++++++++
	CMP #$03 ;right
	BEQ +
		JMP ++++++++++
		+
		JSR Function_ScrollRoomLeftRight
		RTS
	++++++++++
	
	RTS

ChangeHiNametableAdress:
	LDA sprite0NtblHi
	CMP #$23
	BNE +
		LDA #$27
		STA sprite0NtblHi
		RTS
		+
	CMP #$27
	BNE +
		LDA #$23
		STA sprite0NtblHi
		RTS
		+
	CMP #$2B
	BNE +
		LDA #$2F
		STA sprite0NtblHi
		RTS
		+
	CMP #$2F
	BNE +
		LDA #$2B
		STA sprite0NtblHi
		RTS
		+
	RTS

Function_InitScrollVars:
	;load nametable adress
	LDY roomNumber
	LDA (Level1RoomsTeleportLow), Y
	STA pointerLow
	LDA (Level1RoomsTeleportHi), Y
	STA pointerHi
				
	LDY scrollDirection
	LDA (pointerLow), Y
	STA roomNumber
	TAY
	LDA (Level1RoomsNameTablesLow), Y
	STA scroll2Low
	LDA (Level1RoomsNameTablesHi), Y
	STA scroll2Hi
		
	LDY roomNumber
	LDA Level1RoomsSpawnsNum, Y
	STA spawnNum
		
	LDA scrollDirection
	CMP #$00 ;up
	BNE +
		+
	CMP #$01 ;down
	BNE +
		+
	CMP #$02 ;left
	BNE +
		LDA baseNametable
		CMP #$00
		BNE ++
			LDA #$24
			STA scrollHi
			STA baseNametableAddrHi
			JMP _END_SCROLL_DIR_LEFT_
			++
		CMP #$01
		BNE ++
			LDA #$20
			STA scrollHi
			STA baseNametableAddrHi
			JMP _END_SCROLL_DIR_LEFT_
			++
		CMP #$02
		BNE ++
			LDA #$2C
			STA scrollHi
			STA baseNametableAddrHi
			JMP _END_SCROLL_DIR_LEFT_
			++
		CMP #$03
		BNE ++
			LDA #$28
			STA scrollHi
			STA baseNametableAddrHi
			JMP _END_SCROLL_DIR_LEFT_
			++
			_END_SCROLL_DIR_LEFT_:
			LDA #$1F
			STA scrollLow	
			LDA scroll2Low
			CLC
			ADC #$1F
			BCC ++
				INC scroll2Hi
				++
			STA scroll2Low
			RTS
		+			
	CMP #$03 ;right
	BNE +
		LDA baseNametable
		CMP #$00
		BNE ++
			LDA #$24
			STA scrollHi
			STA baseNametableAddrHi
			JMP _END_SCROLL_DIR_RIGHT_
			++
		CMP #$01
		BNE ++
			LDA #$20
			STA scrollHi
			STA baseNametableAddrHi
			JMP _END_SCROLL_DIR_RIGHT_
			++
		CMP #$02
		BNE ++
			LDA #$2C
			STA scrollHi
			STA baseNametableAddrHi
			JMP _END_SCROLL_DIR_RIGHT_
			++
		CMP #$03
		BNE ++
			LDA #$28
			STA scrollHi
			STA baseNametableAddrHi
			JMP _END_SCROLL_DIR_RIGHT_
			++
			_END_SCROLL_DIR_RIGHT_:
			LDA #$00
			STA scrollLow
			RTS
		+
		
	RTS
	
Function_ScrollRoomLeftRight:
	;scroll screen
	LDX scrollDirection
	CPX #$02 ;left
	BNE +
		LDA scrollX
		CLC
		ADC #$F8
		STA scrollX
		LDA scrollX
		CMP #$F8
		BNE ++
			JSR Function_ChangeBaseNameTableLeftRight
			++
		+
	CPX #$03 ;right
	BNE +
		LDA scrollX
		CLC
		ADC #$08
		STA scrollX
		LDA scrollX
		CMP #$00
		BNE ++
			JSR Function_ChangeBaseNameTableLeftRight
			++
		+
	LDA scrollX
	CMP #$00
	BNE +
		LDA FALSE
		STA loadNewRoom
		STA sprite0Check		
				
		;Load sprites player
		LDA #$00 ;type
		STA buttonsP1Old
		STA buttonsP1
		STA spriteType
		LDA savedPlayerX
		STA spriteX
		LDA savedPlayerY
		STA spriteY
		LDA savedPlayerAnim ;anim
		STA spriteStateAnim
		LDA savedPlayerAction ;action
		STA spriteStateAction
		LDA #$00 ;timer
		STA spriteTimerAnim
		STA spriteTimerAction
		LDY spriteType ;health
		LDA SpritesTypesHealth, Y
		STA spriteHealth
		JSR SpritesAdd	
		+
	
	LDA #$00
	STA ntblValuesLength
	
	;load nametable
	;30 height
	;32 width
	LDA scroll2Low
	STA pointer2Low
	LDA scroll2Hi
	STA pointer2Hi
	LDA scrollLow
	STA pointerLow
	LDA scrollHi
	STA pointerHi


	LDX #$00
	_DRAW_LEVEL_COLUMN_:
	LDY #$00
	LDA (pointer2Low), Y ;digits offset in ppu
	STA ntblValues, X
			
	LDA #$25
	STA value
	LDY roomNumber
	LDA Level1SpawnsXNameTableLow, Y
	STA addressLow
	LDA Level1SpawnsXNameTableHi, Y
	STA addressHi
	LDY #$00
		-
		LDA (addressLow), Y ;read spawn x
		CMP pointerLow
		BNE +
			_SPAWN_DRAW_CHECK_HIADDR_:
			TYA
			PHA
			LDY roomNumber
			LDA Level1SpawnsYNameTableLow, Y
			STA addressLow
			LDA Level1SpawnsYNameTableHi, Y
			STA addressHi
			PLA
			TAY
			LDA (addressLow), Y ;read spawn y
			CLC
			ADC baseNametableAddrHi
			CMP pointerHi
			BNE ++
				LDA value
				STA ntblValues, X
				JMP _SPAWN_DRAW_END_
				++
			+
		CLC
		ADC #$01
		CMP pointerLow
		BNE +
			LDA #$25
			STA value
			JMP _SPAWN_DRAW_CHECK_HIADDR_
			+
		CLC
		ADC #$1F
		CMP pointerLow
		BNE +
			LDA #$35
			STA value
			JMP _SPAWN_DRAW_CHECK_HIADDR_
			+
		CLC
		ADC #$01
		CMP pointerLow
		BNE +
			LDA #$35
			STA value
			JMP _SPAWN_DRAW_CHECK_HIADDR_
			+
		INY
		CPY spawnNum
	BNE -
	_SPAWN_DRAW_END_:		
	LDA pointerHi
	STA ntblAddrHi, X
	LDA pointerLow
	STA ntblAddrLow, X
	CLC
	ADC #$20
	STA pointerLow
	BCC +
		INC pointerHi
		+
	LDA pointer2Low
	CLC
	ADC #$20
	STA pointer2Low
	BCC +
		INC pointer2Hi
		+
	INC ntblValuesLength
	INX
	CPX #$1E ;30 - 1 vertical column
	BEQ +
		JMP _DRAW_LEVEL_COLUMN_
		+
	
	;load attribute table
	;attrtable 8x8
	;start at $23C0, $27C0, $2BC0, or $2FC0
	LDA titleAttrValuesFlagsCurrent
	CMP #$08
	BEQ +
		LDA scrollDirection
		CMP #$02 ;left
		BNE ++
			LDA pointer2Low
			SEC 
			SBC #$18
			BCS +++
				DEC pointer2Hi
				+++
			STA pointer2Low
		
			LDA pointerLow
			SEC 
			SBC #$18
			BCS +++
				DEC pointerHi
				+++
			STA pointerLow
			++
			-
			LDY #$00
			LDA (pointer2Low), Y ;digits offset in ppu
			STA ntblValues, X
			LDA pointerHi
			STA ntblAddrHi, X
			LDA pointerLow
			STA ntblAddrLow, X
			CLC
			ADC #$08
			STA pointerLow
			BCC ++
				INC pointerHi
				++
			LDA pointer2Low
			CLC
			ADC #$08
			STA pointer2Low
			BCC ++
				INC pointer2Hi
				++
			INC ntblValuesLength
			INX
			CPX #$26 ;38 - column + attribute column
		BNE -
		INC titleAttrValuesFlagsCurrent
		+
	
	;add sprite 0 helper
	LDA #$80
	STA ntblValues, X
	LDA sprite0NtblHi
	STA ntblAddrHi, X
	LDA sprite0NtblLow
	STA ntblAddrLow, X
	INC ntblValuesLength
	
	LDA scrollDirection
	CMP #$02 ;left
	BNE +
		DEC sprite0NtblLow
		+
	CMP #$03 ;right
	BNE +
		INC sprite0NtblLow
		+	
	
	LDA sprite0NtblLow
	CMP #$60
	BNE +
		JSR ChangeHiNametableAdress
		LDA #$40
		STA sprite0NtblLow
		+
	LDA sprite0NtblLow
	CMP #$3F
	BNE +
		JSR ChangeHiNametableAdress
		LDA #$5F
		STA sprite0NtblLow
		+
	LDA sprite0NtblLow
	CMP #$40
	BNE +
		LDA sprite0NtblHi
		CMP #$23
		BNE ++
			LDA #$00
			STA sprite0BaseNametableTemp
			JMP +
			++
		CMP #$27
		BNE ++
			LDA #$01
			STA sprite0BaseNametableTemp
			JMP +
			++
		CMP #$2B
		BNE ++
			LDA #$00
			STA sprite0BaseNametableTemp
			JMP +
			++
		CMP #$2F
		BNE ++
			LDA #$01
			STA sprite0BaseNametableTemp
			JMP +
			++
		+
	INX
	LDA #$BA
	STA ntblValues, X
	LDA sprite0NtblHi
	STA ntblAddrHi, X
	LDA sprite0NtblLow
	STA ntblAddrLow, X
	INC ntblValuesLength
	
	LDA TRUE
	STA ntblChangeFlag
	
	LDA scrollDirection
	CMP #$02 ;left
	BNE +
		DEC scrollLow
		DEC scroll2Low
		+
	CMP #$03 ;right
	BNE +
		INC scrollLow
		INC scroll2Low
		+	
	
	LDA TRUE
	STA sprite0Check
	
	LDA scrollX
	CMP #$00
	BNE +
		RTS
		+
	
	LDA scrollDirection
	CMP #$03
	BNE +
		JSR ChangeHiNametableAdress
		+
	LDA FALSE	
	STA loadNewRoom
	
	LDX scrollDirection
	LDA scrollX
	CMP ScrollXStatusBarHealth, X ;add health
	BNE +		
		JSR UpdatePlayerHealth		
		+
	LDX scrollDirection
	LDA scrollX
	CMP ScrollXStatusBarCoins, X ;add coins number
	BNE +
		JSR UpdatePlayerCoins
		+
	LDX scrollDirection
	LDA scrollX
	CMP ScrollXStatusBarCommas, X ;add commas
	BNE +
		LDX #$00
			-
			LDA #$E5		
			STA ntblValuesTemp, X
			LDA sprite0NtblHi
			STA ntblAddrHiTemp, X
			LDA NtblValuesBlockAddrLow, X
			STA ntblAddrLowTemp, X

			INX
			CPX #$02
		BNE -	
		LDA #$02
		STA ntblToAdd
		JSR ChangeNametableValuesManual	
		
		LDA powerUpValue
		CMP #$00
		BEQ ++
			LDX #$00
			LDA #$E5		
			STA ntblValuesTemp, X
			LDA sprite0NtblHi
			STA ntblAddrHiTemp, X
			LDA #$72
			STA ntblAddrLowTemp, X
			LDA #$01
			STA ntblToAdd
			JSR ChangeNametableValuesManual
			++		
		+
	LDA scrollDirection
	CMP #$03
	BNE +
		JSR ChangeHiNametableAdress
		+
	LDA TRUE	
	STA loadNewRoom
	
	RTS
	
Function_ChangeBaseNameTableLeftRight:
	LDA baseNametable
	CMP #$00
	BNE +
		LDA #$01
		STA baseNametable
		RTS
		+
	CMP #$01
	BNE +
		LDA #$00
		STA baseNametable
		RTS
		+
	CMP #$02
	BNE +
		LDA #$03
		STA baseNametable
		RTS
		+
	CMP #$03
	BNE +
		LDA #$02
		STA baseNametable
		RTS
		+
	RTS
		