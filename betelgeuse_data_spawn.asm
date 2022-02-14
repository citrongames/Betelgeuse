;-------------------
; number of spawns
;-------------------
Level1RoomsSpawnsNum:
	DB $01, $04, $01, $01, $01, $00
;-------------------
; spawn timer hi/low
;-------------------
Level1SpawnsTimerHiLow:
	DB <(Level1Room1SpawnTimerHi), <(Level1Room2SpawnTimerHi), <(Level1Room2SpawnTimerHi), <(Level1Room2SpawnTimerHi), <(Level1Room2SpawnTimerHi), <(Level1Room2SpawnTimerHi)
Level1SpawnsTimerHiHi:
	DB >(Level1Room1SpawnTimerHi), >(Level1Room2SpawnTimerHi), >(Level1Room2SpawnTimerHi), >(Level1Room2SpawnTimerHi), >(Level1Room2SpawnTimerHi), >(Level1Room2SpawnTimerHi)
Level1Room1SpawnTimerHi:
	DB $00, $00, $00, $00
Level1Room2SpawnTimerHi:
	DB $00, $00, $00, $00
	
Level1SpawnsTimerLowLow:
	DB <(Level1Room1SpawnTimerLow), <(Level1Room2SpawnTimerLow), <(Level1Room2SpawnTimerLow), <(Level1Room2SpawnTimerLow), <(Level1Room2SpawnTimerLow), <(Level1Room2SpawnTimerLow)
Level1SpawnsTimerLowHi:
	DB >(Level1Room1SpawnTimerLow), >(Level1Room2SpawnTimerLow), >(Level1Room2SpawnTimerLow), >(Level1Room2SpawnTimerLow), >(Level1Room2SpawnTimerLow), >(Level1Room2SpawnTimerLow)
Level1Room1SpawnTimerLow:
	DB $10, $80, $10, $40
Level1Room2SpawnTimerLow:
	DB $40, $50, $50, $60
;-------------------
; spawn number
;-------------------
Level1SpawnsNumsLow:
	DB <(Level1Room1SpawnNums), <(Level1Room2SpawnNums), <(Level1Room2SpawnNums), <(Level1Room2SpawnNums), <(Level1Room2SpawnNums), <(Level1Room2SpawnNums)
Level1SpawnsNumsHi:
	DB >(Level1Room1SpawnNums), >(Level1Room2SpawnNums), >(Level1Room2SpawnNums), >(Level1Room2SpawnNums), >(Level1Room2SpawnNums), >(Level1Room2SpawnNums)

Level1Room1SpawnNums:
	DB $04, $0A, $0A, $0A
Level1Room2SpawnNums:
	DB $04, $0A, $0A, $0A
;-------------------
; spawn X
;-------------------
Level1SpawnsXLow:
	DB <(Level1Room1SpawnX), <(Level1Room2SpawnX), <(Level1Room2SpawnX), <(Level1Room2SpawnX), <(Level1Room2SpawnX), <(Level1Room2SpawnX)
Level1SpawnsXHi:
	DB >(Level1Room1SpawnX), >(Level1Room2SpawnX), >(Level1Room2SpawnX), >(Level1Room2SpawnX), >(Level1Room2SpawnX), >(Level1Room2SpawnX)

Level1Room1SpawnX:
	DB $80, $20, $D0, $30
Level1Room2SpawnX:
	DB $30, $80, $80, $D0
;-------------------
; spawn Y
;-------------------
Level1SpawnsYLow:
	DB <(Level1Room1SpawnY), <(Level1Room2SpawnY), <(Level1Room2SpawnY), <(Level1Room2SpawnY), <(Level1Room2SpawnY), <(Level1Room2SpawnY)
Level1SpawnsYHi:
	DB >(Level1Room1SpawnY), >(Level1Room2SpawnY), >(Level1Room2SpawnY), >(Level1Room2SpawnY), >(Level1Room2SpawnY), >(Level1Room2SpawnY)

Level1Room1SpawnY:
	DB $80, $30, $30, $A0
Level1Room2SpawnY:
	DB $70, $A0, $30, $60
;-------------------
; spawn X nametable
;-------------------
Level1SpawnsXNameTableLow:
	DB <(Level1Room1SpawnXNameTable), <(Level1Room2SpawnXNameTable), <(Level1Room2SpawnXNameTable), <(Level1Room2SpawnXNameTable), <(Level1Room2SpawnXNameTable), <(Level1Room2SpawnXNameTable)
Level1SpawnsXNameTableHi:
	DB >(Level1Room1SpawnXNameTable), >(Level1Room2SpawnXNameTable), >(Level1Room2SpawnXNameTable), >(Level1Room2SpawnXNameTable), >(Level1Room2SpawnXNameTable), >(Level1Room2SpawnXNameTable)

Level1Room1SpawnXNameTable:
	DB $10, $C4, $DA, $86
Level1Room2SpawnXNameTable:
	DB $C6, $90, $D0, $9A
;-------------------
; spawn Y nametable
;-------------------
Level1SpawnsYNameTableLow:
	DB <(Level1Room1SpawnYNameTable), <(Level1Room2SpawnYNameTable), <(Level1Room2SpawnYNameTable), <(Level1Room2SpawnYNameTable), <(Level1Room2SpawnYNameTable), <(Level1Room2SpawnYNameTable)
Level1SpawnsYNameTableHi:
	DB >(Level1Room1SpawnYNameTable), >(Level1Room2SpawnYNameTable), >(Level1Room2SpawnYNameTable), >(Level1Room2SpawnYNameTable), >(Level1Room2SpawnYNameTable), >(Level1Room2SpawnYNameTable)

Level1Room1SpawnYNameTable:
	DB $02, $00, $00, $02
Level1Room2SpawnYNameTable:
	DB $01, $02, $00, $01
;-------------------
; spawn type
;-------------------
Level1SpawnsTypeLowLow:
	DB <(Level1Room1SpawnsTypeLow), <(Level1Room1SpawnsTypeLow), <(Level1Room1SpawnsTypeLow), <(Level1Room1SpawnsTypeLow), <(Level1Room1SpawnsTypeLow), <(Level1Room1SpawnsTypeLow)
Level1SpawnsTypeLowHi:
	DB >(Level1Room1SpawnsTypeLow), >(Level1Room1SpawnsTypeLow), >(Level1Room1SpawnsTypeLow), >(Level1Room1SpawnsTypeLow), >(Level1Room1SpawnsTypeLow), >(Level1Room1SpawnsTypeLow)
Level1SpawnsTypeHiLow:
	DB <(Level1Room1SpawnsTypeHi), <(Level1Room1SpawnsTypeHi), <(Level1Room1SpawnsTypeHi), <(Level1Room1SpawnsTypeHi), <(Level1Room1SpawnsTypeHi), <(Level1Room1SpawnsTypeHi)
Level1SpawnsTypeHiHi:
	DB >(Level1Room1SpawnsTypeHi), >(Level1Room1SpawnsTypeHi), >(Level1Room1SpawnsTypeHi), >(Level1Room1SpawnsTypeHi), >(Level1Room1SpawnsTypeHi), >(Level1Room1SpawnsTypeHi)

Level1Room1SpawnsTypeLow:
	DB <(Level1Room1Spawn1Type), <(Level1Room1Spawn1Type), <(Level1Room1Spawn1Type), <(Level1Room1Spawn1Type)
Level1Room1SpawnsTypeHi:
	DB >(Level1Room1Spawn1Type), >(Level1Room1Spawn1Type), >(Level1Room1Spawn1Type), >(Level1Room1Spawn1Type)

Level1Room1Spawn1Type:
	DB $01, $02, $01, $02, $01, $02, $01, $02, $01, $02
Level1Room2Spawn1Type:
	DB $01, $02, $01, $02, $01, $02, $01, $02, $01, $02
;-------------------
; spawn max enemies
;-------------------
Level1Room1SpawnsMaxEnemiesLow:
	DB <(Level1Room1SpawnsMaxEnemies), <(Level1Room2SpawnsMaxEnemies), <(Level1Room2SpawnsMaxEnemies), <(Level1Room2SpawnsMaxEnemies), <(Level1Room2SpawnsMaxEnemies), <(Level1Room2SpawnsMaxEnemies)
Level1Room1SpawnsMaxEnemiesHi:
	DB >(Level1Room1SpawnsMaxEnemies), >(Level1Room2SpawnsMaxEnemies), >(Level1Room2SpawnsMaxEnemies), >(Level1Room2SpawnsMaxEnemies), >(Level1Room2SpawnsMaxEnemies), >(Level1Room2SpawnsMaxEnemies)

Level1Room1SpawnsMaxEnemies:
	DB $04
Level1Room2SpawnsMaxEnemies:
	DB $06
	