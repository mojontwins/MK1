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
		#ifdef ACTIVATE_SCRIPTING
			unsigned int script_offset;
		#endif
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

#ifndef MODE_128K
	extern unsigned char my_binary [0];

	#asm
		._my_binary
			BINARY "../bin/my_binary.bin"	
	#endasm
#endif

// Define your level sequence array here:
// map_w, map_h, scr_ini, ini_x, ini_y, max_objs, c_map_bolts, c_tileset, c_enems_hotspots, c_behs, script
LEVEL levels [] = {
	
};
