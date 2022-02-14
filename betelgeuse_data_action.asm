SpriteTypesMoveFunctionsLow:
	DB <(SpriteMoveFunctionPlayer1), <(SpriteMoveFunctionFollowPlayer1), <(SpriteMoveFunctioneTank), <(SpritePickUpBehaviour), $00, $00, <(SpriteMoveFunctioneExplosion), <(SpritePickUpBehaviour)
	DB <(SpriteMoveFunctioneBullet), <(SpriteMoveFunctioneBulletGhost), <(SpriteMoveFunctioneBullet), $00, $00, $00, $00, <(SpritePickUpBehaviour)
	DB $00
SpriteTypesMoveFunctionsHi:
	DB >(SpriteMoveFunctionPlayer1), >(SpriteMoveFunctionFollowPlayer1), >(SpriteMoveFunctioneTank), >(SpritePickUpBehaviour), $00, $00, >(SpriteMoveFunctioneExplosion), >(SpritePickUpBehaviour)
	DB >(SpriteMoveFunctioneBullet), >(SpriteMoveFunctioneBulletGhost), >(SpriteMoveFunctioneBullet), $00, $00, $00, $00, >(SpritePickUpBehaviour)
	DB $00
;----------------------------------------------------------------
;x change
;----------------------------------------------------------------
SpriteTypesMoveTilesXLowLow:
	DB <(SpritePlayerMoveTilesXLow), <(SpritePlayerMoveTilesXLow), <(SpritePlayerMoveTilesXLow), <(SpriteHurtMoveTilesXLow), <(SpriteGunMoveTilesXLow), <(SpriteHurtMoveTilesXLow), $00, <(SpriteHurtMoveTilesXLow)
	DB <(SpriteBulletMoveTilesXLow), $00, <(SpriteBulletMoveTilesXLow), $00, <(SpriteBoss1MoveTilesXLow), <(SpriteBoss1MoveTilesXLow), <(SpriteBoss1MoveTilesXLow), <(SpriteHurtMoveTilesXLow)
	DB <(SpriteHurtMoveTilesXLow)
SpriteTypesMoveTilesXLowHi:
	DB >(SpritePlayerMoveTilesXLow), >(SpritePlayerMoveTilesXLow), >(SpritePlayerMoveTilesXLow), >(SpriteHurtMoveTilesXLow), >(SpriteGunMoveTilesXLow), >(SpriteHurtMoveTilesXLow), $00, >(SpriteHurtMoveTilesXLow)
	DB >(SpriteBulletMoveTilesXLow), $00, >(SpriteBulletMoveTilesXLow), $00, >(SpriteBoss1MoveTilesXLow), >(SpriteBoss1MoveTilesXLow), >(SpriteBoss1MoveTilesXLow), >(SpriteHurtMoveTilesXLow)
	DB >(SpriteHurtMoveTilesXLow)
SpriteTypesMoveTilesXHiLow:
	DB <(SpritePlayerMoveTilesXHi), <(SpritePlayerMoveTilesXHi), <(SpritePlayerMoveTilesXHi), <(SpriteHurtMoveTilesXHi), <(SpriteGunMoveTilesXHi), <(SpriteHurtMoveTilesXHi), $00, <(SpriteHurtMoveTilesXHi)
	DB <(SpriteBulletMoveTilesXHi), $00, <(SpriteBulletMoveTilesXHi), $00, <(SpriteBoss1MoveTilesXHi), <(SpriteBoss1MoveTilesXHi), <(SpriteBoss1MoveTilesXHi), <(SpriteHurtMoveTilesXHi)
	DB <(SpriteHurtMoveTilesXHi)
SpriteTypesMoveTilesXHiHi:
	DB >(SpritePlayerMoveTilesXHi), >(SpritePlayerMoveTilesXHi), >(SpritePlayerMoveTilesXHi), >(SpriteHurtMoveTilesXHi), >(SpriteGunMoveTilesXHi), >(SpriteHurtMoveTilesXHi), $00, >(SpriteHurtMoveTilesXHi)
	DB >(SpriteBulletMoveTilesXHi), $00, >(SpriteBulletMoveTilesXHi), $00, >(SpriteBoss1MoveTilesXHi), >(SpriteBoss1MoveTilesXHi), >(SpriteBoss1MoveTilesXHi), >(SpriteHurtMoveTilesXHi)
	DB >(SpriteHurtMoveTilesXHi)
;boss 1
SpriteBoss1MoveTilesXLow:
	DB <(SpriteMoveType1x1X)
	DB <(SpriteMoveLeftType2x2X)
	DB <(SpriteMoveLeftType2x2X)
	DB <(SpriteMoveRightType2x2X)
	DB <(SpriteMoveRightType2x2X)
	DB <(SpriteMoveLeft2px)
	DB <(SpriteMoveLeft2px)
	DB <(SpriteMoveRight2px)
	DB <(SpriteMoveRight2px)
	DB <(SpriteMoveLeft3px)
	DB <(SpriteMoveLeft3px)
	DB <(SpriteMoveRight3px)
	DB <(SpriteMoveRight3px)
SpriteBoss1MoveTilesXHi:
	DB >(SpriteMoveType1x1X)
	DB >(SpriteMoveLeftType2x2X)
	DB >(SpriteMoveLeftType2x2X)
	DB >(SpriteMoveRightType2x2X)
	DB >(SpriteMoveRightType2x2X)
	DB >(SpriteMoveLeft2px)
	DB >(SpriteMoveLeft2px)
	DB >(SpriteMoveRight2px)
	DB >(SpriteMoveRight2px)
	DB >(SpriteMoveLeft3px)
	DB >(SpriteMoveLeft3px)
	DB >(SpriteMoveRight3px)
	DB >(SpriteMoveRight3px)
SpriteMoveRight2px:
	DB $02
SpriteMoveLeft2px:
	DB $FE
SpriteMoveRight3px:
	DB $03
SpriteMoveLeft3px:
	DB $FD
;player
SpritePlayerMoveTilesXLow:
	DB <(SpriteMoveType2x2X)
	DB <(SpriteMoveType2x2X)
	DB <(SpriteMoveType2x2X)
	DB <(SpriteMoveLeftType2x2X)
	DB <(SpriteMoveRightType2x2X)
	DB <(SpriteMoveLeftType2x2X), <(SpriteMoveType2x2X), <(SpriteMoveLeftType2x2X), <(SpriteMoveLeftType2x2X), <(SpriteMoveLeftType2x2X), <(SpriteMoveType2x2X), <(SpriteMoveLeftType2x2X)
	DB <(SpriteMoveRightType2x2X), <(SpriteMoveType2x2X), <(SpriteMoveRightType2x2X), <(SpriteMoveRightType2x2X), <(SpriteMoveRightType2x2X), <(SpriteMoveType2x2X), <(SpriteMoveRightType2x2X)
	DB <(SpriteMoveLeftType2x2X), <(SpriteMoveType2x2X), <(SpriteMoveLeftType2x2X), <(SpriteMoveLeftType2x2X), <(SpriteMoveLeftType2x2X), <(SpriteMoveType2x2X), <(SpriteMoveLeftType2x2X)
	DB <(SpriteMoveRightType2x2X), <(SpriteMoveType2x2X), <(SpriteMoveRightType2x2X), <(SpriteMoveRightType2x2X), <(SpriteMoveRightType2x2X), <(SpriteMoveType2x2X), <(SpriteMoveRightType2x2X)
SpritePlayerMoveTilesXHi:
	DB >(SpriteMoveType2x2X)
	DB >(SpriteMoveType2x2X)
	DB >(SpriteMoveType2x2X)
	DB >(SpriteMoveLeftType2x2X)
	DB >(SpriteMoveRightType2x2X)
	DB >(SpriteMoveLeftType2x2X), >(SpriteMoveType2x2X), >(SpriteMoveLeftType2x2X), >(SpriteMoveLeftType2x2X), >(SpriteMoveLeftType2x2X), >(SpriteMoveType2x2X), >(SpriteMoveLeftType2x2X)
	DB >(SpriteMoveRightType2x2X), >(SpriteMoveType2x2X), >(SpriteMoveRightType2x2X), >(SpriteMoveRightType2x2X), >(SpriteMoveRightType2x2X), >(SpriteMoveType2x2X), >(SpriteMoveRightType2x2X)
	DB >(SpriteMoveLeftType2x2X), >(SpriteMoveType2x2X), >(SpriteMoveLeftType2x2X), >(SpriteMoveLeftType2x2X), >(SpriteMoveLeftType2x2X), >(SpriteMoveType2x2X), >(SpriteMoveLeftType2x2X)
	DB >(SpriteMoveRightType2x2X), >(SpriteMoveType2x2X), >(SpriteMoveRightType2x2X), >(SpriteMoveRightType2x2X), >(SpriteMoveRightType2x2X), >(SpriteMoveType2x2X), >(SpriteMoveRightType2x2X)
SpriteMoveType1x1X:
	DB $00
SpriteMoveType2x1X:
	DB $00
SpriteMoveType2x2X:
	DB $00
SpriteMoveRightType2x2X:
	DB $01
SpriteMoveLeftType2x2X:
	DB $FF
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
	
;bullet
SpriteBulletMoveTilesXLow:
	DB <(SpriteMoveType2x2X)
	DB <(SpriteMoveType2x2X)
	DB <(SpriteMoveType2x2X)
	DB <(SpriteMove2LeftXTiles)
	DB <(SpriteMove2RightXTiles)
	DB <(SpriteMove2LeftXTiles), <(SpriteMoveType2x2X), <(SpriteMove2LeftXTiles), <(SpriteMove2LeftXTiles), <(SpriteMove2LeftXTiles), <(SpriteMoveType2x2X), <(SpriteMove2LeftXTiles)
	DB <(SpriteMove2RightXTiles), <(SpriteMoveType2x2X), <(SpriteMove2RightXTiles), <(SpriteMove2RightXTiles), <(SpriteMove2RightXTiles), <(SpriteMoveType2x2X), <(SpriteMove2RightXTiles)
	DB <(SpriteMove2LeftXTiles), <(SpriteMoveType2x2X), <(SpriteMove2LeftXTiles), <(SpriteMove2LeftXTiles), <(SpriteMove2LeftXTiles), <(SpriteMoveType2x2X), <(SpriteMove2LeftXTiles)
	DB <(SpriteMove2RightXTiles), <(SpriteMoveType2x2X), <(SpriteMove2RightXTiles), <(SpriteMove2RightXTiles), <(SpriteMove2RightXTiles), <(SpriteMoveType2x2X), <(SpriteMove2RightXTiles)
SpriteBulletMoveTilesXHi:
	DB >(SpriteMoveType2x2X)
	DB >(SpriteMoveType2x2X)
	DB >(SpriteMoveType2x2X)
	DB >(SpriteMove2LeftXTiles)
	DB >(SpriteMove2RightXTiles)
	DB >(SpriteMove2LeftXTiles), >(SpriteMoveType2x2X), >(SpriteMove2LeftXTiles), >(SpriteMove2LeftXTiles), >(SpriteMove2LeftXTiles), >(SpriteMoveType2x2X), >(SpriteMove2LeftXTiles)
	DB >(SpriteMove2RightXTiles), >(SpriteMoveType2x2X), >(SpriteMove2RightXTiles), >(SpriteMove2RightXTiles), >(SpriteMove2RightXTiles), >(SpriteMoveType2x2X), >(SpriteMove2RightXTiles)
	DB >(SpriteMove2LeftXTiles), >(SpriteMoveType2x2X), >(SpriteMove2LeftXTiles), >(SpriteMove2LeftXTiles), >(SpriteMove2LeftXTiles), >(SpriteMoveType2x2X), >(SpriteMove2LeftXTiles)
	DB >(SpriteMove2RightXTiles), >(SpriteMoveType2x2X), >(SpriteMove2RightXTiles), >(SpriteMove2RightXTiles), >(SpriteMove2RightXTiles), >(SpriteMoveType2x2X), >(SpriteMove2RightXTiles)
SpriteMove2RightXTiles:
	DB $03
SpriteMove2LeftXTiles:
	DB $FD
;----------------------------------------------------------------
;y change
;----------------------------------------------------------------
SpriteTypesMoveTilesYLowLow:
	DB <(SpritePlayerMoveTilesYLow), <(SpritePlayerMoveTilesYLow), <(SpritePlayerMoveTilesYLow), <(SpriteHurtMoveTilesYLow), <(SpriteGunMoveTilesYLow), <(SpriteHurtMoveTilesYLow), $00, <(SpriteHurtMoveTilesYLow)
	DB <(SpriteBulletMoveTilesYLow), $00, <(SpriteBulletMoveTilesYLow), $00, <(SpriteBoss1MoveTilesYLow), <(SpriteBoss1MoveTilesYLow), <(SpriteBoss1MoveTilesYLow), <(SpriteHurtMoveTilesYLow)
	DB <(SpriteHurtMoveTilesYLow)
SpriteTypesMoveTilesYLowHi:
	DB >(SpritePlayerMoveTilesYLow), >(SpritePlayerMoveTilesYLow), >(SpritePlayerMoveTilesYLow), >(SpriteHurtMoveTilesYLow), >(SpriteGunMoveTilesYLow), >(SpriteHurtMoveTilesYLow), $00, >(SpriteHurtMoveTilesYLow)
	DB >(SpriteBulletMoveTilesYLow), $00, >(SpriteBulletMoveTilesYLow), $00, >(SpriteBoss1MoveTilesYLow), >(SpriteBoss1MoveTilesYLow), >(SpriteBoss1MoveTilesYLow), >(SpriteHurtMoveTilesYLow)
	DB >(SpriteHurtMoveTilesYLow)
SpriteTypesMoveTilesYHiLow:
	DB <(SpritePlayerMoveTilesYHi), <(SpritePlayerMoveTilesYHi), <(SpritePlayerMoveTilesYHi), <(SpriteHurtMoveTilesYHi), <(SpriteGunMoveTilesYHi), <(SpriteHurtMoveTilesYHi), $00, <(SpriteHurtMoveTilesYHi)
	DB <(SpriteBulletMoveTilesYHi), $00, <(SpriteBulletMoveTilesYHi), $00, <(SpriteBoss1MoveTilesYHi), <(SpriteBoss1MoveTilesYHi), <(SpriteBoss1MoveTilesYHi), <(SpriteHurtMoveTilesYHi)
	DB <(SpriteHurtMoveTilesYHi)
SpriteTypesMoveTilesYHiHi:
	DB >(SpritePlayerMoveTilesYHi), >(SpritePlayerMoveTilesYHi), >(SpritePlayerMoveTilesYHi), >(SpriteHurtMoveTilesYHi), >(SpriteGunMoveTilesYHi), >(SpriteHurtMoveTilesYHi), $00, >(SpriteHurtMoveTilesYHi)
	DB >(SpriteBulletMoveTilesYHi), $00, >(SpriteBulletMoveTilesYHi), $00, >(SpriteBoss1MoveTilesYHi), >(SpriteBoss1MoveTilesYHi), >(SpriteBoss1MoveTilesYHi), >(SpriteHurtMoveTilesYHi)
	DB >(SpriteHurtMoveTilesYHi)
;boss 1
SpriteBoss1MoveTilesYLow:
	DB <(SpriteMoveType1x1X)
	DB <(SpriteMoveLeftType2x2X)
	DB <(SpriteMoveRightType2x2X)
	DB <(SpriteMoveLeftType2x2X)
	DB <(SpriteMoveRightType2x2X)
	DB <(SpriteMoveLeft2px)
	DB <(SpriteMoveRight2px)
	DB <(SpriteMoveLeft2px)
	DB <(SpriteMoveRight2px)
	DB <(SpriteMoveLeft3px)
	DB <(SpriteMoveRight3px)
	DB <(SpriteMoveLeft3px)
	DB <(SpriteMoveRight3px)
SpriteBoss1MoveTilesYHi:
	DB >(SpriteMoveType1x1X)
	DB >(SpriteMoveLeftType2x2X)
	DB >(SpriteMoveRightType2x2X)
	DB >(SpriteMoveLeftType2x2X)
	DB >(SpriteMoveRightType2x2X)
	DB >(SpriteMoveLeft2px)
	DB >(SpriteMoveRight2px)
	DB >(SpriteMoveLeft2px)
	DB >(SpriteMoveRight2px)
	DB >(SpriteMoveLeft3px)
	DB >(SpriteMoveRight3px)
	DB >(SpriteMoveLeft3px)
	DB >(SpriteMoveRight3px)
;player
SpritePlayerMoveTilesYLow:
	DB <(SpriteMoveNone2x2YTiles)
	DB <(SpriteMoveUpYTiles)
	DB <(SpriteMoveDownYTiles)
	DB <(SpriteMoveNone2x2YTiles)
	DB <(SpriteMoveNone2x2YTiles)
	DB <(SpriteMoveUpYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMoveUpYTiles), <(SpriteMoveUpYTiles), <(SpriteMoveUpYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMoveUpYTiles)
	DB <(SpriteMoveUpYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMoveUpYTiles), <(SpriteMoveUpYTiles), <(SpriteMoveUpYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMoveUpYTiles)
	DB <(SpriteMoveDownYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMoveDownYTiles), <(SpriteMoveDownYTiles), <(SpriteMoveDownYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMoveDownYTiles)
	DB <(SpriteMoveDownYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMoveDownYTiles), <(SpriteMoveDownYTiles), <(SpriteMoveDownYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMoveDownYTiles)
SpritePlayerMoveTilesYHi:
	DB >(SpriteMoveNone2x2YTiles)
	DB >(SpriteMoveUpYTiles)
	DB >(SpriteMoveDownYTiles)
	DB >(SpriteMoveNone2x2YTiles)
	DB >(SpriteMoveNone2x2YTiles)
	DB >(SpriteMoveUpYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMoveUpYTiles), >(SpriteMoveUpYTiles), >(SpriteMoveUpYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMoveUpYTiles)
	DB >(SpriteMoveUpYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMoveUpYTiles), >(SpriteMoveUpYTiles), >(SpriteMoveUpYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMoveUpYTiles)
	DB >(SpriteMoveDownYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMoveDownYTiles), >(SpriteMoveDownYTiles), >(SpriteMoveDownYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMoveDownYTiles)
	DB >(SpriteMoveDownYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMoveDownYTiles), >(SpriteMoveDownYTiles), >(SpriteMoveDownYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMoveDownYTiles)
SpriteMoveNone1x1YTiles:
	DB $00
SpriteMoveNone2x1YTiles:
	DB $00
SpriteMoveNone2x2YTiles:
	DB $00
SpriteMoveUpYTiles
	DB $FF
SpriteMoveDownYTiles
	DB $01
;gun
SpriteGunMoveTilesYLow:
	DB <(SpriteMoveNone2x1YTiles)
	DB <(SpriteGunMoveUp2x1YTiles), <(SpriteGunMoveDown2x1YTiles)
SpriteGunMoveTilesYHi:
	DB >(SpriteMoveNone2x1YTiles)
	DB >(SpriteGunMoveUp2x1YTiles), >(SpriteGunMoveDown2x1YTiles)
SpriteGunMoveUp2x1YTiles:
	DB $FF
SpriteGunMoveDown2x1YTiles:
	DB $01
;hurt
SpriteHurtMoveTilesYLow:
	DB <(SpriteMoveNone1x1YTiles)
	DB <(SpriteHurtMoveUp1x1YTiles), <(SpriteHurtMoveDown1x1YTiles)
SpriteHurtMoveTilesYHi:
	DB >(SpriteMoveNone1x1YTiles)
	DB >(SpriteHurtMoveUp1x1YTiles), >(SpriteHurtMoveDown1x1YTiles)
SpriteHurtMoveUp1x1YTiles:
	DB $FF
SpriteHurtMoveDown1x1YTiles:
	DB $01
	
;bullet
SpriteBulletMoveTilesYLow:
	DB <(SpriteMoveNone2x2YTiles)
	DB <(SpriteMove2UpYTiles)
	DB <(SpriteMove2DownYTiles)
	DB <(SpriteMoveNone2x2YTiles)
	DB <(SpriteMoveNone2x2YTiles)
	DB <(SpriteMove2UpYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMove2UpYTiles), <(SpriteMove2UpYTiles), <(SpriteMove2UpYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMove2UpYTiles)
	DB <(SpriteMove2UpYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMove2UpYTiles), <(SpriteMove2UpYTiles), <(SpriteMove2UpYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMove2UpYTiles)
	DB <(SpriteMove2DownYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMove2DownYTiles), <(SpriteMove2DownYTiles), <(SpriteMove2DownYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMove2DownYTiles)
	DB <(SpriteMove2DownYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMove2DownYTiles), <(SpriteMove2DownYTiles), <(SpriteMove2DownYTiles), <(SpriteMoveNone2x2YTiles), <(SpriteMove2DownYTiles)
SpriteBulletMoveTilesYHi:
	DB >(SpriteMoveNone2x2YTiles)
	DB >(SpriteMove2UpYTiles)
	DB >(SpriteMove2DownYTiles)
	DB >(SpriteMoveNone2x2YTiles)
	DB >(SpriteMoveNone2x2YTiles)
	DB >(SpriteMove2UpYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMove2UpYTiles), >(SpriteMove2UpYTiles), >(SpriteMove2UpYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMove2UpYTiles)
	DB >(SpriteMove2UpYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMove2UpYTiles), >(SpriteMove2UpYTiles), >(SpriteMove2UpYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMove2UpYTiles)
	DB >(SpriteMove2DownYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMove2DownYTiles), >(SpriteMove2DownYTiles), >(SpriteMove2DownYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMove2DownYTiles)
	DB >(SpriteMove2DownYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMove2DownYTiles), >(SpriteMove2DownYTiles), >(SpriteMove2DownYTiles), >(SpriteMoveNone2x2YTiles), >(SpriteMove2DownYTiles)
SpriteMove2UpYTiles
	DB $FD
SpriteMove2DownYTiles
	DB $03
;----------------------------------------------------------------
; frames order
;----------------------------------------------------------------
SpriteTypesMoveFramesLow:
	DB <(SpritePlayerMoveFrames), <(SpritePlayerMoveFrames), <(SpritePlayerMoveFrames), <(SpriteHurtMoveFrames), <(SpriteHurtMoveFrames), <(SpriteHurtMoveFrames), $00, <(SpriteHurtMoveFrames)
	DB <(SpritePlayerMoveFrames), $00, <(SpritePlayerMoveFrames), $00, <(SpriteBossMoveFrames), <(SpriteBossMoveFrames), <(SpriteBossMoveFrames), <(SpriteHurtMoveFrames)
	DB <(SpriteHurtMoveFrames)
SpriteTypesMoveFramesHi:
	DB >(SpritePlayerMoveFrames), >(SpritePlayerMoveFrames), >(SpritePlayerMoveFrames), >(SpriteHurtMoveFrames), >(SpriteHurtMoveFrames), >(SpriteHurtMoveFrames), $00, >(SpriteHurtMoveFrames)
	DB >(SpritePlayerMoveFrames), $00, >(SpritePlayerMoveFrames), $00, >(SpriteBossMoveFrames), >(SpriteBossMoveFrames), >(SpriteBossMoveFrames), >(SpriteHurtMoveFrames)
	DB >(SpriteHurtMoveFrames)
SpriteBossMoveFrames:
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
SpritePlayerMoveFrames:
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $00, $00, $00, $00, $00, $00, $07
	DB $00, $00, $00, $00, $00, $00, $07
	DB $00, $00, $00, $00, $00, $00, $07
	DB $00, $00, $00, $00, $00, $00, $07
SpriteHurtMoveFrames:
	DB $01
	DB $00, $02
	
;----------------------------------------------------------------
; frames time
;----------------------------------------------------------------
SpriteTypesMoveTimesLow:
	DB <(SpritePlayerMoveTimes), <(SpritePlayerMoveTimes), <(SpriteTripodMoveTimes), <(SpriteHurtMoveTimes), <(SpriteHurtMoveTimes), <(SpriteHurtMoveTimes), $00, <(SpriteHurtMoveTimes)
	DB <(SpritePlayerMoveTimes), $00, <(SpritePlayerMoveTimes), $00, <(SpriteBossMoveTimes), <(SpriteBossMoveTimes), <(SpriteBossMoveTimes), <(SpriteHurtMoveTimes)
	DB <(SpriteHurtMoveTimes)
SpriteTypesMoveTimesHi:
	DB >(SpritePlayerMoveTimes), >(SpritePlayerMoveTimes), >(SpriteTripodMoveTimes), >(SpriteHurtMoveTimes), >(SpriteHurtMoveTimes), >(SpriteHurtMoveTimes), $00, >(SpriteHurtMoveTimes)
	DB >(SpritePlayerMoveTimes), $00, >(SpritePlayerMoveTimes), $00, >(SpriteBossMoveTimes), >(SpriteBossMoveTimes), >(SpriteBossMoveTimes), >(SpriteHurtMoveTimes)
	DB >(SpriteHurtMoveTimes)
SpriteBossMoveTimes:
	DB $00
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01
SpritePlayerMoveTimes:
	DB $00
	DB $01
	DB $01
	DB $01
	DB $01
	DB $01, $01, $01, $01, $01, $01, $01
	DB $01, $01, $01, $01, $01, $01, $01
	DB $01, $01, $01, $01, $01, $01, $01
	DB $01, $01, $01, $01, $01, $01, $01
SpriteTripodMoveTimes:
	DB $00
	DB $02
	DB $02
	DB $02
	DB $02
	DB $02, $02, $02, $02, $02, $02, $02
	DB $02, $02, $02, $02, $02, $02, $02
	DB $02, $02, $02, $02, $02, $02, $02
	DB $02, $02, $02, $02, $02, $02, $02
SpriteHurtMoveTimes:
	DB $00
	DB $0F, $0F

;--------------------------------------------------------
; FUNCTIONS
;--------------------------------------------------------
SpritePickUpBehaviour:
	LDA gameState
	CMP #$01
	BNE +
		JMP SpritesUpdateReturn
		+
	
	LDA spritesType, X
	CMP #$0F ;trigun pickup
	BNE +
		LDA spritesStateAction, X
		CMP #$00
		BNE ++
			LDA powerUpTimer
			CMP #$B4
			BNE +++
				LDA powerUpValue
				CMP #$01
				BNE ++++
					LDA powerUpType
					CMP #$01 ;trigun
					BNE +++++
						;remove powerup sprite in status bar
						LDA FALSE
						STA powerUpSprite
						STX index
						INC powerUpsOnLevel
						JSR SpritesRemove
						LDX currentIndex
						JMP SpritesUpdateCycleEndSkipINX
						+++++
					++++
				+++
			++
		+
	LDA spritesStateAction, X
	CMP #$00
	BEQ +
		LDA spritesTimerGlobal, X
		CMP #$00
		BNE ++
			LDA spritesStateAnim, X
			CMP #$00
			BNE +++
				LDA #$00
				STA spritesTimerAnim, X
				LDA #$01
				STA spritesStateAnim, X
				JMP +
				+++
			++
		LDA spritesTimerGlobal, X
		CMP #$78
		BNE ++
			LDA spritesStateAnim, X
			CMP #$00
			BEQ +++
				STX index
				JSR SpritesRemove									
				LDX currentIndex
				JMP SpritesUpdateCycleEndSkipINX
				+++		
			++
		+
	JMP SpritesUpdateReturn
	
SpriteMoveFunctioneTankRandomDir:
	JSR GetRandomNumber
	LDA randomNum
	AND #$80
	CMP #$00
	BNE ++
		LDA randomNum
		AND #$01
		CMP #$00
		BNE +++
			LDA Up
			STA spriteDirection

			LDA #$0A ;anim
			STA spritesStateAnim, X
			LDA #$01 ;action
			STA spritesStateAction, X
			LDA #$00 ;timer
			STA spritesTimerAnim, X
			STA spritesTimerAction, X
			RTS
			+++
		LDA Down
		STA spriteDirection

		LDA #$07 ;anim
		STA spritesStateAnim, X
		LDA #$02 ;action
		STA spritesStateAction, X
		LDA #$00 ;timer
		STA spritesTimerAnim, X
		STA spritesTimerAction, X
		RTS
		++
	LDA randomNum
	AND #$01
	CMP #$00
	BNE +++
		LDA Left
		STA spriteDirection

		LDA #$01 ;anim
		STA spritesStateAnim, X
		LDA #$03 ;action
		STA spritesStateAction, X
		LDA #$00 ;timer
		STA spritesTimerAnim, X
		STA spritesTimerAction, X
		RTS
		+++
	LDA Right
	STA spriteDirection

	LDA #$04 ;anim
	STA spritesStateAnim, X
	LDA #$04 ;action
	STA spritesStateAction, X
	LDA #$00 ;timer
	STA spritesTimerAnim, X
	STA spritesTimerAction, X
	RTS
	
SpriteMoveFunctioneTank:
	LDA gameState
	CMP #$01
	BNE +
		JMP SpritesUpdateReturn
		+

	LDA spritesStateAction, X
	CMP #$00
	BNE +
		LDA spritesTimerAnim, X
		CMP #$00
		BNE ++
			LDA spritesStateAnim, X ;action
			CMP #$0F ;up
			BNE +++
				LDA #$01
				STA spritesStateAction, X
				LDA #$0A ;anim
				STA spritesStateAnim, X
				LDA #$00 ;timer
				STA spritesTimerAnim, X
				STA spritesTimerAction, X
				JMP TAEBE
				+++
			CMP #$0E ;down
			BNE +++
				LDA #$02
				STA spritesStateAction, X
				LDA #$07 ;anim
				STA spritesStateAnim, X
				LDA #$00 ;timer
				STA spritesTimerAnim, X
				STA spritesTimerAction, X
				JMP TAEBE
				+++
			CMP #$0C ;left
			BNE +++
				LDA #$03
				STA spritesStateAction, X
				LDA #$01 ;anim
				STA spritesStateAnim, X
				LDA #$00 ;timer
				STA spritesTimerAnim, X
				STA spritesTimerAction, X
				JMP TAEBE
				+++
			CMP #$0D ;right
			BNE +++
				LDA #$04
				STA spritesStateAction, X
				LDA #$04 ;anim
				STA spritesStateAnim, X
				LDA #$00 ;timer
				STA spritesTimerAnim, X
				STA spritesTimerAction, X
				JMP TAEBE
				+++
			++
		+
			
	TAEBE:
	LDA spritesTimerGlobal, X
	AND #$3F ;time for tank to cahnge direction
	CMP #$00
	BNE +
		JSR SpriteMoveFunctioneTankRandomDir
		JMP SpriteMoveFunctioneTankEnd
		+
	LDA spritesStateAction, X ;action
	CMP #$01 ;up
	BNE +
		LDA Up
		STA spriteDirection
		JMP SpriteMoveFunctioneTankEnd
		+
	CMP #$02 ;down
	BNE +
		LDA Down
		STA spriteDirection
		JMP SpriteMoveFunctioneTankEnd
		+
	CMP #$03 ;left
	BNE +
		LDA Left
		STA spriteDirection
		JMP SpriteMoveFunctioneTankEnd
		+
	CMP #$04 ;right
	BNE +
		LDA Right
		STA spriteDirection
		JMP SpriteMoveFunctioneTankEnd
		+
	SpriteMoveFunctioneTankEnd:
	LDA spritesTimerGlobal, X
	AND #$3F ;time for tank to cahnge direction
	CMP #$00
	BNE +
		JSR GetRandomNumber
		LDA randomNum
		AND #$80
		CMP #$00
		BNE ++
			LDA spriteDirection
			CMP Up
			BNE +++
				LDA #$0F ;anim
				JMP TASBE
				+++
			CMP Down
			BNE +++
				LDA #$0E ;anim
				JMP TASBE
				+++
			CMP Left
			BNE +++
				LDA #$0C ;anim
				JMP TASBE
				+++
			CMP Right
			BNE +++
				LDA #$0D ;anim
				JMP TASBE
				+++
			TASBE:
			STA spritesStateAnim, X
			
			;add bullet
			LDA #$0A ;type
			STA spriteType
			LDA spritesX, X
			CLC
			ADC #$03
			STA spriteX
			LDA spritesY, X
			CLC
			ADC #$04
			STA spriteY
			LDA #$00 ;anim
			STA spriteStateAnim
			LDA spritesStateAction, X ;action
			STA spriteStateAction
			LDA #$00 ;timer
			STA spriteTimerAnim
			STA spriteTimerAction
			LDY spriteType ;health
			LDA SpritesTypesHealth, Y
			STA spriteHealth
			JSR SpritesAdd
			;add bullet end
			
			LDA #$00 ;action
			STA spritesStateAction, X
			LDA #$00 ;timer
			STA spritesTimerAnim, X
			STA spritesTimerAction, X
			++
		+
	JMP SpritesUpdateReturn
	
SpriteMoveFunctioneBullet:
	LDA spritesStateAction, X ;action
	CMP #$01 ;up
	BNE +
		LDA Up
		STA spriteDirection
		JMP SpritesUpdateReturn
		+
	CMP #$02 ;down
	BNE +
		LDA Down
		STA spriteDirection
		JMP SpritesUpdateReturn
		+
	CMP #$03 ;left
	BNE +
		LDA Left
		STA spriteDirection
		JMP SpritesUpdateReturn
		+
	CMP #$04 ;right
	BNE +
		LDA Right
		STA spriteDirection
		JMP SpritesUpdateReturn
		+
	CMP #$05 ;upleft
	BCC +
		CMP #$0C
		BCS ++
			LDA UpLeft
			STA spriteDirection
			JMP SpritesUpdateReturn
			++
		+
	CMP #$0C ;upright
	BCC +
		CMP #$13
		BCS ++
			LDA UpRight
			STA spriteDirection
			JMP SpritesUpdateReturn
			++
		+
	CMP #$13 ;downleft
	BCC +
		CMP #$1A
		BCS ++
			LDA DownLeft
			STA spriteDirection
			JMP SpritesUpdateReturn
			++
		+
	CMP #$1A ;downright
	BCC +
		CMP #$21
		BCS ++
			LDA DownRight
			STA spriteDirection
			JMP SpritesUpdateReturn
			++
		+
	JMP SpritesUpdateReturn

SpriteMoveFunctioneExplosion:
	LDA spritesStateAnim, X
	CMP #$04
	BNE +
		STX index
		JSR SpritesRemove
		JMP SpritesUpdateCycleEndSkipINX
		+
	JMP SpritesUpdateReturn
	
SpriteMoveFunctioneBulletGhost:
	LDA spritesStateAnim, X
	CMP #$01
	BNE +
		STX index
		JSR SpritesRemove
		JMP SpritesUpdateCycleEndSkipINX
		+
	JMP SpritesUpdateReturn
	
SpriteMoveFunctionFollowPlayer1:
	LDA gameState
	CMP #$01
	BNE +
		JMP SpritesUpdateReturn
		+
	
	LDY #$00
		FollowPlayer1Cycle:
		LDA spritesType, Y
		CMP #$00
		BEQ +
			JMP FollowPlayer1End
			+
			;move right-left
			LDA spritesY, X
			CMP spritesY, Y
			BNE +
				LDA spritesX, X
				CMP spritesX, Y
				BNE ++
					;do not move
					LDA #$00
					STA spriteDirection
					JMP SpritesUpdateCycleEnd
					++
				BCS ++
					;move right
					LDA Right
					STA spriteDirection
					LDA spritesStateAction, X
					CMP #$04
					BNE +++
						JMP SpritesUpdateReturn
						+++
					LDA #$00
					STA spritesTimerAction, X
					LDA #$04
					STA spritesStateAction, X
				
					LDA spritesStateAnim, X
					CMP #$06
					BCC +++
						CMP #$0A
						BCS ++++
							JMP SpritesUpdateReturn
							++++
						+++				
					LDA #$00
					STA spritesTimerAnim, X				
					LDA #$06
					STA spritesStateAnim, X
					JMP SpritesUpdateReturn
					++
				;move left
				LDA Left
				STA spriteDirection
				LDA spritesStateAction, X
				CMP #$03
				BNE +++
					JMP SpritesUpdateReturn
					+++
				LDA #$00
				STA spritesTimerAction, X
				LDA #$03
				STA spritesStateAction, X
				
				LDA spritesStateAnim, X
				CMP #$02
				BCC +++
					CMP #$06
					BCS ++++
						JMP SpritesUpdateReturn
						++++
					+++				
				LDA #$00
				STA spritesTimerAnim, X				
				LDA #$02
				STA spritesStateAnim, X
				JMP SpritesUpdateReturn
				+
			;move up-down
			LDA spritesX, X
			CMP spritesX, Y
			BNE +
				LDA spritesY, X
				CMP spritesY, Y
				BCS ++
					;move down
					LDA Down
					STA spriteDirection
					LDA spritesStateAction, X
					CMP #$02
					BNE +++
						JMP SpritesUpdateReturn
						+++
					LDA #$00
					STA spritesTimerAction, X
					LDA #$02
					STA spritesStateAction, X
					
					JMP SpritesUpdateReturn
					++
				;move up
				LDA Up
				STA spriteDirection
				LDA spritesStateAction, X
				CMP #$01
				BNE +++
					JMP SpritesUpdateReturn
					+++
				LDA #$00
				STA spritesTimerAction, X
				LDA #$01
				STA spritesStateAction, X
				
				JMP SpritesUpdateReturn
				+
			;move downright-downleft
			LDA spritesY, X
			CMP spritesY, Y
			BCS +
				LDA spritesX, X
				CMP spritesX, Y
				BCS ++
					;move downright
					LDA DownRight
					STA spriteDirection
					LDA spritesStateAction, X
					CMP #$1A
					BCC +++
						CMP #$21
						BCS ++++
							JMP SpritesUpdateReturn
							++++
						+++	
					LDA #$00
					STA spritesTimerAction, X
					LDA #$1A
					STA spritesStateAction, X
				
					LDA spritesStateAnim, X
					CMP #$06
					BCC +++
						CMP #$0A
						BCS ++++
							JMP SpritesUpdateReturn
							++++
						+++				
					LDA #$00
					STA spritesTimerAnim, X				
					LDA #$06
					STA spritesStateAnim, X
					JMP SpritesUpdateReturn
					++
				;move downleft
				LDA DownLeft
				STA spriteDirection
				LDA spritesStateAction, X
				CMP #$13
				BCC +++
					CMP #$1A
					BCS ++++
						JMP SpritesUpdateReturn
						++++
					+++
				LDA #$00
				STA spritesTimerAction, X
				LDA #$13
				STA spritesStateAction, X
				
				LDA spritesStateAnim, X
				CMP #$02
				BCC +++
					CMP #$06
					BCS ++++
						JMP SpritesUpdateReturn
						++++
					+++		
				LDA #$00
				STA spritesTimerAnim, X				
				LDA #$02
				STA spritesStateAnim, X
				JMP SpritesUpdateReturn
				+
			;move upright-upleft
			LDA spritesX, X
			CMP spritesX, Y
			BCS +
				;move upright
				LDA UpRight
				STA spriteDirection
				LDA spritesStateAction, X
				CMP #$0C
				BCC ++
					CMP #$13
					BCS +++
						JMP SpritesUpdateReturn
						+++
					++	
				LDA #$00
				STA spritesTimerAction, X
				LDA #$0C
				STA spritesStateAction, X
				
				LDA spritesStateAnim, X
				CMP #$06
				BCC ++
					CMP #$0A
					BCS +++
						JMP SpritesUpdateReturn
						+++
					++				
				LDA #$00
				STA spritesTimerAnim, X				
				LDA #$06
				STA spritesStateAnim, X
				JMP SpritesUpdateReturn
				+
			;move upleft
			LDA UpLeft
			STA spriteDirection
			LDA spritesStateAction, X
			CMP #$05
			BCC ++
				CMP #$0C
				BCS +++
					JMP SpritesUpdateReturn
					+++
				++	
			LDA #$00
			STA spritesTimerAction, X
			LDA #$05
			STA spritesStateAction, X
				
			LDA spritesStateAnim, X
			CMP #$02
			BCC ++
				CMP #$06
				BCS +++
					JMP SpritesUpdateReturn
					+++
				++				
			LDA #$00
			STA spritesTimerAnim, X				
			LDA #$02
			STA spritesStateAnim, X
			JMP SpritesUpdateReturn
		FollowPlayer1End:
		INY
		CPY spritesLength
	BEQ +
		JMP FollowPlayer1Cycle
		+
	JMP SpritesUpdateCycleEnd
	
	RTS

SpriteMoveFunctionPlayer1:
	;check invincibility timer
	LDA playerHitTimer
	CMP #$24 ;invincibility time
	BNE +
		LDA #$00
		STA playerHitTimer
		+
	CMP #$00
	BEQ +
		INC playerHitTimer
		+
	;check button A press
	LDA buttonsP1Old
	ORA buttonsP1
	AND bA
	CMP bA
	BEQ +
		JMP ButtonAFuncEnd
		+
		LDA buttonsP1
		AND bB
		CMP bB
		BNE +++
			JMP ButtonAFuncEnd
			+++
		LDA buttonsP1
		AND bA
		CMP bA
		BNE +++
			LDA buttonsP1Old
			AND bA
			CMP bA
			BNE ++
				;button still pressed
				JMP ButtonAPress
				;button still pressed end
				++
			+++
		LDA buttonsP1
		AND bA
		CMP #$00
		BNE ++
			;button unpressed
			;button unpressed end
			JMP +
			++
		;button pressed first time
		JSR GetRandomNumber
		ButtonAPress:
		LDY powerUpType
		LDA bulletsTimer
		CMP BulletsTimes, Y
		BCS ++
			JMP BulletNoTimeA
			++
			LDA bulletsNum
			CMP #$6
			BCC +++
				JMP MaxBulletsA
				+++
				LDA powerUpType
				CMP #$00 ;normal bullet
				BNE +
					;Load sprites bullet
					LDA #$08 ;type
					STA spriteType
					LDA spritesX, X
					CLC
					ADC #$03
					STA spriteX
					LDA spritesY, X
					CLC
					ADC #$04
					STA spriteY
					LDA #$00 ;anim
					STA spriteStateAnim
					JSR AnimToAction
					LDA #$00 ;timer
					STA spriteTimerAnim
					STA spriteTimerAction
					LDY spriteType ;health
					LDA SpritesTypesHealth, Y
					STA spriteHealth
					JSR SpritesAdd
					LDA #$00
					STA bulletsTimer
					INC bulletsNum
					JMP ButtonAFuncEnd
					+
				CMP #$01 ;trigun powerup
				BNE +
					;Load sprites bullet
					LDA #$08 ;type
					STA spriteType
					LDA spritesX, X
					CLC
					ADC #$03
					STA spriteX
					LDA spritesY, X
					CLC
					ADC #$04
					STA spriteY
					LDA #$00 ;anim
					STA spriteStateAnim
					JSR AnimToAction
					LDA #$00 ;timer
					STA spriteTimerAnim
					STA spriteTimerAction
					LDY spriteType ;health
					LDA SpritesTypesHealth, Y
					STA spriteHealth
					JSR SpritesAdd
					INC bulletsNum
					LDA #$00
					STA bulletsTimer	
					
					LDA bulletsNum
					CMP #$6
					BNE +++
						;JMP ButtonAFuncEnd
						+++
					JSR BulletActionToTrigun
					JSR SpritesAdd
					INC bulletsNum
					LDA #$00
					STA bulletsTimer	
					
					LDA bulletsNum
					CMP #$6
					BNE +++
						;JMP ButtonAFuncEnd
						+++		
					LDA temp
					STA spriteStateAction	
					JSR SpritesAdd
					INC bulletsNum
					LDA #$00
					STA bulletsTimer					
					JMP ButtonAFuncEnd
					+
				;button pressed first time end		
			MaxBulletsA:
		BulletNoTimeA:
	ButtonAFuncEnd:
	LDA buttonsP1Old
	ORA buttonsP1
	AND bB
	CMP bB
	BEQ +
		JMP ButtonBFuncEnd
		+
		LDA buttonsP1
		AND bB
		CMP bB
		BNE +++
			LDA buttonsP1Old
			AND bB
			CMP bB
			BNE ++
				;button still pressed
				JMP ButtonBPress
				;button still pressed end
				++
			+++
		LDA buttonsP1
		AND bB
		CMP #$00
		BEQ ++
			JMP ButtonBPressFirst
			++
			;button unpressed
			LDA buttonsP1
			AND #$0F
			CMP Up
			BNE +++
				LDA #$00
				STA spritesTimerAnim, X
				LDA #$10
				STA spritesStateAnim, X
				JMP ButtonBFuncEnd
				+++
			CMP Down
			BNE +++
				LDA #$00
				STA spritesTimerAnim, X
				LDA #$0B
				STA spritesStateAnim, X
				JMP ButtonBFuncEnd
				+++
			CMP Left
			BNE +++
				LDA #$00
				STA spritesTimerAnim, X
				LDA #$01
				STA spritesStateAnim, X
				JMP ButtonBFuncEnd
				+++
			CMP Right
			BNE +++
				LDA #$00
				STA spritesTimerAnim, X
				LDA #$06
				STA spritesStateAnim, X
				JMP ButtonBFuncEnd
				+++
			CMP UpLeft
			BNE +++
				LDA #$00
				STA spritesTimerAnim, X
				LDA #$15
				STA spritesStateAnim, X
				JMP ButtonBFuncEnd
				+++
			CMP UpRight
			BNE +++
				LDA #$00
				STA spritesTimerAnim, X
				LDA #$1A
				STA spritesStateAnim, X
				JMP ButtonBFuncEnd
				+++
			CMP DownLeft
			BNE +++
				LDA #$00
				STA spritesTimerAnim, X
				LDA #$1F
				STA spritesStateAnim, X
				JMP ButtonBFuncEnd
				+++
			CMP DownRight
			BNE +++
				LDA #$00
				STA spritesTimerAnim, X
				LDA #$24
				STA spritesStateAnim, X
				JMP ButtonBFuncEnd
				+++
			;button unpressed end
		;button pressed first time
		ButtonBPressFirst:
		ButtonBPress:
		LDY powerUpType
		LDA bulletsTimer
		CMP BulletsTimes, Y
		BCS ++
			JMP BulletNoTimeB
			++
			LDA bulletsNum
			CMP #$6
			BCC +++
				JMP MaxBulletsB
				+++
				LDA powerUpType
				CMP #$00 ;normal bullet
				BNE +
					;Load sprites bullet
					LDA #$08 ;type
					STA spriteType
					LDA spritesX, X
					CLC
					ADC #$03
					STA spriteX
					LDA spritesY, X
					CLC
					ADC #$04
					STA spriteY				
					LDA #$00 ;anim
					STA spriteStateAnim
					JSR PlayerActionToBulletAction
					LDA #$00 ;timer
					STA spriteTimerAnim
					STA spriteTimerAction			
					LDY spriteType ;health
					LDA SpritesTypesHealth, Y
					STA spriteHealth					
					JSR SpritesAdd
					INC bulletsNum
					LDA #$00
					STA bulletsTimer					
					JMP ButtonBFuncEnd
					+
				CMP #$01 ;trigun powerup
				BNE +
					LDA #$08 ;type
					STA spriteType
					LDA spritesX, X
					CLC
					ADC #$03
					STA spriteX
					LDA spritesY, X
					CLC
					ADC #$04
					STA spriteY				
					LDA #$00 ;anim
					STA spriteStateAnim
					JSR PlayerActionToBulletAction
					LDA #$00 ;timer
					STA spriteTimerAnim
					STA spriteTimerAction			
					LDY spriteType ;health
					LDA SpritesTypesHealth, Y
					STA spriteHealth					
					JSR SpritesAdd
					INC bulletsNum
					LDA #$00
					STA bulletsTimer	
					
					LDA bulletsNum
					CMP #$6
					BNE +++
						;JMP ButtonBFuncEnd
						+++
					JSR BulletActionToTrigun
					JSR SpritesAdd
					INC bulletsNum
					LDA #$00
					STA bulletsTimer
					
					LDA bulletsNum
					CMP #$6
					BNE +++
						;JMP ButtonBFuncEnd
						+++		
					LDA temp
					STA spriteStateAction	
					JSR SpritesAdd
					INC bulletsNum
					LDA #$00
					STA bulletsTimer					
					JMP ButtonBFuncEnd
					+
				;button pressed first time end	
			MaxBulletsB:
		BulletNoTimeB:
	ButtonBFuncEnd:
		
		
	LDA buttonsP1Old
	AND Up
	ORA buttonsP1
	AND #$0F
	CMP Up
	BNE +
		LDA buttonsP1
		AND #$0F
		CMP Up
		BNE +++
			LDA buttonsP1Old
			AND #$0F
			CMP Up
			BNE ++
				;button still pressed
				JMP PlayerDirUp
				;button still pressed end
				++
			+++
		LDA buttonsP1
		AND #$0F
		CMP #$00
		BNE +++
			;button unpressed
			LDA #$00
			STA spriteDirection
			;button unpressed end
			JMP SpritesUpdateCycleEnd
			+++
		;button pressed first time
		LDA spritesStateAction, X
		CMP #$01
		BNE ++++
			LDA spritesStateAnim, X ;action
			CMP #$0F ;up
			BCC +++++
				CMP #$14
				BCS ++++++
					LDA Up
					STA spriteDirection
					JMP SpritesUpdateReturn
					++++++
				+++++
			++++	
		LDA buttonsP1
		AND bB
		CMP bB
		BEQ ++
			LDA #$00
			STA spritesTimerAnim, X
			LDA #$10
			STA spritesStateAnim, X
			++
		LDA #$00
		STA spritesTimerAction, X
		LDA #$01
		STA spritesStateAction, X	
		PlayerDirUp:
		LDA Up
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA buttonsP1Old
	AND Down
	ORA buttonsP1
	AND #$0F
	CMP Down
	BNE +
		LDA buttonsP1
		AND #$0F
		CMP Down
		BNE +++
			LDA buttonsP1Old
			AND #$0F
			CMP Down
			BNE ++
				;button still pressed
				JMP PlayerDirDown
				;button still pressed end
				++
			+++
		LDA buttonsP1
		AND #$0F
		CMP #$00
		BNE +++
			;button unpressed
			LDA #$00
			STA spriteDirection
			;button unpressed end
			JMP SpritesUpdateCycleEnd
			+++
		;button pressed first time
		LDA spritesStateAction, X
		CMP #$02
		BNE ++++
			LDA spritesStateAnim, X ;action
			CMP #$0A ;down
			BCC +++++
				CMP #$0F
				BCS ++++++
					LDA Down
					STA spriteDirection
					JMP SpritesUpdateReturn
					++++++
				+++++
			++++
		LDA buttonsP1
		AND bB
		CMP bB
		BEQ ++
			LDA #$00
			STA spritesTimerAnim, X
			LDA #$0B
			STA spritesStateAnim, X
			++
		LDA #$00
		STA spritesTimerAction, X
		LDA #$02
		STA spritesStateAction, X
		PlayerDirDown:
		LDA Down
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA buttonsP1Old
	AND Left
	ORA buttonsP1
	AND #$0F
	CMP Left
	BNE +
		LDA buttonsP1
		AND #$0F
		CMP Left
		BNE +++
			LDA buttonsP1Old
			AND #$0F
			CMP Left
			BNE ++
				;button still pressed
				JMP PlayerDirLeft
				;button still pressed end
				++
			+++
		LDA buttonsP1
		AND #$0F
		CMP #$00
		BNE +++
			;button unpressed
			LDA #$00
			STA spriteDirection
			;button unpressed end
			JMP SpritesUpdateCycleEnd
			+++
		;button pressed first time
		LDA spritesStateAction, X
		CMP #$03
		BNE ++++
			LDA spritesStateAnim, X ;action
			CMP #$00 ;left
			BCC +++++
				CMP #$05
				BCS ++++++
					LDA Left
					STA spriteDirection
					JMP SpritesUpdateReturn
					++++++
				+++++
			++++
		LDA buttonsP1
		AND bB
		CMP bB
		BEQ ++
			LDA #$00
			STA spritesTimerAnim, X
			LDA #$01
			STA spritesStateAnim, X
			++
		LDA #$00
		STA spritesTimerAction, X
		LDA #$03
		STA spritesStateAction, X
		PlayerDirLeft:
		LDA Left
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA buttonsP1Old
	AND Right
	ORA buttonsP1
	AND #$0F
	CMP Right
	BNE +
		LDA buttonsP1
		AND #$0F
		CMP Right
		BNE +++
			LDA buttonsP1Old
			AND #$0F
			CMP Right
			BNE ++
				;button still pressed
				JMP PlayerDirRight
				;button still pressed end
				++
			+++
		LDA buttonsP1
		AND #$0F
		CMP #$00
		BNE +++
			;button unpressed
			LDA #$00
			STA spriteDirection
			;button unpressed end
			JMP SpritesUpdateCycleEnd
			+++
		;button pressed first time
		LDA spritesStateAction, X
		CMP #$04
		BNE ++++
			LDA spritesStateAnim, X ;action
			CMP #$05 ;right
			BCC +++++
				CMP #$0A
				BCS ++++++
					LDA Right
					STA spriteDirection
					JMP SpritesUpdateReturn
					++++++
				+++++
			++++
		LDA buttonsP1
		AND bB
		CMP bB
		BEQ ++
			LDA #$00
			STA spritesTimerAnim, X
			LDA #$06
			STA spritesStateAnim, X
			++
		LDA #$00
		STA spritesTimerAction, X
		LDA #$04
		STA spritesStateAction, X
		PlayerDirRight:
		LDA Right
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA buttonsP1Old
	AND UpLeft
	ORA buttonsP1
	AND #$0F
	CMP UpLeft
	BNE +
		LDA buttonsP1
		AND #$0F
		CMP UpLeft
		BNE +++
			LDA buttonsP1Old
			AND #$0F
			CMP UpLeft
			BNE ++
				;button still pressed
				JMP PlayerDirUpLeft
				;button still pressed end
				++
			+++
		LDA buttonsP1
		AND #$0F
		CMP #$00
		BNE ++
			;button unpressed
			LDA #$00
			STA spriteDirection
			;button unpressed end
			JMP SpritesUpdateCycleEnd
			++
		;button pressed first time
		LDA spritesStateAction, X
		CMP #$05
		BCC ++
			CMP #$0C
			BCS +++
				LDA spritesStateAnim, X ;action
				CMP #$14 ;up
				BCC +++++
					CMP #$19
					BCS ++++++
						LDA UpLeft
						STA spriteDirection
						JMP SpritesUpdateReturn
						++++++
					+++++
				+++
			++
		LDA buttonsP1
		AND bB
		CMP bB
		BEQ ++
			LDA #$00
			STA spritesTimerAnim, X
			LDA #$15
			STA spritesStateAnim, X
			++
		LDA #$00
		STA spritesTimerAction, X
		LDA #$05
		STA spritesStateAction, X
		PlayerDirUpLeft:
		LDA UpLeft
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA buttonsP1Old
	AND UpRight
	ORA buttonsP1
	AND #$0F
	CMP UpRight
	BNE +
		LDA buttonsP1
		AND #$0F
		CMP UpRight
		BNE +++
			LDA buttonsP1Old
			AND #$0F
			CMP UpRight
			BNE ++
				;button still pressed
				JMP PlayerDirUpRight
				;button still pressed end
			++
			+++
		LDA buttonsP1
		AND #$0F
		CMP #$00
		BNE ++
			;button unpressed
			LDA #$00
			STA spriteDirection
			;button unpressed end
			JMP SpritesUpdateCycleEnd
			++
		;button pressed first time
		LDA spritesStateAction, X
		CMP #$0C
		BCC ++
			CMP #$13
			BCS +++
				LDA spritesStateAnim, X ;action
				CMP #$19 ;upright
				BCC +++++
					CMP #$1E
					BCS ++++++
						LDA UpRight
						STA spriteDirection
						JMP SpritesUpdateReturn
						++++++
					+++++
				+++
			++
		LDA buttonsP1
		AND bB
		CMP bB
		BEQ ++
			LDA #$00
			STA spritesTimerAnim, X
			LDA #$1A
			STA spritesStateAnim, X
			++
		LDA #$00
		STA spritesTimerAction, X
		LDA #$0C
		STA spritesStateAction, X
		PlayerDirUpRight:
		LDA UpRight
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA buttonsP1Old
	AND DownLeft
	ORA buttonsP1
	AND #$0F
	CMP DownLeft
	BNE +
		LDA buttonsP1
		AND #$0F
		CMP DownLeft
		BNE +++
			LDA buttonsP1Old
			AND #$0F
			CMP DownLeft
			BNE ++
				;button still pressed
				JMP PlayerDirDownLeft
				;button still pressed end
				++
			+++
		LDA buttonsP1
		AND #$0F
		CMP #$00
		BNE ++
			;button unpressed
			LDA #$00
			STA spriteDirection
			;button unpressed end
			JMP SpritesUpdateCycleEnd
			++
		;button pressed first time
		LDA spritesStateAction, X
		CMP #$13
		BCC ++
			CMP #$1A
			BCS +++
				LDA spritesStateAnim, X ;action
				CMP #$1E ;downleft
				BCC +++++
					CMP #$23
					BCS ++++++
						LDA DownLeft
						STA spriteDirection
						JMP SpritesUpdateReturn
						++++++
					+++++
				+++
			++
		LDA buttonsP1
		AND bB
		CMP bB
		BEQ ++
			LDA #$00
			STA spritesTimerAnim, X
			LDA #$1F
			STA spritesStateAnim, X
			++
		LDA #$00
		STA spritesTimerAction, X
		LDA #$13
		STA spritesStateAction, X
		PlayerDirDownLeft:
		LDA DownLeft
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA buttonsP1Old
	AND DownRight
	ORA buttonsP1
	AND #$0F
	CMP DownRight
	BNE +
		LDA buttonsP1
		AND #$0F
		CMP DownRight
		BNE +++
			LDA buttonsP1Old
			AND #$0F
			CMP DownRight
			BNE ++
				;button still pressed
				JMP PlayerDirDownRight	
				;button still pressed end
				++
			+++
		LDA buttonsP1
		AND #$0F
		CMP #$00
		BNE ++
			;button unpressed
			LDA #$00
			STA spriteDirection
			;button unpressed end
			JMP SpritesUpdateCycleEnd
			++
		;button pressed first time
		LDA spritesStateAction, X
		CMP #$1A
		BCC ++
			CMP #$21
			BCS +++
				LDA spritesStateAnim, X ;action
				CMP #$23 ;downright
				BCC +++++
					CMP #$28
					BCS ++++++
						LDA DownRight
						STA spriteDirection
						JMP SpritesUpdateReturn
						++++++
					+++++
				+++
			++		
		LDA #$00
		STA spritesTimerAction, X
		LDA #$1A
		STA spritesStateAction, X
		PlayerDirDownRightB:
		LDA buttonsP1
		AND bB
		CMP bB
		BEQ ++
			LDA #$00
			STA spritesTimerAnim, X
			LDA #$24
			STA spritesStateAnim, X
			++
		PlayerDirDownRight:
		LDA DownRight
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA #$00
	STA spriteDirection
	JMP SpritesUpdateCycleEnd

AnimToAction:
	LDA spritesStateAnim, X ;action
	CMP #$0F ;up
	BCC +
		CMP #$14
		BCS ++
			LDA #$01
			STA spriteStateAction
			RTS
			++
		+
	CMP #$0A ;down
	BCC +
		CMP #$0F
		BCS ++
			LDA #$02
			STA spriteStateAction
			RTS
			++
		+
	CMP #$00 ;left
	BCC +
		CMP #$05
		BCS ++
			LDA #$03
			STA spriteStateAction
			RTS
			++
		+
	CMP #$05 ;right
	BCC +
		CMP #$0A
		BCS ++
			LDA #$04
			STA spriteStateAction
			RTS
			++
		+			
	CMP #$14 ;upleft
	BCC +
		CMP #$19
		BCS ++
			LDA #$05
			STA spriteStateAction
			RTS
			++
		+
	CMP #$19 ;upright
	BCC +
		CMP #$1E
		BCS ++
			LDA #$0C
			STA spriteStateAction
			RTS
			++
		+
	CMP #$1E ;downleft
	BCC +
		CMP #$23
		BCS ++
			LDA #$13
			STA spriteStateAction
			RTS
			++
		+
	CMP #$23 ;downright
	BCC +
		CMP #$28
		BCS ++
			LDA #$1A
			STA spriteStateAction
			RTS
			++
		+			

PlayerActionToBulletAction:
	LDA spritesStateAnim, X ;action
	CMP #$0F ;up
	BCC +
		CMP #$14
		BCS ++
			LDA #$01
			STA spriteStateAction
			RTS
			++
		+
	CMP #$0A ;down
	BCC +
		CMP #$0F
		BCS ++
			LDA #$02
			STA spriteStateAction
			RTS
			++
		+
	CMP #$00 ;left
	BCC +
		CMP #$05
		BCS ++
			LDA #$03
			STA spriteStateAction
			RTS
			++
		+
	CMP #$05 ;right
	BCC +
		CMP #$0A
		BCS ++
			LDA #$04
			STA spriteStateAction
			RTS
			++
		+			
	CMP #$14 ;upleft
	BCC +
		CMP #$19
		BCS ++
			LDA #$05
			STA spriteStateAction
			RTS
			++
		+
	CMP #$19 ;upright
	BCC +
		CMP #$1E
		BCS ++
			LDA #$0C
			STA spriteStateAction
			RTS
			++
		+
	CMP #$1E ;downleft
	BCC +
		CMP #$23
		BCS ++
			LDA #$13
			STA spriteStateAction
			RTS
			++
		+
	CMP #$23 ;downright
	BCC +
		CMP #$28
		BCS ++
			LDA #$1A
			STA spriteStateAction
			RTS
			++
		+			
BulletActionToTrigun:
	LDA spriteStateAction
	CMP #$01 ;UP
	BNE +
		LDA #$05
		STA spriteStateAction
		LDA #$0C
		STA temp
		RTS
		+
	CMP #$02 ;DOWN
	BNE +
		LDA #$13
		STA spriteStateAction
		LDA #$1A
		STA temp
		RTS
		+
	CMP #$03 ;LEFT
	BNE +
		LDA #$05
		STA spriteStateAction
		LDA #$13
		STA temp
		RTS
		+
	CMP #$04 ;RIGHT
	BNE +
		LDA #$0C
		STA spriteStateAction
		LDA #$1A
		STA temp
		RTS
		+
	CMP #$05 ;UPLEFT
	BNE +
		LDA #$03
		STA spriteStateAction
		LDA #$01
		STA temp
		RTS
		+
	CMP #$0C ;UPRIGHT
	BNE +
		LDA #$01
		STA spriteStateAction
		LDA #$04
		STA temp
		RTS
		+
	CMP #$13 ;DOWNLEFT
	BNE +
		LDA #$03
		STA spriteStateAction
		LDA #$02
		STA temp
		RTS
		+
	CMP #$1A ;DOWNRIGHT
	BNE +
		LDA #$02
		STA spriteStateAction
		LDA #$04
		STA temp
		RTS
		+
	