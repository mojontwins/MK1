// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

#define PASSWORD_LENGTH	6
#define MENU_Y 			16
#define MENU_X			11
extern unsigned char passwords [0];
#asm
	._passwords
		defm "TETICA"
		defm "PICHON"
		defm "CULETE"
		defm "BUTACA"
#endasm

unsigned char *password = "****** ";

unsigned char check_password (void) {
	wyz_play_sound (SFX_START);

	_x = MENU_X; _y = MENU_Y    ; _t = 7; _gp_gen = " PASSWORD "; print_str ();
	_x = MENU_X; _y = MENU_Y + 1;       ; _gp_gen = "          "; print_str ();
	_x = MENU_X; _y = MENU_Y + 2;       ;                     print_str ();

	for (gpit = 0; gpit < PASSWORD_LENGTH; ++ gpit) password [gpit] = '.';
	password [PASSWORD_LENGTH] = ' ';

	gpit = 0;
	sp_WaitForNoKey ();
	_y = MENU_Y + 2; _t = 71; _gp_gen = password;
	while (1) {
		password [gpit] = '*';
		_x = 16 - PASSWORD_LENGTH / 2; print_str ();
		sp_UpdateNow ();
		
		do {
			gpjt = sp_GetKey ();
		} while (gpjt == 0);

		if (gpjt == 12 && gpit > 0) {
			password [gpit] = gpit == PASSWORD_LENGTH ? ' ' : '.';
			-- gpit;
		} else if (gpjt == 13) break;
		else if (gpjt > 'Z') gpjt -=32;

		if (gpjt >= 'A' && gpjt <= 'Z' && gpit < PASSWORD_LENGTH) {
			password [gpit] = gpjt; ++gpit;
		}

		wyz_play_sound (1);
		sp_WaitForNoKey ();
	}

	sp_WaitForNoKey ();

	// Check password
	_gp_gen = passwords;

	for (gpit = 0; gpit < MAX_LEVELS - 1; ++ gpit) {
		rda = 1; for (gpjt = 0; gpjt < PASSWORD_LENGTH; ++ gpjt) {
			if (password [gpjt] != *_gp_gen ++) rda = 0;
		}

		if (rda) return (1 + gpit);
	}

	return 0;
}

const unsigned char intro_text_0 = "'WILL BUILD A PRETTY LADY!'@SAID ELEUTERIO IN HIS NOOK@AND WITH A GRIN SHADY@AWAITS FOR THE MIX TO COOK";
const unsigned char intro_text_1 = "BUT AYE! THIS HAS GONE BAD!@'THIS AIN'T A PRETTY LADY'@'THIS IS A 'GOKU BAD'!'@SAID THE MONKEY, SHAKY";
const unsigned char intro_text_2 = "ANGRY, HE THREW GOKU AWAY,@AND IN A MOUNTAIN OF SOCKS@HE PUT HIM TO LAY@AND FLEW TO THE DOCKS.";
const unsigned char intro_text_3 = "BUT GOKU SOON AWOKE,@AND SWORE LIKE FEY@HE WOULD CHASE THAT BLOKE@AND MAKE HIM PAY!";
const unsigned char intro_text_4 = "MONKEY CALLS GOKU SCOURED:@'WE COULD MAKE A DEAL:@PICK UP SOME FLOWERS@FOR A LADY IN STILETTO HEELS'";
const unsigned char intro_text_5 = "'MONKEY, YOU SHALL PAY!'@'WAIT, MEET THIS LADY HERE'@SAID THE MONKEY IN DISARRAY@'I MADE HER FOR YOU, SEE!'";
const unsigned char intro_text_6 = "'GET OUT OF MY WAY, MAD APE'@SAID GOKU THROWING A PUNCH@AND WITH THE LADY HE ESCAPED@MARRIED AND BRED A BUNCH.";

const unsigned char intro_text_7 = "'ME HARE UNA MUJER ENCUERA'@DIJO ELEUTERIO EL MONO,@Y EN SU LABORATORIO ESPERA@QUE LA MEZCLA ESTE A TONO.";
const unsigned char intro_text_8 = "SIN EMBARGO, ALGO FUE FATAL:@NO SALIO UNA MUJER ENCUERA.@'ME HA SALIDO UN GOKU MAL!'@DIJO EL MONO CON CARRASPERA.";
const unsigned char intro_text_9 = "ENFADADO, AL GOKU DESECHO,@Y EN UN MONTON DE CALCETINES@DE CABEZA LO TIRO...@Y SE FUE A LOS MULTICINES.";
const unsigned char intro_text_A = "PERO GOKU DESPERTO,@Y JURO QUE SE VENGARIA@DE AQUEL QUE LO ENGENDRO@Y QUE NO LO QUERIA.";
const unsigned char intro_text_B = "EL MONO LLAMA A GOKU MAL@'TENGO ALGO QUE PROPONERTE:@REUNE UN RAMILLETE FLORAL,@UNA CHICA QUIERE CONOCERTE'";
const unsigned char intro_text_C = "'MONO, TENDRAS TU MERECIDO'@'TU NECESITAS NOVIA FORMAL'@CONTESTO EL MONO CONVENCIDO@'HE HECHO UNA MORTICIA MAL'";
const unsigned char intro_text_D = "'QUITA, YA NO ME INTERESAS'@DIJO GOKU DANDO UN MANOTAZO@SE MARCHO CON LA TIPA ESA@Y CERRO DANDO UN PORTAZO.";

const unsigned char *intro_texts [] = {
	intro_text_0, intro_text_1, intro_text_2, intro_text_3,
	intro_text_4,
	intro_text_5, intro_text_6,

	intro_text_7, intro_text_8, intro_text_9, intro_text_A,
	intro_text_B,
	intro_text_C, intro_text_D
};

const unsigned char pic_resource [] = {
	INTRO1_BIN, INTRO2_BIN, INTRO3_BIN, INTRO4_BIN,
	INTRO5_BIN,
	INTRO6_BIN, INTRO7_BIN
};

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

unsigned char introx, introy, stepbystep;
unsigned char intro_iterator;

void show_intro_text () {
	introx = INTRO_X;
	introy = INTRO_Y;
	stepbystep = 1;
	while (rda = *_gp_gen) { ++ _gp_gen;
		
		if (rda != '@') {
			// sp_PrintAtInv (introy, introx ++, INTRO_TEXT_COLOUR, rda - 32);
			#asm
					ld  a, (_rda)
					sub 32
					ld  e, a

					ld  a, (_introx)
					ld  c, a
					inc a
					ld  (_introx), a

					ld  a, (_introy)

					ld  d, INTRO_TEXT_COLOUR

					call SPPrintAtInv
			#endasm
		}

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
		if (rda == '@') {introy += 2; introx = INTRO_X;}
	}
	if (!stepbystep) sp_UpdateNow ();
}

void do_intro (unsigned char ini, unsigned char fin) {
	unsigned char text_offs = lang ? LANG_TEXT_OFFS : 0;
	for (intro_iterator = ini; intro_iterator <= fin; intro_iterator ++) {
		sp_UpdateNow ();
		get_resource (pic_resource [intro_iterator], 16384);
		show_intro_text (intro_texts [intro_iterator + text_offs]);
		espera_activa (SCREEN_WAIT);
		cortina ();
		sp_WaitForNoKey ();
	}
	blackout_area ();	
}
