// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// 128K stuff

void SetRAMBank(void) {
#asm
	.SetRAMBank
			ld	a, 16
			or	b
			ld	bc, $7ffd
			out (C), a
#endasm
}
/*
// Esto lo empecé pero por ahora lo dejo aparcado :-/
#ifdef MOVE_STUFF_TO_RAM_6
typedef struct {
	int x, y;
	unsigned char x1, y1, x2, y2;
	char mx, my;
	char t;
	unsigned char life;
} MALOTE;

MALOTE malotes [3];
MALOTE *malote_copy;

void ram6_to_ram (void) {
	// This function copies current screen data from RAM 6 to low RAM (new screen)
	#asm
		di
		ld b, 6
		call SetRAMBank
	#endasm
		
	// Map screen
#ifdef UNPACKED_MAP
	map_pointer = 0xc000 + (n_pant * 150);
#else
	map_pointer = 0xc000 + (n_pant * 75);
#endif
	for (gpit = 0; gpit < 150; gpit ++) {
#ifdef UNPACKED_MAP
		// Mapa tipo UNPACKED
		gpd = *map_pointer ++;
		map_buff [gpit] = gpd;
#else
		// Mapa tipo PACKED
		if (!(gpit & 1)) {
			gpc = *map_pointer ++;
			gpd = gpc >> 4;
		} else {
			gpd = gpc & 15;
		}
		map_buff [gpit] = gpd;
#endif	
	}
	
	// Enems
	enoffs = n_pant * 3;
#ifdef UNPACKED_MAP
	map_pointer = 0xc000 + MAP_W * MAP_H * 150 + 12 * enoffs;
#else
	map_pointer = 0xc000 + MAP_W * MAP_H * 75 + 12 * enoffs;
#endif
	malote_copy = malotes;
	for (gpit = 0; gpit < 36; gpit ++) {
		*malote_copy ++ = *map_pointer ++;
	}	
	enoffs = 0;

	// Hotspots
	// Bolts
	
	// Get back
	#asm
		di
		ld b, 0
		call SetRAMBank
	#endasm
}

void ram_to_ram6 (void) {
	// This function copies current screen data from low RAM to RAM 6 (update)
	#asm
		di
		ld b, 6
		call SetRAMBank
	#endasm
	
	// Enems
	// Hotspots
	// Bolts
	
	// Get back
	#asm
		di
		ld b, 0
		call SetRAMBank
	#endasm
}
#endif
*/