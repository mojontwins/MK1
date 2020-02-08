// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Partial cortina (looks better)

void cortina2 (void) {
	#asm
			ld	hl, 22528+32
			ld  de, 22528+33
			ld  bc, 768-97
			xor a
			ld  (hl), a
			ldir
	#endasm
}

// Just waits n frames

void halts_delay (unsigned char n) {
	while (n --) {
		#asm
			halt
		#endasm
	}
}

// Simple password checker.

// Variables in extra_vers.h

unsigned char check_password (void) {
	wyz_play_sound (SFX_START);

	_x = MENU_X; _y = MENU_Y    ; _t = 7; _gp_gen = " PASSWORD "; print_str ();
	_x = MENU_X; _y = MENU_Y + 1;       ; _gp_gen = "          "; print_str ();
	_x = MENU_X; _y = MENU_Y + 2;       ;                         print_str ();

	for (gpit = 0; gpit < PASSWORD_LENGTH; ++ gpit) password [gpit] = '.';
	password [PASSWORD_LENGTH] = ' ';

	gpit = 0;
	sp_WaitForNoKey ();
	_y = MENU_Y + 2; _t = 71; _gp_gen = password;
	while (1) {
		password [gpit] = '*';
		_x = 16 - PASSWORD_LENGTH / 2; print_str ();
		sp_UpdateNow ();
		
		do {
			gpjt = sp_GetKey ();
		} while (gpjt == 0);

		if (gpjt == 12 && gpit > 0) {
			password [gpit] = gpit == PASSWORD_LENGTH ? ' ' : '.';
			-- gpit;
		} else if (gpjt == 13) break;
		else if (gpjt > 'Z') gpjt -=32;

		if (gpjt >= 'A' && gpjt <= 'Z' && gpit < PASSWORD_LENGTH) {
			password [gpit] = gpjt; ++gpit;
		}

		wyz_play_sound (1);
		sp_WaitForNoKey ();
	}

	sp_WaitForNoKey ();

	// Check password
	_gp_gen = passwords;

	for (gpit = 0; gpit < MAX_LEVELS - 1; ++ gpit) {
		rda = 1; for (gpjt = 0; gpjt < PASSWORD_LENGTH; ++ gpjt) {
			if (password [gpjt] != *_gp_gen ++) rda = 0;
		}

		if (rda) return (1 + gpit);
	}

	return 0;
}

// Simple intro/cutscene generator.

// do_intro takes two parameters: first and last intro text portion to show.
// each text portion is a string (@ within a string is a line break) and is
// printed alongside a picture stored in the resource library.
// Text portion N will show picture BASE_PIC_RESOURCE + N.

// Variables in extra_vars.h

void show_intro_text () {
	introx = INTRO_X;
	introy = INTRO_Y;
	stepbystep = 1;
	while (rda = *_gp_gen) { ++ _gp_gen;
		
		if (rda != '@') {
			#asm
					ld  a, (_rda)
					sub 32
					ld  e, a

					ld  a, (_introx)
					ld  c, a
					inc a
					ld  (_introx), a

					ld  a, (_introy)

					ld  d, INTRO_TEXT_COLOUR

					call SPPrintAtInv
			#endasm
		}

		if (stepbystep) {
			#asm
				halt
				halt
				halt
				halt
			#endasm
			sp_UpdateNow ();
			#asm
				xor a
				in a, (254)
				cpl
				and 31
				jr z, _dafuq
			#endasm
			stepbystep = 0;
			#asm
				._dafuq
			#endasm
		}
		if (rda == '@') {introy += 2; introx = INTRO_X;}
	}
	if (!stepbystep) sp_UpdateNow ();
}

void do_cutscene (unsigned char ini, unsigned char fin, unsigned char music) {
	blackout_area ();
	text_offs = lang ? LANG_TEXT_OFFS : 0;
	wyz_play_music (music);
	for (intro_iterator = ini; intro_iterator <= fin; intro_iterator ++) {
		sp_UpdateNow ();
		get_resource (pic_resource [intro_iterator], 16384);
		_gp_gen = intro_texts [intro_iterator + text_offs]; show_intro_text ();
		espera_activa (SCREEN_WAIT);
		cortina2 ();
		sp_WaitForNoKey ();
	}
	wyz_stop_sound ();
}
