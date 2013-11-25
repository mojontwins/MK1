// Pantallas.h
// Carga las pantallas fijas
// Copyleft 2010 The Mojon Twins

extern unsigned char s_title [];
extern unsigned char s_marco [];
extern unsigned char s_ending [];

#asm
	._s_title
		BINARY "title.bin"
	._s_marco
		BINARY "marco.bin"
	._s_ending
		BINARY "ending.bin"
#endasm

void unpack (unsigned int address) {
	asm_int [0] = address;
	
	#asm
		ld hl, (_asm_int)
		ld de, 16384
		call depack
	#endasm
}
