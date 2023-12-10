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

	select_joyfunc ();
}
