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
	DB <(SpriteBoundariesBullet), $00, <(SpriteBoundariesEnemyBullet), $00, $00, $00, $00, <(SpriteBoundariesPickUp)
	DB <(SpriteBoundariesPickUp)
SpriteBoundariesHi:
	DB >(SpriteBoundariesPlayer1), >(SpriteBoundariesTripod), >(SpriteBoundariesTank), >(SpriteBoundariesPickUp), $00, $00, $00, >(SpriteBoundariesPickUp)
	DB >(SpriteBoundariesBullet), $00, >(SpriteBoundariesEnemyBullet), $00, $00, $00, $00, >(SpriteBoundariesPickUp)
	DB >(SpriteBoundariesPickUp)
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
SpriteColXSpriteFunctionPlayer1:
	LDA $1004
	LDA spriteDirection
	AND Left
	CMP Left
	BEQ +
		JMP ++++ ;movement to the right?
		+
		;left
		LDX #$00
			- ;left dir cycle
			LDA spritesType, X
			CMP #$01 ;tripod
			BEQ +
				CMP #$02 ;tank
				BEQ +
					CMP #$03 ;hurt
					BEQ +
						CMP #$07 ;coin small
						BEQ +
							CMP #$0F ;trigun powerup
							BEQ +
								CMP #$10 ;key
								BEQ +
									JMP ++
				+
				TAY
				LDA SpriteBoundariesLow, Y
				STA pointerLow
				LDA SpriteBoundariesHi, Y
				STA pointerHi
				;collision on x?
				LDA spriteNewX
				LDY #$00
				CLC 
				ADC SpriteBoundariesPlayer1, Y
				STA temp
				
				LDA spritesX, X
				LDY #$01
				CLC
				ADC (pointerLow), Y
				CMP temp
				BCS +
					JMP ++
					+
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesPlayer1, Y
					STA temp
				
					LDA spritesX, X
					LDY #$01
					CLC
					ADC (pointerLow), Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spritesY, X
						LDY #$03
						CLC
						ADC (pointerLow), Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesY, X
						LDY #$02
						CLC
						ADC (pointerLow), Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+							
							;JSR DecreasePlayerHealth
							;JSR SpriteExplodeOnCollision
							;remove old sprite
							;TXA
							;PHA
							;STX index
							;JSR SpritesRemove
							;PLA
							;TAX
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
								+
							CMP #$03 ;hurt
							BNE +
								JSR IncreasePlayerHealth
								JSR UpdatePlayerHealth
								LDX pastIndex
								STX index
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
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
								BNE ++++++
									;destroy player sprite
									LDX currentIndex
									STX index
									JSR SpriteExplodeOnCollision
									JSR SpritesRemove									
									LDX currentIndex
									;PLA ;pull last coordinate TODO remove push
									JMP SpritesUpdateCycleEndSkipINX
									++++++
								+
							LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		LDA spriteNewX
		STA playerX
		;---------------------------------collision to the level/room LEFT start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$02 ;LEFT
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
		
				;collision on x?
				LDA spriteNewX
				LDY #$00
				CLC 
				ADC SpriteBoundariesPlayer1, Y
				STA temp
				
				TXA
				TAY
				LDA (pointerLow), Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesPlayer1, Y
					STA temp
				
					TXA
					TAY
					LDA (pointerLow), Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							INX
							INX
							JMP ++
							+
							;COLLISION							
							INX							
							TXA		
							INX
							TAY
							LDA (pointerLow), Y				
							CMP #$01 ;wall = door warp
							BNE +
								LDA TRUE
								STA loadNewRoomTemp
								LDA #$02 ;left
								STA scrollDirection
								LDA FALSE
								STA spritesCleared
								LDX currentIndex
								LDA #$EC
								STA savedPlayerX
								LDA spritesY, X
								STA savedPlayerY
								LDA #$01
								STA savedPlayerAnim
								LDA #$03
								STA savedPlayerAction
								+							
							LDA (pointerLow), Y				
							CMP #$03 ;wall = door
							BNE +
								LDY roomNumber
								LDA roomsAttributes, Y
								AND #%00010000 ;check if all spawn enemies defeated
								CMP #$00
								BEQ +++++
									LDA doorsFlags
									AND #%01000000
									CMP #$00
									BEQ ++++++
										LDA keyNum
										CMP #$00
										BEQ +++++++
											LDA doorsFlags
											AND #%10111111
											ORA #%00000100
											STA doorsFlags
											DEC keyNum
											JSR UpdatePlayerKeys
											+++++++
										++++++
									+++++
								LDA doorsFlags
								AND #%01000000
								CMP #$00
								BNE +++++
									JMP +++
									+++++
								+
							LDA spriteOldX
							STA spriteNewX
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
	;---------------------------------collision to the level/room LEFT end
	++++ ;check movement to the right
	LDA spriteDirection
	AND Right
	CMP Right
	BEQ +
		JMP SpritesColXReturn ;no movement on x
		+
		;right
		LDX #$00
			- ;right dir cycle
			LDA spritesType, X
			CMP #$01 ;tripod
			BEQ +
				CMP #$02 ;tank
				BEQ +
					CMP #$03 ;hurt
					BEQ +
						CMP #$07 ;coin small
						BEQ +
							CMP #$0F ;trigun powerup
							BEQ +
								CMP #$10 ;key
								BEQ +
									JMP ++
				+
				TAY
				LDA SpriteBoundariesLow, Y
				STA pointerLow
				LDA SpriteBoundariesHi, Y
				STA pointerHi
				;collision on x?
				LDA spritesX, X
				LDY #$00
				CLC
				ADC (pointerLow), Y
				STA temp
								
				LDA spriteNewX
				LDY #$01
				CLC 
				ADC SpriteBoundariesPlayer1, Y
				CMP temp
				BCS +
					JMP ++
					+										
					LDA spritesX, X
					LDY #$00
					CLC
					ADC (pointerLow), Y
					STA temp
									
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesPlayer1, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spritesY, X
						LDY #$03
						CLC
						ADC (pointerLow), Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesY, X
						LDY #$02
						CLC
						ADC (pointerLow), Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
								+
							CMP #$03 ;hurt
							BNE +
								JSR IncreasePlayerHealth
								JSR UpdatePlayerHealth
								LDX pastIndex
								STX index
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
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
								BNE ++++++
									;destroy player sprite
									LDX currentIndex
									STX index
									JSR SpriteExplodeOnCollision
									JSR SpritesRemove									
									LDX currentIndex
									;PLA ;pull last coordinate TODO remove push
									JMP SpritesUpdateCycleEndSkipINX
									++++++
								+
							LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		LDA spriteNewX
		STA playerX
		;---------------------------------collision to the level/room RIGHT start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$03 ;RIGHT
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
				;collision on x?
				TXA
				TAY
				LDA (pointerLow), Y
				STA temp
								
				LDA spriteNewX
				LDY #$01
				CLC 
				ADC SpriteBoundariesPlayer1, Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+										
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
									
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesPlayer1, Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesPlayer1, Y
						STA temp
						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							INX
							INX
							JMP ++
							+
							;COLLISION														
							INX							
							TXA		
							INX
							TAY
							LDA (pointerLow), Y				
							CMP #$01 ;wall = door warp
							BNE +
								LDA TRUE
								STA loadNewRoomTemp
								LDA #$03 ;right
								STA scrollDirection
								LDA FALSE
								STA spritesCleared
								LDX currentIndex
								LDA #$03
								STA savedPlayerX
								LDA spritesY, X
								STA savedPlayerY
								LDA #$06
								STA savedPlayerAnim
								LDA #$04
								STA savedPlayerAction
								+
							LDA (pointerLow), Y				
							CMP #$03 ;wall = door
							BNE +
								LDY roomNumber
								LDA roomsAttributes, Y
								AND #%00010000 ;check if all spawn enemies defeated
								CMP #$00
								BEQ +++++
									LDA doorsFlags
									AND #%10000000
									CMP #$00
									BEQ ++++++
										LDA keyNum
										CMP #$00
										BEQ +++++++
											LDA doorsFlags
											AND #%01111111
											ORA #%00001000
											STA doorsFlags
											DEC keyNum
											JSR UpdatePlayerKeys
											+++++++
										++++++
									+++++
								LDA doorsFlags
								AND #%10000000
								CMP #$00
								BNE +++++
									JMP +++
									+++++
								+
							LDA spriteOldX
							STA spriteNewX
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
	;---------------------------------collision to the level/room RIGHT end
JMP SpritesColXReturn
						
SpriteColYSpriteFunctionPlayer1:
	LDA spriteDirection
	AND Up
	CMP Up
	BEQ +
		JMP ++++ ;movement to the down?
		+
		;up
		LDX #$00
			- ;up dir cycle
			LDA spritesType, X
			CMP #$01 ;tripod
			BEQ +
				CMP #$02 ;tank
				BEQ +
					CMP #$03 ;hurt
					BEQ +
						CMP #$07 ;coin small
						BEQ +
							CMP #$0F ;trigun powerup
							BEQ +
								CMP #$10 ;key
								BEQ +
									JMP ++
				+
				TAY
				LDA SpriteBoundariesLow, Y
				STA pointerLow
				LDA SpriteBoundariesHi, Y
				STA pointerHi
				;collision on y?
				LDA spriteNewY
				LDY #$02
				CLC 
				ADC SpriteBoundariesPlayer1, Y
				STA temp
				
				LDA spritesY, X
				LDY #$03
				CLC
				ADC (pointerLow), Y
				CMP temp
				BCS +
					JMP ++
					+
					LDA spriteOldY
					LDY #$03
					CLC 
					ADC SpriteBoundariesPlayer1, Y
					STA temp
				
					LDA spritesY, X
					LDY #$03
					CLC
					ADC (pointerLow), Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spritesX, X
						LDY #$01
						CLC
						ADC (pointerLow), Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesX, X
						LDY #$00
						CLC
						ADC (pointerLow), Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
								+
							CMP #$03 ;hurt
							BNE +
								JSR IncreasePlayerHealth
								JSR UpdatePlayerHealth
								LDX pastIndex
								STX index
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
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
								BNE ++++++
									;destroy player sprite
									LDX currentIndex
									STX index
									JSR SpriteExplodeOnCollision
									JSR SpritesRemove									
									LDX currentIndex
									;PLA ;pull last coordinate TODO remove push
									JMP SpritesUpdateCycleEndSkipINX
									++++++
								+
							LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		LDA spriteNewY
		STA playerY
		;---------------------------------collission to the level/room up
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$00 ;Up
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
			;collision on y?
			LDA spriteNewY
			LDY #$02
			CLC 
			ADC SpriteBoundariesPlayer1, Y
			STA temp
				
			TXA
			TAY
			LDA (pointerLow), Y
			CMP temp
			BCS +
				INX
				INX
				INX
				INX
				JMP ++
				+
				LDA spriteOldY
				LDY #$03
				CLC 
				ADC SpriteBoundariesPlayer1, Y
				STA temp
					
				TXA
				TAY
				LDA (pointerLow), Y
				CMP temp
				BCC +
					INX
					INX
					INX
					INX
					JMP ++
					+
					;on the same x position?
					;1
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesPlayer1, Y
					STA temp
						
					INX
					TXA
					TAY
					LDA (pointerLow), Y
					CMP temp
					BCS +
						INX
						INX
						INX
						JMP ++
						+
					;2
					INX
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
				
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesPlayer1, Y
					CMP temp
					BCS +
						INX
						INX
						JMP ++
						+
						;COLLISION					
							INX							
							TXA		
							INX
							TAY
							LDA (pointerLow), Y				
							CMP #$01 ;wall = door warp
							BNE +
								LDA TRUE
								STA loadNewRoomTemp
								LDA #$00 ;up
								STA scrollDirection
								LDA FALSE
								STA spritesCleared
								
								LDX currentIndex								
								LDA spritesX, X
								STA savedPlayerX
								LDA #$B0
								STA savedPlayerY
								
								LDA #$10
								STA savedPlayerAnim
								LDA #$01
								STA savedPlayerAction
								+
							LDA (pointerLow), Y				
							CMP #$03 ;wall = door
							BNE +
								LDY roomNumber
								LDA roomsAttributes, Y
								AND #%00010000 ;check if all spawn enemies defeated
								CMP #$00
								BEQ +++++
									LDA doorsFlags
									AND #%00010000
									CMP #$00
									BEQ ++++++
										LDA keyNum
										CMP #$00
										BEQ +++++++
											LDA doorsFlags
											AND #%11101111
											ORA #%00000001
											STA doorsFlags
											DEC keyNum
											JSR UpdatePlayerKeys
											+++++++
										++++++
									+++++
								LDA doorsFlags
								AND #%00010000
								CMP #$00
								BNE +++++
									JMP +++
									+++++
								+
							LDA spriteOldY
							STA spriteNewY
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++			
		;------------------------------------------------------------
	++++ ;check movement to the down
	LDA spriteDirection
	AND Down
	CMP Down
	BEQ +
		JMP SpritesColYReturn ;no movement on y
		+
		;down
		LDX #$00
			- ;down dir cycle
			LDA spritesType, X
			CMP #$01 ;tripod
			BEQ +
				CMP #$02 ;tank
				BEQ +
					CMP #$03 ;hurt
					BEQ +
						CMP #$07 ;coin small
						BEQ +
							CMP #$0F ;trigun powerup
							BEQ +
								CMP #$10 ;key
								BEQ +
									JMP ++
				+
				TAY
				LDA SpriteBoundariesLow, Y
				STA pointerLow
				LDA SpriteBoundariesHi, Y
				STA pointerHi
				;collision on y?
				LDA spritesY, X
				LDY #$02
				CLC
				ADC (pointerLow), Y
				STA temp
								
				LDA spriteNewY
				LDY #$03
				CLC 
				ADC SpriteBoundariesPlayer1, Y
				CMP temp
				BCS +
					JMP ++
					+										
					LDA spritesY, X
					LDY #$02
					CLC
					ADC (pointerLow), Y
					STA temp
									
					LDA spriteOldY
					LDY #$02
					CLC 
					ADC SpriteBoundariesPlayer1, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spritesX, X
						LDY #$01
						CLC
						ADC (pointerLow), Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesX, X
						LDY #$00
						CLC
						ADC (pointerLow), Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove
								DEC pastIndex
								LDX pastIndex
								JMP ++
								+
							CMP #$03 ;hurt
							BNE +
								JSR IncreasePlayerHealth
								JSR UpdatePlayerHealth
								LDX pastIndex
								STX index
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
								JSR SpritesRemove	
								DEC pastIndex
								LDX pastIndex
								JMP ++
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
								CPX currentIndex
								BPL ++++++
									DEC currentIndex
									++++++
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
								BNE ++++++
									;destroy player sprite
									LDX currentIndex
									STX index
									JSR SpriteExplodeOnCollision
									JSR SpritesRemove									
									LDX currentIndex
									;PLA ;pull last coordinate TODO remove push
									JMP SpritesUpdateCycleEndSkipINX
									++++++
								+
							LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		LDA spriteNewY
		STA playerY
		;---------------------------------collision to the level/room down start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$01 ;Down
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
		;collision on y?
				TXA
				TAY
				LDA (pointerLow), Y
				STA temp
								
				LDA spriteNewY
				LDY #$03
				CLC 
				ADC SpriteBoundariesPlayer1, Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+										
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
									
					LDA spriteOldY
					LDY #$02
					CLC 
					ADC SpriteBoundariesPlayer1, Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							INX
							INX
							JMP ++
							+
							;COLLISION													
							INX							
							TXA		
							INX
							TAY
							LDA (pointerLow), Y				
							CMP #$01 ;wall = door warp
							BNE +
								LDA TRUE
								STA loadNewRoomTemp
								LDA #$01 ;down
								STA scrollDirection
								LDA FALSE
								STA spritesCleared
								LDX currentIndex
								LDA spritesX, X
								STA savedPlayerX
								LDA #$20
								STA savedPlayerY
								LDA #$0B
								STA savedPlayerAnim
								LDA #$02
								STA savedPlayerAction
								+
							LDA (pointerLow), Y				
							CMP #$03 ;wall = door
							BNE +
								LDY roomNumber
								LDA roomsAttributes, Y
								AND #%00010000 ;check if all spawn enemies defeated
								CMP #$00
								BEQ +++++
									LDA doorsFlags
									AND #%00100000
									CMP #$00
									BEQ ++++++
										LDA keyNum
										CMP #$00
										BEQ +++++++
											LDA doorsFlags
											AND #%11011111
											ORA #%00000010
											STA doorsFlags
											DEC keyNum
											JSR UpdatePlayerKeys
											+++++++
										++++++
									+++++
								LDA doorsFlags
								AND #%00100000
								CMP #$00
								BNE +++++
									JMP +++
									+++++
								+
							LDA spriteOldY
							STA spriteNewY
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
		;---------------------------------collision to the level/room down end
JMP SpritesColYReturn

;Tripod collisions
SpriteColXSpriteFunctionTri:
	LDA spriteDirection
	AND Left
	CMP Left
	BEQ +
		JMP ++++ ;movement to the right?
		+
		;left
		LDX #$00
			- ;left dir cycle
			LDA spritesType, X
			CMP #$00 ;player
			BEQ +
			CMP #$01 ;tripod
			BEQ +
				JMP ++
				+
				;collision on x?
				LDA spriteNewX
				LDY #$00
				CLC 
				ADC SpriteBoundariesTripod, Y
				STA temp
				
				LDA spritesX, X
				LDY #$01
				CLC
				ADC SpriteBoundariesPlayer1, Y
				CMP temp
				BCS +
					JMP ++
					+
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesTripod, Y
					STA temp
				
					LDA spritesX, X
					LDY #$01
					CLC
					ADC SpriteBoundariesPlayer1, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesTripod, Y
						STA temp
				
						LDA spritesY, X
						LDY #$03
						CLC
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesY, X
						LDY #$02
						CLC
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesTripod, Y
						CMP temp
						BCS +
							JMP ++
							+							
						;collision
						;LDA spritesType, X
						;CMP #$00 ;player
						;BNE +
						;	;JSR DecreasePlayerHealth
						;	PLA
						;	STA temp					
						;	TXA
						;	PHA						
						;	LDX temp
						;	JSR SpriteExplodeOnCollision
						;	;remove sprite						
						;	STX index
						;	JSR SpritesRemove
						;	PLA
						;	TAX						
						;	LDX temp
						;	JMP SpritesUpdateCycleEndSkipINX
						;	+
						;CMP #$01 ;tripod
						;BNE +
						;	LDA spriteOldX
						;	STA spriteNewX		
						;	JMP SpritesColXReturn
						;	+
						STX pastIndex
						LDA spritesType, X
						CMP #$01 ;tripod
						BNE +
							LDA spriteOldX
							STA spriteNewX		
							JMP SpritesColXReturn
							+
						;else if hit player													
						LDA playerHitTimer ;look if invisible
						CMP #$00
						BNE +
							JSR DecreasePlayerHealth
							JSR UpdatePlayerHealth
							INC playerHitTimer
							LDA healthLow								
							CMP #$00
							BNE ++++++
								;destroy player sprite
								LDX pastIndex
								STX index
								CPX currentIndex
								BPL +++++++
									DEC currentIndex
									+++++++
								JSR SpriteExplodeOnCollision
								JSR SpritesRemove									
								DEC pastIndex									
								++++++
							+
						LDX currentIndex
						DEC spritesHealth, X
						LDA spritesHealth, X
						CMP #$00
						BNE +					
							STX index
							JSR SpriteExplodeOnCollision
							JSR SpritesRemove	
							LDX currentIndex
							;PLA ;pull last coordinate TODO remove push
							JMP SpritesUpdateCycleEndSkipINX
							+	
						LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
					;---------------------------------collision to the level/room LEFT start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$02 ;LEFT
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
		
				;collision on x?
				LDA spriteNewX
				LDY #$00
				CLC 
				ADC SpriteBoundariesTripodLevel, Y
				STA temp
				
				TXA
				TAY
				LDA (pointerLow), Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesTripodLevel, Y
					STA temp
				
					TXA
					TAY
					LDA (pointerLow), Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesTripodLevel, Y
						STA temp
				
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesTripodLevel, Y
						CMP temp
						BCS +
							INX
							INX
							JMP ++
							+
							INX
							INX
							;COLLISION
							LDA spriteOldX
							STA spriteNewX
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
	;---------------------------------collision to the level/room LEFT end
	++++ ;check movement to the right
	LDA spriteDirection
	AND Right
	CMP Right
	BEQ +
		JMP SpritesColXReturn ;no movement on x
		+
		;right
		LDX #$00
			- ;right dir cycle
			LDA spritesType, X
			CMP #$00 ;player
			BEQ +
			CMP #$01 ;tripod
			BEQ +
				JMP ++
				+		
				;collision on x?
				LDA spritesX, X
				LDY #$00
				CLC
				ADC SpriteBoundariesPlayer1, Y
				STA temp
								
				LDA spriteNewX
				LDY #$01
				CLC 
				ADC SpriteBoundariesTripod, Y
				CMP temp
				BCS +
					JMP ++
					+										
					LDA spritesX, X
					LDY #$00
					CLC
					ADC SpriteBoundariesPlayer1, Y
					STA temp
									
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesTripod, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesTripod, Y
						STA temp
				
						LDA spritesY, X
						LDY #$03
						CLC
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesY, X
						LDY #$02
						CLC
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesTripod, Y
						CMP temp
						BCS +
							JMP ++
							+
						;collision
						STX pastIndex
						LDA spritesType, X
						CMP #$01 ;tripod
						BNE +
							LDA spriteOldX
							STA spriteNewX		
							JMP SpritesColXReturn
							+
						;else if hit player													
						LDA playerHitTimer ;look if invisible
						CMP #$00
						BNE +
							JSR DecreasePlayerHealth
							JSR UpdatePlayerHealth
							INC playerHitTimer
							LDA healthLow								
							CMP #$00
							BNE ++++++
								;destroy player sprite
								LDX pastIndex
								STX index
								CPX currentIndex
								BPL +++++++
									DEC currentIndex
									+++++++
								JSR SpriteExplodeOnCollision
								JSR SpritesRemove									
								DEC pastIndex									
								++++++
							+
						LDX currentIndex
						DEC spritesHealth, X
						LDA spritesHealth, X
						CMP #$00
						BNE +					
							STX index
							JSR SpriteExplodeOnCollision
							JSR SpritesRemove	
							LDX currentIndex
							;PLA ;pull last coordinate TODO remove push
							JMP SpritesUpdateCycleEndSkipINX
							+	
						LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
			;---------------------------------collision to the level/room RIGHT start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$03 ;RIGHT
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
				;collision on x?
				TXA
				TAY
				LDA (pointerLow), Y
				STA temp
								
				LDA spriteNewX
				LDY #$01
				CLC 
				ADC SpriteBoundariesTripodLevel, Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+										
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
									
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesTripodLevel, Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesTripodLevel, Y
						STA temp
						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesTripodLevel, Y
						CMP temp
						BCS +
							INX
							INX
							JMP ++
							+
							INX
							INX
							;COLLISION
							LDA spriteOldX
							STA spriteNewX
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
	;---------------------------------collision to the level/room RIGHT end
JMP SpritesColXReturn
						
SpriteColYSpriteFunctionTri:
	LDA spriteDirection
	AND Up
	CMP Up
	BEQ +
		JMP ++++ ;movement to the right?
		+
		;up
		LDX #$00
			- ;up dir cycle
			LDA spritesType, X
			CMP #$00 ;player
			BEQ +
			CMP #$01 ;tripod
			BEQ +
				JMP ++
				+
				;collision on y?
				LDA spriteNewY
				LDY #$02
				CLC 
				ADC SpriteBoundariesTripod, Y
				STA temp
				
				LDA spritesY, X
				LDY #$03
				CLC
				ADC SpriteBoundariesPlayer1, Y
				CMP temp
				BCS +
					JMP ++
					+
					LDA spriteOldY
					LDY #$03
					CLC 
					ADC SpriteBoundariesTripod, Y
					STA temp
				
					LDA spritesY, X
					LDY #$03
					CLC
					ADC SpriteBoundariesPlayer1, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesTripod, Y
						STA temp
				
						LDA spritesX, X
						LDY #$01
						CLC
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesX, X
						LDY #$00
						CLC
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesTripod, Y
						CMP temp
						BCS +
							JMP ++
							+
						;collision
						STX pastIndex
						LDA spritesType, X
						CMP #$01 ;tripod
						BNE +
							LDA spriteOldX
							STA spriteNewX		
							JMP SpritesColYReturn
							+
						;else if hit player													
						LDA playerHitTimer ;look if invisible
						CMP #$00
						BNE +
							JSR DecreasePlayerHealth
							JSR UpdatePlayerHealth
							INC playerHitTimer
							LDA healthLow								
							CMP #$00
							BNE ++++++
								;destroy player sprite
								LDX pastIndex
								STX index
								CPX currentIndex
								BPL +++++++
									DEC currentIndex
									+++++++
								JSR SpriteExplodeOnCollision
								JSR SpritesRemove									
								DEC pastIndex									
								++++++
							+
						LDX currentIndex
						DEC spritesHealth, X
						LDA spritesHealth, X
						CMP #$00
						BNE +					
							STX index
							JSR SpriteExplodeOnCollision
							JSR SpritesRemove	
							LDX currentIndex
							;PLA ;pull last coordinate TODO remove push
							JMP SpritesUpdateCycleEndSkipINX
							+	
						LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
			;---------------------------------collission to the level/room up
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$00 ;Up
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
			;collision on y?
			LDA spriteNewY
			LDY #$02
			CLC 
			ADC SpriteBoundariesTripodLevel, Y
			STA temp
				
			TXA
			TAY
			LDA (pointerLow), Y
			CMP temp
			BCS +
				INX
				INX
				INX
				INX
				JMP ++
				+
				LDA spriteOldY
				LDY #$03
				CLC 
				ADC SpriteBoundariesTripodLevel, Y
				STA temp
					
				TXA
				TAY
				LDA (pointerLow), Y
				CMP temp
				BCC +
					INX
					INX
					INX
					INX
					JMP ++
					+
					;on the same x position?
					;1
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesTripodLevel, Y
					STA temp
						
					INX
					TXA
					TAY
					LDA (pointerLow), Y
					CMP temp
					BCS +
						INX
						INX
						INX
						JMP ++
						+
					;2
					INX
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
				
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesTripodLevel, Y
					CMP temp
					BCS +
						INX
						INX
						JMP ++
						+
						INX
						INX
						;COLLISION
						LDA spriteOldY
						STA spriteNewY
						JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++			
		;------------------------------------------------------------
	++++ ;check movement to the down
	LDA spriteDirection
	AND Down
	CMP Down
	BEQ +
		JMP SpritesColYReturn ;no movement on y
		+
		;down
		LDX #$00
			- ;down dir cycle
			LDA spritesType, X
			CMP #$00 ;player
			BEQ +
			CMP #$01 ;tripod
			BEQ +
				JMP ++
				+		
				;collision on y?
				LDA spritesY, X
				LDY #$02
				CLC
				ADC SpriteBoundariesPlayer1, Y
				STA temp
								
				LDA spriteNewY
				LDY #$03
				CLC 
				ADC SpriteBoundariesTripod, Y
				CMP temp
				BCS +
					JMP ++
					+										
					LDA spritesY, X
					LDY #$02
					CLC
					ADC SpriteBoundariesPlayer1, Y
					STA temp
									
					LDA spriteOldY
					LDY #$02
					CLC 
					ADC SpriteBoundariesTripod, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesTripod, Y
						STA temp
				
						LDA spritesX, X
						LDY #$01
						CLC
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesX, X
						LDY #$00
						CLC
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesTripod, Y
						CMP temp
						BCS +
							JMP ++
							+
						;collision
						STX pastIndex
						LDA spritesType, X
						CMP #$01 ;tripod
						BNE +
							LDA spriteOldX
							STA spriteNewX		
							JMP SpritesColYReturn
							+
						;else if hit player													
						LDA playerHitTimer ;look if invisible
						CMP #$00
						BNE +
							JSR DecreasePlayerHealth
							JSR UpdatePlayerHealth
							INC playerHitTimer
							LDA healthLow								
							CMP #$00
							BNE ++++++
								;destroy player sprite
								LDX pastIndex
								STX index
								CPX currentIndex
								BPL +++++++
									DEC currentIndex
									+++++++
								JSR SpriteExplodeOnCollision
								JSR SpritesRemove									
								DEC pastIndex									
								++++++
							+
						LDX currentIndex
						DEC spritesHealth, X
						LDA spritesHealth, X
						CMP #$00
						BNE +					
							STX index
							JSR SpriteExplodeOnCollision
							JSR SpritesRemove	
							LDX currentIndex
							;PLA ;pull last coordinate TODO remove push
							JMP SpritesUpdateCycleEndSkipINX
							+	
						LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
			;---------------------------------collision to the level/room down start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$01 ;Down
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
		;collision on y?
				TXA
				TAY
				LDA (pointerLow), Y
				STA temp
								
				LDA spriteNewY
				LDY #$03
				CLC 
				ADC SpriteBoundariesTripodLevel, Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+										
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
									
					LDA spriteOldY
					LDY #$02
					CLC 
					ADC SpriteBoundariesTripodLevel, Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesTripodLevel, Y
						STA temp
				
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesTripodLevel, Y
						CMP temp
						BCS +
							INX
							INX
							JMP ++
							+
							INX
							INX
							;COLLISION
							LDA spriteOldY
							STA spriteNewY
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
		;---------------------------------collision to the level/room down end
JMP SpritesColYReturn

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;player bullet collision
BulletsColXSpriteFunctionPlayer1:
	LDA spriteDirection
	AND Left
	CMP Left
	BEQ +
		JMP ++++ ;movement to the right?
		+
		;left
		LDX #$00
			- ;left dir cycle
			LDA spritesType, X	
			CMP #$01 ;tripod
			BEQ +
				CMP #$02 ;tank
			BEQ +
				JMP ++
				+
				;collision on x?
				LDA spriteNewX
				LDY #$00
				CLC 
				ADC SpriteBoundariesBullet, Y
				STA temp
				
				LDA spritesX, X
				LDY #$01
				CLC
				ADC SpriteBoundariesTripod, Y
				CMP temp
				BCS +
					JMP ++
					+
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesBullet, Y
					STA temp
				
					LDA spritesX, X
					LDY #$01
					CLC
					ADC SpriteBoundariesTripod, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesBullet, Y
						STA temp
				
						LDA spritesY, X
						LDY #$03
						CLC
						ADC SpriteBoundariesTripod, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesY, X
						LDY #$02
						CLC
						ADC SpriteBoundariesTripod, Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesBullet, Y
						CMP temp
						BCS +
							JMP ++
							+
							;JSR SpriteExplodeOnCollision
							;remove old sprite
							;TXA
							;PHA
							;STX index
							;JSR SpritesRemove
							;PLA
							;TAX
							
							;DEC bulletsNum
							
							;PLA
							;STA temp					
							;LDX temp
							;CPX index
							;BMI +
							;	DEX
							;	+
							;STX index
							;JSR SpritesRemove
							;JMP SpritesUpdateCycleEndSkipINX
							;JMP +++
							;destroy enemy
							STX pastIndex
							DEC spritesHealth, X
							LDA spritesHealth, X
							CMP #$00
							BNE +					
								STX index
								CPX currentIndex
								BPL +++++++
									DEC currentIndex
									+++++++
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
								LDX currentIndex
								;PLA ;pull last coordinate TODO remove push
								JMP SpritesUpdateCycleEndSkipINX
								+	
							LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		;---------------------------------collision to the level/room LEFT start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$02 ;LEFT
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
		
				;collision on x?
				LDA spriteNewX
				LDY #$00
				CLC 
				ADC SpriteBoundariesBullet, Y
				STA temp
				
				TXA
				TAY
				LDA (pointerLow), Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesBullet, Y
					STA temp
				
					TXA
					TAY
					LDA (pointerLow), Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesBullet, Y
						STA temp
				
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesBullet, Y
						CMP temp
						BCS +
								INX
							INX
							JMP ++
							+
							INX							
							TXA		
							INX
							TAY
							LDA (pointerLow), Y				
							CMP #$02 ;wall = hole
							BNE +						
								JMP +++
								+	
							LDA (pointerLow), Y				
							CMP #$03 ;wall = door
							BNE +
								LDA doorsFlags
								AND #%01000000
								CMP #$00
								BNE +++++
									JMP +++
									+++++
								+
							;COLLISION
								DEC bulletsNum					
								LDX currentIndex
																
								DEY
								DEY
								DEY
								LDA (pointerLow), Y	
								CLC					
								SBC #$03								
								STA spritesX, X 
								
								JSR SpriteBulletGhostOnCollision
								;remove sprite						
								STX index
								JSR SpritesRemove
								;PLA	;pull last coordinate TODO remove push		
								LDX currentIndex
								JMP SpritesUpdateCycleEndSkipINX
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
	;---------------------------------collision to the level/room LEFT end
	++++ ;check movement to the right
	LDA spriteDirection
	AND Right
	CMP Right
	BEQ +
		JMP SpritesColXReturn ;no movement on x
		+
		;right
		LDX #$00
			- ;right dir cycle
			LDA spritesType, X	
			CMP #$01 ;tripod
			BEQ +
				CMP #$02 ;tank
			BEQ +
				JMP ++
				+	
				;collision on x?
				LDA spritesX, X
				LDY #$00
				CLC
				ADC SpriteBoundariesTripod, Y
				STA temp
								
				LDA spriteNewX
				LDY #$01
				CLC 
				ADC SpriteBoundariesBullet, Y
				CMP temp
				BCS +
					JMP ++
					+										
					LDA spritesX, X
					LDY #$00
					CLC
					ADC SpriteBoundariesTripod, Y
					STA temp
									
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesBullet, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesBullet, Y
						STA temp
				
						LDA spritesY, X
						LDY #$03
						CLC
						ADC SpriteBoundariesTripod, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesY, X
						LDY #$02
						CLC
						ADC SpriteBoundariesTripod, Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesBullet, Y
						CMP temp
						BCS +
							JMP ++
							+
							;destroy enemy
							STX pastIndex
							DEC spritesHealth, X
							LDA spritesHealth, X
							CMP #$00
							BNE +					
								STX index
								CPX currentIndex
								BPL +++++++
									DEC currentIndex
									+++++++
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
								LDX currentIndex
								;PLA ;pull last coordinate TODO remove push
								JMP SpritesUpdateCycleEndSkipINX
								+	
							LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		;---------------------------------collision to the level/room RIGHT start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$03 ;RIGHT
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
				;collision on x?
				TXA
				TAY
				LDA (pointerLow), Y
				STA temp
								
				LDA spriteNewX
				LDY #$01
				CLC 
				ADC SpriteBoundariesBullet, Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+										
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
									
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesBullet, Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesBullet, Y
						STA temp
						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesBullet, Y
						CMP temp
						BCS +
							INX
							INX
							JMP ++
							+
							INX							
							TXA		
							INX
							TAY
							LDA (pointerLow), Y				
							CMP #$02 ;wall = hole
							BNE +						
								JMP +++
								+	
							LDA (pointerLow), Y				
							CMP #$03 ;wall = door
							BNE +
								LDA doorsFlags
								AND #%10000000
								CMP #$00
								BNE +++++
									JMP +++
									+++++
								+
							;COLLISION
								DEC bulletsNum					
								LDX currentIndex
																
								DEY
								DEY
								DEY
								LDA (pointerLow), Y	
								CLC					
								SBC #$03								
								STA spritesX, X 
								
								JSR SpriteBulletGhostOnCollision
								;remove sprite						
								STX index
								JSR SpritesRemove
								;PLA	;pull last coordinate TODO remove push		
								LDX currentIndex
								JMP SpritesUpdateCycleEndSkipINX
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
	;---------------------------------collision to the level/room RIGHT end
JMP SpritesColXReturn
						
BulletsColYSpriteFunctionPlayer1:
	LDA spriteDirection
	AND Up
	CMP Up
	BEQ +
		JMP ++++ ;movement to the down?
		+
		;up
		LDX #$00
			- ;up dir cycle
			LDA spritesType, X	
			CMP #$01 ;tripod
			BEQ +
				CMP #$02 ;tank
			BEQ +
				JMP ++
				+
				;collision on y?
				LDA spriteNewY
				LDY #$02
				CLC 
				ADC SpriteBoundariesBullet, Y
				STA temp
				
				LDA spritesY, X
				LDY #$03
				CLC
				ADC SpriteBoundariesTripod, Y
				CMP temp
				BCS +
					JMP ++
					+
					LDA spriteOldY
					LDY #$03
					CLC 
					ADC SpriteBoundariesBullet, Y
					STA temp
				
					LDA spritesY, X
					LDY #$03
					CLC
					ADC SpriteBoundariesTripod, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesBullet, Y
						STA temp
				
						LDA spritesX, X
						LDY #$01
						CLC
						ADC SpriteBoundariesTripod, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesX, X
						LDY #$00
						CLC
						ADC SpriteBoundariesTripod, Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesBullet, Y
						CMP temp
						BCS +
							JMP ++
							+
							;destroy enemy
							STX pastIndex
							DEC spritesHealth, X
							LDA spritesHealth, X
							CMP #$00
							BNE +					
								STX index
								CPX currentIndex
								BPL +++++++
									DEC currentIndex
									+++++++
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
								LDX currentIndex
								;PLA ;pull last coordinate TODO remove push
								JMP SpritesUpdateCycleEndSkipINX
								+	
							LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		;---------------------------------collission to the level/room up
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$00 ;Up
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
			;collision on y?
			LDA spriteNewY
			LDY #$02
			CLC 
			ADC SpriteBoundariesBullet, Y
			STA temp
				
			TXA
			TAY
			LDA (pointerLow), Y
			CMP temp
			BCS +
				INX
				INX
				INX
				INX
				JMP ++
				+
				LDA spriteOldY
				LDY #$03
				CLC 
				ADC SpriteBoundariesBullet, Y
				STA temp
					
				TXA
				TAY
				LDA (pointerLow), Y
				CMP temp
				BCC +
					INX
					INX
					INX
					INX
					JMP ++
					+
					;on the same x position?
					;1
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesBullet, Y
					STA temp
						
					INX
					TXA
					TAY
					LDA (pointerLow), Y
					CMP temp
					BCS +
						INX
						INX
						INX
						JMP ++
						+
					;2
					INX
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
				
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesBullet, Y
					CMP temp
					BCS +
						INX
						INX
						JMP ++
						+
						INX							
						TXA		
						INX
						TAY
						LDA (pointerLow), Y				
						CMP #$02 ;wall = hole
						BNE +						
							JMP +++
							+	
						LDA (pointerLow), Y				
						CMP #$03 ;wall = door
						BNE +
							LDA doorsFlags
							AND #%00010000
							CMP #$00
							BNE +++++
								JMP +++
								+++++
							+
						;COLLISION
							DEC bulletsNum					
							LDX currentIndex
																
							DEY
							DEY
							DEY
							LDA (pointerLow), Y	
							CLC					
							SBC #$04								
							STA spritesY, X 
								
							JSR SpriteBulletGhostOnCollision
							;remove sprite						
							STX index
							JSR SpritesRemove
							;PLA	;pull last coordinate TODO remove push		
							LDX currentIndex
							JMP SpritesUpdateCycleEndSkipINX
						JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++			
		;------------------------------------------------------------
	++++ ;check movement to the down
	LDA spriteDirection
	AND Down
	CMP Down
	BEQ +
		JMP SpritesColYReturn ;no movement on y
		+
		;down
		LDX #$00
			- ;down dir cycle
			LDA spritesType, X	
			CMP #$01 ;tripod
			BEQ +
				CMP #$02 ;tank
			BEQ +
				JMP ++
				+
				;collision on y?
				LDA spritesY, X
				LDY #$02
				CLC
				ADC SpriteBoundariesTripod, Y
				STA temp
								
				LDA spriteNewY
				LDY #$03
				CLC 
				ADC SpriteBoundariesBullet, Y
				CMP temp
				BCS +
					JMP ++
					+										
					LDA spritesY, X
					LDY #$02
					CLC
					ADC SpriteBoundariesTripod, Y
					STA temp
									
					LDA spriteOldY
					LDY #$02
					CLC 
					ADC SpriteBoundariesBullet, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesBullet, Y
						STA temp
				
						LDA spritesX, X
						LDY #$01
						CLC
						ADC SpriteBoundariesTripod, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesX, X
						LDY #$00
						CLC
						ADC SpriteBoundariesTripod, Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesBullet, Y
						CMP temp
						BCS +
							JMP ++
							+												
							;destroy enemy
							STX pastIndex
							DEC spritesHealth, X
							LDA spritesHealth, X
							CMP #$00
							BNE +					
								STX index
								CPX currentIndex
								BPL +++++++
									DEC currentIndex
									+++++++
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
								LDX currentIndex
								;PLA ;pull last coordinate TODO remove push
								JMP SpritesUpdateCycleEndSkipINX
								+	
							LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		;---------------------------------collision to the level/room down start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$01 ;Down
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
		;collision on y?
				TXA
				TAY
				LDA (pointerLow), Y
				STA temp
								
				LDA spriteNewY
				LDY #$03
				CLC 
				ADC SpriteBoundariesBullet, Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+										
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
									
					LDA spriteOldY
					LDY #$02
					CLC 
					ADC SpriteBoundariesBullet, Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesBullet, Y
						STA temp
				
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesBullet, Y
						CMP temp
						BCS +
							INX
							INX
							JMP ++
							+
							INX							
							TXA		
							INX
							TAY
							LDA (pointerLow), Y				
							CMP #$02 ;wall = hole
							BNE +						
								JMP +++
								+	
							LDA (pointerLow), Y				
							CMP #$03 ;wall = door
							BNE +
								LDA doorsFlags
								AND #%00100000
								CMP #$00
								BNE +++++
									JMP +++
									+++++
								+
								;COLLISION
								DEC bulletsNum					
								LDX currentIndex
																
								DEY
								DEY
								DEY
								LDA (pointerLow), Y	
								CLC					
								SBC #$04								
								STA spritesY, X 
								
								JSR SpriteBulletGhostOnCollision
								;remove sprite						
								STX index
								JSR SpritesRemove
								;PLA	;pull last coordinate TODO remove push		
								LDX currentIndex
								JMP SpritesUpdateCycleEndSkipINX
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
		;---------------------------------collision to the level/room down end
JMP SpritesColYReturn

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Tank collisions
SpriteColXSpriteFunctionTank:
	LDA spriteDirection
	AND Left
	CMP Left
	BEQ +
		JMP ++++ ;movement to the right?
		+
		;left
		LDX #$00
			- ;left dir cycle
			LDA spritesType, X
			CMP #$00 ;player
			BEQ +
			CMP #$02 ;tank
			BEQ +
				JMP ++
				+
				;collision on x?
				LDA spriteNewX
				LDY #$00
				CLC 
				ADC SpriteBoundariesTank, Y
				STA temp
				
				LDA spritesX, X
				LDY #$01
				CLC
				ADC SpriteBoundariesPlayer1, Y
				CMP temp
				BCS +
					JMP ++
					+
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesTank, Y
					STA temp
				
					LDA spritesX, X
					LDY #$01
					CLC
					ADC SpriteBoundariesPlayer1, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesTank, Y
						STA temp
				
						LDA spritesY, X
						LDY #$03
						CLC
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesY, X
						LDY #$02
						CLC
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesTank, Y
						CMP temp
						BCS +
							JMP ++
							+							
						;collision
						;LDA spritesType, X
						;CMP #$00 ;player
						;BNE +
						;	;JSR DecreasePlayerHealth
						;	PLA
						;	STA temp					
						;	TXA
						;	PHA						
						;	LDX temp
						;	JSR SpriteExplodeOnCollision
						;	;remove sprite						
						;	STX index
						;	JSR SpritesRemove
						;	PLA
						;	TAX						
						;	LDX temp
						;	JMP SpritesUpdateCycleEndSkipINX
						;	+
						;CMP #$02 ;tank
						;BNE +
						;	LDA spriteOldX
						;	STA spriteNewX		
						;	JMP SpritesColXReturn
						;	+
						STX pastIndex
						LDA spritesType, X
						CMP #$02 ;tank
						BNE +
							LDA spriteOldX
							STA spriteNewX		
							JMP SpritesColXReturn
							+
						;else if hit player													
						LDA playerHitTimer ;look if invisible
						CMP #$00
						BNE +
							JSR DecreasePlayerHealth
							JSR UpdatePlayerHealth
							INC playerHitTimer
							LDA healthLow								
							CMP #$00
							BNE ++++++
								;destroy player sprite
								LDX pastIndex
								STX index
								CPX currentIndex
								BPL +++++++
									DEC currentIndex
									+++++++
								JSR SpriteExplodeOnCollision
								JSR SpritesRemove									
								DEC pastIndex									
								++++++
							+
						LDX currentIndex
						LDA spritesHealth, X
						CMP #$00
						BNE +					
							STX index
							JSR SpriteExplodeOnCollision
							JSR SpritesRemove	
							LDX currentIndex
							;PLA ;pull last coordinate TODO remove push
							JMP SpritesUpdateCycleEndSkipINX
							+	
						LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
					;---------------------------------collision to the level/room LEFT start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$02 ;LEFT
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
		
				;collision on x?
				LDA spriteNewX
				LDY #$00
				CLC 
				ADC SpriteBoundariesTankLevel, Y
				STA temp
				
				TXA
				TAY
				LDA (pointerLow), Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesTankLevel, Y
					STA temp
				
					TXA
					TAY
					LDA (pointerLow), Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesTankLevel, Y
						STA temp
				
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesTankLevel, Y
						CMP temp
						BCS +
							INX
							INX
							JMP ++
							+
							INX
							INX
							;COLLISION
							LDA spriteOldX
							STA spriteNewX				
							LDX currentIndex
							JSR SpriteMoveFunctioneTankRandomDir
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
	;---------------------------------collision to the level/room LEFT end
	++++ ;check movement to the right
	LDA spriteDirection
	AND Right
	CMP Right
	BEQ +
		JMP SpritesColXReturn ;no movement on x
		+
		;right
		LDX #$00
			- ;right dir cycle
			LDA spritesType, X
			CMP #$00 ;player
			BEQ +
			CMP #$02 ;tank
			BEQ +
				JMP ++
				+		
				;collision on x?
				LDA spritesX, X
				LDY #$00
				CLC
				ADC SpriteBoundariesPlayer1, Y
				STA temp
								
				LDA spriteNewX
				LDY #$01
				CLC 
				ADC SpriteBoundariesTank, Y
				CMP temp
				BCS +
					JMP ++
					+										
					LDA spritesX, X
					LDY #$00
					CLC
					ADC SpriteBoundariesPlayer1, Y
					STA temp
									
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesTank, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesTank, Y
						STA temp
				
						LDA spritesY, X
						LDY #$03
						CLC
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesY, X
						LDY #$02
						CLC
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesTank, Y
						CMP temp
						BCS +
							JMP ++
							+
						;collision
						STX pastIndex
						LDA spritesType, X
						CMP #$02 ;tank
						BNE +
							LDA spriteOldX
							STA spriteNewX		
							JMP SpritesColXReturn
							+
						;else if hit player													
						LDA playerHitTimer ;look if invisible
						CMP #$00
						BNE +
							JSR DecreasePlayerHealth
							JSR UpdatePlayerHealth
							INC playerHitTimer
							LDA healthLow								
							CMP #$00
							BNE ++++++
								;destroy player sprite
								LDX pastIndex
								STX index
								CPX currentIndex
								BPL +++++++
									DEC currentIndex
									+++++++
								JSR SpriteExplodeOnCollision
								JSR SpritesRemove									
								DEC pastIndex									
								++++++
							+
						LDX currentIndex
						LDA spritesHealth, X
						CMP #$00
						BNE +					
							STX index
							JSR SpriteExplodeOnCollision
							JSR SpritesRemove	
							LDX currentIndex
							;PLA ;pull last coordinate TODO remove push
							JMP SpritesUpdateCycleEndSkipINX
							+	
						LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
			;---------------------------------collision to the level/room RIGHT start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$03 ;RIGHT
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
				;collision on x?
				TXA
				TAY
				LDA (pointerLow), Y
				STA temp
								
				LDA spriteNewX
				LDY #$01
				CLC 
				ADC SpriteBoundariesTankLevel, Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+										
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
									
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesTankLevel, Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesTankLevel, Y
						STA temp
						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesTankLevel, Y
						CMP temp
						BCS +
							INX
							INX
							JMP ++
							+
							INX
							INX
							;COLLISION
							LDA spriteOldX
							STA spriteNewX				
							LDX currentIndex
							JSR SpriteMoveFunctioneTankRandomDir
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
	;---------------------------------collision to the level/room RIGHT end
JMP SpritesColXReturn
						
SpriteColYSpriteFunctionTank:
	LDA spriteDirection
	AND Up
	CMP Up
	BEQ +
		JMP ++++ ;movement to the right?
		+
		;up
		LDX #$00
			- ;up dir cycle
			LDA spritesType, X
			CMP #$00 ;player
			BEQ +
			CMP #$02 ;tank
			BEQ +
				JMP ++
				+
				;collision on y?
				LDA spriteNewY
				LDY #$02
				CLC 
				ADC SpriteBoundariesTank, Y
				STA temp
				
				LDA spritesY, X
				LDY #$03
				CLC
				ADC SpriteBoundariesPlayer1, Y
				CMP temp
				BCS +
					JMP ++
					+
					LDA spriteOldY
					LDY #$03
					CLC 
					ADC SpriteBoundariesTank, Y
					STA temp
				
					LDA spritesY, X
					LDY #$03
					CLC
					ADC SpriteBoundariesPlayer1, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesTank, Y
						STA temp
				
						LDA spritesX, X
						LDY #$01
						CLC
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesX, X
						LDY #$00
						CLC
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesTank, Y
						CMP temp
						BCS +
							JMP ++
							+
						;collision
						STX pastIndex
						LDA spritesType, X
						CMP #$02 ;tank
						BNE +
							LDA spriteOldX
							STA spriteNewX		
							JMP SpritesColYReturn
							+
						;else if hit player													
						LDA playerHitTimer ;look if invisible
						CMP #$00
						BNE +
							JSR DecreasePlayerHealth
							JSR UpdatePlayerHealth
							INC playerHitTimer
							LDA healthLow								
							CMP #$00
							BNE ++++++
								;destroy player sprite
								LDX pastIndex
								STX index
								CPX currentIndex
								BPL +++++++
									DEC currentIndex
									+++++++
								JSR SpriteExplodeOnCollision
								JSR SpritesRemove									
								DEC pastIndex									
								++++++
							+
						LDX currentIndex
						LDA spritesHealth, X
						CMP #$00
						BNE +					
							STX index
							JSR SpriteExplodeOnCollision
							JSR SpritesRemove	
							LDX currentIndex
							;PLA ;pull last coordinate TODO remove push
							JMP SpritesUpdateCycleEndSkipINX
							+	
						LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
			;---------------------------------collission to the level/room up
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$00 ;Up
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
			;collision on y?
			LDA spriteNewY
			LDY #$02
			CLC 
			ADC SpriteBoundariesTankLevel, Y
			STA temp
				
			TXA
			TAY
			LDA (pointerLow), Y
			CMP temp
			BCS +
				INX
				INX
				INX
				INX
				JMP ++
				+
				LDA spriteOldY
				LDY #$03
				CLC 
				ADC SpriteBoundariesTankLevel, Y
				STA temp
					
				TXA
				TAY
				LDA (pointerLow), Y
				CMP temp
				BCC +
					INX
					INX
					INX
					INX
					JMP ++
					+
					;on the same x position?
					;1
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesTankLevel, Y
					STA temp
						
					INX
					TXA
					TAY
					LDA (pointerLow), Y
					CMP temp
					BCS +
						INX
						INX
						INX
						JMP ++
						+
					;2
					INX
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
				
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesTankLevel, Y
					CMP temp
					BCS +
						INX
						INX
						JMP ++
						+
						INX
						INX
						;COLLISION
						LDA spriteOldY
						STA spriteNewY				
						LDX currentIndex
						JSR SpriteMoveFunctioneTankRandomDir
						JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++			
		;------------------------------------------------------------
	++++ ;check movement to the down
	LDA spriteDirection
	AND Down
	CMP Down
	BEQ +
		JMP SpritesColYReturn ;no movement on y
		+
		;down
		LDX #$00
			- ;down dir cycle
			LDA spritesType, X
			CMP #$00 ;player
			BEQ +
			CMP #$02 ;tank
			BEQ +
				JMP ++
				+		
				;collision on y?
				LDA spritesY, X
				LDY #$02
				CLC
				ADC SpriteBoundariesPlayer1, Y
				STA temp
								
				LDA spriteNewY
				LDY #$03
				CLC 
				ADC SpriteBoundariesTank, Y
				CMP temp
				BCS +
					JMP ++
					+										
					LDA spritesY, X
					LDY #$02
					CLC
					ADC SpriteBoundariesPlayer1, Y
					STA temp
									
					LDA spriteOldY
					LDY #$02
					CLC 
					ADC SpriteBoundariesTank, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesTank, Y
						STA temp
				
						LDA spritesX, X
						LDY #$01
						CLC
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesX, X
						LDY #$00
						CLC
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesTank, Y
						CMP temp
						BCS +
							JMP ++
							+
						;collision
						STX pastIndex
						LDA spritesType, X
						CMP #$02 ;tank
						BNE +
							LDA spriteOldX
							STA spriteNewX		
							JMP SpritesColYReturn
							+
						;else if hit player													
						LDA playerHitTimer ;look if invisible
						CMP #$00
						BNE +
							JSR DecreasePlayerHealth
							JSR UpdatePlayerHealth
							INC playerHitTimer
							LDA healthLow								
							CMP #$00
							BNE ++++++
								;destroy player sprite
								LDX pastIndex
								STX index
								CPX currentIndex
								BPL +++++++
									DEC currentIndex
									+++++++
								JSR SpriteExplodeOnCollision
								JSR SpritesRemove									
								DEC pastIndex									
								++++++
							+
						LDX currentIndex
						LDA spritesHealth, X
						CMP #$00
						BNE +					
							STX index
							JSR SpriteExplodeOnCollision
							JSR SpritesRemove	
							LDX currentIndex
							;PLA ;pull last coordinate TODO remove push
							JMP SpritesUpdateCycleEndSkipINX
							+	
						LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
			;---------------------------------collision to the level/room down start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$01 ;Down
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
		;collision on y?
				TXA
				TAY
				LDA (pointerLow), Y
				STA temp
								
				LDA spriteNewY
				LDY #$03
				CLC 
				ADC SpriteBoundariesTankLevel, Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+										
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
									
					LDA spriteOldY
					LDY #$02
					CLC 
					ADC SpriteBoundariesTankLevel, Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesTankLevel, Y
						STA temp
				
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesTankLevel, Y
						CMP temp
						BCS +
							INX
							INX
							JMP ++
							+
							INX
							INX
							;COLLISION
							LDA spriteOldY
							STA spriteNewY				
							LDX currentIndex
							JSR SpriteMoveFunctioneTankRandomDir
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
		;---------------------------------collision to the level/room down end
JMP SpritesColYReturn
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;enemy bullet collision
BulletsColXSpriteFunctionEnemy:
	LDA spriteDirection
	AND Left
	CMP Left
	BEQ +
		JMP ++++ ;movement to the right?
		+
		;left
		LDX #$00
			- ;left dir cycle
			LDA spritesType, X	
			CMP #$00 ;player
			BEQ +
				JMP ++
				+
				;collision on x?
				LDA spriteNewX
				LDY #$00
				CLC 
				ADC SpriteBoundariesEnemyBullet, Y
				STA temp
				
				LDA spritesX, X
				LDY #$01
				CLC
				ADC SpriteBoundariesPlayer1, Y
				CMP temp
				BCS +
					JMP ++
					+
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesEnemyBullet, Y
					STA temp
				
					LDA spritesX, X
					LDY #$01
					CLC
					ADC SpriteBoundariesPlayer1, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesEnemyBullet, Y
						STA temp
				
						LDA spritesY, X
						LDY #$03
						CLC
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesY, X
						LDY #$02
						CLC
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesEnemyBullet, Y
						CMP temp
						BCS +
							JMP ++
							+
							;JSR DecreasePlayerHealth
							;PLA
							;STA temp					
							;TXA
							;PHA						
							;LDX temp
							;JSR SpriteExplodeOnCollision
							;remove sprite						
							;STX index
							;JSR SpritesRemove
							;PLA
							;TAX						
							;LDX temp
							;JMP SpritesUpdateCycleEndSkipINX
							;JMP +++
							STX pastIndex
							LDA playerHitTimer ;look if invisible
							CMP #$00
							BNE +
								JSR DecreasePlayerHealth
								JSR UpdatePlayerHealth
								INC playerHitTimer
								LDA healthLow								
								CMP #$00
								BNE ++++++
									;destroy player sprite
									LDX pastIndex
									STX index
									CPX currentIndex
									BPL +++++++
										DEC currentIndex
										+++++++
									JSR SpriteExplodeOnCollision
									JSR SpritesRemove									
									DEC pastIndex									
									++++++
								+		
							;destroy bullet					
							LDX currentIndex
							LDA spritesHealth, X
							CMP #$00
							BNE +					
								STX index
								JSR SpriteExplodeOnCollision
								JSR SpritesRemove									
								LDX currentIndex
								;PLA ;pull last coordinate TODO remove push
								JMP SpritesUpdateCycleEndSkipINX
								+	
							LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		;---------------------------------collision to the level/room LEFT start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$02 ;LEFT
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
		
				;collision on x?
				LDA spriteNewX
				LDY #$00
				CLC 
				ADC SpriteBoundariesEnemyBullet, Y
				STA temp
				
				TXA
				TAY
				LDA (pointerLow), Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesEnemyBullet, Y
					STA temp
				
					TXA
					TAY
					LDA (pointerLow), Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesEnemyBullet, Y
						STA temp
				
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesEnemyBullet, Y
						CMP temp
						BCS +
							INX
							INX
							JMP ++
							+
							INX							
							TXA		
							INX
							TAY
							LDA (pointerLow), Y				
							CMP #$02 ;wall = hole
							BEQ +													
								;COLLISION				
								LDX currentIndex
																
								DEY
								DEY
								DEY
								LDA (pointerLow), Y	
								CLC					
								SBC #$04								
								STA spritesX, X 
								
								JSR SpriteExplodeOnCollision
								;remove sprite						
								STX index
								JSR SpritesRemove
								;PLA	;pull last coordinate TODO remove push		
								LDX currentIndex
								JMP SpritesUpdateCycleEndSkipINX
								+	
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
	;---------------------------------collision to the level/room LEFT end
	++++ ;check movement to the right
	LDA spriteDirection
	AND Right
	CMP Right
	BEQ +
		JMP SpritesColXReturn ;no movement on x
		+
		;right
		LDX #$00
			- ;right dir cycle
			LDA spritesType, X	
			CMP #$00 ;player
			BEQ +
				JMP ++
				+	
				;collision on x?
				LDA spritesX, X
				LDY #$00
				CLC
				ADC SpriteBoundariesPlayer1, Y
				STA temp
								
				LDA spriteNewX
				LDY #$01
				CLC 
				ADC SpriteBoundariesEnemyBullet, Y
				CMP temp
				BCS +
					JMP ++
					+										
					LDA spritesX, X
					LDY #$00
					CLC
					ADC SpriteBoundariesPlayer1, Y
					STA temp
									
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesEnemyBullet, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesEnemyBullet, Y
						STA temp
				
						LDA spritesY, X
						LDY #$03
						CLC
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesY, X
						LDY #$02
						CLC
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesEnemyBullet, Y
						CMP temp
						BCS +
							JMP ++
							+	
							STX pastIndex
							LDA playerHitTimer ;look if invisible
							CMP #$00
							BNE +
								JSR DecreasePlayerHealth
								JSR UpdatePlayerHealth
								INC playerHitTimer
								LDA healthLow								
								CMP #$00
								BNE ++++++
									;destroy player sprite
									LDX pastIndex
									STX index
									CPX currentIndex
									BPL +++++++
										DEC currentIndex
										+++++++
									JSR SpriteExplodeOnCollision
									JSR SpritesRemove									
									DEC pastIndex									
									++++++
								+		
							;destroy bullet					
							LDX currentIndex
							LDA spritesHealth, X
							CMP #$00
							BNE +					
								STX index
								JSR SpriteExplodeOnCollision
								JSR SpritesRemove									
								LDX currentIndex
								;PLA ;pull last coordinate TODO remove push
								JMP SpritesUpdateCycleEndSkipINX
								+	
							LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		;---------------------------------collision to the level/room RIGHT start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$03 ;RIGHT
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
				;collision on x?
				TXA
				TAY
				LDA (pointerLow), Y
				STA temp
								
				LDA spriteNewX
				LDY #$01
				CLC 
				ADC SpriteBoundariesEnemyBullet, Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+										
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
									
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesEnemyBullet, Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same y position?
						;1
						LDA spriteOldY
						LDY #$02
						CLC 
						ADC SpriteBoundariesEnemyBullet, Y
						STA temp
						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldY
						LDY #$03
						CLC 
						ADC SpriteBoundariesEnemyBullet, Y
						CMP temp
						BCS +
							INX
							INX
							JMP ++
							+
							INX							
							TXA		
							INX
							TAY
							LDA (pointerLow), Y				
							CMP #$02 ;wall = hole
							BEQ +						
								;COLLISION				
								LDX currentIndex
																
								DEY
								DEY
								DEY
								LDA (pointerLow), Y	
								CLC					
								SBC #$08								
								STA spritesX, X 
								
								JSR SpriteExplodeOnCollision
								;remove sprite						
								STX index
								JSR SpritesRemove
								;PLA	;pull last coordinate TODO remove push		
								LDX currentIndex
								JMP SpritesUpdateCycleEndSkipINX
								+	
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
	;---------------------------------collision to the level/room RIGHT end
JMP SpritesColXReturn
						
BulletsColYSpriteFunctionEnemy:
	LDA spriteDirection
	AND Up
	CMP Up
	BEQ +
		JMP ++++ ;movement to the down?
		+
		;up
		LDX #$00
			- ;up dir cycle
			LDA spritesType, X	
			CMP #$00 ;player
			BEQ +
				JMP ++
				+
				;collision on y?
				LDA spriteNewY
				LDY #$02
				CLC 
				ADC SpriteBoundariesEnemyBullet, Y
				STA temp
				
				LDA spritesY, X
				LDY #$03
				CLC
				ADC SpriteBoundariesPlayer1, Y
				CMP temp
				BCS +
					JMP ++
					+
					LDA spriteOldY
					LDY #$03
					CLC 
					ADC SpriteBoundariesEnemyBullet, Y
					STA temp
				
					LDA spritesY, X
					LDY #$03
					CLC
					ADC SpriteBoundariesPlayer1, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesEnemyBullet, Y
						STA temp
				
						LDA spritesX, X
						LDY #$01
						CLC
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesX, X
						LDY #$00
						CLC
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesEnemyBullet, Y
						CMP temp
						BCS +
							JMP ++
							+
							STX pastIndex
							LDA playerHitTimer ;look if invisible
							CMP #$00
							BNE +
								JSR DecreasePlayerHealth
								JSR UpdatePlayerHealth
								INC playerHitTimer
								LDA healthLow								
								CMP #$00
								BNE ++++++
									;destroy player sprite
									LDX pastIndex
									STX index
									CPX currentIndex
									BPL +++++++
										DEC currentIndex
										+++++++
									JSR SpriteExplodeOnCollision
									JSR SpritesRemove									
									DEC pastIndex									
									++++++
								+		
							;destroy bullet					
							LDX currentIndex
							LDA spritesHealth, X
							CMP #$00
							BNE +					
								STX index
								JSR SpriteExplodeOnCollision
								JSR SpritesRemove									
								LDX currentIndex
								;PLA ;pull last coordinate TODO remove push
								JMP SpritesUpdateCycleEndSkipINX
								+	
							LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		;---------------------------------collission to the level/room up
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$00 ;Up
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
			;collision on y?
			LDA spriteNewY
			LDY #$02
			CLC 
			ADC SpriteBoundariesEnemyBullet, Y
			STA temp
				
			TXA
			TAY
			LDA (pointerLow), Y
			CMP temp
			BCS +
				INX
				INX
				INX
				INX
				JMP ++
				+
				LDA spriteOldY
				LDY #$03
				CLC 
				ADC SpriteBoundariesEnemyBullet, Y
				STA temp
					
				TXA
				TAY
				LDA (pointerLow), Y
				CMP temp
				BCC +
					INX
					INX
					INX
					INX
					JMP ++
					+
					;on the same x position?
					;1
					LDA spriteOldX
					LDY #$00
					CLC 
					ADC SpriteBoundariesEnemyBullet, Y
					STA temp
						
					INX
					TXA
					TAY
					LDA (pointerLow), Y
					CMP temp
					BCS +
						INX
						INX
						INX
						JMP ++
						+
					;2
					INX
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
				
					LDA spriteOldX
					LDY #$01
					CLC 
					ADC SpriteBoundariesEnemyBullet, Y
					CMP temp
					BCS +
						INX
						INX
						JMP ++
						+
						INX							
						TXA		
						INX
						TAY
						LDA (pointerLow), Y				
						CMP #$02 ;wall = hole
						BEQ +						
							;COLLISION				
							LDX currentIndex
																
							DEY
							DEY
							DEY
							LDA (pointerLow), Y	
							CLC					
							SBC #$08								
							STA spritesY, X 
								
							JSR SpriteExplodeOnCollision
							;remove sprite						
							STX index
							JSR SpritesRemove
							;PLA	;pull last coordinate TODO remove push		
							LDX currentIndex
							JMP SpritesUpdateCycleEndSkipINX
							+	
						JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++			
		;------------------------------------------------------------
	++++ ;check movement to the down
	LDA spriteDirection
	AND Down
	CMP Down
	BEQ +
		JMP SpritesColYReturn ;no movement on y
		+
		;down
		LDX #$00
			- ;down dir cycle
			LDA spritesType, X	
			CMP #$00 ;player
			BEQ +
				JMP ++
				+
				;collision on y?
				LDA spritesY, X
				LDY #$02
				CLC
				ADC SpriteBoundariesPlayer1, Y
				STA temp
								
				LDA spriteNewY
				LDY #$03
				CLC 
				ADC SpriteBoundariesEnemyBullet, Y
				CMP temp
				BCS +
					JMP ++
					+										
					LDA spritesY, X
					LDY #$02
					CLC
					ADC SpriteBoundariesPlayer1, Y
					STA temp
									
					LDA spriteOldY
					LDY #$02
					CLC 
					ADC SpriteBoundariesEnemyBullet, Y
					CMP temp
					BCC +
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesEnemyBullet, Y
						STA temp
				
						LDA spritesX, X
						LDY #$01
						CLC
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
						;2						
						LDA spritesX, X
						LDY #$00
						CLC
						ADC SpriteBoundariesPlayer1, Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesEnemyBullet, Y
						CMP temp
						BCS +
							JMP ++
							+	
							STX pastIndex
							LDA playerHitTimer ;look if invisible
							CMP #$00
							BNE +
								JSR DecreasePlayerHealth
								JSR UpdatePlayerHealth
								INC playerHitTimer
								LDA healthLow								
								CMP #$00
								BNE ++++++
									;destroy player sprite
									LDX pastIndex
									STX index
									CPX currentIndex
									BPL +++++++
										DEC currentIndex
										+++++++
									JSR SpriteExplodeOnCollision
									JSR SpritesRemove									
									DEC pastIndex									
									++++++
								+		
							;destroy bullet					
							LDX currentIndex
							LDA spritesHealth, X
							CMP #$00
							BNE +					
								STX index
								JSR SpriteExplodeOnCollision
								JSR SpritesRemove									
								LDX currentIndex
								;PLA ;pull last coordinate TODO remove push
								JMP SpritesUpdateCycleEndSkipINX
								+	
							LDX pastIndex
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		;---------------------------------collision to the level/room down start
		LDY roomNumber ;Room Number
		LDA Level1ColLowLow, Y
		STA pointerLow
		LDA Level1ColLowHi, Y
		STA pointerHi
		LDA Level1ColHiLow, Y
		STA pointer2Low
		LDA Level1ColHiHi, Y
		STA pointer2Hi
		LDY #$01 ;Down
		LDA (pointerLow), Y
		STA pointerLow
		LDA (pointer2Low), Y
		STA pointerHi
		LDY #$00 ;read massive from start		
		LDA (pointerLow), Y ;read collision data
		STA counter
		LDX #$01
		-
		;collision on y?
				TXA
				TAY
				LDA (pointerLow), Y
				STA temp
								
				LDA spriteNewY
				LDY #$03
				CLC 
				ADC SpriteBoundariesEnemyBullet, Y
				CMP temp
				BCS +
					INX
					INX
					INX
					INX
					JMP ++
					+										
					TXA
					TAY
					LDA (pointerLow), Y
					STA temp
									
					LDA spriteOldY
					LDY #$02
					CLC 
					ADC SpriteBoundariesEnemyBullet, Y
					CMP temp
					BCC +
						INX
						INX
						INX
						INX
						JMP ++
						+
						;on the same x position?
						;1
						LDA spriteOldX
						LDY #$00
						CLC 
						ADC SpriteBoundariesEnemyBullet, Y
						STA temp
				
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						CMP temp
						BCS +
							INX
							INX
							INX
							JMP ++
							+
						;2						
						INX
						TXA
						TAY
						LDA (pointerLow), Y
						STA temp
				
						LDA spriteOldX
						LDY #$01
						CLC 
						ADC SpriteBoundariesEnemyBullet, Y
						CMP temp
						BCS +
							INX
							INX
							JMP ++
							+
							INX							
							TXA		
							INX
							TAY
							LDA (pointerLow), Y				
							CMP #$02 ;wall = hole
							BEQ +						
								;COLLISION				
								LDX currentIndex
																
								DEY
								DEY
								DEY
								LDA (pointerLow), Y	
								CLC					
								SBC #$08								
								STA spritesY, X 
								
								JSR SpriteExplodeOnCollision
								;remove sprite						
								STX index
								JSR SpritesRemove
								;PLA	;pull last coordinate TODO remove push		
								LDX currentIndex
								JMP SpritesUpdateCycleEndSkipINX
								+						
							JMP +++
			++
			CPX counter
			BEQ +
				JMP -
				+
		+++
		;---------------------------------collision to the level/room down end
JMP SpritesColYReturn
