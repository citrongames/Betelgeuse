SpriteTypesColXSpriteFunctionsLow:
	DB <(SpriteColXSpriteFunctionPlayer1), <(SpriteColXSpriteFunctionTri), <(SpriteColXSpriteFunctionTank), $00, $00, $00, $00, $00
	DB <(BulletsColXSpriteFunctionPlayer1), $00, <(BulletsColXSpriteFunctionEnemy), $00, $00, $00, $00, $00
	DB $00
SpriteTypesColXSpriteFunctionsHi:
	DB >(SpriteColXSpriteFunctionPlayer1), >(SpriteColXSpriteFunctionTri), >(SpriteColXSpriteFunctionTank), $00, $00, $00, $00, $00
	DB >(BulletsColXSpriteFunctionPlayer1), $00, >(BulletsColXSpriteFunctionEnemy), $00, $00, $00, $00, $00
	DB $00
SpriteTypesColYSpriteFunctionsLow:
	DB <(SpriteColYSpriteFunctionPlayer1), <(SpriteColYSpriteFunctionTri), <(SpriteColYSpriteFunctionTank), $00, $00, $00, $00, $00
	DB <(BulletsColYSpriteFunctionPlayer1), $00, <(BulletsColYSpriteFunctionEnemy), $00, $00, $00, $00, $00
	DB $00
SpriteTypesColYSpriteFunctionsHi:
	DB >(SpriteColYSpriteFunctionPlayer1), >(SpriteColYSpriteFunctionTri), >(SpriteColYSpriteFunctionTank), $00, $00, $00, $00, $00
	DB >(BulletsColYSpriteFunctionPlayer1), $00, >(BulletsColYSpriteFunctionEnemy), $00, $00, $00, $00, $00
	DB $00
SpriteBoundariesLow:
	DB <(SpriteBoundariesPlayer1), <(SpriteBoundariesTripod), <(SpriteBoundariesTank), <(SpriteBoundariesPickUp), $00, $00, $00, <(SpriteBoundariesPickUp)
	DB <(SpriteBoundariesBullet), $00, <(SpriteBoundariesEnemyBullet), $00, $00, <(SpriteBoundariesLevel1Boss), $00, <(SpriteBoundariesPickUp)
	DB <(SpriteBoundariesPickUp)
SpriteBoundariesHi:
	DB >(SpriteBoundariesPlayer1), >(SpriteBoundariesTripod), >(SpriteBoundariesTank), >(SpriteBoundariesPickUp), $00, $00, $00, >(SpriteBoundariesPickUp)
	DB >(SpriteBoundariesBullet), $00, >(SpriteBoundariesEnemyBullet), $00, $00, >(SpriteBoundariesLevel1Boss), $00, >(SpriteBoundariesPickUp)
	DB >(SpriteBoundariesPickUp)
	   ;x0  ;x1  ;y0  ;y1
SpriteBoundariesPlayer1:
	DB $02, $0E, $02, $0E
SpriteBoundariesTripod:
	DB $02, $0E, $02, $0E
SpriteBoundariesTripodLevel:
	DB $02, $0E, $02, $0E
SpriteBoundariesTank:
	DB $02, $0E, $02, $0E
SpriteBoundariesTankLevel:
	DB $02, $0E, $02, $0E
SpriteBoundariesBullet:
	DB $04, $06, $04, $06
SpriteBoundariesEnemyBullet:
	DB $02, $08, $02, $08
SpriteBoundariesPickUp:
	DB $00, $08, $00, $08
SpriteBoundariesLevel1Boss:
	DB $04, $2C, $04, $10
	
SpawnRandomPickUp:
	JSR GetRandomNumber
	LDA randomNum
	AND #$01
	CMP #$00 ;coin or powerup with heart?
	BNE +
		;coin
		LDA randomNum
		AND #$80
		CMP #$00 ;spawn coin or not
		BNE ++
			;coin
			LDA coinsOnLevel
			CMP MaxCoinsOnLevel
			BEQ +++
				INC coinsOnLevel
				LDA #$07
				JMP SpawnPowerUp
				+++
			RTS
			++
		;not spawn
		RTS
		+
	;powerup and heart
	JSR GetRandomNumber
	LDA randomNum
	AND #$01
	CMP #$00 ;spawn or not
	BNE +
		;coin
		LDA randomNum
		AND #$80
		CMP #$00 ;heart or powerup
		BNE ++
			;heart
			LDA powerUpsOnLevel
			CMP #$01
			BEQ +++
				INC powerUpsOnLevel
				LDA #$03
				JMP SpawnPowerUp
				+++
			RTS
			++
		;powerup
		LDA powerUpsOnLevel
		CMP #$01
		BEQ +++
			INC powerUpsOnLevel
			LDA #$0F
			JMP SpawnPowerUp
			+++
		RTS
		+
	;not spawn
	RTS
	++++++
	SpawnPowerUp:
	STA spriteType
	LDA spritesX, X ;x
	CLC
	ADC #$04
	STA spriteX
	LDA spritesY, X ;y
	CLC
	ADC #$04
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
	RTS
	
SpriteExplodeOnCollision:
	;Load sprites explosion
	LDA #$06 ;type
	STA spriteType
	LDA spritesX, X ;x
	STA spriteX
	LDA spritesY, X ;y
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
RTS

SpriteBulletGhostOnCollision:
	;Load sprites explosion
	LDA #$09 ;type
	STA spriteType
	LDA spritesX, X ;x
	STA spriteX
	LDA spritesY, X ;y
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
RTS

;player collision
SpriteColStandStillFunctionPlayer1:
	LDA #$01
	JSR Function_LoadCollisionValuesLeftUp
	LDX #$04
		- ;cycle
		LDY spritesType, X
			CPY #$01 ;tripod
		BEQ +
			CPY #$02 ;tank
		BEQ +
			CPY #$03 ;hurt
		BEQ +
			CPY #$07 ;coin small
		BEQ +
			CPY #$0F ;trigun powerup
		BEQ +
			CPY #$10 ;key
		BEQ +
			CPY #$0A ;enemy bullet
		BEQ +
			CPY #$0D ;boss level 1
		BEQ +
			JMP ++
			+
			JSR Function_CheckCollision
			LDA value
			CMP #$00
			BEQ +
				JMP ++
				+
			;do collision routine
			JSR Function_PlayerCollision
			LDA value
			CMP #$00
			BEQ +
				LDX currentIndex
				JMP SpritesUpdateCycleEndSkipINX
				+
			++
		INX
		CPX spritesLength
	BEQ +
		JMP -
		+
	RTS
	
SpriteColXSpriteFunctionPlayer1:
	LDA spriteDirection
	AND Left
	CMP Left
	BEQ +
		JMP _PLAYER_MOVEMENT_RIGHT_ ;movement to the right?
		+
		;left
		JSR Function_LoadCollisionValuesLeftUp
		LDX #$03
			- ;cycle
			LDY spritesType, X
				CPY #$01 ;tripod
			BEQ +
				CPY #$02 ;tank
			BEQ +
				CPY #$03 ;hurt
			BEQ +
				CPY #$07 ;coin small
			BEQ +
				CPY #$0F ;trigun powerup
			BEQ +
				CPY #$10 ;key
			BEQ +
				CPY #$0A ;enemy bullet
			BEQ +
				CPY #$0D ;boss level 1
			BEQ +
				JMP ++
				+
				JSR Function_CheckCollision
				LDA value
				CMP #$00
				BEQ +
					JMP ++
					+
				;do collision routine
				JSR Function_PlayerCollision
				LDA value
				CMP #$00
				BEQ +
					LDX currentIndex
					JMP SpritesUpdateCycleEndSkipINX
					+
				++
			INX
			CPX spritesLength
	BEQ +
		JMP -
		+
		LDY spriteNewX
		STY playerX
	;---------------------------------collision to the level/room LEFT start
	JSR Function_InitWallCollisionBlocksLeftRightVars	
		-
		;collision on x?
		JSR Function_CheckWallCollisionBlocksLeftRight
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		JSR Function_PlayerCollisionBlocksWall	
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room LEFT end
	_PLAYER_MOVEMENT_RIGHT_: ;check movement to the right
	LDA spriteDirection
	AND Right
	CMP Right
	BEQ +
		JMP SpritesColXReturn ;no movement on x
		+
		;right
		JSR Function_LoadCollisionValuesRightDown
		LDX #$03
			- ;cycle
			LDY spritesType, X
				CPY #$01 ;tripod
			BEQ +
				CPY #$02 ;tank
			BEQ +
				CPY #$03 ;hurt
			BEQ +
				CPY #$07 ;coin small
			BEQ +
				CPY #$0F ;trigun powerup
			BEQ +
				CPY #$10 ;key
			BEQ +
				CPY #$0A ;enemy bullet
			BEQ +
				CPY #$0D ;boss level 1
			BEQ +
				JMP ++
				+
				JSR Function_CheckCollision
				LDA value
				CMP #$00
				BEQ +
					JMP ++
					+
				;do collision routine
				JSR Function_PlayerCollision
				LDA value
				CMP #$00
				BEQ +
					LDX currentIndex
					JMP SpritesUpdateCycleEndSkipINX
					+
				++
			INX
			CPX spritesLength
	BEQ +
		JMP -
		+
		LDY spriteNewX
		STY playerX
	;---------------------------------collision to the level/room RIGHT start
	JSR Function_InitWallCollisionBlocksLeftRightVars	
		-
		;collision on x?
		JSR Function_CheckWallCollisionBlocksLeftRight
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		JSR Function_PlayerCollisionBlocksWall	
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room RIGHT end
	JMP SpritesColXReturn
						
SpriteColYSpriteFunctionPlayer1:
	LDA spriteDirection
	AND Up
	CMP Up
	BEQ +
		JMP _PLAYER_MOVEMENT_DOWN_ ;movement to the down?
		+
		;up
		JSR Function_LoadCollisionValuesLeftUp
		LDX #$03
			- ;cycle
			LDY spritesType, X
				CPY #$01 ;tripod
			BEQ +
				CPY #$02 ;tank
			BEQ +
				CPY #$03 ;hurt
			BEQ +
				CPY #$07 ;coin small
			BEQ +
				CPY #$0F ;trigun powerup
			BEQ +
				CPY #$10 ;key
			BEQ +
				CPY #$0A ;enemy bullet
			BEQ +
				CPY #$0D ;boss level 1
			BEQ +
				JMP ++
				+
				JSR Function_CheckCollision
				LDA value
				CMP #$00
				BEQ +
					JMP ++
					+
				;do collision routine
				JSR Function_PlayerCollision
				LDA value
				CMP #$00
				BEQ +
					LDX currentIndex
					JMP SpritesUpdateCycleEndSkipINX
					+
				++
			INX
			CPX spritesLength
	BEQ +
		JMP -
		+
		LDY spriteNewY
		STY playerY
	;---------------------------------collission to the level/room up
	JSR Function_InitWallCollisionBlocksUpDownVars	
		-
		;collision on x?
		JSR Function_CheckWallCollisionBlocksUpDown
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+	
		JSR Function_PlayerCollisionBlocksWall	
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;------------------------------------------------------------
	_PLAYER_MOVEMENT_DOWN_: ;check movement to the down
	LDA spriteDirection
	AND Down
	CMP Down
	BEQ +
		JMP SpritesColYReturn ;no movement on y
		+
		;down
		JSR Function_LoadCollisionValuesRightDown
		LDX #$03
			- ;cycle
			LDY spritesType, X
				CPY #$01 ;tripod
			BEQ +
				CPY #$02 ;tank
			BEQ +
				CPY #$03 ;hurt
			BEQ +
				CPY #$07 ;coin small
			BEQ +
				CPY #$0F ;trigun powerup
			BEQ +
				CPY #$10 ;key
			BEQ +
				CPY #$0A ;enemy bullet
			BEQ +
				CPY #$0D ;boss level 1
			BEQ +
				JMP ++
				+
				JSR Function_CheckCollision
				LDA value
				CMP #$00
				BEQ +
					JMP ++
					+
				;do collision routine
				JSR Function_PlayerCollision
				LDA value
				CMP #$00
				BEQ +
					LDX currentIndex
					JMP SpritesUpdateCycleEndSkipINX
					+
				++
			INX
			CPX spritesLength
	BEQ +
		JMP -
		+
		LDY spriteNewY
		STY playerY
	;---------------------------------collision to the level/room down start
	JSR Function_InitWallCollisionBlocksUpDownVars	
		-
		;collision on x?
		JSR Function_CheckWallCollisionBlocksUpDown
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+	
		JSR Function_PlayerCollisionBlocksWall	
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room down end
	JMP SpritesColYReturn

;Tripod collisions
SpriteColXSpriteFunctionTri:
	LDA spriteDirection
	AND Left
	CMP Left
	BEQ +
		JMP _TRIPOD_MOVEMENT_RIGHT_ ;movement to the right?
		+
		;left
		JSR Function_LoadCollisionValuesLeftUp
		LDX #$04
			- ;left dir cycle
			CPX currentIndex
			BNE +
				JMP ++
				+
			LDY spritesType, X
			CPY #$01 ;tripod
			BEQ +
				JMP ++
				+
				JSR Function_CheckCollisionEnemy
				LDA value
				CMP #$00
				BEQ +
					JMP ++
					+
				;do collision routine
				LDA spriteOldX
				STA spriteNewX
				JMP SpritesColXReturn
		++
		INX
		CPX spritesLength
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room LEFT start
	JSR Function_InitWallCollisionBlocksLeftRightVars	
		-
		;collision on x?
		JSR Function_CheckWallCollisionBlocksLeftRight
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		;do collision routine
		LDA spriteOldX
		STA spriteNewX
		JMP SpritesColXReturn
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room LEFT end
	_TRIPOD_MOVEMENT_RIGHT_: ;check movement to the right
	LDA spriteDirection
	AND Right
	CMP Right
	BEQ +
		JMP SpritesColXReturn ;no movement on x
		+
		;right
		JSR Function_LoadCollisionValuesRightDown
		LDX #$04
			- ;left dir cycle
			CPX currentIndex
			BNE +
				JMP ++
				+
			LDY spritesType, X
			CPY #$01 ;tripod
			BEQ +
				JMP ++
				+
				JSR Function_CheckCollisionEnemy
				LDA value
				CMP #$00
				BEQ +
					JMP ++
					+
				;do collision routine
				LDA spriteOldX
				STA spriteNewX
				JMP SpritesColXReturn
		++
		INX
		CPX spritesLength
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room RIGHT start
	JSR Function_InitWallCollisionBlocksLeftRightVars	
		-
		;collision on x?
		JSR Function_CheckWallCollisionBlocksLeftRight
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		;do collision routine
		LDA spriteOldX
		STA spriteNewX
		JMP SpritesColXReturn
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room RIGHT end
	JMP SpritesColXReturn
						
SpriteColYSpriteFunctionTri:
	LDA spriteDirection
	AND Up
	CMP Up
	BEQ +
		JMP _TRIPOD_MOVEMENT_DOWN_ ;movement to the right?
		+
		;up
		JSR Function_LoadCollisionValuesLeftUp
		LDX #$04
			- ;left dir cycle
			CPX currentIndex
			BNE +
				JMP ++
				+
			LDY spritesType, X
			CPY #$01 ;tripod
			BEQ +
				JMP ++
				+
				JSR Function_CheckCollisionEnemy
				LDA value
				CMP #$00
				BEQ +
					JMP ++
					+
				;do collision routine
				LDA spriteOldY
				STA spriteNewY
				JMP SpritesColYReturn
		++
		INX
		CPX spritesLength
	BEQ +
		JMP -
		+
	;---------------------------------collission to the level/room up
	JSR Function_InitWallCollisionBlocksUpDownVars	
		-
		;collision on y?
		JSR Function_CheckWallCollisionBlocksUpDown
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		;do collision routine
		LDA spriteOldY
		STA spriteNewY
		JMP SpritesColYReturn
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;------------------------------------------------------------
	_TRIPOD_MOVEMENT_DOWN_ ;check movement to the down
	LDA spriteDirection
	AND Down
	CMP Down
	BEQ +
		JMP SpritesColYReturn ;no movement on y
		+
		;down
		JSR Function_LoadCollisionValuesRightDown
		LDX #$04
			- ;left dir cycle
			CPX currentIndex
			BNE +
				JMP ++
				+
			LDY spritesType, X
			CPY #$01 ;tripod
			BEQ +
				JMP ++
				+
				JSR Function_CheckCollisionEnemy
				LDA value
				CMP #$00
				BEQ +
					JMP ++
					+
				;do collision routine
				LDA spriteOldY
				STA spriteNewY
				JMP SpritesColYReturn
		++
		INX
		CPX spritesLength
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room down start
	JSR Function_InitWallCollisionBlocksUpDownVars	
		-
		;collision on y?
		JSR Function_CheckWallCollisionBlocksUpDown
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		;do collision routine
		LDA spriteOldY
		STA spriteNewY
		JMP SpritesColYReturn
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room down end
	JMP SpritesColYReturn

;player bullet collision
BulletsColXSpriteFunctionPlayer1:
	LDA spriteDirection
	AND Left
	CMP Left
	BEQ +
		JMP _PLAYER_BULLET_MOVEMENT_RIGHT_ ;movement to the right?
		+
		;left
		JSR Function_LoadCollisionValuesLeftUp
				
		LDX #$04
			- ;left dir cycle
			LDY spritesType, X	
			CPY #$01 ;tripod
			BEQ +
				CPY #$02 ;tank
			BEQ +
				CPY #$0D ;boss level 1
			BEQ +
				JMP ++
				+
				JSR Function_CheckCollision
				LDA value
				CMP #$00
				BEQ +
					JMP ++
					+
				;do collision routine
				JSR Function_PlayerBulletCollision
				LDA value
				CMP #$00
				BEQ +
					LDX currentIndex
					JMP SpritesUpdateCycleEndSkipINX
					+
				++
		INX
		CPX spritesLength
		BEQ +
			JMP -
			+
	;---------------------------------collision to the level/room LEFT start
	JSR Function_InitWallCollisionBlocksLeftRightVars	
		-
		;collision on x?
		JSR Function_CheckWallCollisionBlocksLeftRight
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		JSR Function_PlayerBulletCollisionWall	
		LDA value
		CMP #$00
		BEQ +
			LDX currentIndex
			JMP SpritesUpdateCycleEndSkipINX
			+	
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room LEFT end
	_PLAYER_BULLET_MOVEMENT_RIGHT_ ;check movement to the right
	LDA spriteDirection
	AND Right
	CMP Right
	BEQ +
		JMP SpritesColXReturn ;no movement on x
		+
		;right
		JSR Function_LoadCollisionValuesRightDown
				
		LDX #$04
			- ;right dir cycle
			LDY spritesType, X	
			CPY #$01 ;tripod
			BEQ +
				CPY #$02 ;tank
			BEQ +
				CPY #$0D ;boss level 1
			BEQ +
				JMP ++
				+
				JSR Function_CheckCollision
				LDA value
				CMP #$00
				BEQ +
					JMP ++
					+
				;do collision routine
				JSR Function_PlayerBulletCollision
				LDA value
				CMP #$00
				BEQ +
					LDX currentIndex
					JMP SpritesUpdateCycleEndSkipINX
					+
				++
		INX
		CPX spritesLength
		BEQ +
			JMP -
			+
	;---------------------------------collision to the level/room RIGHT start
	JSR Function_InitWallCollisionBlocksLeftRightVars	
		-
		;collision on x?
		JSR Function_CheckWallCollisionBlocksLeftRight
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		JSR Function_PlayerBulletCollisionWall	
		LDA value
		CMP #$00
		BEQ +
			LDX currentIndex
			JMP SpritesUpdateCycleEndSkipINX
			+	
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room RIGHT end
JMP SpritesColXReturn
						
BulletsColYSpriteFunctionPlayer1:
	LDA spriteDirection
	AND Up
	CMP Up
	BEQ +
		JMP _PLAYER_BULLET_MOVEMENT_DOWN_ ;movement to the down?
		+
		;up
		JSR Function_LoadCollisionValuesLeftUp
				
		LDX #$04
			- ;up dir cycle
			LDY spritesType, X	
			CPY #$01 ;tripod
			BEQ +
				CPY #$02 ;tank
			BEQ +
				CPY #$0D ;boss level 1
			BEQ +
				JMP ++
				+
				JSR Function_CheckCollision
				LDA value
				CMP #$00
				BEQ +
					JMP ++
					+
				;do collision routine
				JSR Function_PlayerBulletCollision
				LDA value
				CMP #$00
				BEQ +
					LDX currentIndex
					JMP SpritesUpdateCycleEndSkipINX
					+
				++
		INX
		CPX spritesLength
		BEQ +
			JMP -
			+
	;---------------------------------collission to the level/room up
	JSR Function_InitWallCollisionBlocksUpDownVars	
		-
		;collision on y?
		JSR Function_CheckWallCollisionBlocksUpDown
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		JSR Function_PlayerBulletCollisionWall	
		LDA value
		CMP #$00
		BEQ +
			LDX currentIndex
			JMP SpritesUpdateCycleEndSkipINX
			+	
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+	
	;------------------------------------------------------------
	_PLAYER_BULLET_MOVEMENT_DOWN_ ;check movement to the down
	LDA spriteDirection
	AND Down
	CMP Down
	BEQ +
		JMP SpritesColYReturn ;no movement on y
		+
		;down
		JSR Function_LoadCollisionValuesRightDown
				
		LDX #$04
			- ;down dir cycle
			LDY spritesType, X	
			CPY #$01 ;tripod
			BEQ +
				CPY #$02 ;tank
			BEQ +
				CPY #$0D ;boss level 1
			BEQ +
				JMP ++
				+
				JSR Function_CheckCollision
				LDA value
				CMP #$00
				BEQ +
					JMP ++
					+
				;do collision routine
				JSR Function_PlayerBulletCollision
				LDA value
				CMP #$00
				BEQ +
					LDX currentIndex
					JMP SpritesUpdateCycleEndSkipINX
					+
				++
		INX
		CPX spritesLength
		BEQ +
			JMP -
			+
	;---------------------------------collision to the level/room down start
	JSR Function_InitWallCollisionBlocksUpDownVars	
		-
		;collision on y?
		JSR Function_CheckWallCollisionBlocksUpDown
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		JSR Function_PlayerBulletCollisionWall	
		LDA value
		CMP #$00
		BEQ +
			LDX currentIndex
			JMP SpritesUpdateCycleEndSkipINX
			+	
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+			
	;---------------------------------collision to the level/room down end
	JMP SpritesColYReturn


;Tank collisions
SpriteColXSpriteFunctionTank:
	LDA spriteDirection
	AND Left
	CMP Left
	BEQ +
		JMP _TANK_MOVEMENT_RIGHT_ ;movement to the right?
		+
		;left
		JSR Function_LoadCollisionValuesLeftUp
	;---------------------------------collision to the level/room LEFT start
	JSR Function_InitWallCollisionBlocksLeftRightVars	
		-
		;collision on x?
		JSR Function_CheckWallCollisionBlocksLeftRight
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		;do collision routine
		LDA spriteOldX
		STA spriteNewX
		LDX currentIndex
		JSR SpriteMoveFunctioneTankRandomDir
		JMP SpritesColXReturn
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+	
	;---------------------------------collision to the level/room LEFT end
	_TANK_MOVEMENT_RIGHT_: ;check movement to the right
	LDA spriteDirection
	AND Right
	CMP Right
	BEQ +
		JMP SpritesColXReturn ;no movement on x
		+
		;right
		JSR Function_LoadCollisionValuesRightDown
	;---------------------------------collision to the level/room RIGHT start
	JSR Function_InitWallCollisionBlocksLeftRightVars	
		-
		;collision on x?
		JSR Function_CheckWallCollisionBlocksLeftRight
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		;do collision routine
		LDA spriteOldX
		STA spriteNewX
		LDX currentIndex
		JSR SpriteMoveFunctioneTankRandomDir
		JMP SpritesColXReturn
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+	
	;---------------------------------collision to the level/room RIGHT end
	JMP SpritesColXReturn
						
SpriteColYSpriteFunctionTank:
	LDA spriteDirection
	AND Up
	CMP Up
	BEQ +
		JMP _TANK_MOVEMENT_DOWN_ ;movement to the right?
		+
		;up
		JSR Function_LoadCollisionValuesLeftUp
	;---------------------------------collission to the level/room up
	JSR Function_InitWallCollisionBlocksUpDownVars	
		-
		;collision on y?
		JSR Function_CheckWallCollisionBlocksUpDown
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		;do collision routine
		LDA spriteOldY
		STA spriteNewY
		LDX currentIndex
		JSR SpriteMoveFunctioneTankRandomDir
		JMP SpritesColYReturn
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+	
	;------------------------------------------------------------
	_TANK_MOVEMENT_DOWN_: ;check movement to the down
	LDA spriteDirection
	AND Down
	CMP Down
	BEQ +
		JMP SpritesColYReturn ;no movement on y
		+
		;down
		JSR Function_LoadCollisionValuesRightDown
	;---------------------------------collision to the level/room down start
	JSR Function_InitWallCollisionBlocksUpDownVars	
		-
		;collision on y?
		JSR Function_CheckWallCollisionBlocksUpDown
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		;do collision routine
		LDA spriteOldY
		STA spriteNewY
		LDX currentIndex
		JSR SpriteMoveFunctioneTankRandomDir
		JMP SpritesColYReturn
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room down end
	JMP SpritesColYReturn

;enemy bullet collision
BulletsColXSpriteFunctionEnemy:
	LDA spriteDirection
	AND Left
	CMP Left
	BEQ +
		JMP _ENEMY_BULLET_MOVEMENT_RIGHT_ ;movement to the right?
		+
	;---------------------------------collision to the level/room LEFT start
	JSR Function_LoadCollisionValuesLeftUp
	JSR Function_InitWallCollisionBlocksLeftRightVars	
		-
		;collision on x?
		JSR Function_CheckWallCollisionBlocksLeftRight
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		JSR Function_EnemyBulletCollisionWall
		LDA value
		CMP #$00
		BEQ +
			LDX currentIndex
			JMP SpritesUpdateCycleEndSkipINX
			+	
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room LEFT end
	_ENEMY_BULLET_MOVEMENT_RIGHT_: ;check movement to the right
	LDA spriteDirection
	AND Right
	CMP Right
	BEQ +
		JMP SpritesColXReturn ;no movement on y
		+
	;---------------------------------collision to the level/room RIGHT start
	JSR Function_LoadCollisionValuesRightDown
	JSR Function_InitWallCollisionBlocksLeftRightVars	
		-
		;collision on x?
		JSR Function_CheckWallCollisionBlocksLeftRight
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		JSR Function_EnemyBulletCollisionWall	
		LDA value
		CMP #$00
		BEQ +
			LDX currentIndex
			JMP SpritesUpdateCycleEndSkipINX
			+	
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room RIGHT end
	JMP SpritesColXReturn
						
BulletsColYSpriteFunctionEnemy:
	LDA spriteDirection
	AND Up
	CMP Up
	BEQ +
		JMP _ENEMY_BULLET_MOVEMENT_DOWN_ ;movement to the down?
		+
	;---------------------------------collission to the level/room up
	JSR Function_LoadCollisionValuesLeftUp
	JSR Function_InitWallCollisionBlocksUpDownVars	
		-
		;collision on x?
		JSR Function_CheckWallCollisionBlocksUpDown
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		JSR Function_EnemyBulletCollisionWall	
		LDA value
		CMP #$00
		BEQ +
			LDX currentIndex
			JMP SpritesUpdateCycleEndSkipINX
			+	
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;------------------------------------------------------------
	_ENEMY_BULLET_MOVEMENT_DOWN_: ;check movement to the down
	LDA spriteDirection
	AND Down
	CMP Down
	BEQ +
		JMP SpritesColYReturn ;no movement on y
		+
	;---------------------------------collision to the level/room down start
	JSR Function_LoadCollisionValuesRightDown
	JSR Function_InitWallCollisionBlocksUpDownVars	
		-
		;collision on x?
		JSR Function_CheckWallCollisionBlocksUpDown
		LDA value
		CMP #$00
		BEQ +
			JMP ++
			+
		JSR Function_EnemyBulletCollisionWall	
		LDA value
		CMP #$00
		BEQ +
			LDX currentIndex
			JMP SpritesUpdateCycleEndSkipINX
			+	
		++
	DEC counter
	LDA counter
	CMP #$00
	BEQ +
		JMP -
		+
	;---------------------------------collision to the level/room down end
	JMP SpritesColYReturn

Function_CheckCollision:
	LDA #$00
	STA value
	LDA SpriteBoundariesLow, Y
	STA pointerLow
	LDA SpriteBoundariesHi, Y
	STA pointerHi
				
	LDY #$00
	LDA spritesX, X
	CLC 
	ADC (pointerLow), Y
	STA ColX2
	INY
	LDA spritesX, X
	CLC 
	ADC (pointerLow), Y
	STA ColX3
	INY
	LDA spritesY, X
	CLC 
	ADC (pointerLow), Y
	STA ColY2
	INY
	LDA spritesY, X
	CLC 
	ADC (pointerLow), Y
	STA ColY3
				
	CLC
	LDA ColX3
	CMP ColX0
	BCS +
		LDA #$01
		STA value
		RTS
		+
	CLC
	LDA ColX1
	CMP ColX2
	BCS +
		LDA #$01
		STA value
		RTS
		+
	CLC
	LDA ColY3
	CMP ColY0
	BCS +
		LDA #$01
		STA value
		RTS
		+
	CLC
	LDA ColY1
	CMP ColY2
	BCS +
		LDA #$01
		STA value
		RTS
		+
	RTS
	
Function_LoadCollisionValuesLeftUp:
	CMP #$01
	BNE +
		LDY #$03 
		STY singleDirection
		LDY #$80
		STY doorsCheckFlag
		LDY #$7F
		STY doorsCheckFlagInvert
		+
	CMP #$02
	BNE +
		LDY #$02
		STY singleDirection		
		LDY #$40
		STY doorsCheckFlag
		LDY #$BF
		STY doorsCheckFlagInvert
		+
	CMP #$04
	BNE +
		LDY #$01 
		STY singleDirection
		LDY #$20
		STY doorsCheckFlag
		LDY #$DF
		STY doorsCheckFlagInvert
		+
	CMP #$08
	BNE +
		LDY #$00
		STY singleDirection
		LDY #$10
		STY doorsCheckFlag
		LDY #$EF
		STY doorsCheckFlagInvert
		+

	LDY spritesType, X	
	LDA SpriteBoundariesLow, Y
	STA pointerLow
	LDA SpriteBoundariesHi, Y
	STA pointerHi
	
	LDY #$00
	LDA spriteNewX
	CLC 
	ADC (pointerLow), Y
	STA ColX0
	INY
	LDA spriteOldX
	CLC 
	ADC (pointerLow), Y
	STA ColX1
	INY
	LDA spriteNewY
	CLC 
	ADC (pointerLow), Y
	STA ColY0	
	INY
	LDA spriteOldY
	CLC 
	ADC (pointerLow), Y
	STA ColY1
	RTS

Function_LoadCollisionValuesRightDown:
	CMP #$01
	BNE +
		LDY #$03 
		STY singleDirection
		LDY #$80
		STY doorsCheckFlag
		LDY #$7F
		STY doorsCheckFlagInvert
		+
	CMP #$02
	BNE +
		LDY #$02
		STY singleDirection		
		LDY #$40
		STY doorsCheckFlag
		LDY #$BF
		STY doorsCheckFlagInvert
		+
	CMP #$04
	BNE +
		LDY #$01 
		STY singleDirection
		LDY #$20
		STY doorsCheckFlag
		LDY #$DF
		STY doorsCheckFlagInvert
		+
	CMP #$08
	BNE +
		LDY #$00
		STY singleDirection
		LDY #$10
		STY doorsCheckFlag
		LDY #$EF
		STY doorsCheckFlagInvert
		+
	
	LDY spritesType, X	
	LDA SpriteBoundariesLow, Y
	STA pointerLow
	LDA SpriteBoundariesHi, Y
	STA pointerHi
	
	LDY #$00
	LDA spriteOldX
	CLC 
	ADC (pointerLow), Y
	STA ColX0
	INY
	LDA spriteNewX
	CLC 
	ADC (pointerLow), Y
	STA ColX1
	INY
	LDA spriteOldY
	CLC 
	ADC (pointerLow), Y
	STA ColY0	
	INY
	LDA spriteNewY
	CLC 
	ADC (pointerLow), Y
	STA ColY1
	RTS
	
Function_PlayerBulletCollision:
	LDA #$00
	STA value
	;destroy enemy
	STX pastIndex
	DEC spritesHealth, X
	LDA spritesHealth, X
	CMP #$00
	BNE +		
		LDA spritesType, X
		CMP #$0D ;level 1 boss
		BNE ++
			STX index
			CLC
			CPX currentIndex
			BCS +++
				DEC currentIndex
				DEC currentIndex
				DEC currentIndex
				+++
			DEC index
			JSR SpritesRemove	
			DEC index
			JSR SpritesRemove	
			DEC index
			JSR SpritesRemove	
			DEC pastIndex	
			DEC pastIndex	
			JMP +
			++
		STX index
		CLC
		CPX currentIndex
		BCS ++
			DEC currentIndex
			++
		JSR SpriteExplodeOnCollision
		;spawnpickup
		JSR SpawnRandomPickUp	
		JSR SpritesRemove									
		DEC pastIndex	
		+		
	;destroy bullet
	DEC bulletsNum							
	LDX currentIndex
	LDA spritesHealth, X
	CMP #$00
	BNE +					
		STX index
		JSR SpritesRemove	
		LDA #$01
		STA value
		+	
	LDX pastIndex
	RTS
	

Function_PlayerCollision:
	LDA #$00
	STA value
	STX pastIndex
	LDA spritesType, X
	CMP #$10 ;key
	BNE +
		LDY roomNumber
		LDA roomsAttributes, Y
		AND #%11011111
		STA roomsAttributes, Y
		INC keyNum
		JSR UpdatePlayerKeys
		LDX pastIndex
		STX index
		CLC
		CPX currentIndex
		BCS ++
			DEC currentIndex
			++
		JSR SpritesRemove	
		DEC pastIndex
		LDX pastIndex
		RTS
		+
	CMP #$03 ;hurt
	BNE +
		JSR IncreasePlayerHealth
		JSR UpdatePlayerHealth
		LDX pastIndex
		STX index
		CLC
		CPX currentIndex
		BCS ++
			DEC currentIndex
			++
		JSR SpritesRemove	
		DEC pastIndex
		LDX pastIndex
		RTS
		+
	CMP #$07 ;coin small
	BNE +
		LDA #$01
		STA onesAdd
		LDA #$00
		STA tensAdd
		STA hundredsAdd
		STA tousandsAdd
		JSR DecimalAdd
		JSR UpdatePlayerCoins
		LDX pastIndex
		STX index
		CLC
		CPX currentIndex
		BCS ++
			DEC currentIndex
			++
		JSR SpritesRemove	
		DEC pastIndex
		LDX pastIndex
		RTS
		+
	CMP #$0F ;trigun powerup
	BNE +
		LDA #$01 ;type trigun
		STA powerUpType
		LDA #$FF
		STA powerUpValue
		LDA #$00
		STA powerUpTimer
		STX index
		CLC
		CPX currentIndex
		BCS ++
			DEC currentIndex
			++
		JSR SpritesRemove	
		DEC pastIndex
		LDX pastIndex
		RTS
		+
	CMP #$0A ;enemy bullet
	BNE +
		DEC spritesHealth, X
		+
	CMP #$01 ;tripod
	BNE +
		DEC spritesHealth, X
		+
	;if tank no health decrease
	LDA spritesHealth, X
	CMP #$00
	BNE +								
		STX index
		CLC
		CPX currentIndex
		BCS ++
			DEC currentIndex
			++
		JSR SpriteExplodeOnCollision
		JSR SpritesRemove	
		DEC pastIndex
		+							
	LDA playerHitTimer ;look if invisible
	CMP #$00
	BNE +
		JSR DecreasePlayerHealth
		JSR UpdatePlayerHealth
		INC playerHitTimer
		LDA healthLow								
		CMP #$00
		BNE ++
			;destroy player sprite
			LDX currentIndex
			STX index
			JSR SpriteExplodeOnCollision
			JSR SpritesRemove									
			LDA #$01
			STA value
			RTS
			++
		+
	LDX pastIndex
	RTS
	
Function_InitWallCollisionBlocksUpDownVars:
	LDY roomNumber
	LDA Level1RoomsNameTablesLow, Y
	STA pointerLow
	LDA Level1RoomsNameTablesHi, Y
	STA pointerHi
	
	LDA ColX0
	LSR
	LSR
	LSR
	LSR
	STA ColX2
	
	LDA ColX1
	LSR
	LSR
	LSR
	LSR
	SEC
	SBC ColX2
	STA counter
	INC counter
	
	LDA singleDirection
	CMP #$00 ;up
	BNE +
		LDA ColY0
		AND #$F0
		ORA ColX2
		TAY
		+
	LDA singleDirection
	CMP #$01 ;down
	BNE +
		LDA ColY1
		AND #$F0
		ORA ColX2
		TAY
		+
	
	LDA #$00
	STA lengthLow
	
	RTS
	
Function_CheckWallCollisionBlocksUpDown	
	LDA (pointerLow), Y
	TAX
	LDA singleDirection
	CMP #$00 ;up
	BNE +
		LDA LEVEL_BLOCKS_UP_1, X
		JMP ++
		+
	CMP #$01 ;down
	BNE +
		LDA LEVEL_BLOCKS_DOWN_1, X
		+
	++
	CMP #$FF
	BNE + ;no collision
		INY
		LDA #$01
		STA value
		RTS
		+
	STA value
	AND #$0F
	STA ColX3
	
	LDA value
	LSR
	LSR
	LSR
	LSR
	STA ColX2
	
	TYA
	ASL
	ASL
	ASL
	ASL
	ORA ColX2
	STA ColX2
	AND #$F0
	ORA ColX3
	STA ColX3
	
	LDA singleDirection
	CMP #$00 ;up
	BNE +
		LDA LEVEL_BLOCKS_UP_2, X
		JMP ++
		+
	CMP #$01 ;down
	BNE +
		LDA LEVEL_BLOCKS_DOWN_2, X
		+
	++
	STA value
	AND #$0F
	STA ColWallType
		
	LDA value
	LSR
	LSR
	LSR
	LSR
	STA ColY2
	
	TYA
	AND #$F0
	ORA ColY2
	STA ColY2
	STA ColY3
	
	;check closed door
	LDA lengthLow
	CMP #$01
	BNE +
		LDA #$03
		STA ColWallType
		DEC lengthLow
		LDA ColY2
		LDX singleDirection
		CPX #$00
		BNE ++
			ORA #$07
			++
		CPX #$01
		BNE ++
			AND #$F0
			++		
		STA ColY2
		STA ColY3
		+
	LDA ColWallType
	CMP #$01 ;door
	BNE +
		INC lengthLow
		INC counter
		DEY
		+
	
	LDA #$00
	STA value
	
	INY
	
	CLC
	LDA ColX3
	CMP ColX0
	BCS +
		LDA #$01
		STA value
		RTS
		+
	CLC
	LDA ColX1
	CMP ColX2
	BCS +
		LDA #$01
		STA value
		RTS
		+
	CLC
	LDA ColY3
	CMP ColY0
	BCS +
		LDA #$01
		STA value
		RTS
		+
	CLC
	LDA ColY1
	CMP ColY2
	BCS +
		LDA #$01
		STA value
		RTS
		+
	RTS
	
Function_InitWallCollisionBlocksLeftRightVars:
	LDY roomNumber
	LDA Level1RoomsNameTablesLow, Y
	STA pointerLow
	LDA Level1RoomsNameTablesHi, Y
	STA pointerHi
	
	LDA ColY0
	AND #$F0
	STA ColY2
	
	LDA ColY1
	AND #$F0
	SEC
	SBC ColY2
	LSR
	LSR
	LSR
	LSR
	STA counter
	INC counter
	
	LDA singleDirection
	CMP #$02 ;left
	BNE +
		LDA ColX0
		LSR
		LSR
		LSR
		LSR
		ORA ColY2
		TAY
		+
	LDA singleDirection
	CMP #$03 ;right
	BNE +
		LDA ColX1
		LSR
		LSR
		LSR
		LSR
		ORA ColY2
		TAY
		+
	
	LDA #$00
	STA lengthLow
	
	RTS
	
Function_CheckWallCollisionBlocksLeftRight:
	LDA (pointerLow), Y
	TAX
	LDA singleDirection
	CMP #$02 ;left
	BNE +
		LDA LEVEL_BLOCKS_LEFT_1, X
		JMP ++
		+
	CMP #$03 ;right
	BNE +
		LDA LEVEL_BLOCKS_RIGHT_1, X
		+
	++
	CMP #$FF
	BNE + ;no collision
		TYA
		CLC
		ADC #$10
		TAY
		LDA #$01
		STA value
		RTS
		+
	STA value
	AND #$0F
	STA ColY2
	
	LDA value
	LSR
	LSR
	LSR
	LSR
	STA ColX2
	
	TYA
	ASL
	ASL
	ASL
	ASL
	ORA ColX2
	STA ColX2
	STA ColX3
	
	LDA singleDirection
	CMP #$02 ;left
	BNE +
		LDA LEVEL_BLOCKS_LEFT_2, X
		JMP ++
		+
	CMP #$03 ;right
	BNE +
		LDA LEVEL_BLOCKS_RIGHT_2, X
		+
	++
	STA value
	AND #$0F
	STA ColWallType
		
	LDA value
	LSR
	LSR
	LSR
	LSR
	STA ColY3
	
	TYA
	AND #$F0
	ORA ColY2
	STA ColY2
	AND #$F0
	ORA ColY3
	STA ColY3
	
	;check closed door
	LDA lengthLow
	CMP #$01
	BNE +
		LDA #$03
		STA ColWallType
		DEC lengthLow
		LDA ColX2
		LDX singleDirection
		CPX #$02
		BNE ++
			ORA #$0F
			++
		CPX #$03
		BNE ++
			AND #$F0
			++		
		STA ColX2
		STA ColX3
		+
	LDA ColWallType
	CMP #$01 ;door
	BNE +
		INC lengthLow
		INC counter
		TYA
		SEC
		SBC #$10
		TAY
		+
	
	LDA #$00
	STA value
	
	TYA
	CLC
	ADC #$10
	TAY
	
	CLC
	LDA ColX3
	CMP ColX0
	BCS +
		LDA #$01
		STA value
		RTS
		+
	CLC
	LDA ColX1
	CMP ColX2
	BCS +
		LDA #$01
		STA value
		RTS
		+
	CLC
	LDA ColY3
	CMP ColY0
	BCS +
		LDA #$01
		STA value
		RTS
		+
	CLC
	LDA ColY1
	CMP ColY2
	BCS +
		LDA #$01
		STA value
		RTS
		+
	RTS
	
Function_PlayerCollisionBlocksWall	
	LDA #$00
	STA value
	STY temp
	;check different type of walls
	LDA ColWallType			
	CMP #$01 ;wall = door warp
	BNE +
		LDA TRUE
		STA loadNewRoomTemp
		LDA singleDirection
		STA scrollDirection
		LDA FALSE
		STA spritesCleared
		LDX currentIndex
		LDA spritesX, X
		STA savedPlayerX
		LDA spritesY, X
		STA savedPlayerY
		LDA spritesStateAnim, X
		STA savedPlayerAnim
		LDA spritesStateAction, X
		STA savedPlayerAction
		+							
	LDA ColWallType			
	CMP #$03 ;wall = door
	BNE +
		LDY roomNumber
		LDA roomsAttributes, Y
		AND #%00010000 ;check if all spawn enemies defeated
		CMP #$00
		BEQ ++
			LDA doorsFlags
			AND doorsCheckFlag
			CMP #$00
			BEQ +++
				LDA keyNum
				CMP #$00
				BEQ ++++
					LDA #$00
					STA doorsTimer
					LDA doorsCheckFlag
					LSR
					LSR
					LSR
					LSR
					ORA doorsFlags
					AND doorsCheckFlagInvert
					STA doorsFlags
					DEC keyNum
					JSR UpdatePlayerKeys
					++++
				+++
			++
		LDA doorsFlags
		AND doorsCheckFlag
		CMP #$00
		BNE ++
			LDY temp
			RTS
			++
		+
	LDY singleDirection
	CLC
	CPY #$02
	BCS +
		LDA spriteOldY
		STA spriteNewY
		+
	CLC
	CPY #$02
	BCC +
		LDA spriteOldX
		STA spriteNewX
		+	
	LDY temp
	LDA #$00
	STA value
	RTS
	
Function_PlayerBulletCollisionWall:	
	LDA #$00
	STA value
	;check different type of walls
	LDA ColWallType				
	CMP #$02 ;wall = hole
	BNE +						
		RTS
		+
	LDA ColWallType				
	CMP #$03 ;wall = door
	BNE +	
		LDA doorsFlags
		AND doorsCheckFlag
		CMP #$00
		BNE ++
			RTS
			++
		+
	;COLLISION
	DEC bulletsNum					
	LDX currentIndex
															
	LDY singleDirection
	CPY #$00 ;up
	BNE +
		LDA ColY2
		SEC
		SBC #$05
		STA spritesY, X 
		+
	CPY #$01 ;down
	BNE +
		LDA ColY2
		SEC
		SBC #$05
		STA spritesY, X 
		+
	CPY #$02 ;left
	BNE +
		LDA ColX2
		SEC
		SBC #$04
		STA spritesX, X 
		+
	CPY #$03 ;right
	BNE +
		LDA ColX2
		SEC
		SBC #$05
		STA spritesX, X 
		+
		
	JSR SpriteBulletGhostOnCollision
	;remove sprite						
	STX index
	JSR SpritesRemove	
	LDA #$01
	STA value
	RTS
	
Function_EnemyBulletCollisionWall:
	LDA #$00
	STA value
	
	LDA ColWallType				
	CMP #$02 ;wall = hole
	BNE +						
		RTS
		+			
	;COLLISION				
	LDX currentIndex
																
	LDY singleDirection
	CPY #$00 ;up
	BNE +
		LDA ColY2
		SEC
		SBC #$08
		STA spritesY, X 
		+
	CPY #$01 ;down
	BNE +
		LDA ColY2
		SEC
		SBC #$08
		STA spritesY, X 
		+
	CPY #$02 ;left
	BNE +
		LDA ColX2
		SEC
		SBC #$08
		STA spritesX, X 
		+
	CPY #$03 ;right
	BNE +
		LDA ColX2
		SEC
		SBC #$08
		STA spritesX, X 
		+
										
	JSR SpriteExplodeOnCollision
	;remove sprite						
	STX index
	JSR SpritesRemove
	LDA #$01
	STA value
	RTS

Function_CheckCollisionEnemy:
	LDA #$00
	STA value
	LDA SpriteBoundariesLow, Y
	STA pointerLow
	LDA SpriteBoundariesHi, Y
	STA pointerHi
				
	LDY #$00
	LDA spritesX, X
	CLC 
	ADC (pointerLow), Y
	STA ColX2
	INY
	LDA spritesX, X
	CLC 
	ADC (pointerLow), Y
	STA ColX3
	INY
	LDA spritesY, X
	CLC 
	ADC (pointerLow), Y
	STA ColY2
	INY
	LDA spritesY, X
	CLC 
	ADC (pointerLow), Y
	STA ColY3
															
	LDY singleDirection
	CPY #$00 ;up
	BNE +
		LDA ColY3
		STA ColY2
		+
	CPY #$01 ;down
	BNE +
		LDA ColY2
		STA ColY3
		+
	CPY #$02 ;left
	BNE +
		LDA ColX3
		STA ColX2
		+
	CPY #$03 ;right
	BNE +
		LDA ColX2
		STA ColX3
		+
		
	CLC
	LDA ColX3
	CMP ColX0
	BCS +
		LDA #$01
		STA value
		RTS
		+
	CLC
	LDA ColX1
	CMP ColX2
	BCS +
		LDA #$01
		STA value
		RTS
		+
	CLC
	LDA ColY3
	CMP ColY0
	BCS +
		LDA #$01
		STA value
		RTS
		+
	CLC
	LDA ColY1
	CMP ColY2
	BCS +
		LDA #$01
		STA value
		RTS
		+
	RTS
	