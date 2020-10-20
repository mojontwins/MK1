// MTE MK1 (la Churrera) v6
// Copyleft 2010-2014, 2020 by the Mojon Twins

	sp_player = sp_CreateSpr (sp_MASK_SPRITE, 3, sprites_player);
	sp_AddColSpr (sp_player,  sprites_player + 48);
	sp_AddColSpr (sp_player,  sprites_player + 96);
	p_current_frame = p_next_frame = sprites_player;
