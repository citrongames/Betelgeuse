;--------------------------
; rooms teleport
;--------------------------
Level1RoomsTeleportLow:
	DB <(Level1Room1), <(Level1Room2), <(Level1Room3), <(Level1Room4), <(Level1Room5), <(Level1Room6)
Level1RoomsTeleportHi:
	DB >(Level1Room1), >(Level1Room2), >(Level1Room3), >(Level1Room4), >(Level1Room5), >(Level1Room6)

;      up, down, left, right
Level1Room1:
	DB $01, $02, $03, $04
Level1Room2:
	DB $00, $00, $00, $00
Level1Room3:
	DB $00, $00, $00, $00
Level1Room4:
	DB $00, $00, $00, $00
Level1Room5:
	DB $00, $00, $00, $05
Level1Room6:
	DB $00, $00, $04, $00
;--------------------------
; rooms info:
; always 1
; boss in the room
; spawn item
; room clear
; door right
; door left
; door down
; door up
;--------------------------
Level1RoomsInfo:
	DB %10100011, %10000010, %10000000, %10000000, %10101000, %11000000
;--------------------------
; doors mask
;--------------------------
Level1DoorsMask:
	DB %11111111, %00100010, %00010001, %10001000, %11001100, %01000100
;--------------------------
; spawn item info
;--------------------------
Level1RoomsSpawItem:
	DB $10, $10, $10, $10, $10, $10
Level1RoomsSpawItemX:
	DB $83, $83, $10, $10, $83, $83
Level1RoomsSpawItemY:
	DB $62, $32, $10, $10, $62, $62
	
;--------------------------
; rooms nametables
;--------------------------
Level1RoomsNameTablesLow:
	DB <(LEVEL_1_BLOCKS), <(LEVEL_2_BLOCKS), <(LEVEL_3_BLOCKS), <(LEVEL_4_BLOCKS), <(LEVEL_5_BLOCKS), <(LEVEL_6_BLOCKS)
Level1RoomsNameTablesHi:
	DB >(LEVEL_1_BLOCKS), >(LEVEL_2_BLOCKS), >(LEVEL_3_BLOCKS), >(LEVEL_4_BLOCKS), >(LEVEL_5_BLOCKS), >(LEVEL_6_BLOCKS)
	
;--------------------------
; rooms door nametable coordinates
;--------------------------
Level1RoomsDoorsHiLow:
	DB <(Level1Room1DoorsHi), <(Level1Room2DoorsHi), <(Level1Room2DoorsHi), <(Level1Room2DoorsHi), <(Level1Room2DoorsHi), <(Level1Room2DoorsHi)
Level1RoomsDoorsHiHi:
	DB >(Level1Room1DoorsHi), >(Level1Room2DoorsHi), >(Level1Room2DoorsHi), >(Level1Room2DoorsHi), >(Level1Room2DoorsHi), >(Level1Room2DoorsHi)

;      up, down, left, right
Level1Room1DoorsHi:
	DB $00, $03, $02, $01
Level1Room2DoorsHi:
	DB $00, $03, $01, $01

Level1RoomsDoorsLowLow:
	DB <(Level1Room1DoorsLow), <(Level1Room2DoorsLow), <(Level1Room2DoorsLow), <(Level1Room2DoorsLow), <(Level1Room2DoorsLow), <(Level1Room2DoorsLow)
Level1RoomsDoorsLowHi:
	DB >(Level1Room1DoorsLow), >(Level1Room2DoorsLow), >(Level1Room2DoorsLow), >(Level1Room2DoorsLow), >(Level1Room2DoorsLow), >(Level1Room2DoorsLow)

;      up, down, left, right
Level1Room1DoorsLow:
	DB $4C, $0E, $00, $5E
Level1Room2DoorsLow:
	DB $50, $0E, $80, $9E
