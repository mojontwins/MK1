// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

// You can change this function. To set level to anything different than 0.

{
	sp_UpdateNow ();
	blackout ();
	
	#ifdef MODE_128K
		get_resource (TITLE_BIN, 16384);
		PLAY_MUSIC (0);
	#else		
		#asm
			ld hl, _s_title
			ld de, 16384
			call depack
		#endasm
	#endif

	_x = 11; _y = 15; _t = 71; _gp_gen = (unsigned char *) "1.POQA"; print_str ();
	_x = 11; _y = 16; _t = 71; _gp_gen = (unsigned char *) "2.KEMPSTON"; print_str ();
	_x = 11; _y = 17; _t = 71; _gp_gen = (unsigned char *) "3.SINCLAIR"; print_str ();
	sp_UpdateNow ();

	select_joyfunc ();
}
