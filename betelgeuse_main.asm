;----------------------------------------------------------------
; Definitions
;----------------------------------------------------------------
INCLUDE "betelgeuse_defines.asm"

;----------------------------------------------------------------
; Constants
;----------------------------------------------------------------
PRG_COUNT = 4 	  ;1 = 16KB, 2 = 32KB
CHR_COUNT = 2 	  ;1 = 8KB, 2 = 16KB, 4 = 32KB
MIRRORING = %0000 ;%0000 = horizontal, %0001 = vertical, %1000 = four-screen

;----------------------------------------------------------------
; Variables
;----------------------------------------------------------------
	ENUM $0000
	;NOTE: declare variables using the DSB and DSW directives, like this:
	;MyVariable0 DSB 1
	;MyVariable1 DSB 3
	
	;NOTE: you can also split the variable declarations into individual pages, like this:
	;ENUM $0100
	;ENDE
	;ENUM $0200
	;ENDE
	
	pointerLow	  DSB 1
	pointerHi 	  DSB 1
	pointer2Low   DSB 1
	pointer2Hi    DSB 1
	value		  DSB 1
	vblankFlag	  DSB 1
	addressLow	  DSB 1
	addressHi	  DSB 1
	lengthLow	  DSB 1
	lengthHi	  DSB 1
	gameState 	  DSB 1
	gameStateOld  DSB 1
	counter		  DSB 1
	temp		  DSB 1
	ppuEnableFlag DSB 1
	index		  DSB 1
	colTimer      DSB 1
	
	roomNumber    DSB 1
	randomNum     DSB 1
	
	globalTimerLow DSB 1
	globalTimerHi  DSB 1
	
	buttonsP1 	 DSB 1
	buttonsP1Old DSB 1
	buttonsP2 	 DSB 1
	buttonsP2Old DSB 1
	buttonsTemp  DSB 1
	
	bit16Low DSB 1
	bit16Hi  DSB 1
	
	timerTitleBGColorChangeLow DSB 1
	timerTitleBGColorChangeHi  DSB 1
	timerTitleAttrChange 	   DSB 1
	
	titleBGColorsFlagsCurrent  	 DSB 1
	titleAttrValuesFlagsCurrent  DSB 1
	titleAttrValuesFlagsPeriod   DSB 1
	titleNtblValuesFlagsCurrent  DSB 1
	titleNtblValuesFlagsPeriod   DSB 1
	
	flagAttrTable DSB 1
	flagNtblTable DSB 1
	
	spritesDrawDirection DSB 1
	spritesDrawOffset1	 DSB 1
	spritesDrawOffset2	 DSB 1
	
	spriteDirection DSB 1
	spriteNewX DSB 1
	spriteNewY DSB 1
	spriteOldX DSB 1
	spriteOldY DSB 1
	spriteTypeTemp DSB 1
	
	bulletsTime   		DSB 1
	;clear this on enter new room - 41
	bulletsNum    		DSB 1
	bulletsTimer  		DSB 1
	bulletsType   		DSB 1
	
	spawnGlobalTimerLow DSB 1
	spawnGlobalTimerHi  DSB 1
	spawnEnemyNum       DSB 1
	spawnNum            DSB 1
	spawnAlready        DSB 1
	spawnGlobalNum      DSB 1
	spawnTimerLow       DSB 1
	spawnTimerHi        DSB 1
	spawnTimers         DSB 6
	spawnAnimTimers     DSB 6
	spawnNums           DSB 6
	;end clear
	
	spritesLength 	  DSB 1
	spriteType 		  DSB 1
	spriteX 		  DSB 1
	spriteY 		  DSB 1
	spriteStateAnim   DSB 1
	spriteStateAction DSB 1
	spriteTimerAnim   DSB 1
	spriteTimerAction DSB 1
	spriteHealth      DSB 1
	spriteIndex		  DSB 1
	
	palAddrLow 		DSB 8
	palAddrHi  		DSB 8
	palColors  		DSB 8
	palColorsLength DSB 1
	palChangeFlag	DSB 1
	
	attrAddrLow 		DSB 8
	attrAddrHi  		DSB 8
	attrValues  		DSB 8
	attrValuesLength 	DSB 1
	attrChangeFlag		DSB 1
	
	ntblAddrLowTemp 		DSB 4
	ntblAddrHiTemp  		DSB 4
	ntblValuesTemp  		DSB 4
	
	ntblValuesLength 	DSB 1
	ntblChangeFlag		DSB 1
	ntblToAdd           DSB 1
	
	onesDigit          DSB 1
	tensDigit          DSB 1
	hundredsDigit      DSB 1
	tousandsDigit      DSB 1
	onesAdd            DSB 1
	tensAdd            DSB 1
	hundredsAdd        DSB 1
	tousandsAdd        DSB 1
	
	powerUpValue		DSB 1
	powerUpTimer		DSB 1
	powerUpType			DSB 1
	powerUpSprite       DSB 1
	healthHi			DSB 1
	healthLow			DSB 1
	keyNum				DSB 1
	playerHitTimer      DSB 1
	currentIndex        DSB 1
	pastIndex           DSB 1
	coinsOnLevel        DSB 1
	powerUpsOnLevel     DSB 1
	scrollX				DSB 1
	scrollY				DSB 1
	baseNametable       DSB 1
	
	loadNewRoom			DSB 1
	scrollDirection		DSB 1
	spritesCleared		DSB 1
	
	scrollHi			DSB 1
	scrollLow			DSB 1
	scroll2Hi			DSB 1
	scroll2Low			DSB 1
	savedPlayerX		DSB 1
	savedPlayerY		DSB 1
	savedPlayerAnim		DSB 1
	savedPlayerAction	DSB 1
	sprite0Flag			DSB 1
	sprite0NtblLow		DSB 1
	sprite0NtblHi		DSB 1
	sprite0Check		DSB 1
	baseNametableAddrHi	DSB 1
	sprite0BaseNametable 	 DSB 1
	sprite0BaseNametableTemp DSB 1
	sprite0Y            DSB 1
	
	splitScrollX		DSB 1
	splitScrollY		DSB 1
	
	drawAllSprites		DSB 1
	splitScroll2Y		DSB 1
	sprite0CheckTemp	DSB 1
	loadNewRoomTemp		DSB 1
	changeRegisterFlag  DSB 1
	mirroringMMC1		DSB 1
	NMITemp				DSB 1
	doorsFlags			DSB 1
	doorsTimer			DSB 1
	doorsTrigger		DSB 1
	spawnClosed			DSB 1
	playerX				DSB 1
	playerY				DSB 1
	scrollEndFlag		DSB 1
	alreadySpawnItem	DSB 1
	ColX0				DSB 1
	ColY0				DSB 1
	ColX1				DSB 1
	ColY1				DSB 1
	ColX2				DSB 1
	ColY2				DSB 1
	ColX3				DSB 1
	ColY3				DSB 1
	ColWallType			DSB 1
	singleDirection		DSB 1
	doorsCheckFlag		DSB 1
	doorsCheckFlagInvert DSB 1
	;total 204 of 256
	ENDE
	
	;$0200-03FF - spritebuffer
	
	ENUM $0400 ;other var
	ntblAddrLow 		DSB 64
	ntblAddrHi  		DSB 64
	ntblValues  		DSB 64
	
	;sprite manager table
	spritesType 	   DSB 64
	spritesX		   DSB 64
	spritesY		   DSB 64
	spritesTimerAnim   DSB 64
	spritesTimerAction DSB 64
	spritesStateAnim   DSB 64
	spritesStateAction DSB 64
	spritesTimerGlobal DSB 64
	spritesHealth      DSB 64
	
	roomsAttributes    DSB 64
	
	;total 832 of 1024
	ENDE
;----------------------------------------------------------------
; iNES header
;----------------------------------------------------------------
	DB "NES", $1A 	  ;identification of the iNES header
	DB PRG_COUNT 	  ;number of 16KB PRG-ROM pages
	DB CHR_COUNT 	  ;number of 8KB CHR-ROM pages
	DB $10|MIRRORING ;mapper 1 and mirroring
	DSB 9, $00 	  ;clear the remaining bytes

;----------------------------------------------------------------
; Program Bank 0
;----------------------------------------------------------------
	BASE $8000
	;NOTE: contents of program bank 0 go here
	INCLUDE "betelgeuse_ppudata.asm"
	INCLUDE "betelgeuse_data_collision_level1.asm"
	INCLUDE "betelgeuse_data_collision.asm"
	INCLUDE "betelgeuse_data_spawn.asm"
	INCLUDE "betelgeuse_data_anim.asm"
	INCLUDE "betelgeuse_data_level_blocks.asm"
	ORG $C000

;----------------------------------------------------------------
; Program Bank 1
;----------------------------------------------------------------
	BASE $8000
	;NOTE: contents of program bank 1 go here
	ORG $C000
;----------------------------------------------------------------
; Program Bank 2
;----------------------------------------------------------------
	BASE $8000
	;NOTE: contents of program bank 2 go here
	ORG $C000
;----------------------------------------------------------------
; Fixed Program Bank (16)
;----------------------------------------------------------------
	BASE $C000
Function_SplitScrollYAfter:
	LDY splitScroll2Y
	-
	LDX #$0D
		--
		EOR $00
		DEX
	BNE --
	INX
	INX
	DEY	
	BNE -
	LDY splitScroll2Y
	DEY
	-
	LDX #$0D
		--
		EOR $00
		DEX
		BNE --
		EOR $00
		DEY	
	BNE -
			
	LDA #$D7
	STA splitScrollY
				
	LDA sprite0BaseNametable
	ASL
	ASL
	STA $2006
				
	LDA splitScrollY ;Y
	STA $2005
	AND #$38
	ASL
	ASL
	STA temp
				
	LDA splitScrollX ;X
	STA $2005
	AND #$F8
	LSR
	LSR
	LSR
	ORA temp
	STA $2006
	JMP Function_SplitScrollYAfter_RETURN
	RTS
	
Function_SplitScrollYBefore:
	LDY splitScroll2Y
	-
	LDX #$0D
		--
		EOR $00
		DEX
	BNE --
		INX
		INX
		DEY	
	BNE -
	LDY splitScroll2Y
	-
	LDX #$0D
		--
		EOR $00
		DEX
	BNE --
		EOR $00
		DEY	
	BNE -
			
	LDA #$00
	STA splitScrollY
			
	LDA sprite0BaseNametable
	ASL
	ASL
	STA $2006
				
	LDA splitScrollY ;Y
	STA $2005
	AND #$38
	ASL
	ASL
	STA temp
				
	LDA splitScrollX ;X
	STA $2005
	AND #$F8
	LSR
	LSR
	LSR
	ORA temp
	STA $2006
	JMP Function_SplitScrollYBefore_RETURN
	RTS
	

Reset:
	;NOTE: initialization code goes here
	JMP Init
	ReturnInit:
	JSR ConfigMMC1
	JSR VBlankWait ;First wait for vblank to make sure PPU is ready
	JSR ClearMemory	
	JSR VBlankWait ;Second wait for vblank, PPU is ready after this
	;END of init
	
	LDA #$00
	STA bulletsNum
	STA bulletsTimer
	STA bulletsType
	
	LDA #$10
	STA bulletsTime
	
	LDA #$00
	STA ppuEnableFlag
	
	LDA #$01
	STA	ppuEnableFlag
	LDA #$01
	STA gameState
	LDA #$00
	STA $2001
	LDA #%10010000
	STA $2000

GameLoop:
	LDA #$00
	STA vblankFlag
	LDA $1000 ;---------------------------------------------------------
	;read joypads
	LDA buttonsP1
	STA buttonsP1Old
	JSR ReadController1
	LDA buttonsP2
	STA buttonsP2Old
	JSR ReadController2
	
	;Start game logic
	LDA gameState
	CMP #$00 ;None
	BEQ +
		JMP GameStateNoneEnd
		+
		CMP gameStateOld
		BNE ++
			JMP GameStateNoneInitEnd
			++
			STA gameStateOld
			;put init code here
			JMP GameStateEnd
			GameStateNoneInitEnd:
			;put code here
			JMP GameStateEnd
		GameStateNoneEnd:
	CMP #$01 ;Title screen
	BEQ +
		JMP GameStateTitleEnd
		+
		CMP gameStateOld
		BNE ++
			JMP GameStateTitleInitEnd
			++
			;put init code here
			JSR TitleInit
			JMP GameStateEnd
			GameStateTitleInitEnd:
			;put code here
			JSR TitleRun
			JMP GameStateEnd
		GameStateTitleEnd:
	CMP #$02 ;Game
	BEQ +
		JMP GameStateLevel1End
		+
		CMP gameStateOld
		BNE ++
			JMP GameStateLevel1InitEnd
			++
			;put init code here
			JSR Level1Init
			JMP GameStateEnd
			GameStateLevel1InitEnd:
			;put code here
			LDA splitScroll2Y
			CMP #00
			BEQ ++
			LDY scrollDirection
			LDA scrollY
			CMP SplitScroll2YBefore, Y
			BCC ++
				JMP Function_SplitScrollYBefore	
				Function_SplitScrollYBefore_RETURN:
				++		
			JSR Level1Run
			LDA $1001 ;---------------------------------------------------------
			LDA sprite0Check
			CMP TRUE
			BNE ++
					-
					LDA $2002
					AND #$40
				BEQ -	
				LDX #$16
					-
					EOR #$00
					DEX
				BNE -

				LDA sprite0BaseNametableTemp
				ASL
				ASL
				STA $2006
				
				LDA splitScrollY ;Y
				STA $2005
				AND #$38
				ASL
				ASL
				STA temp
				
				LDA splitScrollX ;X
				STA $2005
				AND #$F8
				LSR
				LSR
				LSR
				ORA temp
				STA $2006
				++
				
				;LDX #$04
				;	-
				;	DEX
				;BNE -
				
				LDA splitScroll2Y
				CMP #00
				BEQ ++
				LDY scrollDirection
				LDA scrollY
				CMP SplitScroll2YAfter, Y
				BCS ++
					JMP Function_SplitScrollYAfter	
					Function_SplitScrollYAfter_RETURN:
					++
				LDA FALSE
				STA sprite0Check
				LDA scrollY
				CMP #$70
				BNE +
					JSR Function_sprite0BaseNametableOrigChangeUpDown
					+
			JMP GameStateEnd
		GameStateLevel1End:
	CMP #$03 ;Info
	BEQ +
		JMP GameStateInfoEnd
		+
		CMP gameStateOld
		BNE ++
			JMP GameStateInfoInitEnd
			++
			;put init code here
			JSR InfoInit
			JMP GameStateEnd
			GameStateInfoInitEnd:
			;put code here
			JSR InfoRun
			JMP GameStateEnd
		GameStateInfoEnd:
	GameStateEnd:
	;end game logic	
	
	LDA loadNewRoomTemp
	STA loadNewRoom
	CMP TRUE
	BEQ +
		;update global timer
		LDA globalTimerLow
		STA bit16Low
		LDA globalTimerHi
		STA bit16Hi
		JSR Bit16Inc
		LDA bit16Low
		STA globalTimerLow
		LDA bit16Hi
		STA globalTimerHi
	
		LDA bulletsTimer
		CMP #$70
		BEQ ++
			INC bulletsTimer
			++
	
		INC powerUpTimer
		
		LDA doorsFlags
		CMP #$00
		BEQ ++
			INC doorsTimer
			++
		+
	
	WaitTillVBlank:	
		LDA vblankFlag
		CMP #$01
		BNE WaitTillVBlank

	JMP GameLoop ;jump back to GameLoop, infinite loop
	
NMI:	
	PHP
	PHA
	TXA
	PHA
	TYA
	PHA
	
	LDA ppuEnableFlag
	CMP #$00
	BEQ +
		JMP NMIStart
		+
		LDA gameState
		CMP #$01 ;Title
		BNE +
			LDA #<(paletteTitleBG)
			STA pointerLow
			LDA #>(paletteTitleBG)
			STA pointerHi
			
			LDA #<(paletteSprites)
			STA pointer2Low
			LDA #>(paletteSprites)
			STA pointer2Hi
			
			JMP PalLoadEnd
			+
		CMP #$02 ;Level1
		BNE +
			LDA #<(paletteLevel)
			STA pointerLow
			LDA #>(paletteLevel)
			STA pointerHi
			
			LDA #<(paletteSprites)
			STA pointer2Low
			LDA #>(paletteSprites)
			STA pointer2Hi
			
			JMP PalLoadEnd
			+
		CMP #$03 ;Info
		BNE +
			LDA #<(paletteInfo)
			STA pointerLow
			LDA #>(paletteInfo)
			STA pointerHi
			
			LDA #<(paletteSprites)
			STA pointer2Low
			LDA #>(paletteSprites)
			STA pointer2Hi
			+
		PalLoadEnd:
		LDA $2002 	   	  ;read PPU status to reset the high/low latch
		LDA #$3F
		STA $2006 	   	  ;write the high byte of address
		LDA #$00
		STA $2006 	   	  ;write the low byte of address
		LDY #$00
		-
			LDA (pointerLow), Y
			STA $2007	   	  ;write to PPU
			INY
			CPY #$10
		BNE -
		
		LDA $2002 	   	  ;read PPU status to reset the high/low latch
		LDA #$3F
		STA $2006 	   	  ;write the high byte of address
		LDA #$10
		STA $2006 	   	  ;write the low byte of address
		LDY #$00
			-
			LDA (pointer2Low), Y
			STA $2007	   	  ;write to PPU
			INY
			CPY #$10
		BNE -
		
		LDA #$00 ;tell the ppu there is no background scrolling
		STA $2005
		LDA #$00
		STA $2005
	
		LDA $2002 	   	  ;read PPU status to reset the high/low latch
		LDA #$00
		STA $2006 	   	  ;write the high byte of address
		LDA #$00
		STA $2006 
		LDA #$00 ;disable rendering
		STA $2001
		LDA #%10010000 ; nmi
		STA $2000
		
	NMIStart:
	;NOTE: NMI code goes here	
	;run other game graphics updating code here
	
	;Palette color change
	LDA palChangeFlag
	CMP TRUE
	BNE +
		LDA palColorsLength
		CMP #$00
		BNE ++
			JMP +
			++
		LDX #$00
			-
			LDA $2002 	   	  ;read PPU status to reset the high/low latch
			LDA palAddrHi, X
			STA $2006 	   	  ;write the high byte of address
			LDA palAddrLow, X
			STA $2006 	   	  ;write the low byte of address
			LDA palColors, X
			STA $2007	   	  ;write to PPU
			INX
			CPX palColorsLength
		BNE -
		LDA #$00
		STA palColorsLength
		STA palChangeFlag
		+
	
	;Attribute table change
	LDA attrChangeFlag
	CMP TRUE
	BNE +
		LDA attrValuesLength
		CMP #$00
		BNE ++
			JMP +
			++
		LDX #$00
			-
			LDA $2002 	   	   ;read PPU status to reset the high/low latch
			LDA attrAddrHi, X
			STA $2006 	   	   ;write the high byte of address
			LDA attrAddrLow, X
			STA $2006 	   	   ;write the low byte of address
			LDA attrValues, X
			STA $2007	   	   ;write to PPU
			INX
			CPX attrValuesLength
		BNE -
		LDA #$00
		STA attrValuesLength
		STA attrChangeFlag
		+

	;Nametable change
	LDA ntblChangeFlag
	CMP TRUE	
	BNE +
		LDA ntblValuesLength
		CMP #$00
		BNE ++
			JMP +
			++
		LDX #$00
			-
			LDA $2002 	   	   ;read PPU status to reset the high/low latch
			LDA ntblAddrHi, X
			STA $2006 	   	   ;write the high byte of address
			LDA ntblAddrLow, X
			STA $2006 	   	   ;write the low byte of address
			LDA ntblValues, X
			STA $2007	   	   ;write to PPU
			INX
			CPX ntblValuesLength
		BNE -
		LDA #$00
		STA ntblValuesLength
		STA ntblChangeFlag
		+
		
	LDA spritesDrawDirection
	CMP #$01
	BEQ +
	LDA #$00  ;DMA sprite transfer
	STA $2003 ;set the low byte (00) of the RAM address	 
	LDA #$02
	STA $4014 ;set the high byte (02) of the RAM address, start the transfer
	+
	LDA spritesDrawDirection
	CMP #$00
	BEQ +
	LDA #$00  ;DMA sprite transfer
	STA $2003 ;set the low byte (00) of the RAM address	 
	LDA #$03
	STA $4014 ;set the high byte (02) of the RAM address, start the transfer
	+
	LDA ppuEnableFlag
	CMP #$01
	BEQ +
		JMP NMIEnd
		+
		
	LDA changeRegisterFlag
	CMP TRUE
	BNE +
		LDA #$80 ;set MMC1 mirroring bank
		STA pointerHi
		LDA MMC1DefaultConfig
		AND #$FC
		ORA mirroringMMC1 ;horizontal mirroring
		STA value
		JSR MMC1WriteRegister
		LDA FALSE
		STA changeRegisterFlag
		+
	;This is the PPU clean up section, so rendering the next frame starts properly.
	;LDA scrollX ;tell the ppu there is no background scrolling
	;STA $2005
	;LDA scrollY
	;STA $2005
	LDA #%10010000 ;enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
	EOR baseNametable
	STA $2000
	LDA #%00011110 ;enable sprites, enable background, no clipping on left side
	STA $2001
	
	LDA baseNametable
	ASL
	ASL
	STA $2006
				
	LDA scrollY ;Y
	STA $2005
	AND #$38
	ASL
	ASL
	STA NMITemp
				
	LDA scrollX ;X
	STA $2005
	AND #$F8
	LSR
	LSR
	LSR
	ORA NMITemp
	STA $2006
	;INC scrollX
	;LDA scrollX
	;CMP #$00
	;BNE +
	;	LDA baseNametable
	;	CMP #$01
	;	BNE ++
	;		LDA #$00
	;		STA baseNametable
	;		JMP +
	;		++
	;	LDA #$01
	;	STA baseNametable
	;	+
	
	NMIEnd:	

	LDA #$01
	STA vblankFlag
	PLA
	TAY
	PLA
	TAX
	PLA
	PLP
	
	RTI ;return from interrupt

IRQ:
	;NOTE: IRQ code goes here
	
;----------------------------------------------------------------
; Subroutines
;----------------------------------------------------------------
	INCLUDE "betelgeuse_functions.asm"

;----------------------------------------------------------------
; Include files
;----------------------------------------------------------------
	INCLUDE "betelgeuse_init.asm"

;----------------------------------------------------------------
; PPU data
;----------------------------------------------------------------
	;ORG $EA00	
	INCLUDE "betelgeuse_data.asm"	
	INCLUDE "betelgeuse_data_action.asm"
;----------------------------------------------------------------
; Interrupt vectors
;----------------------------------------------------------------
	ORG $FFFA

	DW NMI
	DW Reset
	DW IRQ

;----------------------------------------------------------------
; CHR-ROM banks
;----------------------------------------------------------------
	INCBIN "betelgeuse_sprite.chr"
	INCBIN "betelgeuse_title.chr"
	INCBIN "betelgeuse_level.chr"
	INCBIN "betelgeuse_level.chr"
