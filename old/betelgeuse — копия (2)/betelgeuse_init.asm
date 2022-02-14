;----------------------------------------------------------------
; Init function
;----------------------------------------------------------------
Init:
	SEI 	  ;disable IRQs
	CLD 	  ;disable decimal mode
	LDX #$40
	STX $4017 ;disable APU frame IRQ
	LDX #$FF
	TXS 	  ;Set up stack
	INX 	  ;now X = 0
	STX $2000 ;disable NMI
	STX $2001 ;disable rendering
	STX $4010 ;disable DMC IRQs
	BIT $2002 ;clear vblank flag
	
	JMP ReturnInit
	
;----------------------------------------------------------------
; MMC1 configure function
;----------------------------------------------------------------
ConfigMMC1:
	LDA #$80 ;set mmc1 options
	STA pointerHi
	LDA #%00011110 ;horizontal mirroring, fixed $C000, 4 KB CHR pages
	STA value
	JSR MMC1WriteRegister

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
	
	LDA #$E0 ;set prg bank
	STA pointerHi
	LDA #%00010000
	STA value
	JSR MMC1WriteRegister
	
	RTS

;----------------------------------------------------------------
; Write to MMC1 register function
; pointerLow - reg address
; value - reg value
;----------------------------------------------------------------
MMC1WriteRegister:
	LDX #$00
	LDA #$80	   
	STA (pointerLow, X) ;reset the shift register
	LDA value	;load desired value
	STA (pointerLow, X)
	LSR A
	STA (pointerLow, X)
	LSR A
	STA (pointerLow, X)
	LSR A
	STA (pointerLow, X)
	LSR A
	STA (pointerLow, X)
	
	RTS

;----------------------------------------------------------------
; Memory clearing function
;----------------------------------------------------------------
ClearMemory:
	LDX #$00
		-
		LDA #$00
		STA $0000, X
		;STA $0100, X ;clear stack, we don't want this, it will screw up return from function
		STA $0300, X
		STA $0400, X
		STA $0500, X
		STA $0600, X
		STA $0700, X
		LDA #$FE
		STA $0200, X ;OAM needs to be initialized to $EF-$FF, not 0, or you'll get a bunch of garbage sprites at (0, 0).
		INX
	BNE -
	RTS
	
;----------------------------------------------------------------
; Waiting for VBlank ready function
;----------------------------------------------------------------
VBlankWait:
		-
		BIT $2002
	BPL -
	
	RTS
