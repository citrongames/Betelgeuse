;----------------------------------------------------------------
; Title initialization function
;----------------------------------------------------------------
TitleInit:
	LDA #$00 ;disable nmi
	STA $2000
		
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
	JSR Function_FillNametableBlank
	
	LDA #<(TITLE_DATA_TITLE_1)
	STA pointerLow
	LDA #>(TITLE_DATA_TITLE_1)
	STA pointerHi
	LDA #$C6
	STA addressLow
	LDA #$20
	STA addressHi
	LDA #$13
	STA lengthLow
	LDA #$00
	STA lengthHi
	JSR WriteToPPU
	
	LDA #<(TITLE_DATA_TITLE_2)
	STA pointerLow
	LDA #>(TITLE_DATA_TITLE_2)
	STA pointerHi
	LDA #$E6
	STA addressLow
	LDA #$20
	STA addressHi
	LDA #$13
	STA lengthLow
	LDA #$00
	STA lengthHi
	JSR WriteToPPU
	
	LDA #<(TITLE_DATA_TITLE_3)
	STA pointerLow
	LDA #>(TITLE_DATA_TITLE_3)
	STA pointerHi
	LDA #$06
	STA addressLow
	LDA #$21
	STA addressHi
	LDA #$13
	STA lengthLow
	LDA #$00
	STA lengthHi
	JSR WriteToPPU
	
	LDA #<(TITLE_DATA_TITLE_4)
	STA pointerLow
	LDA #>(TITLE_DATA_TITLE_4)
	STA pointerHi
	LDA #$69
	STA addressLow
	LDA #$22
	STA addressHi
	LDA #$0D
	STA lengthLow
	LDA #$00
	STA lengthHi
	JSR WriteToPPU
	
	LDA #<(TITLE_DATA_TITLE_5)
	STA pointerLow
	LDA #>(TITLE_DATA_TITLE_5)
	STA pointerHi
	LDA #$AE
	STA addressLow
	LDA #$22
	STA addressHi
	LDA #$03
	STA lengthLow
	LDA #$00
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
	
	LDA #%10010000 ;enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
	STA $2000
		-:	
		LDA vblankFlag
		CMP #$01
	BNE -
		
	LDA #$01
	STA ppuEnableFlag

	RTS

;----------------------------------------------------------------
; Level1 initialization function
;----------------------------------------------------------------
Level1Init:
	LDA #$00 ;disable nmi
	STA $2000
	
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
	LDA #<(LEVEL_1_BLOCKS)
	STA pointerLow
	LDA #>(LEVEL_1_BLOCKS)
	STA pointerHi
	LDA #$00
	STA addressLow
	LDA #$20
	STA addressHi
	LDA #$FF
	STA lengthLow
	LDA #$03
	STA lengthHi
	;JSR WriteToPPU
	JSR WriteFromBlocksToPPU
	
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
	;Load sprites key
	LDA #$10 ;type
	STA spriteType
	LDA #$A0 ;x
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
	
	LDA #$03
	STA ntblToAdd
	LDX #$00
		-
		LDA #$E5		
		STA ntblValuesTemp, X
		LDA sprite0NtblHi
		STA ntblAddrHiTemp, X
		LDA NtblValuesBlockAddrLow, X
		STA ntblAddrLowTemp, X

		INX
		CPX ntblToAdd
	BNE -	
	JSR ChangeNametableValuesManual	
	
	JSR UpdatePlayerHealth
	JSR UpdatePlayerCoins
	JSR UpdatePlayerKeys
	
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
	
	;load spawns
	LDY roomNumber
	LDA Level1RoomsSpawnsNum, Y
	STA spawnNum
	CMP #$00
	BNE +
		JMP ++
		+
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
	++

	LDY roomNumber
	LDA Level1RoomsInfo, Y
	STA roomsAttributes, Y
	STA value
	JSR Function_InvertByteLow
	LDA value
	ORA #%11110000
	STA doorsFlags
	
	;load doors	
	LDA #$08
	STA temp
	LDA #$04
	STA spawnNum
	LDY #$00
		--
		LDA doorsFlags
		AND DoorsMask, Y
		CMP #$00
		BNE +
			JMP ++
			+
		
		LDX roomNumber
		LDA Level1RoomsDoorsLowLow, X
		STA pointerLow
		LDA Level1RoomsDoorsLowHi, X
		STA pointerHi
		LDA (pointerLow), Y
		STA addressLow
		
		LDA Level1RoomsDoorsHiLow, X
		STA pointerLow
		LDA Level1RoomsDoorsHiHi, X
		STA pointerHi
		LDA (pointerLow), Y
		CLC
		ADC baseNametableAddrHi
		STA addressHi
		LDX #$00
			-		
			STX value
			LDA temp
			CLC
			ADC value
			TAX
			LDA DoorFramesUp, X		
			LDX value
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
		++
		LDA temp 
		CLC
		ADC #$0C
		STA temp
		
		INY
		CPY spawnNum
	BNE --
	
	LDA #$CF
	STA sprite0Y
	
	JSR SpritesDraw
	
	LDA #%10010000 ;enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
	STA $2000
		-:	
		LDA vblankFlag
		CMP #$01
	BNE -
		
	LDA #$01
	STA ppuEnableFlag
	
	RTS

;----------------------------------------------------------------
; Info initialization function
;----------------------------------------------------------------
InfoInit:
	LDA #$00 ;disable nmi
	STA $2000
	
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
	JSR Function_FillNametableBlank
	
	LDA #<(TITLE_DATA_INFO_1)
	STA pointerLow
	LDA #>(TITLE_DATA_INFO_1)
	STA pointerHi
	LDA #$63
	STA addressLow
	LDA #$20
	STA addressHi
	LDA #$07
	STA lengthLow
	LDA #$00
	STA lengthHi
	JSR WriteToPPU
	
	LDA #<(TITLE_DATA_INFO_2)
	STA pointerLow
	LDA #>(TITLE_DATA_INFO_2)
	STA pointerHi
	LDA #$A3
	STA addressLow
	LDA #$20
	STA addressHi
	LDA #$17
	STA lengthLow
	LDA #$00
	STA lengthHi
	JSR WriteToPPU
	
	LDA #<(TITLE_DATA_INFO_3)
	STA pointerLow
	LDA #>(TITLE_DATA_INFO_3)
	STA pointerHi
	LDA #$E3
	STA addressLow
	LDA #$20
	STA addressHi
	LDA #$15
	STA lengthLow
	LDA #$00
	STA lengthHi
	JSR WriteToPPU
	
	LDA #<(TITLE_DATA_INFO_4)
	STA pointerLow
	LDA #>(TITLE_DATA_INFO_4)
	STA pointerHi
	LDA #$63
	STA addressLow
	LDA #$22
	STA addressHi
	LDA #$0F
	STA lengthLow
	LDA #$00
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
	
	LDA #%10010000 ;enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
	STA $2000
		-:	
		LDA vblankFlag
		CMP #$01
	BNE -
		
	LDA #$01
	STA ppuEnableFlag
	
	RTS

;----------------------------------------------------------------
; Load specific sprite in title
;----------------------------------------------------------------
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
		CLC
		CMP index
		BCC ++
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
	;check if need load
	LDA sprite0Check
	CMP TRUE
	BNE +
		LDA drawAllSprites
		CMP FALSE
		BEQ ++
			LDA #$00
			STA addressLow
			LDA #$02
			STA addressHi
			LDA spritesDrawDirection
			CMP #$00
			BEQ +++
				LDA #$03
				STA addressHi
				+++			
			LDY #$00
			LDA sprite0Y ;y
			STA (addressLow), Y
			RTS
			++
		LDA TRUE
		STA drawAllSprites
		+
	LDA scrollEndFlag
	CMP TRUE
	BNE +
		LDA FALSE
		STA scrollEndFlag
		RTS
		+
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
			;load sprite type
			LDA spritesType, X
			STA spriteType
			
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
				LDA addressLow
				CMP spritesDrawOffset1
				BNE ++
					JMP NoClearRemainingSprites
					++
				+
			
			;load sprite y	
			LDY spriteType
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
			LDY spriteType
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
			LDY spriteType
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
			
			LDY spriteType
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
			LDY spriteType
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
			
			LDA addressLow
			CMP spritesDrawOffset1
			BNE +
				JMP NoClearRemainingSprites
				+
			LDY spriteType
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
	NoClearRemainingSprites:
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
	LDA sprite0Y
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
			;load sprite type
			LDA spritesType, X
			STA spriteType
			
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
				LDA addressLow
				CMP spritesDrawOffset2
				BNE ++
					JMP NoClearRemainingSprites2
					++
				+
			
			;load sprite x
			LDY spriteType
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
			LDY spriteType
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
			LDY spriteType
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
			LDY spriteType
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
			LDY spriteType
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
			
			LDA addressLow
			CMP spritesDrawOffset2
			BNE ++
				JMP NoClearRemainingSprites2
				++
				
			LDY spriteType
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
	NoClearRemainingSprites2:
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
	LDA sprite0Y ;y
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
; Update sprites tiles, attributes, x, y, etc
;----------------------------------------------------------------
SpritesUpdate:
	LDA spritesLength
	CMP #$00
	BNE +
		JMP SpritesUpdateEnd
		+
		LDX #$00
		LDA gameState
		CMP #$02
		BNE ++
			LDX #$02
			++
			SpritesUpdateCycle:
			LDA spritesType, X
			STA spriteTypeTemp
			
			INC spritesTimerGlobal, X
			;run action function
			LDA spritesX, X
			STA spriteOldX
			STA spriteNewX
			LDA spritesY, X
			STA spriteOldY
			STA spriteNewY
			
			LDY spriteTypeTemp
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
					
			LDY spriteTypeTemp
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
					LDY spriteTypeTemp
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
					
					;change x
					LDY spriteTypeTemp
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
					LDY spriteTypeTemp
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
					STA spriteOldX
					
					;change y
					LDY spriteTypeTemp
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
					LDY spriteTypeTemp
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
					STA spriteOldY
					
					;reset timer
					LDA #$00
					STA spritesTimerAction, X
			SpritesUpdateActionsNoTime:
						
			INC spritesTimerAnim, X
			;compare anim timers
			LDY spriteTypeTemp
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
					LDY spriteTypeTemp
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
			;check if player standing still
			LDY spriteTypeTemp
			CPY #$00 ;player
			BNE +
				LDA spriteDirection
				CMP #$00 ;stand still
				BNE ++
					STX currentIndex
					JSR SpriteColStandStillFunctionPlayer1
					LDX currentIndex
					++
				+
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
		CLC
		CMP buttonsTemp
		BNE ++
			;button still pressed do nothing
			JMP +
			++
		BCS +++
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
		CLC
		CMP buttonsTemp
		BNE ++
			;button still pressed do nothing
			JMP +
			++
		BCS +++
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
		CLC
		CMP buttonsTemp
		BNE ++
			;button still pressed do nothing
			JMP +
			++
		BCS +++
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
		CLC
		CMP buttonsTemp
		BNE ++
			;button still pressed do nothing
			JMP +
			++
		BCS +++
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
	JSR Function_UpdateDoors
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
		CLC
		CMP buttonsTemp
		BNE ++
			;button still pressed do nothing
			JMP +
			++
		BCS +++
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
; Write BLocks to PPU
;----------------------------------------------------------------
WriteFromBlocksToPPU:
	LDA $2002 	   ;read PPU status to reset the high/low latch
	LDA addressHi
	STA $2006 	   ;write the high byte of address
	LDA addressLow
	STA $2006 	   ;write the low byte of address
	
	LDA #$00
	STA lengthLow
	
	LDY #$00
	-
	LDA lengthLow
	CMP #$00
	BNE +
		LDA (pointerLow), Y
		TAX
		LDA LEVEL_BLOCKS_1X1, X
		STA $2007
		LDA LEVEL_BLOCKS_1X2, X
		STA $2007
		+
	LDA lengthLow
	CMP #$01
	BNE +
		LDA (pointerLow), Y
		TAX
		LDA LEVEL_BLOCKS_2X1, X
		STA $2007
		LDA LEVEL_BLOCKS_2X2, X
		STA $2007		
		+	
	TYA
	AND #$0F
	CMP #$0F
	BNE +
		LDA lengthLow
		CMP #$00
		BNE ++
			TYA
			SEC
			SBC #$10
			TAY
			INC lengthLow
			JMP +
			++
		CMP #$01
		BNE ++
			DEC lengthLow
			++
		+
	INY
	CPY #$F0
	BNE -

	RTS
	
;----------------------------------------------------------------
; Write black to PPU
;----------------------------------------------------------------
Function_FillNametableBlank:
	LDA $2002 	   ;read PPU status to reset the high/low latch
	LDA #$20
	STA $2006 	   ;write the high byte of address
	LDA #$00
	STA $2006 	   ;write the low byte of address
	LDX #$FF
	LDY #$FF
		-
		INX
			--
			INY
			LDA #$27	 ;load data from address (pointerLow + the value in y)
			STA $2007 			 ;write to PPU
			CPY #$FF
		BNE --
		CPX #$03
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
	LDA roomsAttributes, Y
	AND #%00010000 ;check if all spawn enemies defeated
	CMP #$00
	BEQ +
		LDA alreadySpawnItem
		CMP TRUE
		BEQ ++
			LDA roomsAttributes, Y
			AND #%00100000 ;check if need spawn item
			CMP #$00
			BEQ +++
				JSR Function_SpawnRoomItem
				+++
			++
		RTS
		+
	LDA doorsTrigger
	CMP #$00
	BEQ +
		JMP _SPAWN_MANAGER_DOOR_TRIGGER_
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
		CLC
		CMP #$0A
		BCS +
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
			INC spawnClosed
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
		CLC
		CMP #$17
		BCS +
			INC spawnAnimTimers, X
			INX
			JMP SMFS
			+
		INX
		JMP SMFS
		SMRTS:
		;update global spawn timer
		LDA spawnGlobalTimerHi
		CMP #$FF
		BNE +
			LDA spawnGlobalTimerLow
			CMP #$FF
			BNE ++
				RTS
				++
			+
		LDA spawnGlobalTimerLow
		STA bit16Low
		LDA spawnGlobalTimerHi
		STA bit16Hi
		JSR Bit16Inc
		LDA bit16Low
		STA spawnGlobalTimerLow
		LDA bit16Hi
		STA spawnGlobalTimerHi
		
		_SPAWN_MANAGER_DOOR_TRIGGER_
		LDA doorsTrigger
		CMP #$00
		BNE +
			JMP _SPAWN_MANAGER_DOOR_TRIGGER_END_
			+
			LDA doorsTrigger
			CMP #$04
			BNE ++
				LDA playerX
				CMP #$0D
				BCC +++
						LDY roomNumber
						LDA roomsAttributes, Y
						STA value
						JSR Function_InvertByteLow
						LDA value
						ORA #%11110000
						STA doorsFlags
						LDA #$00
						STA doorsTrigger
						LDA #$01
						STA doorsTimer
					+++
				++	
			LDA doorsTrigger
			CMP #$03
			BNE ++
				LDA playerX
				CMP #$E2
				BCS +++
						LDY roomNumber
						LDA roomsAttributes, Y
						STA value
						JSR Function_InvertByteLow
						LDA value
						ORA #%11110000
						STA doorsFlags
						LDA #$00
						STA doorsTrigger
						LDA #$01
						STA doorsTimer
					+++
				++	
			LDA doorsTrigger
			CMP #$02
			BNE ++
				LDA playerY
				CMP #$15
				BCC +++
						LDY roomNumber
						LDA roomsAttributes, Y
						STA value
						JSR Function_InvertByteLow
						LDA value
						ORA #%11110000
						STA doorsFlags
						LDA #$00
						STA doorsTrigger
						LDA #$01
						STA doorsTimer
					+++
				++	
			LDA doorsTrigger
			CMP #$01
			BNE ++
				LDA playerY
				CMP #$B2
				BCS +++
						LDY roomNumber
						LDA roomsAttributes, Y
						STA value
						JSR Function_InvertByteLow
						LDA value
						ORA #%11110000
						STA doorsFlags
						LDA #$00
						STA doorsTrigger
						LDA #$01
						STA doorsTimer
					+++
				++	
		_SPAWN_MANAGER_DOOR_TRIGGER_END_:
		LDA spawnNum
		CMP spawnClosed
		BNE +
			LDA spawnAlready
			CMP #$00
			BNE ++
			LDA doorsFlags
			AND #%11110000
			CMP #$00
			BEQ +++
				LDY roomNumber
				LDA roomsAttributes, Y
				ORA #%00010000
				STA roomsAttributes, Y
				STA value
				ASL
				ASL
				ASL
				ASL
				STA doorsFlags
				JSR Function_InvertByteLow
				LDA value
				AND #%00001111
				ORA doorsFlags
				STA doorsFlags
				LDA #$01
				STA doorsTimer
				LDA #$00
				STA spawnClosed
				+++
				++
			+
	RTS

;----------------------------------------------------------------
; Add decimal number
;----------------------------------------------------------------
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
	
;----------------------------------------------------------------
; Dec player health
;----------------------------------------------------------------
DecreasePlayerHealth:
	LDA healthHi
	CMP #$00
	BNE +
		LSR healthLow
		+
	LSR healthHi
	RTS

;----------------------------------------------------------------
; Inc player health
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Draw player health
;----------------------------------------------------------------
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

;----------------------------------------------------------------
; Draw coins
;----------------------------------------------------------------
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
	
;----------------------------------------------------------------
; Draw keys
;----------------------------------------------------------------
UpdatePlayerKeys:
	;check if need load
	LDA loadNewRoom
	CMP TRUE
	BNE +
		RTS
		+
	LDA #$01
	STA ntblToAdd
	LDA keyNum
	CLC
	CMP #$0A
	BCC +
		LDA #$09
		+
	CLC
	ADC #$F6 ;digits offset in ppu
	STA ntblValuesTemp
	LDA sprite0NtblHi
	STA ntblAddrHiTemp
	LDA NtblValuesKeyCountAddrLow
	STA ntblAddrLowTemp
		
	JSR ChangeNametableValuesManual	
	RTS
	
;----------------------------------------------------------------
; Draw power up
;----------------------------------------------------------------
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
			LDA #$6E
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
				LDA #$68 ;x
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
		LDA #$6E
		STA ntblAddrLowTemp, X
		LDA #$01
		STA ntblToAdd
		JSR ChangeNametableValuesManual
		
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

;----------------------------------------------------------------
; Load new room
;----------------------------------------------------------------
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
			CMP #$10 ;key
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
			CPY #$1D
		BNE -
		
		LDA FALSE
		STA ntblChangeFlag
		STA alreadySpawnItem
		
		LDA #$00
		STA titleAttrValuesFlagsCurrent
		STA titleNtblValuesFlagsCurrent
		STA flagNtblTable
		
		JSR Function_InitScrollVars
		RTS
	++++++
	LDA scrollDirection
	CMP #$00 ;up
	BEQ +
		JMP ++++++++++
		+
		JSR Function_ScrollRoomUp
		RTS
	++++++++++
	CMP #$01 ;down
	BEQ +
		JMP ++++++++++
		+
		JSR Function_ScrollRoomDown
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

;----------------------------------------------------------------
; Change Hi Ntbl addr
;----------------------------------------------------------------
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
	
;----------------------------------------------------------------
; Change Hi Ntbl adr Up/Down
;----------------------------------------------------------------
ChangeHiNametableAdressUpDown:
	LDA sprite0NtblHi
	CMP #$23
	BNE +
		LDA #$2B
		STA sprite0NtblHi
		RTS
		+
	CMP #$27
	BNE +
		LDA #$2F
		STA sprite0NtblHi
		RTS
		+
	CMP #$2B
	BNE +
		LDA #$23
		STA sprite0NtblHi
		RTS
		+
	CMP #$2F
	BNE +
		LDA #$27
		STA sprite0NtblHi
		RTS
		+
	RTS
	
;----------------------------------------------------------------
; Change Ntbl left right
;----------------------------------------------------------------
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
	
;----------------------------------------------------------------
; Change Ntbl up down
;----------------------------------------------------------------
Function_ChangeBaseNameTableUpDown:
	LDA baseNametable
	CMP #$00
	BNE +
		LDA #$02
		STA baseNametable
		RTS
		+
	CMP #$01
	BNE +
		LDA #$03
		STA baseNametable
		RTS
		+
	CMP #$02
	BNE +
		LDA #$00
		STA baseNametable
		RTS
		+
	CMP #$03
	BNE +
		LDA #$01
		STA baseNametable
		RTS
		+
	RTS

;----------------------------------------------------------------
; Sprite 0 Ntbl temp change up down
;----------------------------------------------------------------
Function_sprite0BaseNametableChangeUpDown:
	LDA sprite0BaseNametableTemp
	CMP #$00
	BNE +
		LDA #$02
		STA sprite0BaseNametableTemp
		RTS
		+
	CMP #$01
	BNE +
		LDA #$03
		STA sprite0BaseNametableTemp
		RTS
		+
	CMP #$02
	BNE +
		LDA #$00
		STA sprite0BaseNametableTemp
		RTS
		+
	CMP #$03
	BNE +
		LDA #$01
		STA sprite0BaseNametableTemp
		RTS
		+
	RTS

;----------------------------------------------------------------
; Sprite 0 Ntbl change up down
;----------------------------------------------------------------
Function_sprite0BaseNametableOrigChangeUpDown:
	LDA sprite0BaseNametable
	CMP #$00
	BNE +
		LDA #$02
		STA sprite0BaseNametable
		RTS
		+
	CMP #$01
	BNE +
		LDA #$03
		STA sprite0BaseNametable
		RTS
		+
	CMP #$02
	BNE +
		LDA #$00
		STA sprite0BaseNametable
		RTS
		+
	CMP #$03
	BNE +
		LDA #$01
		STA sprite0BaseNametable
		RTS
		+
	RTS

;----------------------------------------------------------------
; Init scroll variables
;----------------------------------------------------------------
Function_InitScrollVars:
	;load nametable adress
	LDY roomNumber
	LDA doorsFlags
	LSR
	LSR
	LSR
	LSR
	ORA #%11110000
	AND roomsAttributes, Y
	STA roomsAttributes, Y
						
	LDY roomNumber
	STY index
	LDA (Level1RoomsTeleportLow), Y
	STA pointerLow
	LDA (Level1RoomsTeleportHi), Y
	STA pointerHi
				
	LDY scrollDirection
	LDA (pointerLow), Y
	STA roomNumber
	
	LDY roomNumber
	LDA roomsAttributes, Y
	AND #%10000000
	CMP #$00
	BNE +
		LDA Level1RoomsInfo, Y			
		STA roomsAttributes, Y
		+
	LDA roomsAttributes, Y
	LDX scrollDirection
	CPX #$00 ;up
	BNE +
		AND #%11111101
		JMP ++
		+
	CPX #$01 ;down
	BNE +
		AND #%11111110
		JMP ++
		+
	CPX #$02 ;left
	BNE +
		AND #%11110111
		JMP ++
		+
	CPX #$03 ;right
	BNE +
		AND #%11111011
		JMP ++
		+
	++
	STA roomsAttributes, Y
	ASL
	ASL
	ASL
	ASL
	STA doorsFlags
	
	LDY roomNumber
	LDA (Level1RoomsNameTablesLow), Y
	STA scroll2Low
	LDA (Level1RoomsNameTablesHi), Y
	STA scroll2Hi
		
	LDY roomNumber
	LDA Level1RoomsSpawnsNum, Y
	STA spawnNum
	
	
	LDA scrollDirection
	STA doorsTrigger
	INC doorsTrigger
	CMP #$00 ;up
	BNE +
		LDA #$00
		STA lengthLow
		LDA #$00
		STA lengthHi
		LDA baseNametable
		STA sprite0BaseNametable
		STA sprite0BaseNametableTemp
		CMP #$00
		BNE ++
			LDA #$28
			STA scrollHi
			STA baseNametableAddrHi
			JMP _END_SCROLL_DIR_UP_
			++
		CMP #$01
		BNE ++
			LDA #$20
			STA scrollHi
			STA baseNametableAddrHi
			LDA #$02
			STA baseNametable
			STA sprite0BaseNametable
			STA sprite0BaseNametableTemp
			LDA #$2B
			STA sprite0NtblHi			
			JMP _END_SCROLL_DIR_UP_
			++
		CMP #$02
		BNE ++
			LDA #$20
			STA scrollHi
			STA baseNametableAddrHi
			JMP _END_SCROLL_DIR_UP_
			++
		CMP #$03
		BNE ++
			LDA #$24
			STA scrollHi
			STA baseNametableAddrHi
			JMP _END_SCROLL_DIR_UP_
			++
			_END_SCROLL_DIR_UP_:
			LDA #$40
			STA scrollLow	
			LDA scrollHi
			CLC
			ADC #$03
			STA scrollHi
			
			LDA scroll2Low
			CLC
			ADC #$D0
			BCC ++
				INC scroll2Hi
				++
			STA scroll2Low
			JSR Function_sprite0BaseNametableChangeUpDown
			
			LDY #$01 ;down
			JSR Function_ConvertNametableToPlayerXY
			DEC savedPlayerY

			LDA #$03
			STA mirroringMMC1
			LDA TRUE
			STA changeRegisterFlag		
			RTS
		+
	CMP #$01 ;down
	BNE +
		LDA #$00
		STA lengthLow
		LDA #$00
		STA lengthHi
		LDA baseNametable
		STA sprite0BaseNametable
		STA sprite0BaseNametableTemp
		CMP #$00
		BNE ++
			LDA #$28
			STA scrollHi
			STA baseNametableAddrHi
			JMP _END_SCROLL_DIR_DOWN_
			++
		CMP #$01
		BNE ++
			LDA #$20
			STA scrollHi
			STA baseNametableAddrHi
			LDA #$02
			STA baseNametable
			STA sprite0BaseNametable
			STA sprite0BaseNametableTemp
			LDA #$2B
			STA sprite0NtblHi
			JMP _END_SCROLL_DIR_DOWN_
			++
		CMP #$02
		BNE ++
			LDA #$20
			STA scrollHi
			STA baseNametableAddrHi
			JMP _END_SCROLL_DIR_DOWN_
			++
		CMP #$03
		BNE ++
			LDA #$24
			STA scrollHi
			STA baseNametableAddrHi
			JMP _END_SCROLL_DIR_DOWN_
			++
			_END_SCROLL_DIR_DOWN_:
			LDA #$00
			STA scrollLow	
			JSR Function_sprite0BaseNametableChangeUpDown
			
			LDY #$00 ;up
			JSR Function_ConvertNametableToPlayerXY
			
			LDA #$03
			STA mirroringMMC1
			LDA TRUE
			STA changeRegisterFlag		
			RTS
		+
	CMP #$02 ;left
	BNE +
		LDA #$01
		STA lengthLow
		LDA #$00
		STA lengthHi
		LDA baseNametable
		STA sprite0BaseNametableTemp
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
			LDA #$20
			STA scrollHi
			STA baseNametableAddrHi
			LDA #$01
			STA baseNametable
			STA sprite0BaseNametable
			STA sprite0BaseNametableTemp
			LDA #$27
			STA sprite0NtblHi
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
			ADC #$0F
			BCC ++
				INC scroll2Hi
				++
			STA scroll2Low
			
			LDY #$03 ;right
			JSR Function_ConvertNametableToPlayerXY
			DEC savedPlayerX
			
			LDA #$02
			STA mirroringMMC1
			LDA TRUE
			STA changeRegisterFlag		
			RTS
		+			
	CMP #$03 ;right
	BNE +
		LDA #$00
		STA lengthLow
		LDA #$00
		STA lengthHi
		LDA baseNametable
		STA sprite0BaseNametableTemp
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
			LDA #$20
			STA scrollHi
			STA baseNametableAddrHi
			LDA #$01
			STA baseNametable
			STA sprite0BaseNametable
			STA sprite0BaseNametableTemp
			LDA #$27
			STA sprite0NtblHi
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
			
			LDY #$02 ;left
			JSR Function_ConvertNametableToPlayerXY
			INC savedPlayerX
			
			LDA #$02
			STA mirroringMMC1
			LDA TRUE
			STA changeRegisterFlag
			RTS
		+
		
	RTS
	
;----------------------------------------------------------------
; Scroll room left right
;----------------------------------------------------------------
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
		STA loadNewRoomTemp
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
		
		LDY roomNumber
		LDA Level1RoomsInfo, Y
		AND #%01000000
		CMP #$00
		BEQ ++
			LDA #$7E
			STA spriteX
			LDA #$4E
			STA spriteY
			JSR Function_LoadLevelBoss
			++
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
	_DRAW_LEVEL_COLUMN_LEFT_RIGHT_:
	LDA lengthLow
	CMP #$00
	BNE +
		LDY #$00
		LDA (pointer2Low), Y
		TAY
		LDA LEVEL_BLOCKS_1X1, Y
		STA ntblValues, X
		LDA pointerHi
		STA ntblAddrHi, X
		LDA pointerLow
		STA ntblAddrLow, X
		CLC
		ADC #$20
		STA pointerLow
		BCC ++
			INC pointerHi
			++
		INX
		LDY #$00
		LDA (pointer2Low), Y
		TAY
		LDA LEVEL_BLOCKS_2X1, Y
		STA ntblValues, X
		LDA pointerHi
		STA ntblAddrHi, X
		LDA pointerLow
		STA ntblAddrLow, X
		CLC
		ADC #$20
		STA pointerLow
		BCC ++
			INC pointerHi
			++
		+
	LDA lengthLow
	CMP #$01
	BNE +
		LDY #$00
		LDA (pointer2Low), Y
		TAY
		LDA LEVEL_BLOCKS_1X2, Y
		STA ntblValues, X
		LDA pointerHi
		STA ntblAddrHi, X
		LDA pointerLow
		STA ntblAddrLow, X
		CLC
		ADC #$20
		STA pointerLow
		BCC ++
			INC pointerHi
			++
		INX
		LDY #$00
		LDA (pointer2Low), Y
		TAY
		LDA LEVEL_BLOCKS_2X2, Y
		STA ntblValues, X
		LDA pointerHi
		STA ntblAddrHi, X
		LDA pointerLow
		STA ntblAddrLow, X
		CLC
		ADC #$20
		STA pointerLow
		BCC ++
			INC pointerHi
			++	
		+	
	LDA pointer2Low
	CLC
	ADC #$10
	STA pointer2Low
	BCC +
		INC pointer2Hi
		+
	INC ntblValuesLength
	INC ntblValuesLength
	INX
	CPX #$1E
	BEQ +
		JMP _DRAW_LEVEL_COLUMN_LEFT_RIGHT_
		+

	LDA lengthLow
	CMP #$00
	BNE ++
		INC lengthLow
		JMP +
		++
	LDA lengthLow
	CMP #$01
	BNE ++
		DEC lengthLow
		++
		+
	JSR Function_DrawSpawnDoorsLeftRight
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
			SBC #$08
			BCS +++
				DEC pointer2Hi
				+++
			SEC 
			SBC lengthHi
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
		LDA scrollDirection
		CMP #$03 ;right
		BNE ++
			LDA pointer2Low
			CLC
			ADC lengthHi
			BCC +++
				INC pointer2Hi
				+++
			STA pointer2Low
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
			BCC ++
				INC pointer2Hi
				++
			STA pointer2Low
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
		LDA lengthLow
		CMP #$01
		BNE ++
			LDA scroll2Low
			SEC 
			SBC #$01
			BCS +++
				DEC scroll2Hi
				+++
			STA scroll2Low
			JMP +
			++
		INC lengthHi
		+
	LDA scrollDirection
	CMP #$03 ;right
	BNE +
		INC scrollLow
		LDA lengthLow
		CMP #$00
		BNE ++
			LDA scroll2Low
			CLC 
			ADC #$01
			BCC +++
				INC scroll2Hi
				+++
			STA scroll2Low
			JMP +
			++
		INC lengthHi
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
	CMP ScrollXStatusBarKey, X ;add key
	BNE +		
		JSR UpdatePlayerKeys	
		+
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
			CPX #$03
		BNE -	
		LDA #$03
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
			LDA #$6E
			STA ntblAddrLowTemp, X
			LDA #$01
			STA ntblToAdd
			JSR ChangeNametableValuesManual
			++		
		+
	LDX scrollDirection
	LDA scrollX
	CMP ScrollXStatusBarPowerUp, X ;add powerup number
	BNE +
		JSR UpdatePlayerPowerUp
		+
	LDA scrollDirection
	CMP #$03
	BNE +
		JSR ChangeHiNametableAdress
		+
	LDA TRUE	
	STA loadNewRoom
	
	LDA #$D8
	STA splitScrollY
	RTS
	
;----------------------------------------------------------------
; Scroll room down
;----------------------------------------------------------------
Function_ScrollRoomDown:
	;load additional nametable
	LDY titleNtblValuesFlagsCurrent
	LDA titleNtblValuesFlagsCurrent
	CMP #$03
	BNE +
		JMP _DRAW_LEVEL_DOWN_EXTRA_
		+
		LDA scroll2Low
		STA pointer2Low
		LDA scroll2Hi
		STA pointer2Hi
		LDA scrollLow
		STA pointerLow
		LDA scrollHi
		STA pointerHi	
		LDA #$00
		STA ntblValuesLength

		LDA pointer2Low
		CLC 
		ADC ScrollYExtraNtblDownAdd, Y
		BCC ++
			INC pointer2Hi
			++
		STA pointer2Low
			
		LDA pointerLow
		CLC 
		ADC ScrollYExtraNtblLowAdd, Y
		BCC ++
			INC pointerHi
			++
		STA pointerLow
		LDA pointerHi
		CLC 
		ADC ScrollYExtraNtblHiAdd, Y
		STA pointerHi

		LDX #$00
		_DRAW_LEVEL_COLUMN_DOWN_EXTRA_:
		LDY #$00
		LDA (pointer2Low), Y
		TAY
		LDA LEVEL_BLOCKS_1X1, Y
		STA ntblValues, X
		LDA pointerHi
		STA ntblAddrHi, X
		LDA pointerLow
		STA ntblAddrLow, X
		INC pointerLow
		INX
		LDY #$00
		LDA (pointer2Low), Y
		TAY
		LDA LEVEL_BLOCKS_1X2, Y
		STA ntblValues, X
		LDA pointerHi
		STA ntblAddrHi, X
		LDA pointerLow
		STA ntblAddrLow, X
		INC pointerLow
		
		LDA pointer2Low
		CLC
		ADC #$01
		BCC ++
			INC pointer2Hi
			++
		STA pointer2Low
		INC ntblValuesLength
		INC ntblValuesLength
		INX
		CPX #$20
		BEQ ++
			JMP _DRAW_LEVEL_COLUMN_DOWN_EXTRA_
			++
		
		INC titleNtblValuesFlagsCurrent
		LDA TRUE
		STA ntblChangeFlag
		RTS
		_DRAW_LEVEL_DOWN_EXTRA_:
	;scroll screen	
	LDA #$00
	STA splitScrollY
	
	LDA scrollY
	CLC
	CMP #$70
	BCS +
		LDA splitScroll2Y
		CLC
		ADC #$04
		STA splitScroll2Y
		JMP ++
		+
	CLC
	CMP #$70
	BCC +
		LDA splitScroll2Y
		SEC
		SBC #$04
		STA splitScroll2Y
		JMP ++
		+
	++
	
	LDA TRUE
	STA sprite0Check
	
	LDA scrollY
	CMP #$00
	BNE +
		LDA #$00
		STA splitScroll2Y
		LDA FALSE
		STA sprite0Check
		+
	LDA scrollY
	CLC
	ADC #$08
	STA scrollY

	LDA scrollY
	CLC
	CMP #$70
	BCS +
		LDA sprite0Y
		SEC
		SBC #$08
		STA sprite0Y
		+	
	
	LDA scrollY
	CMP #$D8
	BNE +
		LDA FALSE	
		STA splitScroll2Y
		STA loadNewRoomTemp
		LDA TRUE
		STA scrollEndFlag
		JSR Function_ChangeBaseNameTableUpDown
		LDA #$D8
		STA splitScrollY
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
		
		LDY roomNumber
		LDA Level1RoomsInfo, Y
		AND #%01000000
		CMP #$00
		BEQ ++
			LDA #$7E
			STA spriteX
			LDA #$4E
			STA spriteY
			JSR Function_LoadLevelBoss
			++
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
	_DRAW_LEVEL_COLUMN_Y_DOWN_:
	LDA lengthLow
	CMP #$00
	BNE +
		LDY #$00
		LDA (pointer2Low), Y
		TAY
		LDA LEVEL_BLOCKS_1X1, Y
		STA ntblValues, X
		LDA pointerHi
		STA ntblAddrHi, X
		LDA pointerLow
		STA ntblAddrLow, X
		INC pointerLow
		INX
		LDY #$00
		LDA (pointer2Low), Y
		TAY
		LDA LEVEL_BLOCKS_1X2, Y
		STA ntblValues, X
		LDA pointerHi
		STA ntblAddrHi, X
		LDA pointerLow
		STA ntblAddrLow, X
		CLC
		ADC #$01
		STA pointerLow
		BCC ++
			INC pointerHi
			++
		+
	LDA lengthLow
	CMP #$01
	BNE +
		LDY #$00
		LDA (pointer2Low), Y
		TAY
		LDA LEVEL_BLOCKS_2X1, Y
		STA ntblValues, X
		LDA pointerHi
		STA ntblAddrHi, X
		LDA pointerLow
		STA ntblAddrLow, X
		INC pointerLow
		INX
		LDY #$00
		LDA (pointer2Low), Y
		TAY
		LDA LEVEL_BLOCKS_2X2, Y
		STA ntblValues, X
		LDA pointerHi
		STA ntblAddrHi, X
		LDA pointerLow
		STA ntblAddrLow, X
		CLC
		ADC #$01
		STA pointerLow
		BCC ++
			INC pointerHi
			++
		+	
	LDA pointer2Low
	CLC
	ADC #$01
	STA pointer2Low
	BCC +
		INC pointer2Hi
		+
	INC ntblValuesLength
	INC ntblValuesLength
	INX
	CPX #$20
	BEQ +
		JMP _DRAW_LEVEL_COLUMN_Y_DOWN_
		+

	LDA lengthLow
	CMP #$00
	BNE ++
		INC lengthLow
		JMP +
		++
	LDA lengthLow
	CMP #$01
	BNE ++
		DEC lengthLow
		++
		+
	JSR Function_DrawSpawnDoorsUpDown
	;load attribute table
	;attrtable 8x8
	;start at $23C0, $27C0, $2BC0, or $2FC0
	LDY titleAttrValuesFlagsCurrent
	LDA titleAttrValuesFlagsCurrent
	CMP #$08
	BEQ +
		LDA scrollDirection
		CMP #$01 ;down
		BNE ++
			LDA pointer2Low
			CLC 
			ADC ScrollYAttrNtblAdd, Y
			BCC +++
				INC pointer2Hi
				+++
			STA pointer2Low
			
			LDA pointerLow
			CLC 
			ADC ScrollYAttrNtblLowAdd, Y
			BCC +++
				INC pointerHi
				+++
			STA pointerLow
			LDA pointerHi
			CLC 
			ADC ScrollYAttrNtblHiAdd, Y
			STA pointerHi
			++
			-
			LDY #$00
			LDA (pointer2Low), Y ;digits offset in ppu
			STA ntblValues, X
			LDA pointerHi
			STA ntblAddrHi, X
			LDA pointerLow
			STA ntblAddrLow, X
			INC pointerLow
			LDA pointer2Low
			CLC
			ADC #$01
			BCC ++
				INC pointer2Hi
				++
			STA pointer2Low
			INC ntblValuesLength
			INX
			CPX #$28 ;40 - column + attribute column
		BNE -
		INC titleAttrValuesFlagsCurrent
		+

	LDA scrollY
	CLC
	CMP #$70
	BCS +
		JMP _SPRITE_0_HELPER_END_DOWN_
		+
	LDA scrollY
	CLC
	CMP #$78
	BCC +
		LDA #$D8
		STA splitScrollY
		+
	;add sprite 0 helper
	LDA flagNtblTable
	CMP TRUE
	BEQ +
		LDA #$80
		STA ntblValues, X
		LDA sprite0NtblHi
		STA ntblAddrHi, X
		LDA sprite0NtblLow
		STA ntblAddrLow, X
		INC ntblValuesLength
		INX
		+
	LDA flagNtblTable
	CMP FALSE
	BEQ +
		LDA #$80
		STA ntblValues, X
		LDA #$20
		STA ntblAddrHi, X
		LDA #$00
		STA ntblAddrLow, X
		INC ntblValuesLength
		INX
		+
	LDA FALSE
	STA flagNtblTable
	
	LDA sprite0NtblLow
	CLC
	ADC #$20
	BCC +
		INC sprite0NtblHi
		+
	STA sprite0NtblLow

	;check if need scroll swap
	LDA scrollY
	CMP #$70
	BNE +
		LDA #$CF
		STA sprite0Y
		LDA #$A0
		STA sprite0NtblLow
		JSR Function_sprite0BaseNametableOrigChangeUpDown
		LDA sprite0BaseNametable
		ASL
		ASL
		CLC
		ADC #$21
		STA sprite0NtblHi
		JSR Function_sprite0BaseNametableOrigChangeUpDown
		+
	LDA scrollY
	CMP #$78
	BNE +
		JSR Function_sprite0BaseNametableChangeUpDown
		+
	LDA ntblValues
	CMP #$80
	BNE +
		LDA #$BA
		STA ntblValues, X
		LDA sprite0NtblHi
		STA ntblAddrHi, X
		LDA sprite0NtblLow
		STA ntblAddrLow, X
		INC ntblValuesLength
		+
	LDA ntblValues
	CMP #$80
	BEQ +
		LDA #$80
		STA ntblValues, X
		LDA #$00
		STA ntblAddrHi, X
		LDA #$00
		STA ntblAddrLow, X
		INC ntblValuesLength
		LDA TRUE
		STA flagNtblTable
		+
	_SPRITE_0_HELPER_END_DOWN_:
	;sprite0Helper end
	
	LDA TRUE
	STA ntblChangeFlag
	
	LDA scrollLow
	CLC
	ADC #$20		
	BCC +
		INC scrollHi
		+
	STA scrollLow
	
	LDA lengthLow
	CMP #$00
	BNE +
		LDA scroll2Low
		CLC 
		ADC #$10
		BCC ++
			INC scroll2Hi
			++
		STA scroll2Low
		JMP ++
		+
		INC lengthHi	
		++
	
	LDA scrollY
	CMP #$D8
	BNE +
		LDA #$00
		STA scrollY
		RTS
		+
	
	LDA FALSE	
	STA loadNewRoom
	JSR ChangeHiNametableAdressUpDown
	
	LDX scrollDirection
	LDA scrollY
	CMP ScrollXStatusBarKey, X ;add key
	BNE +		
		JSR UpdatePlayerKeys	
		+
	LDX scrollDirection
	LDA scrollY
	CMP ScrollXStatusBarHealth, X ;add health
	BNE +		
		JSR UpdatePlayerHealth		
		+
	LDX scrollDirection
	LDA scrollY
	CMP ScrollXStatusBarCoins, X ;add coins
	BNE +					
		JSR UpdatePlayerCoins	
		+
	LDX scrollDirection
	LDA scrollY
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
			CPX #$03
		BNE -	
		LDA #$03
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
			LDA #$6E
			STA ntblAddrLowTemp, X
			LDA #$01
			STA ntblToAdd
			JSR ChangeNametableValuesManual
			++		
		+
	LDX scrollDirection
	LDA scrollY
	CMP ScrollXStatusBarPowerUp, X ;add powerup
	BNE +					
		JSR UpdatePlayerPowerUp	
		+
	JSR ChangeHiNametableAdressUpDown
	LDA TRUE	
	STA loadNewRoom

	LDA TRUE	
	STA loadNewRoomTemp

	RTS
	
;----------------------------------------------------------------
; Scroll room up
;----------------------------------------------------------------
Function_ScrollRoomUp:
	;load additional nametable
	LDY titleNtblValuesFlagsCurrent
	LDA titleNtblValuesFlagsCurrent
	CMP #$03
	BEQ +
		LDA scroll2Low
		STA pointer2Low
		LDA scroll2Hi
		STA pointer2Hi
		LDA scrollLow
		STA pointerLow
		LDA scrollHi
		STA pointerHi	
		LDA #$00
		STA ntblValuesLength

		LDA pointer2Low
		CLC 
		ADC ScrollYExtraNtblUpAdd, Y
		BCC ++
			INC pointer2Hi
			++
		STA pointer2Low
			
		LDA pointerLow
		CLC 
		ADC ScrollYExtraNtblAdd, Y
		BCC ++
			INC pointerHi
			++
		STA pointerLow

			-
			LDY #$00
			LDA titleNtblValuesFlagsCurrent
			CMP #$00
			BNE ++
				LDA #$80
				JMP +++
				++
			LDA (pointer2Low), Y ;digits offset in ppu
			+++
			STA ntblValues, X
			LDA pointerHi
			STA ntblAddrHi, X
			LDA pointerLow
			STA ntblAddrLow, X
			CLC
			ADC #$01
			STA pointerLow
			BCC ++
				INC pointerHi
				++
			LDA pointer2Low
			CLC
			ADC #$01
			STA pointer2Low
			BCC ++
				INC pointer2Hi
				++
			INC ntblValuesLength
			INX
			CPX #$20 ;32 - column
		BNE -
		
		INC titleNtblValuesFlagsCurrent
		LDA TRUE
		STA ntblChangeFlag
		RTS
		+
	
	;scroll screen		
	LDA TRUE
	STA sprite0Check
	LDA #$00
	STA splitScrollY
	LDA scrollY
	CMP #$00
	BNE +
		LDA splitScroll2Y
		CMP #$00
		BNE ++
			JSR Function_ChangeBaseNameTableUpDown
			LDA #$00
			STA splitScroll2Y
			LDA FALSE
			STA sprite0Check
			LDA #$D8
			STA scrollY
			++
		+
	LDA scrollY
	SEC
	SBC #$08
	STA scrollY

	LDA scrollY
	CLC
	CMP #$70
	BCS +
		LDA sprite0Y
		CLC
		ADC #$08
		STA sprite0Y
		+	
	
	LDA scrollY
	CLC
	CMP #$68
	BCS +
		LDA splitScroll2Y
		SEC
		SBC #$04
		STA splitScroll2Y
		JMP ++
		+
	CLC
	CMP #$68
	BCC +
		LDA splitScroll2Y
		CLC
		ADC #$04
		STA splitScroll2Y
		JMP ++
		+
	++
	LDA scrollY
	CMP #$F8
	BNE +
		LDA FALSE	
		STA splitScroll2Y
		STA loadNewRoomTemp
		LDA TRUE
		STA scrollEndFlag
		LDA #$D8
		STA splitScrollY
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
		
		LDY roomNumber
		LDA Level1RoomsInfo, Y
		AND #%01000000
		CMP #$00
		BEQ ++
			LDA #$7E
			STA spriteX
			LDA #$4E
			STA spriteY
			JSR Function_LoadLevelBoss
			++
			
		LDA #$00
		STA scrollY
		LDA #$CF
		STA sprite0Y
		RTS
		+
	LDA $1005	
	;load nametable
	;30 height
	;32 width	
	LDA #$00
	STA ntblValuesLength
	
	LDA scroll2Low
	STA pointer2Low
	LDA scroll2Hi
	STA pointer2Hi
	LDA scrollLow
	STA pointerLow
	LDA scrollHi
	STA pointerHi

	LDX #$00
	_DRAW_LEVEL_COLUMN_Y_UP_:
	LDA lengthLow
	CMP #$00
	BNE +
		LDY #$00
		LDA (pointer2Low), Y
		TAY
		LDA LEVEL_BLOCKS_1X1, Y
		STA ntblValues, X
		LDA pointerHi
		STA ntblAddrHi, X
		LDA pointerLow
		STA ntblAddrLow, X
		INC pointerLow
		INX
		LDY #$00
		LDA (pointer2Low), Y
		TAY
		LDA LEVEL_BLOCKS_1X2, Y
		STA ntblValues, X
		LDA pointerHi
		STA ntblAddrHi, X
		LDA pointerLow
		STA ntblAddrLow, X
		CLC
		ADC #$01
		STA pointerLow
		BCC ++
			INC pointerHi
			++
		+
	LDA lengthLow
	CMP #$01
	BNE +
		LDY #$00
		LDA (pointer2Low), Y
		TAY
		LDA LEVEL_BLOCKS_2X1, Y
		STA ntblValues, X
		LDA pointerHi
		STA ntblAddrHi, X
		LDA pointerLow
		STA ntblAddrLow, X
		INC pointerLow
		INX
		LDY #$00
		LDA (pointer2Low), Y
		TAY
		LDA LEVEL_BLOCKS_2X2, Y
		STA ntblValues, X
		LDA pointerHi
		STA ntblAddrHi, X
		LDA pointerLow
		STA ntblAddrLow, X
		CLC
		ADC #$01
		STA pointerLow
		BCC ++
			INC pointerHi
			++
		+	
	LDA pointer2Low
	CLC
	ADC #$01
	STA pointer2Low
	BCC +
		INC pointer2Hi
		+
	INC ntblValuesLength
	INC ntblValuesLength
	INX
	CPX #$20
	BEQ +
		JMP _DRAW_LEVEL_COLUMN_Y_UP_
		+

	LDA lengthLow
	CMP #$00
	BNE ++
		INC lengthLow
		JMP +
		++
	LDA lengthLow
	CMP #$01
	BNE ++
		DEC lengthLow
		++
		+
	JSR Function_DrawSpawnDoorsUpDown
	;load extra table
	LDA scrollY
	CLC
	CMP #$70
	BCS +
	LDY titleAttrValuesFlagsCurrent
	LDA titleAttrValuesFlagsCurrent
	CMP #$08
	BEQ +	
		LDA pointerLow
		CLC 
		ADC #ScrollYExtraNtblLowUpAdd, Y
		BCC ++
			INC pointerHi
			++
		STA pointerLow
		LDA pointerHi
		CLC 
		ADC #ScrollYExtraNtblHiUpAdd, Y
		STA pointerHi
			-
			LDY #$00
			LDA #$80 ;clear zero tile
			STA ntblValues, X
			LDA pointerHi
			STA ntblAddrHi, X
			LDA pointerLow
			STA ntblAddrLow, X
			CLC
			ADC #$01
			STA pointerLow
			BCC ++
				INC pointerHi
				++
			INC ntblValuesLength
			INX
			CPX #$28 ;40 - column + extra
		BNE -
		INC titleAttrValuesFlagsCurrent
		+
	LDA scrollY
	CLC
	CMP #$70
	BCS +
		JMP _SPRITE_0_HELPER_END_UP_
		+
	LDA scrollY
	CLC
	CMP #$70
	BCC +
		LDA #$D8
		STA splitScrollY
		+
	;add sprite 0 helper

	LDA #$80
	STA ntblValues, X
	LDA sprite0NtblHi
	STA ntblAddrHi, X
	LDA sprite0NtblLow
	STA ntblAddrLow, X
	INC ntblValuesLength
	INX

	LDA sprite0NtblLow
	SEC
	SBC #$20
	BCS +
		DEC sprite0NtblHi
		+
	STA sprite0NtblLow

	;check if need scroll swap
	LDA scrollY
	CMP #$D0
	BNE +
		LDA FALSE
		STA sprite0Check
		JSR Function_sprite0BaseNametableChangeUpDown
		+
	LDA scrollY
	CMP #$70
	BNE +
		LDA #$5F
		STA sprite0Y
		LDA #$40
		STA sprite0NtblLow
		JSR Function_sprite0BaseNametableOrigChangeUpDown
		LDA sprite0BaseNametable
		ASL
		ASL
		CLC
		ADC #$23
		STA sprite0NtblHi
		+
	
	LDY index
	LDA Level1RoomsDoorsHiLow, Y
	STA pointerLow
	LDA Level1RoomsDoorsHiHi, Y
	STA pointerHi	
	LDY #$02
	LDA (pointerLow), Y
	STA addressHi

	LDY index
	LDA Level1RoomsDoorsLowLow, Y
	STA pointerLow
	LDA Level1RoomsDoorsLowHi, Y
	STA pointerHi	
	LDY #$02
	LDA (pointerLow), Y
	STA addressLow

	LDA sprite0NtblLow
	CMP addressLow
	BNE +
		LDA sprite0NtblHi
		AND #$1F
		CMP addressHi
		BNE +
			JMP ++
		+
	LDA addressLow
	CLC
	ADC #$20
	CMP sprite0NtblLow
	BNE +
		LDA sprite0NtblHi
		AND #$1F
		CMP addressHi
		BNE +
			++
			LDA #$80
			STA ntblValues, X
			LDA #$00
			STA ntblAddrHi, X
			LDA #$00
			STA ntblAddrLow, X
			INC ntblValuesLength
			LDA TRUE
			STA flagNtblTable
			JMP _SPRITE_0_HELPER_END_UP_
		+
	LDA #$BA
	STA ntblValues, X
	LDA sprite0NtblHi
	STA ntblAddrHi, X
	LDA sprite0NtblLow
	STA ntblAddrLow, X
	INC ntblValuesLength
	_SPRITE_0_HELPER_END_UP_:
	;sprite0Helper end
	
	LDA scrollLow
	SEC
	SBC #$20		
	BCS +
		DEC scrollHi
		+
	STA scrollLow
	
	LDA lengthLow
	CMP #$01
	BNE +
		LDA scroll2Low
		SEC 
		SBC #$10
		BCS ++
			DEC scroll2Hi
			++
		STA scroll2Low
		JMP ++
		+
		INC lengthHi	
		++
		
	LDA TRUE
	STA ntblChangeFlag
	
	LDA scrollY
	CMP #$F8
	BNE +
		LDA #$00
		STA scrollY
		LDA #$CF
		STA sprite0Y
		RTS
		+
	
	LDA FALSE	
	STA loadNewRoom
	;JSR ChangeHiNametableAdressUpDown
	LDX scrollDirection
	LDA scrollY
	CMP ScrollXStatusBarKey, X ;add health
	BNE +		
		JSR UpdatePlayerKeys		
		+
	LDX scrollDirection
	LDA scrollY
	CMP ScrollXStatusBarHealth, X ;add health
	BNE +		
		JSR UpdatePlayerHealth		
		+
	LDX scrollDirection
	LDA scrollY
	CMP ScrollXStatusBarCoins, X ;add coins
	BNE +					
		JSR UpdatePlayerCoins	
		+
	LDX scrollDirection
	LDA scrollY
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
			CPX #$03
		BNE -	
		LDA #$03
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
			LDA #$6E
			STA ntblAddrLowTemp, X
			LDA #$01
			STA ntblToAdd
			JSR ChangeNametableValuesManual
			++		
		+
	LDX scrollDirection
	LDA scrollY
	CMP ScrollXStatusBarPowerUp, X ;add powerup
	BNE +					
		JSR UpdatePlayerPowerUp	
		+
	;JSR ChangeHiNametableAdressUpDown
	LDA TRUE	
	STA loadNewRoom
		
	LDA TRUE	
	STA loadNewRoomTemp

	RTS

;----------------------------------------------------------------
; Change Nbtl to X Y
;----------------------------------------------------------------
Function_ConvertNametableToPlayerXY:
	LDA #$F8
	STA savedPlayerX
	LDA #$B8
	STA savedPlayerY
	
	LDX roomNumber
	LDA Level1RoomsDoorsHiLow, X
	STA pointerLow
	LDA Level1RoomsDoorsHiHi, X
	STA pointerHi	
	LDA (pointerLow), Y
	STA addressHi
	LDA Level1RoomsDoorsLowLow, X
	STA pointerLow
	LDA Level1RoomsDoorsLowHi, X
	STA pointerHi	
	LDA (pointerLow), Y
	STA addressLow
	
	AND #$1F
	STA counter
	INC counter
	LDX #$00
	LDA savedPlayerX
		-
		CLC
		ADC #$08
		INX
		CPX counter
	BNE -	
	STA savedPlayerX
	STA playerX
	
	LDA addressHi
	STA counter
	INC counter
	LDX #$00
	LDA savedPlayerY
		-
		CLC
		ADC #$40
		INX
		CPX counter
	BNE -	
	STA savedPlayerY
	
	LDA addressLow
	AND #$E0
	LSR
	LSR
	LSR
	LSR
	LSR
	STA counter
	INC counter
	LDX #$00
	LDA savedPlayerY
		-
		CLC
		ADC #$08
		INX
		CPX counter
	BNE -	
	STA savedPlayerY
	STA playerY
	
	RTS

;----------------------------------------------------------------
; Update doors state
;----------------------------------------------------------------
Function_UpdateDoors:
	;check if need load
	LDA loadNewRoom
	CMP TRUE
	BNE +
		RTS
		+
	LDY roomNumber
	LDA Level1DoorsMask, Y
	AND doorsFlags
	STA doorsFlags
	AND #%00000001
	CMP #%00000001 ;up door
	BNE +
		LDY #$00	
		JSR Function_InitDoorPos
		LDA #<(DoorFramesUp)
		STA pointerLow
		LDA #>(DoorFramesUp)
		STA pointerHi
		
		LDA doorsFlags
		AND #%00010000
		CMP #$00 
		BNE ++
			;open door
			LDA doorsTimer
			CMP #$01
			BNE +++
				LDY #$04
				JSR Function_DrawDoor
				+++
			CMP #$02
			BNE +++
				LDY #$00
				JSR Function_DrawDoor
				+++	
			JMP +
			++
		;close door
		LDA doorsTimer
		CMP #$01
		BNE +++
			LDY #$04
			JSR Function_DrawDoor
			+++
		CMP #$02
		BNE +++
			LDY #$08
			JSR Function_DrawDoor
			+++	
		+
	LDA doorsFlags
	AND #%00000010
	CMP #%00000010 ;down door
	BNE +
		LDY #$01	
		JSR Function_InitDoorPos
		LDA #<(DoorFramesDown)
		STA pointerLow
		LDA #>(DoorFramesDown)
		STA pointerHi
		
		LDA doorsFlags
		AND #%00100000
		CMP #$00 
		BNE ++
			;open door
			LDA doorsTimer
			CMP #$01
			BNE +++
				LDY #$04
				JSR Function_DrawDoor
				+++
			CMP #$02
			BNE +++
				LDY #$00
				JSR Function_DrawDoor
				+++	
			JMP +
			++
		;close door
		LDA doorsTimer
		CMP #$01
		BNE +++
			LDY #$04
			JSR Function_DrawDoor
			+++
		CMP #$02
		BNE +++
			LDY #$08
			JSR Function_DrawDoor
			+++	
		+
	LDA doorsFlags
	AND #%00000100
	CMP #%00000100 ;left door
	BNE +
		LDY #$02	
		JSR Function_InitDoorPos
		LDA #<(DoorFramesLeft)
		STA pointerLow
		LDA #>(DoorFramesLeft)
		STA pointerHi
		
		LDA doorsFlags
		AND #%01000000
		CMP #$00 
		BNE ++
			;open door
			LDA doorsTimer
			CMP #$01
			BNE +++
				LDY #$04
				JSR Function_DrawDoor
				+++
			CMP #$02
			BNE +++
				LDY #$00
				JSR Function_DrawDoor
				+++	
			JMP +
			++
		;close door
		LDA doorsTimer
		CMP #$01
		BNE +++
			LDY #$04
			JSR Function_DrawDoor
			+++
		CMP #$02
		BNE +++
			LDY #$08
			JSR Function_DrawDoor
			+++	
		+
	LDA doorsFlags
	AND #%00001000
	CMP #%00001000 ;right door
	BNE +
		LDY #$03	
		JSR Function_InitDoorPos
		LDA #<(DoorFramesRight)
		STA pointerLow
		LDA #>(DoorFramesRight)
		STA pointerHi
		
		LDA doorsFlags
		AND #%10000000
		CMP #$00 
		BNE ++
			;open door
			LDA doorsTimer
			CMP #$01
			BNE +++
				LDY #$04
				JSR Function_DrawDoor
				+++
			CMP #$02
			BNE +++
				LDY #$00
				JSR Function_DrawDoor
				+++	
			JMP +
			++
		;close door
		LDA doorsTimer
		CMP #$01
		BNE +++
			LDY #$04
			JSR Function_DrawDoor
			+++
		CMP #$02
		BNE +++
			LDY #$08
			JSR Function_DrawDoor
			+++	
		+
	LDA doorsTimer
	CMP #$02
	BNE +
		LDA doorsFlags
		AND #%11110000
		STA doorsFlags
		LDA #$00
		STA doorsTimer
		+
	RTS
	
;----------------------------------------------------------------
; Init door position
;----------------------------------------------------------------
Function_InitDoorPos:
	LDX roomNumber	
	LDA Level1RoomsDoorsHiLow, X
	STA pointerLow
	LDA Level1RoomsDoorsHiHi, X
	STA pointerHi	
	LDA (pointerLow), Y
	CLC
	ADC baseNametableAddrHi
	STA addressHi
		
	LDA Level1RoomsDoorsLowLow, X
	STA pointerLow
	LDA Level1RoomsDoorsLowHi, X
	STA pointerHi	
	LDA (pointerLow), Y
	STA addressLow
		
	RTS
	
;----------------------------------------------------------------
; Draw doors
;----------------------------------------------------------------
Function_DrawDoor:
	LDA #$04
	STA ntblToAdd	
	LDX #$00
	
	LDA (pointerLow), Y	
	STA ntblValuesTemp, X
	LDA addressHi
	STA ntblAddrHiTemp, X
	LDA addressLow
	STA ntblAddrLowTemp, X
	INC addressLow
	INX
	INY
		
	LDA (pointerLow), Y			
	STA ntblValuesTemp, X
	LDA addressHi
	STA ntblAddrHiTemp, X
	LDA addressLow
	STA ntblAddrLowTemp, X
	CLC
	ADC #$20
	STA addressLow
	BCC +
		INC addressHi
		+
	DEC addressLow
	INX
	INY
		
	LDA (pointerLow), Y			
	STA ntblValuesTemp, X
	LDA addressHi
	STA ntblAddrHiTemp, X
	LDA addressLow
	STA ntblAddrLowTemp, X
	INC addressLow
	INX
	INY
		
	LDA (pointerLow), Y			
	STA ntblValuesTemp, X
	LDA addressHi
	STA ntblAddrHiTemp, X
	LDA addressLow
	STA ntblAddrLowTemp, X
		
	JSR ChangeNametableValuesManual	
	RTS
	
;----------------------------------------------------------------
; Invert low byte
;----------------------------------------------------------------
Function_InvertByteLow:
	LDA value
	AND #%00000001
	CMP #%00000001
	BEQ +
		LDA value
		CLC
		ADC #%00000001
		STA value
		JMP ++
		+
		LDA value
		SEC
		SBC #%00000001
		STA value
		++
	LDA value
	AND #%00000010
	CMP #%00000010
	BEQ +
		LDA value
		CLC
		ADC #%00000010
		STA value
		JMP ++
		+
		LDA value
		SEC
		SBC #%00000010
		STA value
		++
	LDA value
	AND #%00000100
	CMP #%00000100
	BEQ +
		LDA value
		CLC
		ADC #%00000100
		STA value
		JMP ++
		+
		LDA value
		SEC
		SBC #%00000100
		STA value
		++
	LDA value
	AND #%00001000
	CMP #%00001000
	BEQ +
		LDA value
		CLC
		ADC #%00001000
		STA value
		JMP ++
		+
		LDA value
		SEC
		SBC #%00001000
		STA value
		++
	RTS
	
;----------------------------------------------------------------
; Draw key door
;----------------------------------------------------------------
Function_DrawKeyDoor:
	LDA #$08
	STA temp
	LDA #$04
	STA counter
	
	LDY roomNumber
	LDA Level1RoomsDoorsLowLow, Y
	STA addressLow
	LDA Level1RoomsDoorsLowHi, Y
	STA addressHi
	LDY #$00
		-
		LDA doorsFlags
		AND DoorsMask, Y
		CMP #$00
		BNE +
			JMP +++
			+
		LDA #$00
		STA value	
		LDA (addressLow), Y ;read door x
		CMP pointerLow
		BNE +
			_DOOR_DRAW_CHECK_HIADDR_:
			TYA
			PHA
			LDY roomNumber
			LDA Level1RoomsDoorsHiLow, Y
			STA addressLow
			LDA Level1RoomsDoorsHiHi, Y
			STA addressHi
			PLA
			TAY
			LDA (addressLow), Y ;read door y
			CLC
			ADC baseNametableAddrHi
			CMP pointerHi
			BNE ++
				STY bit16Low
				LDA value
				CLC
				ADC temp
				TAY
				LDA DoorFramesUp, Y		
				LDY bit16Low
				STA ntblValues, X
				JMP _DOOR_DRAW_END_
				++
			+
		CLC
		ADC #$01
		CMP pointerLow
		BNE +
			LDA #$01
			STA value
			JMP _DOOR_DRAW_CHECK_HIADDR_
			+
		CLC
		ADC #$1F
		CMP pointerLow
		BNE +
			LDA #$02
			STA value
			JMP _DOOR_DRAW_CHECK_HIADDR_
			+
		CLC
		ADC #$01
		CMP pointerLow
		BNE +
			LDA #$03
			STA value
			JMP _DOOR_DRAW_CHECK_HIADDR_
			+
		+++
		LDA temp 
		CLC
		ADC #$0C
		STA temp
		INY
		CPY counter
	BNE -
	_DOOR_DRAW_END_:		
	RTS

;----------------------------------------------------------------
; Drawn doors and spawn up down
;----------------------------------------------------------------
Function_DrawSpawnDoorsUpDown:
	TXA
	PHA
	LDA spawnNum
	CMP #$00
	BNE +
		JMP _SPAWNS_DRAW_END_
		+
	LDY #$00
		-
		LDX roomNumber
		LDA Level1SpawnsYNameTableLow, X
		STA addressLow
		LDA Level1SpawnsYNameTableHi, X
		STA addressHi
		LDA (addressLow), Y ;read spawn ntbl hi
		STA bit16Hi
				
		LDA Level1SpawnsXNameTableLow, X
		STA addressLow
		LDA Level1SpawnsXNameTableHi, X
		STA addressHi
		LDA (addressLow), Y ;read spawn ntbl low
		STA bit16Low
		CLC
		CMP ntblAddrLow
		BCC +
			LDX #$1F
			CLC
			CMP ntblAddrLow, X
			BCS ++
				LDA ntblAddrHi
				AND #%00000011
				CMP bit16Hi
				BNE +++
					LDA bit16Low
					AND #%00011111
					TAX
					LDA #$25
					STA ntblValues, X
					INX
					STA ntblValues, X
					+++
				++
			+
		LDA bit16Low
		CLC
		ADC #$20
		BCC +
			INC bit16Hi
			+
		CLC
		CMP ntblAddrLow
		BCC +
			LDX #$1F
			CLC
			CMP ntblAddrLow, X
			BCS ++
				LDA ntblAddrHi
				AND #%00000011
				CMP bit16Hi
				BNE +++
					LDA bit16Low
					AND #%00011111
					TAX
					LDA #$35
					STA ntblValues, X
					INX
					STA ntblValues, X
					+++
				++
			+
		INY
		CPY spawnNum
	BNE -
	_SPAWNS_DRAW_END_:
	LDA #$08
	STA temp
	
	LDA #$04
	STA counter
	LDY #$00
		_DOORS_DRAW_START_:
		LDX roomNumber
		LDA Level1RoomsDoorsHiLow, X
		STA addressLow
		LDA Level1RoomsDoorsHiHi, X
		STA addressHi
		LDA (addressLow), Y ;read spawn ntbl hi
		STA bit16Hi
				
		LDA Level1RoomsDoorsLowLow, X
		STA addressLow
		LDA Level1RoomsDoorsLowHi, X
		STA addressHi
		LDA (addressLow), Y ;read spawn ntbl low
		STA bit16Low
		CLC
		CMP ntblAddrLow
		BCC +
			LDX #$1F
			CLC
			CMP ntblAddrLow, X
			BCS ++
				LDA ntblAddrHi
				AND #%00000011
				CMP bit16Hi
				BNE +++
					LDA bit16Low
					AND #%00011111
					TAX
					LDA doorsFlags
					AND DoorsMask, Y
					CMP #$00
					BEQ ++++
						TYA
						PHA
						LDY temp
						LDA DoorFramesUp, Y	
						STA ntblValues, X
						INX
						INY
						LDA DoorFramesUp, Y	
						STA ntblValues, X
						PLA
						TAY
						++++
					+++
				++
			+
		LDA bit16Low
		CLC
		ADC #$20
		BCC +
			INC bit16Hi
			+
		CLC
		CMP ntblAddrLow
		BCC +
			LDX #$1F
			CLC
			CMP ntblAddrLow, X
			BCS ++
				LDA ntblAddrHi
				AND #%00000011
				CMP bit16Hi
				BNE +++
					LDA bit16Low
					AND #%00011111
					TAX
					LDA doorsFlags
					AND DoorsMask, Y
					CMP #$00
					BEQ ++++
						TYA
						PHA
						LDY temp
						INY
						INY
						LDA DoorFramesUp, Y	
						STA ntblValues, X
						INX
						INY
						LDA DoorFramesUp, Y	
						STA ntblValues, X
						PLA
						TAY
						++++
					+++
				++
			+
		LDA temp 
		CLC
		ADC #$0C
		STA temp
		INY
		CPY counter
	BEQ +
		JMP _DOORS_DRAW_START_
		+
	PLA
	TAX
	RTS

;----------------------------------------------------------------
; Draw doors and spawns left right
;----------------------------------------------------------------
Function_DrawSpawnDoorsLeftRight:
	TXA
	PHA
	LDA spawnNum
	CMP #$00
	BNE +
		JMP _SPAWNS_DRAW_LEFT_RIGHT_END_
		+
	LDY #$00
		_SPAWNS_DRAW_LEFT_RIGHT_START_
		LDA #$00
		STA value
		LDX roomNumber
		LDA Level1SpawnsYNameTableLow, X
		STA addressLow
		LDA Level1SpawnsYNameTableHi, X
		STA addressHi
		LDA (addressLow), Y ;read spawn ntbl hi
		STA bit16Hi
	
		LDA Level1SpawnsXNameTableLow, X
		STA addressLow
		LDA Level1SpawnsXNameTableHi, X
		STA addressHi
		LDA (addressLow), Y ;read spawn ntbl low
		STA bit16Low
		AND #%00011111
		CMP ntblAddrLow
		BNE +
			LDA bit16Hi
			CMP #$01
			BNE ++
				LDA #$08
				STA value
				++
			CMP #$02
			BNE ++
				LDA #$10
				STA value
				++
			CMP #$03
			BNE ++
				LDA #$18
				STA value
				++
			LDA bit16Low
			LSR
			LSR
			LSR
			LSR
			LSR
			CLC
			ADC value
			TAX
			LDA #$25
			STA ntblValues, X
			INX
			LDA #$35
			STA ntblValues, X
			+
		LDA bit16Low
		CLC
		ADC #$01
		BCC +
			INC bit16Hi
			+
		STA bit16Low
		AND #%00011111
		CMP ntblAddrLow
		BNE +
			LDA bit16Hi
			CMP #$01
			BNE ++
				LDA #$08
				STA value
				++
			CMP #$02
			BNE ++
				LDA #$10
				STA value
				++
			CMP #$03
			BNE ++
				LDA #$18
				STA value
				++
			LDA bit16Low
			LSR
			LSR
			LSR
			LSR
			LSR
			CLC
			ADC value
			TAX
			LDA #$25
			STA ntblValues, X
			INX
			LDA #$35
			STA ntblValues, X
			+
		INY
		CPY spawnNum
	BEQ +
		JMP _SPAWNS_DRAW_LEFT_RIGHT_START_
		+
	_SPAWNS_DRAW_LEFT_RIGHT_END_:
	LDA #$08
	STA temp
	
	LDA #$04
	STA counter
	LDY #$00
		_DOORS_DRAW_LEFT_RIGHT_START_:
		LDX roomNumber
		LDA Level1RoomsDoorsHiLow, X
		STA addressLow
		LDA Level1RoomsDoorsHiHi, X
		STA addressHi
		LDA (addressLow), Y ;read spawn ntbl hi
		STA bit16Hi
				
		LDA Level1RoomsDoorsLowLow, X
		STA addressLow
		LDA Level1RoomsDoorsLowHi, X
		STA addressHi
		LDA (addressLow), Y ;read spawn ntbl low
		STA bit16Low
		AND #%00011111
		CMP ntblAddrLow
		BNE +
			LDA #$00
			STA value
			LDA doorsFlags
			AND DoorsMask, Y
			CMP #$00
			BEQ ++++
				LDA bit16Hi
				CMP #$01
				BNE ++
					LDA #$08
					STA value
					++
				CMP #$02
				BNE ++
					LDA #$10
					STA value
					++
				CMP #$03
				BNE ++
					LDA #$18
					STA value
					++
				LDA bit16Low
				LSR
				LSR
				LSR
				LSR
				LSR
				CLC
				ADC value
				TAX
				TYA
				PHA
				LDY temp
				LDA DoorFramesUp, Y	
				STA ntblValues, X
				INX
				INY
				INY
				LDA DoorFramesUp, Y	
				STA ntblValues, X
				PLA
				TAY
				++++
			+
		LDA bit16Low
		CLC
		ADC #$01
		BCC +
			INC bit16Hi
			+
		STA bit16Low
		AND #%00011111
		CMP ntblAddrLow
		BNE +
			LDA #$00
			STA value
			LDA doorsFlags
			AND DoorsMask, Y
			CMP #$00
			BEQ ++++
				LDA bit16Hi
				CMP #$01
				BNE ++
					LDA #$08
					STA value
					++
				CMP #$02
				BNE ++
					LDA #$10
					STA value
					++
				CMP #$03
				BNE ++
					LDA #$18
					STA value
					++
				LDA bit16Low
				LSR
				LSR
				LSR
				LSR
				LSR
				CLC
				ADC value
				TAX
				TYA
				PHA
				LDY temp
				INY
				LDA DoorFramesUp, Y	
				STA ntblValues, X
				INX
				INY
				INY
				LDA DoorFramesUp, Y	
				STA ntblValues, X
				PLA
				TAY
				++++
			+
		LDA temp 
		CLC
		ADC #$0C
		STA temp
		INY
		CPY counter
	BEQ +
		JMP _DOORS_DRAW_LEFT_RIGHT_START_
		+
	PLA
	TAX
	RTS

;----------------------------------------------------------------
; Spawn room item
;----------------------------------------------------------------
Function_SpawnRoomItem:
	;Load sprites coin
	LDA Level1RoomsSpawItem, Y ;type
	STA spriteType
	LDA Level1RoomsSpawItemX, Y ;x
	STA spriteX
	LDA Level1RoomsSpawItemY, Y ;y
	STA spriteY
	LDA #$00 ;anim
	STA spriteStateAnim
	LDA #$01 ;action
	STA spriteStateAction
	LDA #$00 ;timer
	STA spriteTimerAnim
	STA spriteTimerAction
	JSR SpritesAdd
	LDA TRUE
	STA alreadySpawnItem
	RTS
	
;----------------------------------------------------------------
; Load Boss
;----------------------------------------------------------------
Function_LoadLevelBoss:
	LDA $1004
	LDA #$0C ;level 1 boss
	STA spriteType
	
	LDX #$00
	-
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
	
	LDA spriteX
	CLC
	ADC Level1BossAddOffsetX, X
	STA spriteX
	
	LDA spriteY
	CLC
	ADC Level1BossAddOffsetY, X
	STA spriteY
	
	INC spriteType

	INX
	CPX #$03
	BNE -
	
	RTS
	