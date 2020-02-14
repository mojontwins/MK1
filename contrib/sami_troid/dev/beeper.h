// Beeper.h
// Sonidos creados para Sami Troid por Son Link

extern unsigned char beeper [];

#asm
	._beeper
		BINARY "../bin/beeper3.bin"
#endasm

/*
	TABLA DE SONIDOS

	n	Sonido
	----------
	0	Enemy destroyed
	1	Enemy hit
	2	Something
	3	Jump
	4	Player hit
	5	incubadora
	6	Shot
	7	Item #1		(item)
	8	Item #2		(key)
	9	Item #3		(life)

*/

void beep_fx (unsigned char n) {
   #asm
		xor a
		ld	(23624), a
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
				call _beeper + 450
			#endasm
			break;
		case 6:
			#asm
				call _beeper + 250
			#endasm
			break;
		case 7:
			#asm
				call _beeper + 300
			#endasm
			break;
		case 8:
			#asm
				call _beeper + 400
			#endasm
			break;
		case 9:
			#asm
				call _beeper + 350
			#endasm
			break;
	}
}
