;----------------------------------------------------------------
; Graphic resources
;----------------------------------------------------------------
LEVEL_1_BLOCKS:
	INCBIN "level1_blocks.blck"
attributetableLevel1:
	INCBIN "betelgeuse_level1.atr"
LEVEL_2_BLOCKS:
	INCBIN "level2_blocks.blck"
attributetableLevel2:
	INCBIN "betelgeuse_level2.atr"	
LEVEL_3_BLOCKS:
	INCBIN "level3_blocks.blck"
attributetableLevel3:
	INCBIN "betelgeuse_level3.atr"	
LEVEL_4_BLOCKS:
	INCBIN "level4_blocks.blck"
attributetableLevel4:
	INCBIN "betelgeuse_level4.atr"	
LEVEL_5_BLOCKS:
	INCBIN "level5_blocks.blck"
attributetableLevel5:
	INCBIN "betelgeuse_level5.atr"	
LEVEL_6_BLOCKS:
	INCBIN "level6_blocks.blck"
attributetableLevel6:
	INCBIN "betelgeuse_level6.atr"	

TITLE_DATA_INFO_1:
	INCBIN "TITLE_DATA_INFO_1"
TITLE_DATA_INFO_2:
	INCBIN "TITLE_DATA_INFO_2"
TITLE_DATA_INFO_3:
	INCBIN "TITLE_DATA_INFO_3"
TITLE_DATA_INFO_4:
	INCBIN "TITLE_DATA_INFO_4"
attributetableInfo:
	INCBIN "betelgeuse_info.atr"
TITLE_DATA_TITLE_1:
	INCBIN "TITLE_DATA_TITLE_1"
TITLE_DATA_TITLE_2:
	INCBIN "TITLE_DATA_TITLE_2"
TITLE_DATA_TITLE_3:
	INCBIN "TITLE_DATA_TITLE_3"
TITLE_DATA_TITLE_4:
	INCBIN "TITLE_DATA_TITLE_4"
TITLE_DATA_TITLE_5:
	INCBIN "TITLE_DATA_TITLE_5"
attributetableTitle:
	INCBIN "betelgeuse_title.atr"
	
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