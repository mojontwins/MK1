// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Pantallas.h
// Carga las pantallas fijas
// Copyleft 2010 The Mojon Twins

#ifndef MODE_128K
	extern unsigned char s_title [];
	extern unsigned char s_marco [];
	extern unsigned char s_ending [];

	#asm
		._s_title
			BINARY "title.bin"
		._s_marco
	#endasm
	#ifndef DIRECT_TO_PLAY
		#asm
				BINARY "marco.bin"
		#endasm
	#endif
	#asm
		._s_ending
			BINARY "ending.bin"
	#endasm
#endif

void blackout (void) {
	#asm
		ld hl, 22528
		ld (hl), 0
		push hl
		pop de
		inc de
		ld bc, 767
		ldir
	#endasm
}
