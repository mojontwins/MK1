// Printing functions

void attr (char x, char y) {
	// x + 15 * y = x + (16 - 1) * y = x + 16 * y - y = x + (y << 4) - y.
#ifdef PLAYER_AUTO_CHANGE_SCREEN
	if (x < 0 || y < 0 || x > 14 || y > 9) return 0;
#else
	if (x < 0 || y < 0) return 8;
#endif
	return map_attr [x + (y << 4) - y];	
}

void qtile (unsigned char x, unsigned char y) {
	// x + 15 * y = x + (16 - 1) * y = x + 16 * y - y = x + (y << 4) - y.
	return map_buff [x + (y << 4) - y];	
}

#ifdef UNPACKED_MAP
// Función que pinta un tile para mapas unpacked

void draw_coloured_tile (unsigned char x, unsigned char y, unsigned char t) {
	unsigned char *pointer;
	unsigned char xx, yy;
	t = 64 + (t << 2);
	pointer = (unsigned char *) &tileset [2048 + t];
	sp_PrintAtInv (y, x, pointer [0], t);
	sp_PrintAtInv (y, x + 1, pointer [1], t + 1);
	sp_PrintAtInv (y + 1, x, pointer [2], t + 2);
	sp_PrintAtInv (y + 1, x + 1, pointer [3], t + 3);	
}

#else
// Función que pinta un tile para mapas packed

void draw_coloured_tile (unsigned char x, unsigned char y, unsigned char t) {
	unsigned char *pointer;
	unsigned char xx, yy;
#ifdef USE_AUTO_TILE_SHADOWS
	unsigned char *pointer_alt;
	unsigned char t_alt;
#endif
	
#ifdef USE_AUTO_SHADOWS
	xx = (x - VIEWPORT_X) >> 1;
	yy = (y - VIEWPORT_Y) >> 1;	
	if (!(attr (xx, yy) & 8) && (t < 16 || t == 19)) {
		t = 64 + (t << 2);
		pointer = (unsigned char *) &tileset [2048 + t];
		sp_PrintAtInv (y, x, attr (xx - 1, yy - 1) & 8 ? (pointer[0] & 7)-1 : pointer [0], t);
		sp_PrintAtInv (y, x + 1, attr (xx, yy - 1) & 8 ? (pointer[1] & 7)-1 : pointer [1], t + 1);
		sp_PrintAtInv (y + 1, x, attr (xx - 1, yy) & 8 ? (pointer[2] & 7)-1 : pointer [2], t + 2);
		sp_PrintAtInv (y + 1, x + 1, pointer [3], t + 3);
	} else {
#endif

#ifdef USE_AUTO_TILE_SHADOWS
	xx = (x - VIEWPORT_X) >> 1;
	yy = (y - VIEWPORT_Y) >> 1;	
	if (!(attr (xx, yy) & 8) && (t < 16 || t == 19)) {
		t = 64 + (t << 2);
		if (t == 140) {
			pointer = (unsigned char *) &tileset [2188];
			t_alt = 192;
			pointer_alt = (unsigned char *) &tileset [2048 + 192];
		} else {
			pointer = (unsigned char *) &tileset [2048 + t];
			t_alt = 128 + t;
			pointer_alt = (unsigned char *) &tileset [2048 + t + 128];
		}
		
		if (attr (xx - 1, yy - 1) & 8) {
			sp_PrintAtInv (y, x, pointer_alt [0], t_alt);
		} else {
			sp_PrintAtInv (y, x, pointer [0], t);
		}
		if (attr (xx, yy - 1) & 8) {
			sp_PrintAtInv (y, x + 1, pointer_alt [1], t_alt + 1);
		} else {
			sp_PrintAtInv (y, x + 1, pointer [1], t + 1);
		}
		if (attr (xx - 1, yy) & 8) {
			sp_PrintAtInv (y + 1, x, pointer_alt [2], t_alt + 2);
		} else {
			sp_PrintAtInv (y + 1, x, pointer [2], t + 2);
		} 
		sp_PrintAtInv (y + 1, x + 1, pointer [3], t + 3);
	} else {
#endif
		t = 64 + (t << 2);
		pointer = (unsigned char *) &tileset [2048 + t];
		sp_PrintAtInv (y, x, pointer [0], t);
		sp_PrintAtInv (y, x + 1, pointer [1], t + 1);
		sp_PrintAtInv (y + 1, x, pointer [2], t + 2);
		sp_PrintAtInv (y + 1, x + 1, pointer [3], t + 3);
#ifdef USE_AUTO_SHADOWS
	}
#endif

#ifdef USE_AUTO_TILE_SHADOWS
	}
#endif
}
#endif

void print_number2 (unsigned char x, unsigned char y, unsigned char number) {
	sp_PrintAtInv (y, x, 7, 16 + (number / 10));
	sp_PrintAtInv (y, x + 1, 7, 16 + (number % 10));
}

#ifndef DEACTIVATE_OBJECTS
void draw_objs () {
#if defined(ONLY_ONE_OBJECT) && defined(ACTIVATE_SCRIPTING)
	if (player.objs) {
		sp_PrintAtInv (OBJECTS_ICON_Y, OBJECTS_ICON_X, 135, 132);
		sp_PrintAtInv (OBJECTS_ICON_Y, OBJECTS_ICON_X + 1, 135, 133);
		sp_PrintAtInv (OBJECTS_ICON_Y + 1, OBJECTS_ICON_X, 135, 134);
		sp_PrintAtInv (OBJECTS_ICON_Y + 1, OBJECTS_ICON_X + 1, 135, 135);
	} else {
		draw_coloured_tile (OBJECTS_ICON_X, OBJECTS_ICON_Y, 17);
	}
	print_number2 (OBJECTS_X, OBJECTS_Y, flags [OBJECT_COUNT]);
#else
	print_number2 (OBJECTS_X, OBJECTS_Y, player.objs);
#endif
}
#endif

void print_str (unsigned char x, unsigned char y, unsigned char c, unsigned char *s) {
	while (*s)	{
		sp_PrintAtInv (y, x ++, c, (*s ++) - 32);
	}
}

#ifdef COMPRESSED_LEVELS
void blackout_area (void) {
	// blackens gameplay area for LEVEL XX display
	asm_int [0] = 22528 + 32 * VIEWPORT_Y + VIEWPORT_X;
	#asm
		ld	hl, _asm_int
		ld	a, (hl)
		ld	e, a
		inc	hl
		ld	a, (hl)
		ld	d, a
		
		ld b, 20
	.bal1
		push bc
		push de
		pop hl
		ld	(hl), 0
		inc de
		ld bc, 29
		ldir
		inc de
		inc de
		pop bc
		djnz bal1	
	#endasm
}
#endif
