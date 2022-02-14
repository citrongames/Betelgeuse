;--------------------------
; rooms teleport
;--------------------------
Level1RoomsTeleportLow:
	DB <(Level1Room1), <(Level1Room2), <(Level1Room3), <(Level1Room4), <(Level1Room5)
Level1RoomsTeleportHi:
	DB >(Level1Room1), >(Level1Room2), >(Level1Room3), >(Level1Room4), >(Level1Room5)

;      up, down, left, right
Level1Room1:
	DB $01, $01, $01, $01
Level1Room2:
	DB $00, $00, $00, $00
Level1Room3:
	DB $01, $01, $01, $01
Level1Room4:
	DB $01, $01, $01, $01
Level1Room5:
	DB $01, $01, $01, $01
	
;--------------------------
; rooms nametables
;--------------------------
Level1RoomsNameTablesLow:
	DB <(nametableRoom1), <(nametableRoom2), <(nametableRoom3), <(nametableRoom4), <(nametableRoom5)
Level1RoomsNameTablesHi:
	DB >(nametableRoom1), >(nametableRoom2), >(nametableRoom3), >(nametableRoom4), >(nametableRoom5)
	
;-------------------
;walls collisions for level 1 rooms
;-------------------
Level1ColLowLow:
	DB <(Level1Room1ColLow), <(Level1Room2ColLow)
Level1ColLowHi:
	DB >(Level1Room1ColLow), >(Level1Room2ColLow)
Level1ColHiLow:
	DB <(Level1Room1ColHi), <(Level1Room2ColHi)
Level1ColHiHi:
	DB >(Level1Room1ColHi), >(Level1Room2ColHi)

Level1Room1ColLow:
	DB <(Level1Room1ColUp), <(Level1Room1ColDown), <(Level1Room1ColLeft), <(Level1Room1ColRight)
Level1Room1ColHi:
	DB >(Level1Room1ColUp), >(Level1Room1ColDown), >(Level1Room1ColLeft), >(Level1Room1ColRight)
Level1Room2ColLow:
	DB <(Level1Room2ColUp), <(Level1Room2ColDown), <(Level1Room2ColLeft), <(Level1Room2ColRight)
Level1Room2ColHi:
	DB >(Level1Room2ColUp), >(Level1Room2ColDown), >(Level1Room2ColLeft), >(Level1Room2ColRight)
;-------------------
;num y x1 x2 type etc...
;TYPES:
;0 - stop movement
;1 - door warp
;2 - hole
;-------------------
;--ROOM 1--
Level1Room1ColUp:
	DB $51, $10, $6F, $60, $01, $18, $30, $0F, $00, $18, $5F, $3F, $00, $18, $EF, $70, $00, $1F, $3F, $30, $00, $47, $60, $47, $00, $47, $C0, $AF, $00, $4F, $6F, $60, $00, $4F, $AF, $A0, $00, $4F, $FE, $EF, $00, $77, $70, $40, $00, $77, $C6, $97, $00, $7F, $0F, $01, $00, $8E, $2E, $20, $02, $97, $76, $5F, $00, $97, $B0, $90, $00, $9F, $5F, $50, $00, $9F, $BF, $B0, $00, $9F, $EF, $DF, $02, $AE, $DF, $D1, $02
Level1Room1ColDown:
	DB $35, $40, $6F, $40, $00, $40, $C6, $A0, $00, $5F, $FE, $EF, $00, $70, $76, $47, $00, $70, $C0, $90, $00, $80, $2E, $20, $02, $8F, $0F, $01, $00, $90, $70, $50, $00, $90, $BE, $97, $00, $90, $EF, $D0, $02, $BF, $6F, $0F, $00, $BF, $EF, $80, $00, $CF, $7F, $70, $01
Level1Room1ColLeft:
	DB $41, $03, $8F, $80, $01, $0F, $7E, $18, $00, $0F, $BE, $90, $00, $2E, $8E, $80, $02, $3F, $1F, $18, $00, $47, $6F, $48, $00, $5F, $9F, $98, $00, $60, $18, $10, $00, $6F, $4F, $40, $00, $70, $CF, $BF, $00, $76, $97, $70, $00, $97, $8F, $78, $00, $AF, $4F, $48, $00, $BF, $9F, $90, $00, $C6, $77, $40, $00, $DF, $AE, $A0, $02
Level1Room1ColRight:
	DB $41, $20, $8E, $80, $02, $30, $1F, $18, $00, $40, $77, $40, $00, $50, $9F, $90, $00, $60, $4F, $48, $00, $6F, $18, $10, $00, $70, $8F, $77, $00, $7F, $CF, $BF, $00, $90, $97, $70, $00, $A0, $4F, $40, $00, $B0, $9F, $98, $00, $C0, $6F, $48, $00, $D0, $AE, $90, $02, $EF, $4E, $18, $00, $EF, $BE, $60, $00, $FC, $5F, $50, $01

;--ROOM 2--
Level1Room2ColUp:
	DB $19, $10, $8F, $80, $01, $18, $7F, $0F, $00, $18, $EF, $90, $00, $50, $0F, $01, $00, $5F, $FE, $EF, $00, $8F, $AF, $50, $02
Level1Room2ColDown:
	DB $19, $CF, $7F, $70, $01, $BF, $70, $0F, $00, $BF, $EF, $7F, $00, $60, $0F, $01, $00, $6F, $FE, $EF, $00, $50, $AF, $50, $02
Level1Room2ColLeft:
	DB $19, $03, $5F, $50, $01, $0F, $50, $18, $00, $0F, $BE, $5F, $00, $70, $CF, $BF, $00, $80, $18, $10, $00, $AF, $8F, $50, $02
Level1Room2ColRight:
	DB $19, $FC, $6F, $60, $01, $EF, $5E, $18, $00, $EF, $BE, $70, $00, $8F, $18, $10, $00, $7F, $CF, $BF, $00, $50, $8F, $50, $02

;--ROOM 3--
Level1Room3ColUp:
	DB $3D, $10, $8F, $80, $01, $18, $7F, $0F, $00, $18, $EF, $90, $00, $37, $50, $37, $00, $37, $C0, $AF, $00, $3F, $5F, $50, $00, $3F, $AF, $A0, $00, $57, $37, $30, $00, $57, $CF, $C0, $00, $5F, $0F, $01, $00, $5F, $FE, $EF, $00, $87, $60, $40, $00, $87, $B7, $9F, $00, $8F, $6F, $60, $00, $8F, $9F, $90, $00
Level1Room3ColDown:
	DB $31, $CF, $7F, $70, $01, $BF, $70, $0F, $00, $BF, $EF, $7F, $00, $80, $6F, $47, $00, $80, $B0, $90, $00, $70, $47, $40, $00, $70, $B7, $B0, $00, $6F, $0F, $01, $00, $6F, $FE, $EF, $00, $50, $CF, $C7, $00, $30, $5F, $30, $00, $30, $C7, $A0, $00
Level1Room3ColLeft:
	DB $39, $01, $6F, $60, $01, $0F, $5E, $18, $00, $0F, $BE, $70, $00, $37, $57, $37, $00, $47, $7F, $70, $00, $5F, $3F, $30, $00, $6F, $8F, $80, $00, $70, $CF, $BF, $00, $80, $18, $10, $00, $9F, $8F, $87, $00, $AF, $3F, $37, $00, $B7, $87, $70, $00, $C7, $4F, $30, $00, $CF, $57, $50, $00
Level1Room3ColRight:
	DB $35, $FE, $6F, $60, $01, $EF, $5E, $18, $00, $EF, $BE, $70, $00, $C0, $57, $37, $00, $B0, $7F, $70, $00, $A0, $3F, $30, $00, $90, $8F, $80, $00, $8F, $18, $10, $00, $7F, $CF, $BF, $00, $60, $8F, $87, $00, $50, $3F, $37, $00, $40, $87, $70, $00, $30, $57, $30, $00

;--ROOM 4--
Level1Room4ColUp:
	DB $41, $10, $8F, $80, $01, $18, $7F, $0F, $00, $18, $EF, $90, $00, $37, $60, $47, $00, $37, $C0, $A0, $00, $37, $CE, $C8, $00, $3F, $6F, $60, $00, $5F, $0F, $01, $00, $5F, $FE, $EF, $00, $67, $60, $40, $00, $67, $6E, $67, $00, $67, $C7, $9F, $00, $6F, $9F, $90, $00, $77, $70, $60, $00, $97, $77, $70, $00, $9F, $4F, $30, $00
Level1Room4ColDown:
	DB $2D, $CF, $7F, $70, $01, $BF, $70, $0F, $00, $BF, $EF, $7F, $00, $80, $4F, $30, $00, $70, $77, $67, $00, $6F, $0F, $01, $00, $6F, $FE, $EF, $00, $60, $6E, $47, $00, $60, $C0, $90, $00, $30, $6F, $40, $00, $30, $CE, $A0, $00
Level1Room4ColLeft:
	DB $39, $01, $6F, $60, $01, $0F, $5E, $18, $00, $0F, $BE, $70, $00, $47, $5F, $37, $00, $4F, $9F, $80, $00, $67, $6F, $67, $00, $6E, $67, $60, $00, $6F, $3F, $30, $00, $70, $CF, $BF, $00, $77, $97, $70, $00, $80, $18, $10, $00, $9F, $6F, $67, $00, $C7, $67, $37, $00, $CE, $36, $30, $00
Level1Room4ColRight:
	DB $35, $FE, $6F, $60, $01, $EF, $5E, $18, $00, $EF, $BE, $70, $00, $C0, $5F, $37, $00, $A0, $37, $30, $00, $90, $6F, $60, $00, $8F, $18, $10, $00, $7F, $CF, $BF, $00, $70, $97, $77, $00, $60, $3F, $37, $00, $60, $77, $67, $00, $40, $67, $30, $00, $30, $9F, $80, $00

;--ROOM 5--
Level1Room5ColUp:
	DB $15, $10, $8F, $80, $01, $18, $7F, $0F, $00, $18, $EF, $90, $00, $5F, $0F, $01, $00, $5F, $FE, $EF, $00
Level1Room5ColDown:
	DB $15, $CF, $7F, $70, $01, $BF, $70, $0F, $00, $BF, $EF, $7F, $00, $6F, $0F, $01, $00, $6F, $FE, $EF, $00
Level1Room5ColLeft:
	DB $15, $01, $6F, $60, $01, $0F, $5E, $18, $00, $0F, $BE, $79, $00, $70, $CF, $BF, $00, $80, $18, $10, $00
Level1Room5ColRight:
	DB $15, $FE, $6F, $60, $01, $EF, $5E, $18, $00, $EF, $BE, $79, $00, $8F, $18, $10, $00, $7F, $CF, $BF, $00
