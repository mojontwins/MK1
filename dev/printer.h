// Churrera Engine
// ===============
// Copyleft 2010, 2011 by The Mojon Twins

// printer.h
// Miscellaneous printing functions (tiles, status, etc).

void draw_rectangle (unsigned char x1, unsigned char y1, unsigned char x2, unsigned char y2, unsigned char c) {
	unsigned char i, j;
	for (i = y1; i <= y2; i ++)
		for (j = x1; j <= x2; j ++)
			sp_PrintAtInv (i, j, c, 0);	
}

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
// Draw unpacked tile

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
// Draw packed tile (with special effects)

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
	if (attr (xx, yy) < 8 && (t < 16 || t == 19)) {
		t = 64 + (t << 2);
		pointer = (unsigned char *) &tileset [2048 + t];
		sp_PrintAtInv (y, x, attr (xx - 1, yy - 1) == 8 ? (pointer[0] & 7)-1 : pointer [0], t);
		sp_PrintAtInv (y, x + 1, attr (xx, yy - 1) == 8 ? (pointer[1] & 7)-1 : pointer [1], t + 1);
		sp_PrintAtInv (y + 1, x, attr (xx - 1, yy) == 8 ? (pointer[2] & 7)-1 : pointer [2], t + 2);
		sp_PrintAtInv (y + 1, x + 1, pointer [3], t + 3);
	} else {
#endif

#ifdef USE_AUTO_TILE_SHADOWS
	xx = (x - VIEWPORT_X) >> 1;
	yy = (y - VIEWPORT_Y) >> 1;	
	if (attr (xx, yy) < 4 && (t < 16 || t == 19)) {
		t = 64 + (t << 2);
		if (t == 140) {
			pointer = (unsigned char *) &tileset [2188];
			t_alt = 192;
			pointer_alt = (unsigned char *) &tileset [2188];
		} else {
			pointer = (unsigned char *) &tileset [2048 + t];
			t_alt = 128 + t;
			pointer_alt = (unsigned char *) &tileset [2048 + t + 128];
		}
		
		if (attr (xx - 1, yy - 1) >= 4) {
			sp_PrintAtInv (y, x, pointer_alt [0], t_alt);
		} else {
			sp_PrintAtInv (y, x, pointer [0], t);
		}
		if (attr (xx, yy - 1) >= 4) {
			sp_PrintAtInv (y, x + 1, pointer_alt [1], t_alt + 1);
		} else {
			sp_PrintAtInv (y, x + 1, pointer [1], t + 1);
		}
		if (attr (xx - 1, yy) >= 4) {
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

void draw_2_digits (unsigned char x, unsigned char y, unsigned char value) {
	sp_PrintAtInv (y, x, 71, 16 + (value % 100) / 10);
	sp_PrintAtInv (y, 1 + x, 71, 16 + value % 10);
}

#ifdef USE_COINS
void draw_coins () {
	draw_2_digits (COINS_X, COINS_Y, flags [COIN_FLAG]);
}
#endif

#ifndef DEACTIVATE_EVIL_ZONE
void draw_evil_zone_gauge () {
	unsigned char val = EVIL_ZONE_BEEPS_COUNT - player.killingzone_beepcount;
	draw_2_digits (EVIL_GAUGE_X, EVIL_GAUGE_Y, val);
}
#endif

#ifdef PLAYER_SHOW_ITEM
void draw_item () {
	draw_coloured_tile (ITEM_SHOW_X, ITEM_SHOW_Y, ITEM_FIRST_TILE + flags [ITEM_IN_FLAG] - 1);
}
#endif

void draw_life () {
	unsigned char i;
	if (player.life > 0) i = (unsigned char) player.life; else i = 0;
#ifdef DRAW_HI_DIGIT
	sp_PrintAtInv (LIFE_H_Y, LIFE_H_X, 71, 16 + i / 100);
#endif
	draw_2_digits (LIFE_X, LIFE_Y, i);
}

// This is a patch for this game
#ifndef DEACTIVATE_OBJECTS
void draw_objs () {
#ifdef ONLY_ONE_OBJECT
	if (player.objs) {
		sp_PrintAtInv (OBJECTS_ICON_Y, OBJECTS_ICON_X, 135, 132);
		sp_PrintAtInv (OBJECTS_ICON_Y, OBJECTS_ICON_X + 1, 135, 133);
		sp_PrintAtInv (OBJECTS_ICON_Y + 1, OBJECTS_ICON_X, 135, 134);
		sp_PrintAtInv (OBJECTS_ICON_Y + 1, OBJECTS_ICON_X + 1, 135, 135);
	} else {
		draw_coloured_tile (OBJECTS_ICON_X, OBJECTS_ICON_Y, 17);
	}
	draw_2_digits (OBJECTS_X, OBJECTS_Y, flags [OBJECT_COUNT]);
#else
	draw_2_digits (OBJECTS_X, OBJECTS_Y, player.objs);
#endif
}
#endif

#ifndef DEACTIVATE_KEYS
void draw_keys () {
	draw_2_digits (KEYS_X, KEYS_Y, player.keys);
}
#endif

#if defined (PLAYER_KILLS_ENEMIES) || defined (PLAYER_CAN_FIRE)
void draw_killed () {
	draw_2_digits (KILLED_X, KILLED_Y, player.killed);
}
#endif

void draw_text (unsigned char x, unsigned char y, unsigned char c, char *s) {
	unsigned char m;
	while (*s) {
		m = (*s) - 32;
		sp_PrintAtInv (y, x ++, c, m);
		s ++;
	}
}
