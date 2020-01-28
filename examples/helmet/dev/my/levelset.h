// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// levelset.h

// Contains this game's level sequence.
// Format is different for 128K games (using level bundles)
// and 48 games (using separate assets).

#ifdef MODE_128K
	// 128K format:
	typedef struct {
		unsigned char resource_id;
		unsigned char music_id;
		unsigned int script_offset;
	} LEVEL;
#else
	// 48K format:
	typedef struct {
		unsigned char map_w, map_h;
		unsigned char scr_ini, ini_x, ini_y;
		unsigned char max_objs;
		unsigned char *c_map_bolts;
		unsigned char *c_tileset;
		unsigned char *c_enems_hotspots;
		unsigned char *c_behs;
		#ifdef PER_LEVEL_SPRITESET
			unsigned char *c_sprites;
		#endif
		#ifdef ACTIVATE_SCRIPTING
			unsigned int script_offset;
		#endif
	} LEVEL;
#endif

// In 48K mode, include here your compressed binaries:

extern unsigned char map_bolts_0 [0];
extern unsigned char map_bolts_1 [0];
extern unsigned char map_bolts_2 [0];
extern unsigned char tileset_0 [0];
extern unsigned char tileset_1 [0];
extern unsigned char tileset_2 [0];
extern unsigned char enems_hotspots_0 [0];
extern unsigned char enems_hotspots_1 [0];
extern unsigned char enems_hotspots_2 [0];
extern unsigned char behs_0_1 [0];
extern unsigned char behs_2 [0];

#asm
	._map_bolts_0
		BINARY "../bin/mapa_bolts0c.bin"
	._map_bolts_1
		BINARY "../bin/mapa_bolts1c.bin"
	._map_bolts_2
		BINARY "../bin/mapa_bolts2c.bin"
	._tileset_0
		BINARY "../bin/tileset0c.bin"
	._tileset_1
		BINARY "../bin/tileset1c.bin"
	._tileset_2
		BINARY "../bin/tileset2c.bin"
	._enems_hotspots_0
		BINARY "../bin/enems_hotspots0c.bin"
	._enems_hotspots_1
		BINARY "../bin/enems_hotspots1c.bin"
	._enems_hotspots_2
		BINARY "../bin/enems_hotspots2c.bin"
	._behs_0_1
		BINARY "../bin/behs0_1c.bin"
	._behs_2
		BINARY "../bin/behs2c.bin"
#endasm

// Define your level sequence array here:
// map_w, map_h, scr_ini, ini_x, ini_y, max_objs, c_map_bolts, c_tileset, c_enems_hotspots, c_behs, script
LEVEL levels [] = {
	{ 1, 24, 23, 12, 7, 99, map_bolts_0, tileset_0, enems_hotspots_0, behs_0_1 },
	{ 1, 24, 23, 12, 7, 99, map_bolts_1, tileset_1, enems_hotspots_1, behs_0_1 },
	{ 1, 24, 23, 6, 8, 99, map_bolts_2, tileset_2, enems_hotspots_2, behs_2 }
};
