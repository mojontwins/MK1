// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

if (n_pant == 0 && flags [1] == 0 && gpy < 96 && p_objs == 5) {
	flags [1] = 1;

	// Animation
	_gp_gen = decos_bombs;
	for (gpit = 0; gpit < 5; ++ gpit) {
		rda = *_gp_gen; _gp_gen += 2;
		_x = rda >> 4; _y = rda & 15; _t = 17;
		update_tile ();
		sp_UpdateNow ();
		beep_fx (0);
	}

	_x = 1; _y = 0; _t = 71; 
	_gp_gen = (unsigned char *) ("  DONE! NOW GO BACK TO BASE!  ");
	print_str ();
}

if (flags [0]) {
	if (gpx < 64 && gpy >= 16 && gpy < 80) {
		flags [0] = 0;
		beep_fx (9);
		_x = 1; _y = 0; _t = 71; 
		_gp_gen = (unsigned char *) (" HALF NEW MOTORBIKE FOR SALE! ");
		print_str ();
	}
}

#ifdef CHEAT
	if (sp_KeyPressed (KEY_M) && sp_KeyPressed (KEY_Z)) { 
		o_pant = 99; n_pant = 23; flags [1] = 1;
	}
#endif
