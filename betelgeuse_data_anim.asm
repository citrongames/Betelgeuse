;----------------------------------------------------------------	
; Anim database
; 00 - player
; 01 - tripod
; 02 - tank
; 03 - heart
; 04 - gun
; 05 - coin
; 06 - explosion
; 07 - coin small
; 08 - player bullet
; 09 - bullet ghost
; 0A - enemy bullet
; 0B - crab
; 0C - boss 1 up
; 0D - boss 1 middle
; OE - boss 1 down
; 0F - powerup trigun
; 10 - key
;----------------------------------------------------------------
SpritesTypesHealth:
	DB $FF, $01, $02, $00, $00, $00, $00, $00
	DB $00, $00, $01, $02, $03, $03, $03, $00
	DB $00
SpriteTypesLengthByte:
	DB $10, $10, $10, $04, $08, $04, $10, $04
	DB $04, $04, $04, $10, $30, $30, $10, $04
	DB $04
SpriteTypesLengthTiles:
	DB $04, $04, $04, $01, $02, $01, $04, $01
	DB $01, $01, $01, $04, $0C, $0C, $04, $01
	DB $01
SpriteTypesXLow:
	DB <(SpriteType2x2X), <(SpriteType2x2X), <(SpriteType2x2X), <(SpriteType1x1X), <(SpriteType2x1X), <(SpriteType1x1X), <(SpriteType2x2X), <(SpriteType1x1X)
	DB <(SpriteType1x1X), <(SpriteType1x1X), <(SpriteType1x1X), <(SpriteType2x2X), <(SpriteType4x3X), <(SpriteType6x2X), <(SpriteType4x1X), <(SpriteType1x1X)
	DB <(SpriteType1x1X)
SpriteTypesXHi:
	DB >(SpriteType2x2X), >(SpriteType2x2X), >(SpriteType2x2X), >(SpriteType1x1X), >(SpriteType2x1X), >(SpriteType1x1X), >(SpriteType2x2X), >(SpriteType1x1X)
	DB >(SpriteType1x1X), >(SpriteType1x1X), >(SpriteType1x1X), >(SpriteType2x2X), >(SpriteType4x3X), >(SpriteType6x2X), >(SpriteType4x1X), >(SpriteType1x1X)
	DB >(SpriteType1x1X)
SpriteTypesYLow:
	DB <(SpriteType2x2Y), <(SpriteType2x2Y), <(SpriteType2x2Y), <(SpriteType1x1Y), <(SpriteType2x1Y), <(SpriteType1x1Y), <(SpriteType2x2Y), <(SpriteType1x1Y)
	DB <(SpriteType1x1Y), <(SpriteType1x1Y), <(SpriteType1x1Y), <(SpriteType2x2Y), <(SpriteType4x3Y), <(SpriteType6x2Y), <(SpriteType4x1Y), <(SpriteType1x1Y)
	DB <(SpriteType1x1Y)
SpriteTypesYHi:
	DB >(SpriteType2x2Y), >(SpriteType2x2Y), >(SpriteType2x2Y), >(SpriteType1x1Y), >(SpriteType2x1Y), >(SpriteType1x1Y), >(SpriteType2x2Y), >(SpriteType1x1Y)
	DB >(SpriteType1x1Y), >(SpriteType1x1Y), >(SpriteType1x1Y), >(SpriteType2x2Y), >(SpriteType4x3Y), >(SpriteType6x2Y), >(SpriteType4x1Y), >(SpriteType1x1Y)
	DB >(SpriteType1x1Y)

SpriteType1x1X:
	DB $00
SpriteType1x1Y:
	DB $00
SpriteType2x1X:
	DB $00, $08
SpriteType2x1Y:
	DB $00, $00
SpriteType2x2X:
	DB $00, $08, $00, $08
SpriteType2x2Y:
	DB $00, $00, $08, $08
SpriteType4x3X:
	DB $00, $08, $10, $18, $00, $08, $10, $18, $00, $08, $10, $18
SpriteType4x3Y:
	DB $00, $00, $00, $00, $08, $08, $08, $08, $10, $10, $10, $10
SpriteType6x2X:
	DB $00, $08, $10, $18, $20, $28, $00, $08, $10, $18, $20, $28
SpriteType6x2Y:
	DB $00, $00, $00, $00, $00, $00, $08, $08, $08, $08, $08, $08
SpriteType4x1X:
	DB $00, $08, $10, $18
SpriteType4x1Y:
	DB $00, $00, $00, $00
;----------------------------------------------------------------	
;tiles in frame
;----------------------------------------------------------------
SpriteTypesAnimsTilesLowLow:
	DB <(SpritePlayerAnimsTilesLow), <(SpriteTripodAnimsTilesLow), <(SpriteTankAnimsTilesLow), <(SpriteHurtAnimsTilesLow), <(SpriteGunAnimsTilesLow), <(SpriteCoinAnimsTilesLow), <(SpriteExpAnimsTilesLow), <(SpriteCoinSmallAnimsTilesLow)
	DB <(SpritePlayerBulletAnimsTilesLow), <(SpritePlayerBulletGhostAnimsTilesLow), <(SpriteEnemyBulletAnimsTilesLow), <(SpriteCrabAnimsTilesLow), <(SpriteBoss1UpAnimsTilesLow), <(SpriteBoss1MiddleAnimsTilesLow), <(SpriteBoss1DownAnimsTilesLow), <(SpriteTrigunAnimsTilesLow)
	DB <(SpriteKeyAnimsTilesLow)
SpriteTypesAnimsTilesLowHi:
	DB >(SpritePlayerAnimsTilesLow), >(SpriteTripodAnimsTilesLow), >(SpriteTankAnimsTilesLow), >(SpriteHurtAnimsTilesLow), >(SpriteGunAnimsTilesLow), >(SpriteCoinAnimsTilesLow), >(SpriteExpAnimsTilesLow), >(SpriteCoinSmallAnimsTilesLow)
	DB >(SpritePlayerBulletAnimsTilesLow), >(SpritePlayerBulletGhostAnimsTilesLow), >(SpriteEnemyBulletAnimsTilesLow), >(SpriteCrabAnimsTilesLow), >(SpriteBoss1UpAnimsTilesLow), >(SpriteBoss1MiddleAnimsTilesLow), >(SpriteBoss1DownAnimsTilesLow), >(SpriteTrigunAnimsTilesLow)
	DB >(SpriteKeyAnimsTilesLow)
SpriteTypesAnimsTilesHiLow:
	DB <(SpritePlayerAnimsTilesHi), <(SpriteTripodAnimsTilesHi), <(SpriteTankAnimsTilesHi), <(SpriteHurtAnimsTilesHi), <(SpriteGunAnimsTilesHi), <(SpriteCoinAnimsTilesHi), <(SpriteExpAnimsTilesHi), <(SpriteCoinSmallAnimsTilesHi)
	DB <(SpritePlayerBulletAnimsTilesHi), <(SpritePlayerBulletGhostAnimsTilesHi), <(SpriteEnemyBulletAnimsTilesHi), <(SpriteCrabAnimsTilesHi), <(SpriteBoss1UpAnimsTilesHi), <(SpriteBoss1MiddleAnimsTilesHi), <(SpriteBoss1DownAnimsTilesHi), <(SpriteTrigunAnimsTilesHi)
	DB <(SpriteKeyAnimsTilesHi)
SpriteTypesAnimsTilesHiHi:
	DB >(SpritePlayerAnimsTilesHi), >(SpriteTripodAnimsTilesHi), >(SpriteTankAnimsTilesHi), >(SpriteHurtAnimsTilesHi), >(SpriteGunAnimsTilesHi), >(SpriteCoinAnimsTilesHi), >(SpriteExpAnimsTilesHi), >(SpriteCoinSmallAnimsTilesHi)
	DB >(SpritePlayerBulletAnimsTilesHi), >(SpritePlayerBulletGhostAnimsTilesHi), >(SpriteEnemyBulletAnimsTilesHi), >(SpriteCrabAnimsTilesHi), >(SpriteBoss1UpAnimsTilesHi), >(SpriteBoss1MiddleAnimsTilesHi), >(SpriteBoss1DownAnimsTilesHi), >(SpriteTrigunAnimsTilesHi)
	DB >(SpriteKeyAnimsTilesHi)
;player
SpritePlayerAnimsTilesLow:
	DB <(SpritePlayerAnimWalkLeft1Tiles)
	DB <(SpritePlayerAnimWalkLeft1Tiles), <(SpritePlayerAnimWalkLeft2Tiles), <(SpritePlayerAnimWalkLeft3Tiles), <(SpritePlayerAnimWalkLeft4Tiles)
	DB <(SpritePlayerAnimWalkRight1Tiles)
	DB <(SpritePlayerAnimWalkRight1Tiles), <(SpritePlayerAnimWalkRight2Tiles), <(SpritePlayerAnimWalkRight3Tiles), <(SpritePlayerAnimWalkRight4Tiles)
	DB <(SpritePlayerAnimWalkDown1Tiles)
	DB <(SpritePlayerAnimWalkDown1Tiles), <(SpritePlayerAnimWalkDown2Tiles), <(SpritePlayerAnimWalkDown3Tiles), <(SpritePlayerAnimWalkDown4Tiles)
	DB <(SpritePlayerAnimWalkUp1Tiles)
	DB <(SpritePlayerAnimWalkUp1Tiles), <(SpritePlayerAnimWalkUp2Tiles), <(SpritePlayerAnimWalkUp3Tiles), <(SpritePlayerAnimWalkUp4Tiles)
	DB <(SpritePlayerAnimWalkLeftUp1Tiles)
	DB <(SpritePlayerAnimWalkLeftUp1Tiles), <(SpritePlayerAnimWalkLeftUp2Tiles), <(SpritePlayerAnimWalkLeftUp3Tiles), <(SpritePlayerAnimWalkLeftUp4Tiles)
	DB <(SpritePlayerAnimWalkRightUp1Tiles)
	DB <(SpritePlayerAnimWalkRightUp1Tiles), <(SpritePlayerAnimWalkRightUp2Tiles), <(SpritePlayerAnimWalkRightUp3Tiles), <(SpritePlayerAnimWalkRightUp4Tiles)
	DB <(SpritePlayerAnimWalkLeftDown1Tiles)
	DB <(SpritePlayerAnimWalkLeftDown1Tiles), <(SpritePlayerAnimWalkLeftDown2Tiles), <(SpritePlayerAnimWalkLeftDown3Tiles), <(SpritePlayerAnimWalkLeftDown4Tiles)
	DB <(SpritePlayerAnimWalkRightDown1Tiles)
	DB <(SpritePlayerAnimWalkRightDown1Tiles), <(SpritePlayerAnimWalkRightDown2Tiles), <(SpritePlayerAnimWalkRightDown3Tiles), <(SpritePlayerAnimWalkRightDown4Tiles)
SpritePlayerAnimsTilesHi:
	DB >(SpritePlayerAnimWalkLeft1Tiles)
	DB >(SpritePlayerAnimWalkLeft1Tiles), >(SpritePlayerAnimWalkLeft2Tiles), >(SpritePlayerAnimWalkLeft3Tiles), >(SpritePlayerAnimWalkLeft4Tiles)
	DB >(SpritePlayerAnimWalkRight1Tiles)
	DB >(SpritePlayerAnimWalkRight1Tiles), >(SpritePlayerAnimWalkRight2Tiles), >(SpritePlayerAnimWalkRight3Tiles), >(SpritePlayerAnimWalkRight4Tiles)
	DB >(SpritePlayerAnimWalkDown1Tiles)
	DB >(SpritePlayerAnimWalkDown1Tiles), >(SpritePlayerAnimWalkDown2Tiles), >(SpritePlayerAnimWalkDown3Tiles), >(SpritePlayerAnimWalkDown4Tiles)
	DB >(SpritePlayerAnimWalkUp1Tiles)
	DB >(SpritePlayerAnimWalkUp1Tiles), >(SpritePlayerAnimWalkUp2Tiles), >(SpritePlayerAnimWalkUp3Tiles), >(SpritePlayerAnimWalkUp4Tiles)
	DB >(SpritePlayerAnimWalkLeftUp1Tiles)
	DB >(SpritePlayerAnimWalkLeftUp1Tiles), >(SpritePlayerAnimWalkLeftUp2Tiles), >(SpritePlayerAnimWalkLeftUp3Tiles), >(SpritePlayerAnimWalkLeftUp4Tiles)
	DB >(SpritePlayerAnimWalkRightUp1Tiles)
	DB >(SpritePlayerAnimWalkRightUp1Tiles), >(SpritePlayerAnimWalkRightUp2Tiles), >(SpritePlayerAnimWalkRightUp3Tiles), >(SpritePlayerAnimWalkRightUp4Tiles)
	DB >(SpritePlayerAnimWalkLeftDown1Tiles)
	DB >(SpritePlayerAnimWalkLeftDown1Tiles), >(SpritePlayerAnimWalkLeftDown2Tiles), >(SpritePlayerAnimWalkLeftDown3Tiles), >(SpritePlayerAnimWalkLeftDown4Tiles)
	DB >(SpritePlayerAnimWalkRightDown1Tiles)
	DB >(SpritePlayerAnimWalkRightDown1Tiles), >(SpritePlayerAnimWalkRightDown2Tiles), >(SpritePlayerAnimWalkRightDown3Tiles), >(SpritePlayerAnimWalkRightDown4Tiles)
SpritePlayerAnimWalkLeft1Tiles:
	DB $26, $27, $36, $37
SpritePlayerAnimWalkLeft2Tiles:
	DB $28, $29, $38, $39
SpritePlayerAnimWalkLeft3Tiles:
	DB $2A, $2B, $3A, $3B
SpritePlayerAnimWalkLeft4Tiles:
	DB $2C, $2D, $3C, $3D
SpritePlayerAnimWalkRight1Tiles:
	DB $27, $26, $37, $36
SpritePlayerAnimWalkRight2Tiles:
	DB $29, $28, $39, $38
SpritePlayerAnimWalkRight3Tiles:
	DB $2B, $2A, $3B, $3A
SpritePlayerAnimWalkRight4Tiles:
	DB $2D, $2C, $3D, $3C
SpritePlayerAnimWalkDown1Tiles
	DB $46, $47, $56, $57
SpritePlayerAnimWalkDown2Tiles
	DB $48, $49, $58, $59
SpritePlayerAnimWalkDown3Tiles
	DB $4A, $4B, $5A, $5B
SpritePlayerAnimWalkDown4Tiles
	DB $4C, $4D, $5C, $5D
SpritePlayerAnimWalkUp1Tiles
	DB $66, $67, $76, $77
SpritePlayerAnimWalkUp2Tiles
	DB $68, $69, $78, $79
SpritePlayerAnimWalkUp3Tiles
	DB $6A, $6B, $7A, $7B
SpritePlayerAnimWalkUp4Tiles
	DB $6C, $6D, $7C, $7D
SpritePlayerAnimWalkLeftUp1Tiles
	DB $86, $87, $96, $97
SpritePlayerAnimWalkLeftUp2Tiles
	DB $88, $89, $98, $99
SpritePlayerAnimWalkLeftUp3Tiles
	DB $8A, $8B, $9A, $9B
SpritePlayerAnimWalkLeftUp4Tiles
	DB $8C, $8D, $9C, $9D
SpritePlayerAnimWalkRightUp1Tiles
	DB $87, $86, $97, $96
SpritePlayerAnimWalkRightUp2Tiles
	DB $89, $88, $99, $98
SpritePlayerAnimWalkRightUp3Tiles
	DB $8B, $8A, $9B, $9A
SpritePlayerAnimWalkRightUp4Tiles
	DB $8D, $8C, $9D, $9C
SpritePlayerAnimWalkLeftDown1Tiles
	DB $A6, $A7, $B6, $B7
SpritePlayerAnimWalkLeftDown2Tiles
	DB $A8, $A9, $B8, $B9
SpritePlayerAnimWalkLeftDown3Tiles
	DB $AA, $AB, $BA, $BB
SpritePlayerAnimWalkLeftDown4Tiles
	DB $AC, $AD, $BC, $BD
SpritePlayerAnimWalkRightDown1Tiles
	DB $A7, $A6, $B7, $B6
SpritePlayerAnimWalkRightDown2Tiles
	DB $A9, $A8, $B9, $B8
SpritePlayerAnimWalkRightDown3Tiles
	DB $AB, $AA, $BB, $BA
SpritePlayerAnimWalkRightDown4Tiles
	DB $AD, $AC, $BD, $BC
;tripod
SpriteTripodAnimsTilesLow:
	DB <(SpriteTripodAnimLeft1Tiles)
	DB <(SpriteTripodAnimRight1Tiles)
	DB <(SpriteTripodAnimLeft1Tiles), <(SpriteTripodAnimLeft2Tiles), <(SpriteTripodAnimLeft3Tiles), <(SpriteTripodAnimLeft4Tiles)
	DB <(SpriteTripodAnimRight1Tiles), <(SpriteTripodAnimRight2Tiles), <(SpriteTripodAnimRight3Tiles), <(SpriteTripodAnimRight4Tiles)
SpriteTripodAnimsTilesHi:
	DB >(SpriteTripodAnimLeft1Tiles)
	DB >(SpriteTripodAnimRight1Tiles)
	DB >(SpriteTripodAnimLeft1Tiles), >(SpriteTripodAnimLeft2Tiles), >(SpriteTripodAnimLeft3Tiles), >(SpriteTripodAnimLeft4Tiles)
	DB >(SpriteTripodAnimRight1Tiles), >(SpriteTripodAnimRight2Tiles), >(SpriteTripodAnimRight3Tiles), >(SpriteTripodAnimRight4Tiles)
SpriteTripodAnimLeft1Tiles:
	DB $06, $07, $16, $17
SpriteTripodAnimLeft2Tiles:
	DB $08, $09, $18, $19
SpriteTripodAnimLeft3Tiles:
	DB $0A, $0B, $1A, $1B
SpriteTripodAnimLeft4Tiles:
	DB $0C, $0D, $1C, $1D
SpriteTripodAnimRight1Tiles:
	DB $07, $06, $17, $16
SpriteTripodAnimRight2Tiles:
	DB $09, $08, $19, $18
SpriteTripodAnimRight3Tiles:
	DB $0B, $0A, $1B, $1A
SpriteTripodAnimRight4Tiles:
	DB $0D, $0C, $1D, $1C
;tank
SpriteTankAnimsTilesLow:
	DB <(SpriteTankAnimWalkLeft1Tiles)
	DB <(SpriteTankAnimWalkLeft1Tiles), <(SpriteTankAnimWalkLeft2Tiles)
	DB <(SpriteTankAnimWalkRight1Tiles)
	DB <(SpriteTankAnimWalkRight1Tiles), <(SpriteTankAnimWalkRight2Tiles)
	DB <(SpriteTankAnimWalkDown1Tiles)
	DB <(SpriteTankAnimWalkDown1Tiles), <(SpriteTankAnimWalkDown2Tiles)
	DB <(SpriteTankAnimWalkUp1Tiles)
	DB <(SpriteTankAnimWalkUp1Tiles), <(SpriteTankAnimWalkUp2Tiles)
	DB <(SpriteTankAnimShootLeftTiles)
	DB <(SpriteTankAnimShootRightTiles)
	DB <(SpriteTankAnimShootDownTiles)
	DB <(SpriteTankAnimShootUpTiles)
SpriteTankAnimsTilesHi:
	DB >(SpriteTankAnimWalkLeft1Tiles)
	DB >(SpriteTankAnimWalkLeft1Tiles), >(SpriteTankAnimWalkLeft2Tiles)
	DB >(SpriteTankAnimWalkRight1Tiles)
	DB >(SpriteTankAnimWalkRight1Tiles), >(SpriteTankAnimWalkRight2Tiles)
	DB >(SpriteTankAnimWalkDown1Tiles)
	DB >(SpriteTankAnimWalkDown1Tiles), >(SpriteTankAnimWalkDown2Tiles)
	DB >(SpriteTankAnimWalkUp1Tiles)
	DB >(SpriteTankAnimWalkUp1Tiles), >(SpriteTankAnimWalkUp2Tiles)
	DB >(SpriteTankAnimShootLeftTiles)
	DB >(SpriteTankAnimShootRightTiles)
	DB >(SpriteTankAnimShootDownTiles)
	DB >(SpriteTankAnimShootUpTiles)
SpriteTankAnimWalkLeft1Tiles:
	DB $00, $01, $10, $11
SpriteTankAnimWalkLeft2Tiles:
	DB $00, $01, $20, $21
SpriteTankAnimWalkRight1Tiles:
	DB $01, $00, $11, $10
SpriteTankAnimWalkRight2Tiles:
	DB $01, $00, $21, $20
SpriteTankAnimWalkDown1Tiles:
	DB $34, $35, $44, $45
SpriteTankAnimWalkDown2Tiles:
	DB $34, $35, $54, $55
SpriteTankAnimWalkUp1Tiles:
	DB $32, $33, $42, $43
SpriteTankAnimWalkUp2Tiles:
	DB $32, $33, $52, $53
SpriteTankAnimShootLeftTiles:
	DB $60, $61, $70, $71
SpriteTankAnimShootRightTiles:
	DB $61, $60, $71, $70
SpriteTankAnimShootDownTiles:
	DB $84, $85, $94, $95
SpriteTankAnimShootUpTiles:
	DB $82, $83, $92, $93
;hurt
SpriteHurtAnimsTilesLow:
	DB <(SpriteHurtAnimStayTiles)
	DB <(SpriteHurtAnimStayTiles), <(SpriteNone)
SpriteHurtAnimsTilesHi:
	DB >(SpriteHurtAnimStayTiles)
	DB >(SpriteHurtAnimStayTiles), >(SpriteNone)
SpriteHurtAnimStayTiles:
	DB $A0
SpriteNone:
	DB $FF
;gun
SpriteGunAnimsTilesLow:
	DB <(SpriteGunAnimStayTiles)
SpriteGunAnimsTilesHi:
	DB >(SpriteGunAnimStayTiles)
SpriteGunAnimStayTiles:
	DB $E2, $E3
;coin
SpriteCoinAnimsTilesLow:
	DB <(SpriteCoinAnimStayTiles)
SpriteCoinAnimsTilesHi:
	DB >(SpriteCoinAnimStayTiles)
SpriteCoinAnimStayTiles:
	DB $E4
;explosion
SpriteExpAnimsTilesLow:
	DB <(SpriteExpAnimBoom1Tiles)
	DB <(SpriteExpAnimBoom2Tiles)
	DB <(SpriteExpAnimBoom3Tiles)
	DB <(SpriteExpAnimBoom4Tiles)
	DB <(SpriteExpAnimBoom5Tiles)
SpriteExpAnimsTilesHi:
	DB >(SpriteExpAnimBoom1Tiles)
	DB >(SpriteExpAnimBoom2Tiles)
	DB >(SpriteExpAnimBoom3Tiles)
	DB >(SpriteExpAnimBoom4Tiles)
	DB >(SpriteExpAnimBoom5Tiles)
SpriteExpAnimBoom1Tiles:
	DB $C0, $C1, $D0, $D1
SpriteExpAnimBoom2Tiles:
	DB $C2, $C3, $D2, $D3
SpriteExpAnimBoom3Tiles:
	DB $C4, $C5, $D4, $D5
SpriteExpAnimBoom4Tiles:
	DB $C6, $C7, $D6, $D7
SpriteExpAnimBoom5Tiles:
	DB $A2, $A2, $A2, $A2
;coin small
SpriteCoinSmallAnimsTilesLow:
	DB <(SpriteCoinSmallAnimStayTiles)
	DB <(SpriteCoinSmallAnimStayTiles), <(SpriteNone)
SpriteCoinSmallAnimsTilesHi:
	DB >(SpriteCoinSmallAnimStayTiles)
	DB >(SpriteCoinSmallAnimStayTiles), >(SpriteNone)
SpriteCoinSmallAnimStayTiles:
	DB $FC
;player bullet
SpritePlayerBulletAnimsTilesLow:
	DB <(SpritePlayerBulletAnimsTiles)
SpritePlayerBulletAnimsTilesHi:
	DB >(SpritePlayerBulletAnimsTiles)
SpritePlayerBulletAnimsTiles:
	DB $B0
;bullet ghost
SpritePlayerBulletGhostAnimsTilesLow:
	DB <(SpritePlayerBulletGhostAnimsTiles1), <(SpritePlayerBulletGhostAnimsTiles1)
SpritePlayerBulletGhostAnimsTilesHi:
	DB >(SpritePlayerBulletGhostAnimsTiles1), >(SpritePlayerBulletGhostAnimsTiles1)
SpritePlayerBulletGhostAnimsTiles1:
	DB $B1
;enemy bullet
SpriteEnemyBulletAnimsTilesLow:
	DB <(SpriteEnemyBulletAnimsTiles)
SpriteEnemyBulletAnimsTilesHi:
	DB >(SpriteEnemyBulletAnimsTiles)
SpriteEnemyBulletAnimsTiles:
	DB $B2
;enemy crab
SpriteCrabAnimsTilesLow:
	DB <(SpriteCrabAnimsTiles)
SpriteCrabAnimsTilesHi:
	DB >(SpriteCrabAnimsTiles)
SpriteCrabAnimsTiles:
	DB $30, $31, $40, $41
;enemy boss1
SpriteBoss1UpAnimsTilesLow:
	DB <(SpriteBoss1UpAnimsTiles)
SpriteBoss1UpAnimsTilesHi:
	DB >(SpriteBoss1UpAnimsTiles)
SpriteBoss1UpAnimsTiles:
	DB $0E, $0F, $1E, $1F, $2E, $2F, $3E, $3F, $4E, $4F, $5E, $5F, $FF
SpriteBoss1MiddleAnimsTilesLow:
	DB <(SpriteBoss1MiddleAnimsTiles)
SpriteBoss1MiddleAnimsTilesHi:
	DB >(SpriteBoss1MiddleAnimsTiles)
SpriteBoss1MiddleAnimsTiles:
	DB $8E, $6E, $6F, $7E, $7F, $AF, $BE, $BF, $CE, $CF, $DE, $DF 
SpriteBoss1DownAnimsTilesLow:
	DB <(SpriteBoss1DownAnimsTiles)
SpriteBoss1DownAnimsTilesHi:
	DB >(SpriteBoss1DownAnimsTiles)
SpriteBoss1DownAnimsTiles:
	DB $8F, $9E, $9F, $AE
;trigun
SpriteTrigunAnimsTilesLow:
	DB <(SpriteTrigunAnimStayTiles)
	DB <(SpriteTrigunAnimStayTiles), <(SpriteNone)
SpriteTrigunAnimsTilesHi:
	DB >(SpriteTrigunAnimStayTiles)
	DB >(SpriteTrigunAnimStayTiles), >(SpriteNone)
SpriteTrigunAnimStayTiles:
	DB $F1
;key
SpriteKeyAnimsTilesLow:
	DB <(SpriteKeyAnimStayTiles)
	DB <(SpriteKeyAnimStayTiles), <(SpriteNone)
SpriteKeyAnimsTilesHi:
	DB >(SpriteKeyAnimStayTiles)
	DB >(SpriteKeyAnimStayTiles), >(SpriteNone)
SpriteKeyAnimStayTiles:
	DB $F6
;----------------------------------------------------------------
;tiles attributes
;----------------------------------------------------------------
SpriteTypesAnimsAttrLowLow:
	DB <(SpritePlayerAnimsAttrLow), <(SpriteTripodAnimsAttrLow), <(SpriteTankAnimsAttrLow), <(SpriteHurtAnimsAttrLow), <(SpriteGunAnimsAttrLow), <(SpriteGunAnimsAttrLow), <(SpriteExpAnimsAttrLow), <(SpriteCoinSmallAnimsAttrLow)
	DB <(SpritePlayerBulletAnimsAttrLow), <(SpritePlayerBulletGhostAnimsAttrLow), <(SpritePlayerBulletAnimsAttrLow), <(SpritePlayerAnimsAttrLow), <(SpriteBoss1UpAnimsAttrLow), <(SpriteBoss1MiddleAnimsAttrLow), <(SpriteBoss1DownAnimsAttrLow), <(SpriteTrigunAnimsAttrLow)
	DB <(SpriteTrigunAnimsAttrLow)
SpriteTypesAnimsAttrLowHi:
	DB >(SpritePlayerAnimsAttrLow), >(SpriteTripodAnimsAttrLow), >(SpriteTankAnimsAttrLow), >(SpriteHurtAnimsAttrLow), >(SpriteGunAnimsAttrLow), >(SpriteGunAnimsAttrLow), >(SpriteExpAnimsAttrLow), >(SpriteCoinSmallAnimsAttrLow)
	DB >(SpritePlayerBulletAnimsAttrLow), >(SpritePlayerBulletGhostAnimsAttrLow), >(SpritePlayerBulletAnimsAttrLow), >(SpritePlayerAnimsAttrLow), >(SpriteBoss1UpAnimsAttrLow), >(SpriteBoss1MiddleAnimsAttrLow), >(SpriteBoss1DownAnimsAttrLow), >(SpriteTrigunAnimsAttrLow)
	DB >(SpriteTrigunAnimsAttrLow)
SpriteTypesAnimsAttrHiLow:
	DB <(SpritePlayerAnimsAttrHi), <(SpriteTripodAnimsAttrHi), <(SpriteTankAnimsAttrHi), <(SpriteHurtAnimsAttrHi), <(SpriteGunAnimsAttrHi), <(SpriteGunAnimsAttrHi), <(SpriteExpAnimsAttrHi), <(SpriteCoinSmallAnimsAttrHi)
	DB <(SpritePlayerBulletAnimsAttrHi), <(SpritePlayerBulletGhostAnimsAttrHi), <(SpritePlayerBulletAnimsAttrHi), <(SpritePlayerAnimsAttrHi), <(SpriteBoss1UpAnimsAttrHi), <(SpriteBoss1MiddleAnimsAttrHi), <(SpriteBoss1DownAnimsAttrHi), <(SpriteTrigunAnimsAttrHi)
	DB <(SpriteTrigunAnimsAttrHi)
SpriteTypesAnimsAttrHiHi:
	DB >(SpritePlayerAnimsAttrHi), >(SpriteTripodAnimsAttrHi), >(SpriteTankAnimsAttrHi), >(SpriteHurtAnimsAttrHi), >(SpriteGunAnimsAttrHi), >(SpriteGunAnimsAttrHi), >(SpriteExpAnimsAttrHi), >(SpriteCoinSmallAnimsAttrHi)
	DB >(SpritePlayerBulletAnimsAttrHi), >(SpritePlayerBulletGhostAnimsAttrHi), >(SpritePlayerBulletAnimsAttrHi), >(SpritePlayerAnimsAttrHi), >(SpriteBoss1UpAnimsAttrHi), >(SpriteBoss1MiddleAnimsAttrHi), >(SpriteBoss1DownAnimsAttrHi), >(SpriteTrigunAnimsAttrHi)
	DB >(SpriteTrigunAnimsAttrHi)
;player
SpritePlayerAnimsAttrLow:
	DB <(SpritePlayerAnimWalkLeft1Attr)
	DB <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr)
	DB <(SpritePlayerAnimWalkRight1Attr)
	DB <(SpritePlayerAnimWalkRight1Attr), <(SpritePlayerAnimWalkRight1Attr), <(SpritePlayerAnimWalkRight1Attr), <(SpritePlayerAnimWalkRight1Attr)
	DB <(SpritePlayerAnimWalkLeft1Attr)
	DB <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr)
	DB <(SpritePlayerAnimWalkLeft1Attr)
	DB <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr)
	DB <(SpritePlayerAnimWalkLeft1Attr)
	DB <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr)
	DB <(SpritePlayerAnimWalkRight1Attr)
	DB <(SpritePlayerAnimWalkRight1Attr), <(SpritePlayerAnimWalkRight1Attr), <(SpritePlayerAnimWalkRight1Attr), <(SpritePlayerAnimWalkRight1Attr)
	DB <(SpritePlayerAnimWalkLeft1Attr)
	DB <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr), <(SpritePlayerAnimWalkLeft1Attr)
	DB <(SpritePlayerAnimWalkRight1Attr)
	DB <(SpritePlayerAnimWalkRight1Attr), <(SpritePlayerAnimWalkRight1Attr), <(SpritePlayerAnimWalkRight1Attr), <(SpritePlayerAnimWalkRight1Attr)
SpritePlayerAnimsAttrHi:
	DB >(SpritePlayerAnimWalkLeft1Attr)
	DB >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr)
	DB >(SpritePlayerAnimWalkRight1Attr)
	DB >(SpritePlayerAnimWalkRight1Attr), >(SpritePlayerAnimWalkRight1Attr), >(SpritePlayerAnimWalkRight1Attr), >(SpritePlayerAnimWalkRight1Attr)
	DB >(SpritePlayerAnimWalkLeft1Attr)
	DB >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr)
	DB >(SpritePlayerAnimWalkLeft1Attr)
	DB >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr)
	DB >(SpritePlayerAnimWalkLeft1Attr)
	DB >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr)
	DB >(SpritePlayerAnimWalkRight1Attr)
	DB >(SpritePlayerAnimWalkRight1Attr), >(SpritePlayerAnimWalkRight1Attr), >(SpritePlayerAnimWalkRight1Attr), >(SpritePlayerAnimWalkRight1Attr)
	DB >(SpritePlayerAnimWalkLeft1Attr)
	DB >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr), >(SpritePlayerAnimWalkLeft1Attr)
	DB >(SpritePlayerAnimWalkRight1Attr)
	DB >(SpritePlayerAnimWalkRight1Attr), >(SpritePlayerAnimWalkRight1Attr), >(SpritePlayerAnimWalkRight1Attr), >(SpritePlayerAnimWalkRight1Attr)
SpritePlayerAnimWalkLeft1Attr:
	DB $00, $00, $00, $00
SpritePlayerAnimWalkRight1Attr:
	DB $40, $40, $40, $40
;tripod
SpriteTripodAnimsAttrLow:
	DB <(SpriteTripodAnimLeft1Attr)
	DB <(SpriteTripodAnimRight1Attr)
	DB <(SpriteTripodAnimLeft1Attr), <(SpriteTripodAnimLeft1Attr), <(SpriteTripodAnimLeft1Attr), <(SpriteTripodAnimLeft1Attr) 
	DB <(SpriteTripodAnimRight1Attr), <(SpriteTripodAnimRight1Attr), <(SpriteTripodAnimRight1Attr), <(SpriteTripodAnimRight1Attr)
SpriteTripodAnimsAttrHi:
	DB >(SpriteTripodAnimLeft1Attr)
	DB >(SpriteTripodAnimRight1Attr)
	DB >(SpriteTripodAnimLeft1Attr), >(SpriteTripodAnimLeft1Attr), >(SpriteTripodAnimLeft1Attr), >(SpriteTripodAnimLeft1Attr) 
	DB >(SpriteTripodAnimRight1Attr), >(SpriteTripodAnimRight1Attr), >(SpriteTripodAnimRight1Attr), >(SpriteTripodAnimRight1Attr)
SpriteTripodAnimLeft1Attr:
	DB $01, $01, $01, $01
SpriteTripodAnimRight1Attr:
	DB $41, $41, $41, $41
;tank
SpriteTankAnimsAttrLow:
	DB <(SpriteTankAnimWalkLeft1Attr)
	DB <(SpriteTankAnimWalkLeft1Attr), <(SpriteTankAnimWalkLeft1Attr)
	DB <(SpriteTankAnimWalkRight1Attr)
	DB <(SpriteTankAnimWalkRight1Attr), <(SpriteTankAnimWalkRight1Attr)
	DB <(SpriteTankAnimWalkLeft1Attr)
	DB <(SpriteTankAnimWalkLeft1Attr), <(SpriteTankAnimWalkLeft1Attr)
	DB <(SpriteTankAnimWalkLeft1Attr)
	DB <(SpriteTankAnimWalkLeft1Attr), <(SpriteTankAnimWalkLeft1Attr)
	DB <(SpriteTankAnimShootLeft1Attr)
	DB <(SpriteTankAnimShootRight1Attr)
	DB <(SpriteTankAnimShootLeft1Attr)
	DB <(SpriteTankAnimShootLeft1Attr)
SpriteTankAnimsAttrHi:
	DB >(SpriteTankAnimWalkLeft1Attr)
	DB >(SpriteTankAnimWalkLeft1Attr), >(SpriteTankAnimWalkLeft1Attr)
	DB >(SpriteTankAnimWalkRight1Attr)
	DB >(SpriteTankAnimWalkRight1Attr), >(SpriteTankAnimWalkRight1Attr)
	DB >(SpriteTankAnimWalkLeft1Attr)
	DB >(SpriteTankAnimWalkLeft1Attr), >(SpriteTankAnimWalkLeft1Attr)
	DB >(SpriteTankAnimWalkLeft1Attr)
	DB >(SpriteTankAnimWalkLeft1Attr), >(SpriteTankAnimWalkLeft1Attr)
	DB >(SpriteTankAnimShootLeft1Attr)
	DB >(SpriteTankAnimShootRight1Attr)
	DB >(SpriteTankAnimShootLeft1Attr)
	DB >(SpriteTankAnimShootLeft1Attr)
SpriteTankAnimWalkLeft1Attr:
	DB $01, $01, $01, $01
SpriteTankAnimWalkRight1Attr:
	DB $41, $41, $41, $41
SpriteTankAnimShootLeft1Attr:
	DB $00, $00, $00, $00
SpriteTankAnimShootRight1Attr
	DB $40, $40, $40, $40
;hurt
SpriteHurtAnimsAttrLow:
	DB <(SpriteHurtAnimStayAttr)
	DB <(SpriteHurtAnimStayAttr), <(SpriteHurtAnimStayAttr)
SpriteHurtAnimsAttrHi:
	DB >(SpriteHurtAnimStayAttr)
	DB >(SpriteHurtAnimStayAttr), >(SpriteHurtAnimStayAttr)
SpriteHurtAnimStayAttr:
	DB $00
;coin small
SpriteCoinSmallAnimsAttrLow:
	DB <(SpriteCoinSmallAnimStayAttr)
	DB <(SpriteCoinSmallAnimStayAttr), <(SpriteCoinSmallAnimStayAttr)
SpriteCoinSmallAnimsAttrHi:
	DB >(SpriteCoinSmallAnimStayAttr)
	DB >(SpriteCoinSmallAnimStayAttr), >(SpriteCoinSmallAnimStayAttr)
SpriteCoinSmallAnimStayAttr:
	DB $03
;gun
SpriteGunAnimsAttrLow:
	DB <(SpriteGunAnimStayAttr)
SpriteGunAnimsAttrHi:
	DB >(SpriteGunAnimStayAttr)
SpriteGunAnimStayAttr:
	DB $03, $03
;coin
;explosion
SpriteExpAnimsAttrLow:
	DB <(SpriteExpAnimBoom1Attr)
	DB <(SpriteExpAnimBoom1Attr)
	DB <(SpriteExpAnimBoom1Attr)
	DB <(SpriteExpAnimBoom1Attr)
	DB <(SpriteExpAnimBoom1Attr)
SpriteExpAnimsAttrHi:
	DB >(SpriteExpAnimBoom1Attr)
	DB >(SpriteExpAnimBoom1Attr)
	DB >(SpriteExpAnimBoom1Attr)
	DB >(SpriteExpAnimBoom1Attr)
	DB >(SpriteExpAnimBoom1Attr)
SpriteExpAnimBoom1Attr:
	DB $00, $00, $00, $00
;player bullet
SpritePlayerBulletAnimsAttrLow:
	DB <(SpritePlayerBulletAnimsAttr)
SpritePlayerBulletAnimsAttrHi:
	DB >(SpritePlayerBulletAnimsAttr)
SpritePlayerBulletAnimsAttr:
	DB $00
;bullet ghost
SpritePlayerBulletGhostAnimsAttrLow:
	DB <(SpritePlayerBulletGhostAnimsAttr), <(SpritePlayerBulletGhostAnimsAttr)
SpritePlayerBulletGhostAnimsAttrHi:
	DB >(SpritePlayerBulletGhostAnimsAttr), >(SpritePlayerBulletGhostAnimsAttr)
SpritePlayerBulletGhostAnimsAttr:
	DB $00
;boss 1
SpriteBoss1UpAnimsAttrLow:
	DB <(SpriteBoss1UpAnimsAttr)
SpriteBoss1UpAnimsAttrHi:
	DB >(SpriteBoss1UpAnimsAttr)
SpriteBoss1UpAnimsAttr:
	DB $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
SpriteBoss1MiddleAnimsAttrLow:
	DB <(SpriteBoss1MiddleAnimsAttr)
SpriteBoss1MiddleAnimsAttrHi:
	DB >(SpriteBoss1MiddleAnimsAttr)
SpriteBoss1MiddleAnimsAttr:
	DB $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
SpriteBoss1DownAnimsAttrLow:
	DB <(SpriteBoss1DownAnimsAttr)
SpriteBoss1DownAnimsAttrHi:
	DB >(SpriteBoss1DownAnimsAttr)
SpriteBoss1DownAnimsAttr:
	DB $00, $00, $00, $00, $00
;trigun
SpriteTrigunAnimsAttrLow:
	DB <(SpriteTrigunAnimStayAttr)
	DB <(SpriteTrigunAnimStayAttr), <(SpriteTrigunAnimStayAttr)
SpriteTrigunAnimsAttrHi:
	DB >(SpriteTrigunAnimStayAttr)
	DB >(SpriteTrigunAnimStayAttr), >(SpriteTrigunAnimStayAttr)
SpriteTrigunAnimStayAttr:
	DB $02
;----------------------------------------------------------------
; frames order
;----------------------------------------------------------------
SpriteTypesAnimsFramesLow:
	DB <(SpritePlayerAnimsFrames), <(SpriteTripodAnimsFrames), <(SpriteTankAnimsFrames), <(SpriteHurtAnimsFrames), <(SpriteTripodAnimsFrames), <(SpriteTripodAnimsFrames), <(SpriteExpAnimsFrames), <(SpriteHurtAnimsFrames)
	DB <(SpriteTripodAnimsFrames), <(SpriteBulletGhostAnimsFrames), <(SpriteTripodAnimsFrames), <(SpriteTripodAnimsFrames), <(SpriteTripodAnimsFrames), <(SpriteTripodAnimsFrames), <(SpriteTripodAnimsFrames), <(SpriteHurtAnimsFrames)
	DB <(SpriteHurtAnimsFrames)
SpriteTypesAnimsFramesHi:
	DB >(SpritePlayerAnimsFrames), >(SpriteTripodAnimsFrames), >(SpriteTankAnimsFrames), >(SpriteHurtAnimsFrames), >(SpriteTripodAnimsFrames), >(SpriteTripodAnimsFrames), >(SpriteExpAnimsFrames), >(SpriteHurtAnimsFrames)
	DB >(SpriteTripodAnimsFrames), >(SpriteBulletGhostAnimsFrames), >(SpriteTripodAnimsFrames), >(SpriteTripodAnimsFrames), >(SpriteTripodAnimsFrames), >(SpriteTripodAnimsFrames), >(SpriteTripodAnimsFrames), >(SpriteHurtAnimsFrames)
	DB >(SpriteHurtAnimsFrames)
;player
SpritePlayerAnimsFrames:
	DB $01
	DB $00, $00, $00, $04
	DB $01
	DB $00, $00, $00, $04
	DB $01
	DB $00, $00, $00, $04
	DB $01
	DB $00, $00, $00, $04
	DB $01
	DB $00, $00, $00, $04
	DB $01
	DB $00, $00, $00, $04
	DB $01
	DB $00, $00, $00, $04
	DB $01
	DB $00, $00, $00, $04
;tripod
SpriteTripodAnimsFrames:
	DB $01 
	DB $01
	DB $00,$00,$00,$04
	DB $00,$00,$00,$04
;hurt
;coin small
;trigun
SpriteHurtAnimsFrames:
	DB $01 
	DB $00, $02
;tank
SpriteTankAnimsFrames:
	DB $01
	DB $00, $02
	DB $01
	DB $00, $02
	DB $01
	DB $00, $02
	DB $01
	DB $00, $02
	DB $01
	DB $01
	DB $01
	DB $01
;hurt
;gun
;coin
;explosion
SpriteExpAnimsFrames:
	DB $00, $00, $00, $00, $05
;bullet ghost
SpriteBulletGhostAnimsFrames:
	DB $00, $02
;----------------------------------------------------------------
; frames time
;----------------------------------------------------------------
SpriteTypesAnimsTimesLow:
	DB <(SpritePlayerAnimsTimes), <(SpriteTripodAnimsTimes), <(SpriteTankAnimsTimes), <(SpriteHurtAnimsTimes), <(SpriteTripodAnimsTimes), <(SpriteTripodAnimsTimes), <(SpriteExpAnimsTimes), <(SpriteHurtAnimsTimes)
	DB <(SpriteTripodAnimsTimes), <(SpriteBulletGhostTimes), <(SpriteTripodAnimsTimes), <(SpriteTripodAnimsTimes), <(SpriteTripodAnimsTimes), <(SpriteTripodAnimsTimes), <(SpriteTripodAnimsTimes), <(SpriteHurtAnimsTimes)
	DB <(SpriteHurtAnimsTimes)
SpriteTypesAnimsTimesHi:
	DB >(SpritePlayerAnimsTimes), >(SpriteTripodAnimsTimes), >(SpriteTankAnimsTimes), >(SpriteHurtAnimsTimes), >(SpriteTripodAnimsTimes), >(SpriteTripodAnimsTimes), >(SpriteExpAnimsTimes), >(SpriteHurtAnimsTimes)
	DB >(SpriteTripodAnimsTimes), >(SpriteBulletGhostTimes), >(SpriteTripodAnimsTimes), >(SpriteTripodAnimsTimes), >(SpriteTripodAnimsTimes), >(SpriteTripodAnimsTimes), >(SpriteTripodAnimsTimes), >(SpriteHurtAnimsTimes)
	DB >(SpriteHurtAnimsTimes)
;player
SpritePlayerAnimsTimes:
	DB $00
	DB $06, 06, 06, 06
	DB $00
	DB $06, 06, 06, 06
	DB $00
	DB $06, 06, 06, 06
	DB $00
	DB $06, 06, 06, 06
	DB $00
	DB $06, 06, 06, 06
	DB $00
	DB $06, 06, 06, 06
	DB $00
	DB $06, 06, 06, 06
	DB $00
	DB $06, 06, 06, 06
;tripod 
SpriteTripodAnimsTimes:
	DB $00
	DB $00
	DB $06,$06,$06,$06
	DB $06,$06,$06,$06
;hurt
;coin small
;trigun
SpriteHurtAnimsTimes:
	DB $00
	DB $03, $03
;tank
SpriteTankAnimsTimes:
	DB $00
	DB $06, 06
	DB $00
	DB $06, 06
	DB $00
	DB $06, 06
	DB $00
	DB $06, 06
	DB $0C
	DB $0C
	DB $0C
	DB $0C
;hurt 
;gun
;coin
;explosion
SpriteExpAnimsTimes:
	DB $06, 06, 06, 06, 01
;bullet ghost
SpriteBulletGhostTimes:
	DB $06, $06
