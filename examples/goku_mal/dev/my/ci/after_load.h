// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

	// Splash screens

	sp_UpdateNow ();	// Clear buffer

	for (gpit = 0; gpit < 3; ++ gpit) {
		get_resource (splash_screens [gpit], 16384);
		espera_activa (500);
		wyz_play_sound (1);
		cortina ();
		blackout ();
	}

	// Select lang

	_x = 11; _y = 11; _t = 71; _gp_gen = "1. ENGLISH"; print_str ();
	_x = 11; _y = 12; _t = 71; _gp_gen = "2. SPANISH"; print_str ();
	sp_UpdateNow ();

	while (lang == 99) {
		gpjt = sp_GetKey ();
		if (gpjt == '1' || gpjt == '2') lang = gpjt - '1';
	}
	cortina ();
