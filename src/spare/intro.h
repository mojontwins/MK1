// intro.h
// Simple intro/cutscene generator.

// do_intro takes two parameters: first and last intro text portion to show.
// each text portion is a string (@ within a string is a line break) and is
// printed alongside a picture stored in the resource library.
// Text portion N will show picture BASE_PIC_RESOURCE + N.

#define INTRO_X				2		// Top-left X coordinate of text.
#define INTRO_Y 			12		// "   "    Y "          "  "
#define BASE_PIC_RESOURCE 	11		// Pic resources start here
#define INTRO_TEXT_COLOUR	71		// Text colour.
#define SCREEN_WAIT			250		// halts to wait after showing a screen.
#define LANG_TEXT_OFFS		7		// Add to message for second language text.

extern unsigned char intro_text_1 [0];
extern unsigned char intro_text_2 [0];
extern unsigned char intro_text_3 [0];
extern unsigned char intro_text_4 [0];
extern unsigned char intro_text_5 [0];
extern unsigned char intro_text_6 [0];
extern unsigned char intro_text_7 [0];
extern unsigned char intro_text_8 [0];
extern unsigned char intro_text_9 [0];
extern unsigned char intro_text_10 [0];
extern unsigned char intro_text_11 [0];
extern unsigned char intro_text_12 [0];
extern unsigned char intro_text_13 [0];
extern unsigned char intro_text_14 [0];
unsigned char *intro_texts [] = {
	intro_text_1, intro_text_2, intro_text_3, intro_text_4,
	intro_text_5,
	intro_text_6, intro_text_7,
	intro_text_8, intro_text_9, intro_text_10, intro_text_11,
	intro_text_12,
	intro_text_13, intro_text_14
};

#asm
		;    "----------------------------OOOOOOOOOOOOOOOOOOOOOOOOOOOO----------------------------OOOOOOOOOOOOOOOOOOOOOOOOOOOO"
	._intro_text_1
		defm "'WILL BUILD A PRETTY LADY!'@SAID ELEUTERIO IN HIS NOOK@AND WITH A GRIN SHADY@AWAITS FOR THE MIX TO COOK"
		defb 0
	._intro_text_2
		defm "BUT AYE! THIS HAS GONE BAD!@'THIS AIN'T A PRETTY LADY'@'THIS IS A 'GOKU BAD'!'@SAID THE MONKEY, SHAKY"
		defb 0
	._intro_text_3
		defm "ANGRY, HE THREW GOKU AWAY,@AND IN A MOUNTAIN OF SOCKS@HE PUT HIM TO LAY@AND FLEW TO THE DOCKS."
		defb 0
	._intro_text_4
		defm "BUT GOKU SOON AWOKE,@AND SWORE LIKE FEY@HE WOULD CHASE THAT BLOKE@AND MAKE HIM PAY!"
		defb 0
	._intro_text_5
		defm "MONKEY CALLS GOKU SCOURED:@'WE COULD MAKE A DEAL:@PICK UP SOME FLOWERS@FOR A LADY IN STILETTO HEELS'"
		defb 0
	._intro_text_6
		defm "'MONKEY, YOU SHALL PAY!'@'WAIT, MEET THIS LADY HERE'@SAID THE MONKEY IN DISARRAY@'I MADE HER FOR YOU, SEE!'"
		defb 0
	._intro_text_7
		defm "'GET OUT OF MY WAY, MAD APE'@SAID GOKU THROWING A PUNCH@AND WITH THE LADY HE ESCAPED@MARRIED AND BRED A BUNCH."
		defb 0
		
	._intro_text_8
		defm "'ME HARE UNA MUJER ENCUERA'@DIJO ELEUTERIO EL MONO,@Y EN SU LABORATORIO ESPERA@QUE LA MEZCLA ESTE A TONO."
		defb 0
	._intro_text_9
		defm "SIN EMBARGO, ALGO FUE FATAL:@NO SALIO UNA MUJER ENCUERA.@'ME HA SALIDO UN GOKU MAL!'@DIJO EL MONO CON CARRASPERA."
		defb 0
	._intro_text_10
		defm "ENFADADO, AL GOKU DESECHO,@Y EN UN MONTON DE CALCETINES@DE CABEZA LO TIRO...@Y SE FUE A LOS MULTICINES."
		defb 0
	._intro_text_11
		defm "PERO GOKU DESPERTO,@Y JURO QUE SE VENGARIA@DE AQUEL QUE LO ENGENDRO@Y QUE NO LO QUERIA."
		defb 0
	._intro_text_12
		defm "EL MONO LLAMA A GOKU MAL@'TENGO ALGO QUE PROPONERTE:@REUNE UN RAMILLETE FLORAL,@UNA CHICA QUIERE CONOCERTE'"
		defb 0
	._intro_text_13
		defm "'MONO, TENDRAS TU MERECIDO'@'TU NECESITAS NOVIA FORMAL'@CONTESTO EL MONO CONVENCIDO@'HE HECHO UNA MORTICIA MAL'"
		defb 0
	._intro_text_14
		defm "'QUITA, YA NO ME INTERESAS'@DIJO GOKU DANDO UN MANOTAZO@SE MARCHO CON LA TIPA ESA@Y CERRO DANDO UN PORTAZO."
		defb 0
#endasm

unsigned char introx, introy, stepbystep, character;
void show_intro_text (unsigned char *s) {
	introx = INTRO_X;
	introy = INTRO_Y;
	stepbystep = 1;
	while (*s) {
		character = (*s ++);
		if (character != '@') sp_PrintAtInv (introy, introx ++, INTRO_TEXT_COLOUR, character - 32);
		if (stepbystep) {
			#asm
				halt
				halt
				halt
				halt
			#endasm
			sp_UpdateNow ();
			#asm
				xor a
				in a, (254)
				cpl
				and 31
				jr z, _dafuq
			#endasm
			stepbystep = 0;		
			#asm
				._dafuq
			#endasm
		}
		if (character == '@') {introy += 2; introx = INTRO_X;}
	}
	if (!stepbystep) sp_UpdateNow ();
}

unsigned char intro_iterator;
void do_intro (unsigned char ini, unsigned char fin) {
	unsigned char text_offs = LANG_TEXT_OFFS * language;
	for (intro_iterator = ini; intro_iterator <= fin; intro_iterator ++) {
		sp_UpdateNow ();
		blackout_area ();
		get_resource (BASE_PIC_RESOURCE + intro_iterator, 16384);
		show_intro_text (intro_texts [intro_iterator + text_offs]);
		espera_activa (SCREEN_WAIT);
		sp_WaitForNoKey ();
	}
	blackout_area ();	
}
