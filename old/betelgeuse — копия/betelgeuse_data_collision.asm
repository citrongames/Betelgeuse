SpriteTypesColXSpriteFunctionsLow:
	DB <(SpriteColXSpriteFunctionPlayer1), <(SpriteColXSpriteFunctionTri), $00, $00, $00, $00, $00, $00, $00
SpriteTypesColXSpriteFunctionsHi:
	DB >(SpriteColXSpriteFunctionPlayer1), >(SpriteColXSpriteFunctionTri), $00, $00, $00, $00, $00, $00, $00
	
SpriteTypesColYSpriteFunctionsLow:
	DB <(SpriteColYSpriteFunctionPlayer1), <(SpriteColYSpriteFunctionTri), $00, $00, $00, $00, $00, $00, $00
SpriteTypesColYSpriteFunctionsHi:
	DB >(SpriteColYSpriteFunctionPlayer1), >(SpriteColYSpriteFunctionTri), $00, $00, $00, $00, $00, $00, $00


SpriteBoundariesPlayer1:
	DB $02, $0E, $02, $0E
	
SpriteBoundariesTripod:
	DB $02, $0E, $02, $0E

SpriteBoundariesTripodLevel:
	DB $02, $0E, $02, $0E

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
	JSR SpritesAdd
RTS

;player collision
SpriteColXSpriteFunctionPlayer1:
	LDA spriteDirection
	AND Left
	CMP Left
	BEQ +
		JMP ++++ ;movement to the right?
		+
		;left
			LDA $FFF0
		LDX #$00
			- ;left dir cycle
			LDA spritesType, X
			CMP #$01 ;tripod
			BEQ +
				JMP ++
				+
				;collision on x?
				LDA spriteNewX
				LDY #$00
				CLC 
				ADC SpriteBoundariesPlayer1, Y
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
					ADC SpriteBoundariesPlayer1, Y
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
						ADC SpriteBoundariesPlayer1, Y
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
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
							JSR SpriteExplodeOnCollision
							;remove old sprite
							TXA
							PHA
							STX index
							JSR SpritesRemove
							PLA
							TAX
							JMP +++
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		;---------------------------------collision to the level/room LEFT start
		LDY #$00 ;Room Number
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
			CMP #$01 ;tripod
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
				ADC SpriteBoundariesPlayer1, Y
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
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
							JSR SpriteExplodeOnCollision
							;remove old sprite
							TXA
							PHA
							STX index
							JSR SpritesRemove
							PLA
							TAX
							JMP +++
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		;---------------------------------collision to the level/room RIGHT start
		LDY #$00 ;Room Number
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
				JMP ++
				+
				;collision on y?
				LDA spriteNewY
				LDY #$02
				CLC 
				ADC SpriteBoundariesPlayer1, Y
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
					ADC SpriteBoundariesPlayer1, Y
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
						ADC SpriteBoundariesPlayer1, Y
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
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
							JSR SpriteExplodeOnCollision
							;remove old sprite
							TXA
							PHA
							STX index
							JSR SpritesRemove
							PLA
							TAX
							JMP +++
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		;---------------------------------collission to the level/room up
		LDY #$00 ;Room Number
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
			CMP #$01 ;tripod
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
				ADC SpriteBoundariesPlayer1, Y
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
						ADC SpriteBoundariesPlayer1, Y
						CMP temp
						BCS +
							JMP ++
							+
							JSR SpriteExplodeOnCollision
							;remove old sprite
							TXA
							PHA
							STX index
							JSR SpritesRemove
							PLA
							TAX
							JMP +++
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
		;---------------------------------collision to the level/room down start
		LDY #$00 ;Room Number
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
			CMP #$01
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
						LDA spritesType, X
						CMP #$00 ;player
						BNE +
							PLA
							STA temp					
							TXA
							PHA						
							LDX temp
							JSR SpriteExplodeOnCollision
							;remove sprite						
							STX index
							JSR SpritesRemove
							PLA
							TAX						
							LDX temp
							JMP SpritesUpdateCycleEndSkipINX
							+
						CMP #$01 ;tripod
						BNE +
							LDA spriteOldX
							STA spriteNewX		
							JMP SpritesColXReturn
							+
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
					;---------------------------------collision to the level/room LEFT start
		LDY #$00 ;Room Number
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
						LDA spritesType, X
						CMP #$00 ;player
						BNE +
							PLA
							STA temp					
							TXA
							PHA						
							LDX temp
							JSR SpriteExplodeOnCollision
							;remove sprite						
							STX index
							JSR SpritesRemove
							PLA
							TAX						
							LDX temp
							JMP SpritesUpdateCycleEndSkipINX
							+
						CMP #$01 ;tripod
						BNE +
							LDA spriteOldX
							STA spriteNewX		
							JMP SpritesColXReturn
							+
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
			;---------------------------------collision to the level/room RIGHT start
		LDY #$00 ;Room Number
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
			CMP #$01
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
						LDA spritesType, X
						CMP #$00 ;player
						BNE +
							PLA
							STA temp					
							TXA
							PHA						
							LDX temp
							JSR SpriteExplodeOnCollision
							;remove sprite						
							STX index
							JSR SpritesRemove
							PLA
							TAX						
							LDX temp
							JMP SpritesUpdateCycleEndSkipINX
							+
						CMP #$01 ;tripod
						BNE +
							LDA spriteOldY
							STA spriteNewY		
							JMP SpritesColYReturn
							+
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
			;---------------------------------collission to the level/room up
		LDY #$00 ;Room Number
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
						LDA spritesType, X
						CMP #$00 ;player
						BNE +
							PLA
							STA temp					
							TXA
							PHA						
							LDX temp
							JSR SpriteExplodeOnCollision
							;remove sprite						
							STX index
							JSR SpritesRemove
							PLA
							TAX						
							LDX temp
							JMP SpritesUpdateCycleEndSkipINX
							+
						CMP #$01 ;tripod
						BNE +
							LDA spriteOldY
							STA spriteNewY		
							JMP SpritesColYReturn
							+
				++
			INX
			+++
			CPX spritesLength
		BEQ +
			JMP -
			+
			;---------------------------------collision to the level/room down start
		LDY #$00 ;Room Number
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
