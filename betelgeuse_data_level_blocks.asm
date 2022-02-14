LEVEL_BLOCKS_1X1:
	DB $80, $6E, $2E, $88, $70, $81, $4E, $91, $41, $51, $60, $00, $22, $85, $40, $AC, $1A, $2C, $04, $0C, $0E, $42, $3A, $4C, $04, $3A, $8C, $3A, $29, $19, $0A, $1A, $0E, $1C, $49, $8A, $6A, $1B, $2A, $0A, $00, $80, $8E, $6C, $00, $00, $00, $B7, $00, $AB, $AB, $00, $B8, $00, $20, $94, $04, $0C, $19, $19
LEVEL_BLOCKS_1X2:
	DB $80, $6E, $2F, $89, $71, $71, $4F, $41, $41, $01, $01, $01, $23, $85, $04, $AD, $1B, $2D, $04, $0D, $BE, $43, $59, $4D, $04, $59, $8D, $AE, $AE, $09, $0B, $1B, $BE, $1D, $59, $8B, $6B, $1B, $59, $0B, $01, $80, $8F, $6D, $01, $01, $B6, $01, $AA, $93, $01, $01, $B8, $24, $21, $01, $04, $0D, $1A, $1B
LEVEL_BLOCKS_2X1:
	DB $80, $7E, $3E, $98, $50, $10, $5E, $40, $04, $10, $50, $10, $32, $85, $40, $2B, $5B, $3C, $40, $5B, $2A, $52, $4A, $5E, $04, $2A, $9C, $4A, $39, $5A, $5B, $5A, $2A, $0F, $AF, $9A, $7A, $5B, $2A, $5B, $50, $80, $9E, $7C, $10, $A7, $10, $10, $10, $AB, $AB, $A8, $10, $10, $30, $50, $40, $0F, $5A, $5A
LEVEL_BLOCKS_2X2:
	DB $80, $7F, $3F, $99, $11, $11, $5E, $04, $04, $11, $11, $11, $33, $85, $04, $5B, $5B, $3D, $04, $5B, $59, $53, $59, $5E, $04, $59, $9D, $BF, $59, $5B, $5B, $5B, $59, $5B, $BF, $9B, $7B, $5C, $59, $5C, $11, $80, $9F, $7D, $A6, $11, $11, $11, $AA, $11, $11, $A8, $11, $34, $31, $11, $04, $5B, $5B, $5B
	
;block number 
;4 tiles in name table
;x x y type - up
;x x y type - down
;x y y type - left
;x y y type - right
;types:
;0 - stop movement
;1 - door warp
;2 - hole
;3 - closed door
;F - no collision

LEVEL_BLOCKS_UP_1:
	DB $0F, $0F, $0F, $0F, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $7F, $0F, $0F, $FF, $0F, $07, $FF, $07, $FF, $FF, $07, $0F, $07, $07, $0F, $0F, $0F, $07, $7F, $07, $0F, $0F, $0F, $07, $0F, $FF, $0F, $FF, $0F, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $7F, $0F, $0F
LEVEL_BLOCKS_UP_2:
	DB $F0, $70, $F0, $01, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $70, $70, $F0, $FF, $70, $F0, $FF, $F0, $FF, $FF, $F0, $00, $F0, $F0, $70, $70, $70, $F0, $70, $70, $00, $72, $70, $F0, $70, $FF, $72, $FF, $72, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $70, $70, $70
	
LEVEL_BLOCKS_DOWN_1:
	DB $0F, $FF, $0F, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $0F, $0F, $0F, $FF, $0F, $07, $FF, $07, $FF, $FF, $07, $0F, $07, $07, $0F, $0F, $0F, $07, $0F, $07, $0F, $0F, $0F, $07, $0F, $FF, $0F, $0F, $0F, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $0F, $0F, $0F
LEVEL_BLOCKS_DOWN_2:
	DB $00, $FF, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $00, $00, $FF, $00, $FF, $FF, $00, $F0, $00, $00, $00, $00, $00, $00, $00, $00, $F0, $02, $00, $00, $00, $FF, $02, $F1, $02, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00
	
LEVEL_BLOCKS_LEFT_1:
	DB $F0, $FF, $F0, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $77, $F0, $F0, $FF, $F0, $70, $FF, $70, $FF, $FF, $70, $FF, $70, $70, $F0, $F0, $F0, $70, $77, $70, $30, $F0, $F0, $70, $F0, $FF, $F0, $00, $F0, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $77, $F0, $F0
LEVEL_BLOCKS_LEFT_2:
	DB $F0, $FF, $F0, $70, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F0, $70, $F0, $FF, $70, $F0, $FF, $F0, $FF, $FF, $F0, $FF, $F0, $F0, $70, $70, $70, $F0, $F0, $70, $F1, $72, $70, $F0, $70, $FF, $72, $F0, $72, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F0, $70, $70
	
LEVEL_BLOCKS_RIGHT_1:
	DB $00, $FF, $00, $F0, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $FF, $00, $00, $FF, $00, $FF, $FF, $00, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $00, $00, $00, $00, $FF, $00, $F0, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00
LEVEL_BLOCKS_RIGHT_2:
	DB $F0, $FF, $F0, $70, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F0, $70, $F0, $FF, $70, $F0, $FF, $F0, $FF, $FF, $F0, $F1, $F0, $F0, $70, $70, $70, $F0, $F0, $70, $FF, $72, $70, $F0, $70, $FF, $72, $F0, $72, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F0, $70, $70
