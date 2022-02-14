;----------------------------------------------------------------
; Graphic resources
;----------------------------------------------------------------
nametableTitle:
	INCBIN "betelgeuse_title.nam"
attributetableTitle:
	INCBIN "betelgeuse_title.atr"

nametableLevel1:
	INCBIN "betelgeuse_level1.nam"
attributetableLevel1:
	INCBIN "betelgeuse_level1.atr"
	
nametableInfo:
	INCBIN "betelgeuse_info.nam"
attributetableInfo:
	INCBIN "betelgeuse_info.atr"
	
paletteTitleBG:
	INCBIN "betelgeuse_title.pal"
paletteSprites:
	INCBIN "betelgeuse_sprite.pal"
paletteLevel:
	INCBIN "betelgeuse_level.pal"
paletteInfo:
	INCBIN "betelgeuse_info.pal"
paletteBlack:
	INCBIN "black.pal"
sprites:
	   ;vert tile attr horiz
	DB $50, $04, $00, $70	;sprite 0
	DB $50, $05, $00, $78	;sprite 1