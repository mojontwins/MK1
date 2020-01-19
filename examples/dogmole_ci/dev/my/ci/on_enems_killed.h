// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// my/ci/on_enems_killed.h

if (p_killed == N_ENEMS_TYPE_3) {
	flags [3] = 1;

	// Print message
	_t = 79;
	_x = 8; _y = 10; _gp_gen = my_spacer;  print_str ();
	_x = 8; _y = 12;                       print_str ();
	_x = 8; _y = 11; _gp_gen = my_message; print_str ();

	sp_UpdateNowEx (0);

	// Wait
	espera_activa (150);

	// Force reenter
	o_pant = 99;
}
