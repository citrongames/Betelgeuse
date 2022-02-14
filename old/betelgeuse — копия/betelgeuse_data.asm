;----------------------------------------------------------------
; Other resources
;----------------------------------------------------------------
TitleSprite1X:
	DB $60, $5D, $60
TitleSprite2X:
	DB $77, $7C, $7C
TitleSprite3X:
	DB $90, $90, $90
TitleSprite1Y:
	DB $60, $60, $60
TitleSprite2Y:
	DB $64, $64, $64
TitleSprite3Y:
	DB $60, $60, $60
TitleSprite1Anim:
	DB $04, $07, $06
TitleSprite2Anim:
	DB $00, $00, $00
TitleSprite3Anim:
	DB $01, $07, $02
TitleSprite1Action:
	DB $00, $00, $00
TitleSprite2Action:
	DB $01, $01, $01
TitleSprite3Action:
	DB $00, $00, $00
TitleSprite1Type:
	DB $02, $02, $01
TitleSprite2Type:
	DB $04, $03, $05
TitleSprite3Type:
	DB $02, $02, $01
	
TitleBGColorsFlags:
	DB $00, $01, $02
TitleBGColors:
	DB $0F, $01, $0C
TitleBGColorsLength:
	DB $03
TitleBGColorsNum:
	DB $01
TitleBGColorsAddrLow:
	DB $00, $00, $00
TitleBGColorsAddrHi:
	DB $3F, $3F, $3F
	
TitleAttrValuesFlags:
	DB $00,$04
	DB $08,$0C 
TitleAttrValues:
	DB $60,$50,$50,$90, $20,$00,$00,$80
	DB $06,$05,$05,$09, $02,$00,$00,$08
TitleAttrValuesLength:
	DB $02
TitleAttrValuesNum:
	DB $04
TitleAttrValuesAddrLow:
	DB $E2,$E3,$E4,$E5, $E2,$E3,$E4,$E5
	DB $EA,$EB,$EC,$ED, $EA,$EB,$EC,$ED
TitleAttrValuesAddrHi:
	DB $23,$23,$23,$23, $23,$23,$23,$23
	DB $23,$23,$23,$23, $23,$23,$23,$23
	
TitleNtblValuesFlags:
	DB $00,$04
TitleNtblValues:
	DB $26,$26,$27,$27, $27,$27,$26,$26
TitleNtblValuesLength:
	DB $01
TitleNtblValuesNum:
	DB $04
TitleNtblValuesAddrLow:
	DB $69,$76,$A9,$B6, $69,$76,$A9,$B6
TitleNtblValuesAddrHi:
	DB $22,$22,$22,$22, $22,$22,$22,$22
