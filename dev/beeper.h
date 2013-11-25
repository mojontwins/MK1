// Beeper.h
// Carga las rutinas de beeper y las lanza
// Copyleft 2010 The Mojon Twins

extern unsigned char beeper [];

#asm
	._beeper
		BINARY "beeper.bin"
#endasm

void peta_el_beeper (unsigned char n) {
	#asm
		xor a
		ld (23624), a
	#endasm
	switch (n) {
		case 0:
			#asm
				call _beeper
			#endasm
			break;
		case 1:
			#asm
				call _beeper + 50
			#endasm
			break;
		case 2:
			#asm
				call _beeper + 100
			#endasm
			break;
		case 3:
			#asm
				call _beeper + 150
			#endasm
			break;
		case 4:
			#asm
				call _beeper + 200
			#endasm
			break;
		case 5:
			#asm
				call _beeper + 250
			#endasm
			break;
	}
}
