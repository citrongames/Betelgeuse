;----------------------------------------------------------------
; Other resources
;----------------------------------------------------------------
MMC1DefaultConfig:
	DB $1E
	
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
	DB $00, $04, $08, $0C, $10, $14, $18
TitleNtblValues:
	DB $26,$26,$27,$27, $27,$27,$26,$26, $05,$06,$15,$16, $07,$08,$17,$18, $44,$45,$54,$55, $44,$45,$54,$55, $25,$25,$35,$35
TitleNtblValuesLength:
	DB $01
TitleNtblValuesNum:
	DB $04
TitleNtblValuesAddrLow:
	DB $69,$76,$A9,$B6, $69,$76,$A9,$B6, $10,$11,$30,$31, $10,$11,$30,$31, $10,$11,$30,$31, $10,$11,$30,$31, $10,$11,$30,$31
TitleNtblValuesAddrHi:
	DB $22,$22,$22,$22, $22,$22,$22,$22, $22,$22,$22,$22, $22,$22,$22,$22, $22,$22,$22,$22, $22,$22,$22,$22, $22,$22,$22,$22
	
NtblValuesKeyCountAddrLow:
	DB $76
NtblValuesBlockAddrLow:
	DB $63,$79,$75,$6E
NtblValuesCoinCountAddrLow:
	DB $7D,$7C,$7B,$7A
NtblValuesHealthLowAddrLow:
	DB $64,$65,$66,$67
NtblValuesHealthHiAddrLow:
	DB $68,$69,$6A,$6B
NtblValuesPowerUpAddrLow:
	DB $6F,$70,$71,$72
PlayerInvincibilityPattern:
	DB $FF, $03,$03,$02,$02,$00,$00, $03,$03,$02,$02,$00,$00, $03,$03,$02,$02,$00,$00, $03,$03,$02,$02,$00,$00, $03,$03,$02,$02,$00,$00, $03,$03,$02,$02,$00,$00
MaxCoinsOnLevel:
	DB $06
SpawnNtblAddrAdd:
	DB $00, $01, $20, $21
SpawnNtblTile:
	DB $25, $25, $35, $35
ScrollXStatusBarHealth:
	DB $28, $48, $18, $E8
ScrollXStatusBarCoins:
	DB $20, $50, $10, $F0
ScrollXStatusBarCommas:
	DB $18, $58, $08, $F8
ScrollXStatusBarPowerUp:
	DB $10, $60, $20, $E0
ScrollXStatusBarKey:
	DB $08, $68, $28, $D8
ScrollYExtraNtblAdd:
	DB $60, $80, $A0
ScrollYExtraNtblUpAdd:
	DB $00, $20, $40
ScrollYExtraNtblDownAdd:
	DB $E0, $E0, $E0
ScrollYExtraNtblLowAdd:
	DB $60, $80, $A0, $F8, $E0, $C8, $B0, $98, $80, $68, $50, $38
ScrollYExtraNtblHiAdd:
	DB $03, $03, $03, $02, $02, $02, $02, $02, $02, $02, $02, $02
ScrollYAttrNtblAdd:
	DB $E0, $E8, $E0, $E8, $E0, $E8, $E0, $E8
ScrollYAttrNtblLowAdd:
	DB $A0, $88, $70, $58, $40, $28, $10, $F8
ScrollYAttrNtblHiAdd:
	DB $03, $03, $03, $03, $03, $03, $03, $02
ScrollYExtraNtblUpExtraAdd:
	DB $A0, $C8, $F0, $18, $40, $68, $90, $B8
ScrollYExtraNtblLowUpAdd:
	DB $A0, $C8, $F0, $18, $40, $68, $90, $B8
ScrollYExtraNtblHiUpAdd:
	DB $01, $01, $01, $02, $02, $02, $02, $02
SplitScroll2YBefore:
	DB $78, $70
SplitScroll2YAfter:
	DB $69, $78
BulletsTimes:
	DB $10, $18
DoorFramesUp:
	DB $88, $89, $98, $99
	DB $72, $73, $98, $99
	DB $62, $63, $72, $73
DoorFramesDown:
	DB $8E, $8F, $9E, $9F
	DB $8E, $8F, $64, $65
	DB $64, $65, $74, $75
DoorFramesLeft:
	DB $8A, $8B, $9A, $9B
	DB $67, $8B, $77, $9B
	DB $66, $67, $76, $77
DoorFramesRight:
	DB $8C, $8D, $9C, $9D
	DB $8C, $68, $9C, $78
	DB $68, $69, $78, $79
DoorsMask:
	DB %00010000, %00100000, %01000000, %10000000
Level1BossAddOffsetX:
	DB $F8, $08
Level1BossAddOffsetY:
	DB $18, $10 