SpriteTypesMoveFunctionsLow:
	DB <(SpriteMoveFunctionPlayer1), <(SpriteMoveFunctionFollowPlayer1), $00, $00, $00, $00, <(SpriteMoveFunctioneExplosion), $00, $00
SpriteTypesMoveFunctionsHi:
	DB >(SpriteMoveFunctionPlayer1), >(SpriteMoveFunctionFollowPlayer1), $00, $00, $00, $00, >(SpriteMoveFunctioneExplosion), $00, $00

SpriteMoveFunctioneExplosion:
	LDA spritesStateAnim, X
	CMP #$04
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
	;check button A press
	LDA buttonsP1Old
	AND bA
	ORA buttonsP1
	AND bA
	CMP bA
	BNE +
		LDA buttonsP1Old
		AND bA
		CMP bA
		BNE ++
			;button still pressed
			JMP +
			;button still pressed end
			++
		LDA buttonsP1
		AND bA
		CMP #$00
		BNE ++
			;button unpressed
			;
			;button unpressed end
			JMP +
			++
		;button pressed first time
		LDA bulletsTimer
		CMP #$3C
		BEQ ++
		;Load sprites bullet
		LDA #$08 ;type
		STA spriteType
		LDA spritesX, X
		STA spriteX
		LDA spritesY, X
		STA spriteY
		LDA #$00 ;anim
		STA spriteStateAnim
		LDA spritesStateAction, X ;action
		STA spriteStateAction
		LDA #$00 ;timer
		STA spriteTimerAnim
		STA spriteTimerAction
		JSR SpritesAdd
		LDA #$00
		STA bulletsTimer
		;button pressed first time end		
			++
		+
	
	LDA buttonsP1Old
	AND Up
	ORA buttonsP1
	CMP Up
	BNE +
		LDA buttonsP1Old
		CMP Up
		BNE ++
			;button still pressed
			JMP PlayerDirUp
			;button still pressed end
			++
		LDA buttonsP1
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
			LDA Up
			STA spriteDirection
			JMP SpritesUpdateReturn
			++++
		LDA #$00
		STA spritesTimerAnim, X
		STA spritesTimerAction, X
		LDA #$01
		STA spritesStateAction, X
		LDA #$10
		STA spritesStateAnim, X
		PlayerDirUp:
		LDA Up
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA buttonsP1Old
	AND Down
	ORA buttonsP1
	CMP Down
	BNE +
		LDA buttonsP1Old
		CMP Down
		BNE ++
			;button still pressed
			JMP PlayerDirDown
			;button still pressed end
			++
		LDA buttonsP1
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
			LDA Down
			STA spriteDirection
			JMP SpritesUpdateReturn
			++++
		LDA #$00
		STA spritesTimerAnim, X
		STA spritesTimerAction, X
		LDA #$02
		STA spritesStateAction, X
		LDA #$0B
		STA spritesStateAnim, X
		PlayerDirDown:
		LDA Down
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA buttonsP1Old
	AND Left
	ORA buttonsP1
	CMP Left
	BNE +
		LDA buttonsP1Old
		CMP Left
		BNE ++
			;button still pressed
			JMP PlayerDirLeft
			;button still pressed end
			++
		LDA buttonsP1
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
			LDA Left
			STA spriteDirection
			JMP SpritesUpdateReturn
			++++
		LDA #$00
		STA spritesTimerAnim, X
		STA spritesTimerAction, X
		LDA #$03
		STA spritesStateAction, X
		LDA #$01
		STA spritesStateAnim, X
		PlayerDirLeft:
		LDA Left
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA buttonsP1Old
	AND Right
	ORA buttonsP1
	CMP Right
	BNE +
		LDA buttonsP1Old
		CMP Right
		BNE ++
			;button still pressed
			JMP PlayerDirRight
			;button still pressed end
			++
		LDA buttonsP1
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
			LDA Right
			STA spriteDirection
			JMP SpritesUpdateReturn
			++++
		LDA #$00
		STA spritesTimerAnim, X
		STA spritesTimerAction, X
		LDA #$04
		STA spritesStateAction, X
		LDA #$06
		STA spritesStateAnim, X
		PlayerDirRight:
		LDA Right
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA buttonsP1Old
	AND UpLeft
	ORA buttonsP1
	CMP UpLeft
	BNE +
		LDA buttonsP1Old
		CMP UpLeft
		BNE ++
			;button still pressed
			JMP PlayerDirUpLeft
			;button still pressed end
			++
		LDA buttonsP1
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
				LDA UpLeft
				STA spriteDirection
				JMP SpritesUpdateReturn
				+++
			++
		LDA #$00
		STA spritesTimerAnim, X
		STA spritesTimerAction, X
		LDA #$05
		STA spritesStateAction, X
		LDA #$15
		STA spritesStateAnim, X
		PlayerDirUpLeft:
		LDA UpLeft
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA buttonsP1Old
	AND UpRight
	ORA buttonsP1
	CMP UpRight
	BNE +
		LDA buttonsP1Old
		CMP UpRight
		BNE ++
			;button still pressed
			JMP PlayerDirUpRight
			;button still pressed end
			++
		LDA buttonsP1
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
				LDA UpRight
				STA spriteDirection
				JMP SpritesUpdateReturn
				+++
			++
		LDA #$00
		STA spritesTimerAnim, X
		STA spritesTimerAction, X
		LDA #$0C
		STA spritesStateAction, X
		LDA #$1A
		STA spritesStateAnim, X
		PlayerDirUpRight:
		LDA UpRight
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA buttonsP1Old
	AND DownLeft
	ORA buttonsP1
	CMP DownLeft
	BNE +
		LDA buttonsP1Old
		CMP DownLeft
		BNE ++
			;button still pressed
			JMP PlayerDirDownLeft
			;button still pressed end
			++
		LDA buttonsP1
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
				LDA DownLeft
				STA spriteDirection
				JMP SpritesUpdateReturn
				+++
			++
		LDA #$00
		STA spritesTimerAnim, X
		STA spritesTimerAction, X
		LDA #$13
		STA spritesStateAction, X
		LDA #$1F
		STA spritesStateAnim, X
		PlayerDirDownLeft:
		LDA DownLeft
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	LDA buttonsP1Old
	AND DownRight
	ORA buttonsP1
	CMP DownRight
	BNE +
		LDA buttonsP1Old
		CMP DownRight
		BNE ++
			;button still pressed
			JMP PlayerDirDownRight
			;button still pressed end
			++
		LDA buttonsP1
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
				LDA DownRight
				STA spriteDirection
				JMP SpritesUpdateReturn
				+++
			++
		LDA #$00
		STA spritesTimerAnim, X
		STA spritesTimerAction, X
		LDA #$1A
		STA spritesStateAction, X
		LDA #$24
		STA spritesStateAnim, X
		PlayerDirDownRight:
		LDA DownRight
		STA spriteDirection
		;button pressed first time end		
		JMP SpritesUpdateReturn
		+
	JMP SpritesUpdateCycleEnd

;----------------------------------------------------------------
;x change
;----------------------------------------------------------------
SpriteTypesMoveTilesXLowLow:
	DB <(SpritePlayerMoveTilesXLow), <(SpritePlayerMoveTilesXLow), <(SpritePlayerMoveTilesXLow), <(SpriteHurtMoveTilesXLow), <(SpriteGunMoveTilesXLow), <(SpriteHurtMoveTilesXLow), $00, <(SpriteHurtMoveTilesXLow), <(SpriteBulletMoveTilesXLow)
SpriteTypesMoveTilesXLowHi:
	DB >(SpritePlayerMoveTilesXLow), >(SpritePlayerMoveTilesXLow), >(SpritePlayerMoveTilesXLow), >(SpriteHurtMoveTilesXLow), >(SpriteGunMoveTilesXLow), >(SpriteHurtMoveTilesXLow), $00, >(SpriteHurtMoveTilesXLow), >(SpriteBulletMoveTilesXLow)
SpriteTypesMoveTilesXHiLow:
	DB <(SpritePlayerMoveTilesXHi), <(SpritePlayerMoveTilesXHi), <(SpritePlayerMoveTilesXHi), <(SpriteHurtMoveTilesXHi), <(SpriteGunMoveTilesXHi), <(SpriteHurtMoveTilesXHi), $00, <(SpriteHurtMoveTilesXHi), <(SpriteBulletMoveTilesXHi)
SpriteTypesMoveTilesXHiHi:
	DB >(SpritePlayerMoveTilesXHi), >(SpritePlayerMoveTilesXHi), >(SpritePlayerMoveTilesXHi), >(SpriteHurtMoveTilesXHi), >(SpriteGunMoveTilesXHi), >(SpriteHurtMoveTilesXHi), $00, >(SpriteHurtMoveTilesXHi), >(SpriteBulletMoveTilesXHi)
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
	DB $02
SpriteMove2LeftXTiles:
	DB $FE
;----------------------------------------------------------------
;y change
;----------------------------------------------------------------
SpriteTypesMoveTilesYLowLow:
	DB <(SpritePlayerMoveTilesYLow), <(SpritePlayerMoveTilesYLow), <(SpritePlayerMoveTilesYLow), <(SpriteHurtMoveTilesYLow), <(SpriteGunMoveTilesYLow), <(SpriteHurtMoveTilesYLow), $00, <(SpriteHurtMoveTilesYLow), <(SpriteBulletMoveTilesYLow)
SpriteTypesMoveTilesYLowHi:
	DB >(SpritePlayerMoveTilesYLow), >(SpritePlayerMoveTilesYLow), >(SpritePlayerMoveTilesYLow), >(SpriteHurtMoveTilesYLow), >(SpriteGunMoveTilesYLow), >(SpriteHurtMoveTilesYLow), $00, >(SpriteHurtMoveTilesYLow), >(SpriteBulletMoveTilesYLow)
SpriteTypesMoveTilesYHiLow:
	DB <(SpritePlayerMoveTilesYHi), <(SpritePlayerMoveTilesYHi), <(SpritePlayerMoveTilesYHi), <(SpriteHurtMoveTilesYHi), <(SpriteGunMoveTilesYHi), <(SpriteHurtMoveTilesYHi), $00, <(SpriteHurtMoveTilesYHi), <(SpriteBulletMoveTilesYHi)
SpriteTypesMoveTilesYHiHi:
	DB >(SpritePlayerMoveTilesYHi), >(SpritePlayerMoveTilesYHi), >(SpritePlayerMoveTilesYHi), >(SpriteHurtMoveTilesYHi), >(SpriteGunMoveTilesYHi), >(SpriteHurtMoveTilesYHi), $00, >(SpriteHurtMoveTilesYHi), >(SpriteBulletMoveTilesYHi)
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
	DB $FE
SpriteMove2DownYTiles
	DB $02
;----------------------------------------------------------------
; frames order
;----------------------------------------------------------------
SpriteTypesMoveFramesLow:
	DB <(SpritePlayerMoveFrames), <(SpritePlayerMoveFrames), <(SpritePlayerMoveFrames), <(SpriteHurtMoveFrames), <(SpriteHurtMoveFrames), <(SpriteHurtMoveFrames), $00, <(SpriteHurtMoveFrames), <(SpritePlayerMoveFrames)
SpriteTypesMoveFramesHi:
	DB >(SpritePlayerMoveFrames), >(SpritePlayerMoveFrames), >(SpritePlayerMoveFrames), >(SpriteHurtMoveFrames), >(SpriteHurtMoveFrames), >(SpriteHurtMoveFrames), $00, >(SpriteHurtMoveFrames), >(SpritePlayerMoveFrames)
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
	DB <(SpritePlayerMoveTimes), <(SpritePlayerMoveTimes), <(SpriteTripodMoveTimes), <(SpriteHurtMoveTimes), <(SpriteHurtMoveTimes), <(SpriteHurtMoveTimes), $00, <(SpriteHurtMoveTimes), <(SpritePlayerMoveTimes)
SpriteTypesMoveTimesHi:
	DB >(SpritePlayerMoveTimes), >(SpritePlayerMoveTimes), >(SpriteTripodMoveTimes), >(SpriteHurtMoveTimes), >(SpriteHurtMoveTimes), >(SpriteHurtMoveTimes), $00, >(SpriteHurtMoveTimes), >(SpritePlayerMoveTimes)
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

