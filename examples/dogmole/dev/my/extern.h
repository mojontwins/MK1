// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// External custom code to be run from a script

// Dogmole Tuppowski - Print a simple message when all monks are dead

unsigned char *my_spacer = "                ";
unsigned char *my_message = " PUERTA ABIERTA ";

void do_extern_action (unsigned char n) {
	// Add custom code here.

	// Discard n, we don't need it. There's only one action to perform

	// Print message
	_x = 8; _y = 10; _gp_gen = my_spacer;  print_str ();
	        _y = 12;                       print_str ();
	        _y = 11; _gp_gen = my_message; print_str ();

	sp_UpdateNow ();

	// Wait
	espera_activa (150);

	// Force reenter
	o_pant = 99;
}
