// MTE MK1 (la Churrera) v6
// Copyleft 2010-2014, 2020 by the Mojon Twins

for (gpit = 0; gpit < MAX_ENEMS; gpit ++) {
	sp_moviles [gpit] = sp_CreateSpr (sp_MASK_SPRITE, 3, sprites_enems);
	sp_AddColSpr (sp_moviles [gpit],  sprites_enems + 48);
	sp_AddColSpr (sp_moviles [gpit],  sprites_enems + 96);
	en_an_current_frame [gpit] = en_an_next_frame [gpit] = sprites_enems;
}
