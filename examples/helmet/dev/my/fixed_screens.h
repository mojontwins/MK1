// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

void validate (void) {
	clear_sprites ();
	#asm
		LIB SPValidate
		ld  c, VIEWPORT_X
		ld  b, VIEWPORT_Y
		ld  d, VIEWPORT_Y+19
		ld  e, VIEWPORT_X+29
		ld  iy, fsClipStruct
		call SPValidate
	#endasm
}

#ifndef MODE_128K
	void lame_sound (void) {
		gpit = 4; do {
			beep_fx (rda);
			beep_fx (rdb);
		} while (-- gpit);
		beep_fx (9);
	}
#endif

void game_ending (void) {
	sp_UpdateNow();
	blackout ();
	#ifdef MODE_128K
		// Resource 2 = ending
		get_resource (ENDING_BIN, 16384);
	#else
		#asm
			ld hl, _s_ending
			ld de, 16384
			call depack
		#endasm
	#endif

	// Custom for Helmet
	#ifdef LANG_ES
		_x = 10; _y = 7; _t = 70; _gp_gen = (unsigned char *) ("ENHORABUENA!"); print_str ();
		_x = 2; _y = 9; _t = 71; _gp_gen = (unsigned char *) ("CONSEGUISTE PONER LAS BOMBAS"); print_str ();
		_x = 4; _y = 10;         _gp_gen = (unsigned char *) ("Y DESTRUIR EL ORDENADOR!"); print_str ();
		_x = 8; _y = 11;         _gp_gen = (unsigned char *) ("MISION CUMPLIDA!!"); print_str ();
	#else
		_x = 8; _y = 7; _t = 70; _gp_gen = (unsigned char *) ("CONGRATULATIONS!"); print_str ();
		_x = 2; _y = 9; _t = 71; _gp_gen = (unsigned char *) ("YOU MANAGED TO SET THE BOMBS"); print_str ();
		_x = 4; _y = 10;         _gp_gen = (unsigned char *) ("AND DESTROY THE COMPUTER"); print_str ();
		_x = 5; _y = 11;         _gp_gen = (unsigned char *) ("MISSION ACCOMPLISHED!!"); print_str ();
	#endif
	sp_UpdateNowEx (0);
	
	#ifdef MODE_128K
	#else
		rda = 7; rdb = 2;
		lame_sound ();		
	#endif

	espera_activa (5000);
}

void dr (void) {
	_x = 10; _y = 11; _t = 79; _gp_gen = spacer; print_str ();
	_x = 10; _y = 12;          _gp_gen = gen_pt; print_str ();
	_x = 10; _y = 13;          _gp_gen = spacer; print_str ();
	sp_UpdateNowEx (0);
}

void game_over (void) {
	// Custom for helmet
	validate ();
	gen_pt = (unsigned char *) (" GAME UNDER "); dr ();

	#ifdef MODE_128K
	#else
		rda = 7; rdb = 2;
		lame_sound ();
	#endif

	if (level > 0) {
		// Continue!
		_x = 10; _y = 15; _t = 79; _gp_gen = spacer; print_str ();
		#ifdef LANG_ES
			_x = 10; _y = 16;        ; _gp_gen = (unsigned char *)(" CONTINUAR? "); print_str ();
			_x = 10; _y = 17;        ; _gp_gen = (unsigned char *)(" 1-SI  2-NO "); print_str ();			
		#else
			_x = 10; _y = 16;        ; _gp_gen = (unsigned char *)("  CONTINUE  "); print_str ();
			_x = 10; _y = 17;        ; _gp_gen = (unsigned char *)(" 1-YES 2-NO "); print_str ();
		#endif
		_x = 10; _y = 18;        ; _gp_gen = spacer; print_str ();
		sp_UpdateNow ();

		while (1) {
			gpit = sp_GetKey ();
			if (gpit == '1') {
				current_level = level;
				do_continue = 1;
				break;
			}
			if (gpit == '2') break;
		}
	}	
}

#if defined(TIMER_ENABLE) && defined(SHOW_TIMER_OVER)
	void time_over (void) {
		_x = 10; _y = 11; _t = 79; _gp_gen = spacer; print_str ();
		_x = 10; _y = 12; _t = 79; _gp_gen = (unsigned char *)(" TIME'S UP! "); print_str ();
		_x = 10; _y = 13; _t = 79; _gp_gen = spacer; print_str ();
		sp_UpdateNowEx (0);
			
		#ifdef MODE_128K
		#else
			rda = 1; rdb = 2;
		lame_sound ();
		#endif
		
		espera_activa (250);
	}
#endif

#ifdef PAUSE_ABORT
	void pause_screen (void) {
		gen_pt = (unsigned char *) ("   PAUSED   "); dr ();
	}
#endif

#ifdef COMPRESSED_LEVELS
	void zone_clear (void) {
		validate ();
		#ifdef LANG_ES
			gen_pt = (unsigned char *) (" BIEN HECHO "); dr ();		
		#else
			gen_pt = (unsigned char *) (" ZONE CLEAR "); dr ();
		#endif
		espera_activa (250);			
	}
#endif
