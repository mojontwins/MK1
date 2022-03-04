// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// For all screens

// Precalc this address which will be used with broken tile 
// persistence.

c_screen_address = mapa + n_pant * 75;

// General text

if (flags [1]) {
	#ifdef LANG_ES
		_gp_gen = (unsigned char *) ("BOMBAS PUESTAS! VUELVE A BASE!");
	#else
		_gp_gen = (unsigned char *) ("BOMBS ARE SET! RETURN TO BASE!");
	#endif
} else {
	#ifdef LANG_ES
		_gp_gen = (unsigned char *) ("PON 5 BOMBAS EN LA COMPUTADORA");	
	#else
		_gp_gen = (unsigned char *) (" SET 5 BOMBS IN EVIL COMPUTER");	
	#endif
}
_x = 1; _y = 0; _t = 71;
print_str ();

// Screen 0: Paint computer / bomb & message

if (n_pant == 0) {
	_gp_gen = decos_computer; draw_decorations ();

	if (flags [1]) {
		_gp_gen = decos_bombs; draw_decorations ();
	} else {
		#ifdef LANG_ES
			_gp_gen = (unsigned char *) (" PON LAS 5 BOMBAS!  RAPIDO! ");
		#else
			_gp_gen = (unsigned char *) (" SET BOMBS IN EVIL COMPUTER ");
		#endif
		_x = 1; _y = 0; _t = 71;
		print_str ();
	}
}

// Half new motorcycle for sale

if (n_pant == 21 && level == 0) {
	_gp_gen = decos_moto; draw_decorations ();
	flags [0] = 1;
}

// Ending condition

if (n_pant == 23 && flags [1]) {
	beep_fx (0);
	success = 1;
	playing = 0;
}
