// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

// Very simple ISR which counts frames.

#asm
	defw 0	// 2 bytes libres
#endasm

void ISR (void) {	
	#asm
			ld  hl, _isrc
			inc (hl)
	#endasm
}
