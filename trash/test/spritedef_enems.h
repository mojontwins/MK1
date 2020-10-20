// MTE MK1 (la Churrera) v6
// Copyleft 2010-2014, 2020 by the Mojon Twins

	sp_moviles [gpit] = sp_CreateSpr (sp_MASK_SPRITE, 3, sprites_enems);
	sp_AddColSpr (sp_moviles [gpit],  sprites_enems + 0);
	sp_AddColSpr (sp_moviles [gpit],  sprites_enems + 48);
	en_an_current_frame [gpit] = en_an_next_frame [gpit] = sprites_enems;
}
