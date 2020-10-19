// MTE MK1 (la Churrera) v6
// Copyleft 2010-2014, 2020 by the Mojon Twins

for (gpit = 0; gpit < MAX_ENEMS; gpit ++) {
	sp_moviles [gpit] = sp_CreateSpr(sp_MASK_SPRITE, 3, sprite_9_a);
	sp_AddColSpr (sp_moviles [gpit], sprite_9_b);
	sp_AddColSpr (sp_moviles [gpit], sprite_9_c);	
	en_an_current_frame [gpit] = en_an_next_frame [gpit] = sprite_9_a;
}
