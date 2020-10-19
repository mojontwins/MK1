// MTE MK1 (la Churrera) v6
// Copyleft 2010-2014, 2020 by the Mojon Twins

// 48K Generic ISR

// isr
#asm
	defw 0	// 2 bytes libres
#endasm

void ISR(void) {	
	++ isrc;
}
