// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// Splash screens and language selector

const unsigned char splash_screens [] = { LOGO_BIN, CONTROLS_BIN, DEDICADO_BIN };
unsigned char lang = 99;

// Password screen

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

// Cutscenes

extern unsigned char *intro_texts [0];

#asm
	._intro_text_0 defm "'WILL BUILD A PRETTY LADY!'@SAID ELEUTERIO IN HIS NOOK@AND WITH A GRIN SHADY@AWAITS FOR THE MIX TO COOK", 0
	._intro_text_1 defm "BUT AYE! THIS HAS GONE BAD!@'THIS AIN'T A PRETTY LADY'@'THIS IS A 'GOKU BAD'!'@SAID THE MONKEY, SHAKY", 0
	._intro_text_2 defm "ANGRY, HE THREW GOKU AWAY,@AND IN A MOUNTAIN OF SOCKS@HE PUT HIM TO LAY@AND FLEW TO THE DOCKS.", 0
	._intro_text_3 defm "BUT GOKU SOON AWOKE,@AND SWORE LIKE FEY@HE WOULD CHASE THAT BLOKE@AND MAKE HIM PAY!", 0
	._intro_text_4 defm "MONKEY CALLS GOKU SCOURED:@'WE COULD MAKE A DEAL:@PICK UP SOME FLOWERS@FOR A LADY IN STILETTO HEELS'", 0
	._intro_text_5 defm "'MONKEY, YOU SHALL PAY!'@'WAIT, MEET THIS LADY HERE'@SAID THE MONKEY IN DISARRAY@'I MADE HER FOR YOU, SEE!'", 0
	._intro_text_6 defm "'GET OUT OF MY WAY, MAD APE'@SAID GOKU THROWING A PUNCH@AND WITH THE LADY HE ESCAPED@MARRIED AND BRED A BUNCH.", 0

	._intro_text_7 defm "'ME HARE UNA MUJER ENCUERA'@DIJO ELEUTERIO EL MONO,@Y EN SU LABORATORIO ESPERA@QUE LA MEZCLA ESTE A TONO.", 0
	._intro_text_8 defm "SIN EMBARGO, ALGO FUE FATAL:@NO SALIO UNA MUJER ENCUERA.@'ME HA SALIDO UN GOKU MAL!'@DIJO EL MONO CON CARRASPERA.", 0
	._intro_text_9 defm "ENFADADO, AL GOKU DESECHO,@Y EN UN MONTON DE CALCETINES@DE CABEZA LO TIRO...@Y SE FUE A LOS MULTICINES.", 0
	._intro_text_A defm "PERO GOKU DESPERTO,@Y JURO QUE SE VENGARIA@DE AQUEL QUE LO ENGENDRO@Y QUE NO LO QUERIA.", 0
	._intro_text_B defm "EL MONO LLAMA A GOKU MAL@'TENGO ALGO QUE PROPONERTE:@REUNE UN RAMILLETE FLORAL,@UNA CHICA QUIERE CONOCERTE'", 0
	._intro_text_C defm "'MONO, TENDRAS TU MERECIDO'@'TU NECESITAS NOVIA FORMAL'@CONTESTO EL MONO CONVENCIDO@'HE HECHO UNA MORTICIA MAL'", 0
	._intro_text_D defm "'QUITA, YA NO ME INTERESAS'@DIJO GOKU DANDO UN MANOTAZO@SE MARCHO CON LA TIPA ESA@Y CERRO DANDO UN PORTAZO.", 0

	._intro_texts 
		defw _intro_text_0, _intro_text_1, _intro_text_2, _intro_text_3
		defw _intro_text_4, _intro_text_5, _intro_text_6
		defw _intro_text_7, _intro_text_8, _intro_text_9, _intro_text_A
		defw _intro_text_B, _intro_text_C, _intro_text_D
#endasm

const unsigned char pic_resource [] = {
	INTRO1_BIN, INTRO2_BIN, INTRO3_BIN, INTRO4_BIN,
	INTRO5_BIN,
	INTRO6_BIN, INTRO7_BIN
};

#define INTRO_X				2		// Top-left X coordinate of text.
#define INTRO_Y 			12		// "   "    Y "          "  "
#define BASE_PIC_RESOURCE 	11		// Pic resources start here
#define INTRO_TEXT_COLOUR	71		// Text colour.
#define SCREEN_WAIT			250		// halts to wait after showing a screen.
#define LANG_TEXT_OFFS		7		// Add to message for second language text.

unsigned char introx, introy, stepbystep;
unsigned char intro_iterator;
unsigned char text_offs;

// Big numbers for level splash screens

unsigned char levelnumbers [] = {
	 64, 65, 66, 66, 66, 66, 66,  0,  0, 
	 67, 68, 66, 66, 66, 66, 66,  0,  0, 
	  0,  0, 66, 66, 66, 66, 66,  0,  0, 
	  0,  0, 66, 66, 66, 66, 66,  0,  0, 
	  0,  0, 66, 66, 66, 66, 66,  0,  0, 
	 69, 66, 66, 66, 66, 66, 66, 66, 70, 
	 
	 71, 66, 66, 66, 66, 66, 66, 66, 72, 
	 66, 66, 73, 74, 74, 74, 75, 66, 66, 
	  0,  0, 76, 77, 78, 79, 66, 66, 80, 
	 81, 79, 66, 66, 82, 83, 84, 85,  0, 
	 66, 66, 86, 85,  0,  0,  0, 66, 66, 
	 66, 66, 66, 66, 66, 66, 66, 66, 66, 
	 
	 66, 66, 66, 66, 66, 66, 66, 66, 66, 
	 66, 66, 87, 88, 89, 90, 66, 91, 92, 
	  0, 93, 94, 95, 66, 66, 66, 96, 97, 
	 98, 68, 68, 68, 68, 68, 99, 66, 66,
	 66, 66,114,  0,  0,  0,115, 66, 66, 
	100, 66, 66, 66, 66, 66, 66, 66,101,
	
	  0,  0,102,103, 66,104,105,  0,  0,
	102,103, 66,104,105,  0,  0,  0,  0,
	 66,104,105,  0,106,106,  0,  0,  0,
	 66, 66, 66, 66, 66, 66, 66, 66, 66, 
	 66, 66, 66, 66, 66, 66, 66, 66, 66, 
	  0,  0,  0,  0, 66, 66,  0,  0,  0,
	  
	 66, 66, 66, 66, 66, 66, 66, 66, 66, 
	 66, 66,  0,  0,  0,  0,  0,  0,  0,
	 66, 66,107,108, 66, 66, 66,109,110,
	 68, 68,111,112,112,112,113, 66, 66,
	 66, 66,114,  0,  0,  0,115, 66, 66,
	100, 66, 66, 66, 66, 66, 66, 66,101
};	

