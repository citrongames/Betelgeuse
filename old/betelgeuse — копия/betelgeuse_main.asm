;----------------------------------------------------------------
; Definitions
;----------------------------------------------------------------
INCLUDE "betelgeuse_defines.asm"

;----------------------------------------------------------------
; Constants
;----------------------------------------------------------------
PRG_COUNT = 2 	  ;1 = 16KB, 2 = 32KB
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
	
	bulletsNum    DSB 1
	bulletsTimer  DSB 1
	bulletsType   DSB 1
	
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
	ENDE
	
	ENUM $0400 ;other var
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
	
	ntblAddrLow 		DSB 8
	ntblAddrHi  		DSB 8
	ntblValues  		DSB 8
	ntblValuesLength 	DSB 1
	ntblChangeFlag		DSB 1
	ENDE
	
	ENUM $0600 ;sprite manager table
	spritesType 	   DSB 64
	spritesX		   DSB 64
	spritesY		   DSB 64
	spritesTimerAnim   DSB 64
	spritesTimerAction DSB 64
	spritesStateAnim   DSB 64
	spritesStateAction DSB 64
	
	spritesLength 	  DSB 1
	spriteType 		  DSB 1
	spriteX 		  DSB 1
	spriteY 		  DSB 1
	spriteStateAnim   DSB 1
	spriteStateAction DSB 1
	spriteTimerAnim   DSB 1
	spriteTimerAction DSB 1
	spriteIndex		  DSB 1
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
	ORG $C000

;----------------------------------------------------------------
; Fixed Program Bank (16)
;----------------------------------------------------------------
	BASE $C000

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
	
	LDA #$00
	STA ppuEnableFlag
	
	LDA #$01
	STA gameState
	LDA #$00
	STA $2001
	LDA #%10010000
	STA $2000

GameLoop:
	LDA $FFF1 ; breakpoint
	LDA #$00
	STA vblankFlag

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
			JSR Level1Run
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
	CMP #$3C
	BEQ +
		INC bulletsTimer
		+
			
	LDA $FFF2 ; breakpoint
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
		LDA #$00 ;disable nmi
		STA $2000
		JMP NMIEnd
	NMIStart:
	;NOTE: NMI code goes here	
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
	;run other game graphics updating code here
	
	;Palette color change
	LDA palChangeFlag
	CMP TRUE
	BNE +
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
	
	;This is the PPU clean up section, so rendering the next frame starts properly.
	LDA #$00 ;tell the ppu there is no background scrolling
	STA $2005
	LDA #$00
	STA $2005
	
	LDA #%10010000 ;enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
	STA $2000
	LDA #%00011110 ;enable sprites, enable background, no clipping on left side
	STA $2001
	
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
	ORG $E000	
	INCLUDE "betelgeuse_data.asm"
	INCLUDE "betelgeuse_data_anim.asm"
	INCLUDE "betelgeuse_data_action.asm"
	INCLUDE "betelgeuse_data_collision.asm"
	INCLUDE "betelgeuse_data_collision_level1.asm"
	
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
