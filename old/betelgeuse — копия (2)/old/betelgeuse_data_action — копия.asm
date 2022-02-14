SpriteTypesMoveFunctionsLow:
	DB <(SpriteMoveFunctionNone), <(SpriteMoveFunctionNone), <(SpriteMoveFunctionNone), <(SpriteMoveFunctionNone), <(SpriteMoveFunctionNone), <(SpriteMoveFunctionNone)
SpriteTypesMoveFunctionsHi:
	DB >(SpriteMoveFunctionNone), >(SpriteMoveFunctionNone), >(SpriteMoveFunctionNone), >(SpriteMoveFunctionNone), >(SpriteMoveFunctionNone), >(SpriteMoveFunctionNone)

SpriteMoveFunctionNone:
	JMP SpritesUpdateActionsReturn
	
SpriteMoveFunctionWobble:
	LDA gameState
	CMP #$01
	BNE +
		LDA #$01
		STA spritesStateAction, X
		LDA #$00
		STA spritesTimerAction, X
		+
	JMP SpritesUpdateActionsReturn
;----------------------------------------------------------------
;x change
;----------------------------------------------------------------
SpriteTypesMoveTilesXLowLow:
	DB <(SpritePlayerMoveTilesXLow), <(SpritePlayerMoveTilesXLow), <(SpritePlayerMoveTilesXLow), <(SpriteHurtMoveTilesXLow), <(SpriteGunMoveTilesXLow), <(SpriteHurtMoveTilesXLow)
SpriteTypesMoveTilesXLowHi:
	DB >(SpritePlayerMoveTilesXLow), >(SpritePlayerMoveTilesXLow), >(SpritePlayerMoveTilesXLow), >(SpriteHurtMoveTilesXLow), >(SpriteGunMoveTilesXLow), >(SpriteHurtMoveTilesXLow)
SpriteTypesMoveTilesXHiLow:
	DB <(SpritePlayerMoveTilesXHi), <(SpritePlayerMoveTilesXHi), <(SpritePlayerMoveTilesXHi), <(SpriteHurtMoveTilesXHi), <(SpriteGunMoveTilesXHi), <(SpriteHurtMoveTilesXHi)
SpriteTypesMoveTilesXHiHi:
	DB >(SpritePlayerMoveTilesXHi), >(SpritePlayerMoveTilesXHi), >(SpritePlayerMoveTilesXHi), >(SpriteHurtMoveTilesXHi), >(SpriteGunMoveTilesXHi), >(SpriteHurtMoveTilesXHi)
;player
SpritePlayerMoveTilesXLow:
	DB <(SpriteMoveType2x2X)
SpritePlayerMoveTilesXHi:
	DB >(SpriteMoveType2x2X)
;gun
SpriteGunMoveTilesXLow:
	DB <(SpriteMoveType2x1X)
	DB <(SpriteMoveType2x1X), <(SpriteMoveType2x1X)
SpriteGunMoveTilesXHi:
	DB >(SpriteMoveType2x1X)
	DB >(SpriteMoveType2x1X), >(SpriteMoveType2x1X)
;hurt
SpriteHurtMoveTilesXLow:
	DB <(SpriteMoveType1x1X)
	DB <(SpriteMoveType1x1X), <(SpriteMoveType1x1X)
SpriteHurtMoveTilesXHi:
	DB >(SpriteMoveType1x1X)
	DB >(SpriteMoveType1x1X), >(SpriteMoveType1x1X)
	
SpriteMoveType1x1X:
	DB $00
SpriteMoveType2x1X:
	DB $00, $08
SpriteMoveType2x2X:
	DB $00, $08, $00, $08

;----------------------------------------------------------------
;y change
;----------------------------------------------------------------
SpriteTypesMoveTilesYLowLow:
	DB <(SpritePlayerMoveTilesYLow), <(SpritePlayerMoveTilesYLow), <(SpritePlayerMoveTilesYLow), <(SpriteHurtMoveTilesYLow), <(SpriteGunMoveTilesYLow), <(SpriteHurtMoveTilesYLow)
SpriteTypesMoveTilesYLowHi:
	DB >(SpritePlayerMoveTilesYLow), >(SpritePlayerMoveTilesYLow), >(SpritePlayerMoveTilesYLow), >(SpriteHurtMoveTilesYLow), >(SpriteGunMoveTilesYLow), >(SpriteHurtMoveTilesYLow)
SpriteTypesMoveTilesYHiLow:
	DB <(SpritePlayerMoveTilesYHi), <(SpritePlayerMoveTilesYHi), <(SpritePlayerMoveTilesYHi), <(SpriteHurtMoveTilesYHi), <(SpriteGunMoveTilesYHi), <(SpriteHurtMoveTilesYHi)
SpriteTypesMoveTilesYHiHi:
	DB >(SpritePlayerMoveTilesYHi), >(SpritePlayerMoveTilesYHi), >(SpritePlayerMoveTilesYHi), >(SpriteHurtMoveTilesYHi), >(SpriteGunMoveTilesYHi), >(SpriteHurtMoveTilesYHi)
;player
SpritePlayerMoveTilesYLow:
	DB <(SpriteMoveNone2x2YTiles)
SpritePlayerMoveTilesYHi:
	DB >(SpriteMoveNone2x2YTiles)
;gun
SpriteGunMoveTilesYLow:
	DB <(SpriteMoveNone2x1YTiles)
	DB <(SpriteGunMoveUp2x1YTiles), <(SpriteGunMoveDown2x1YTiles)
SpriteGunMoveTilesYHi:
	DB >(SpriteMoveNone2x1YTiles)
	DB >(SpriteGunMoveUp2x1YTiles), >(SpriteGunMoveDown2x1YTiles)
SpriteGunMoveUp2x1YTiles:
	DB $00, $00
SpriteGunMoveDown2x1YTiles:
	DB $FF, $FF
;hurt
SpriteHurtMoveTilesYLow:
	DB <(SpriteMoveNone1x1YTiles)
	DB <(SpriteHurtMoveUp1x1YTiles), <(SpriteHurtMoveDown1x1YTiles)
SpriteHurtMoveTilesYHi:
	DB >(SpriteMoveNone1x1YTiles)
	DB >(SpriteHurtMoveUp1x1YTiles), >(SpriteHurtMoveDown1x1YTiles)
SpriteHurtMoveUp1x1YTiles:
	DB $00
SpriteHurtMoveDown1x1YTiles:
	DB $FF
	
SpriteMoveNone1x1YTiles:
	DB $00
SpriteMoveNone2x1YTiles:
	DB $00, $00
SpriteMoveNone2x2YTiles:
	DB $00, $00, $08, $08
;----------------------------------------------------------------
; frames order
;----------------------------------------------------------------
SpriteTypesMoveFramesLow:
	DB <(SpriteHurtMoveFrames), <(SpriteHurtMoveFrames), <(SpriteHurtMoveFrames), <(SpriteHurtMoveFrames), <(SpriteHurtMoveFrames), <(SpriteHurtMoveFrames)
SpriteTypesMoveFramesHi:
	DB >(SpriteHurtMoveFrames), >(SpriteHurtMoveFrames), >(SpriteHurtMoveFrames), >(SpriteHurtMoveFrames), >(SpriteHurtMoveFrames), >(SpriteHurtMoveFrames)
SpriteHurtMoveFrames:
	DB $01
	DB $00, $02
	
;----------------------------------------------------------------
; frames time
;----------------------------------------------------------------
SpriteTypesMoveTimesLow:
	DB <(SpriteHurtMoveTimes), <(SpriteHurtMoveTimes), <(SpriteHurtMoveTimes), <(SpriteHurtMoveTimes), <(SpriteHurtMoveTimes), <(SpriteHurtMoveTimes)
SpriteTypesMoveTimesHi:
	DB >(SpriteHurtMoveTimes), >(SpriteHurtMoveTimes), >(SpriteHurtMoveTimes), >(SpriteHurtMoveTimes), >(SpriteHurtMoveTimes), >(SpriteHurtMoveTimes)
SpriteHurtMoveTimes:
	DB $00
	DB $0F, $0F

