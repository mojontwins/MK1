// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// This code is used to display the "new level" screen. You can customize it for your game:

{
	// Show cutscenes at the beginning of levels 0 and 3

	if (level == 0) {		
		do_cutscene (0, 3, 1);
	} else if (level == 3) {
		do_cutscene (4, 4, 1);
	}

	// Show new level screen (customized)

	// Unpack tileset
	get_resource (LEVEL_SCREEN_TSC_BIN, (unsigned int) (tileset));

	// Show zone screen
	sp_UpdateNow ();
	blackout ();
	get_resource (level ? ZONEB_BIN : ZONEA_BIN, 16384);

	// Show password
	if (level) {
		_x = 7; _y = 18; _t = 70; _gp_gen = " PASSWORD "; print_str ();
		_gp_gen = passwords + ((level - 1) * PASSWORD_LENGTH);
		gpx = 9; for (gpit = 0; gpit < PASSWORD_LENGTH; ++ gpit) {
			#asm
					ld  hl, (__gp_gen)
					ld  a, (hl)
					sub 32
					inc hl
					ld  (__gp_gen), hl
					ld  e, a
					
					ld  d, 70
					
					ld  a, (_gpx)
					ld  c, a
					inc a 
					ld  (_gpx), a
					
					ld  a, 19

					call SPPrintAtInv
			#endasm
		}
	}

	// Show big number
	map_pointer = level * 54 + levelnumbers;
	for (gpy = 16; gpy < 22; ++ gpy) {
		for (gpx = 22; gpx < 31; ++ gpx) {
			#asm
					ld  hl, (_map_pointer)
					ld  a, (hl)
					inc hl
					ld  (_map_pointer), hl
					ld  e, a
					
					ld  d, 71
					
					ld  a, (_gpx)
					ld  c, a
					
					ld  a, (_gpy)

					call SPPrintAtInv
			#endasm
		}
	}

	sp_UpdateNow ();
	wyz_play_music (2);
	espera_activa (250);
	wyz_stop_sound ();
}
