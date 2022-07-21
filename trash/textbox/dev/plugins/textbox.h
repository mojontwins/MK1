// Textbox MK1 en forma de plugin
// Llámese desde donde más convenga.

// Los textos bla bla

#define TEXT_BUFF_SIZE 			256 		// Max. characters in text box
unsigned char text_buff [TEXT_BUFF_SIZE];	// Text will be unpacked to this buffer,
											// then displayed.

extern unsigned char textos_load [0];  		// texts.bin contains packed strings
#asm
	._textos_load
		BINARY "texts.bin"
#endasm

unsigned char keyp, stepbystep;  			// Used so you press anything and text flushes

unsigned char button_pressed (void) {
	return ((((joyfunc) (&keys)) & sp_FIRE) == 0);
}

void textbox (unsigned char n) {
	asm_int = n << 1;
	#asm
			; First we get where to look for the packed string			
			ld de, (_asm_int)			
			ld hl, _textos_load
			add hl, de

			; hl points to an index, read the offset to the string we want
			ld e, (hl)
			inc hl
			ld d, (hl)			
			ld hl, _textos_load
			add hl, de
			
			; Depack to text_buff:
			ld de, _text_buff
	
			; 5-bit scaped depacker by na_th_an
			; Contains code by Antonio Villena
			
			ld a, $80
	
		.fbsd_mainb
			call fbsd_unpackc
			ld c, a
			ld a, b
			and a
			jr z, fbsd_fin
			call fbsd_stor
			ld a, c
			jr fbsd_mainb	
	
		.fbsd_stor
			cp 31
			jr z, fbsd_escaped
			add a, 64
			jr fbsd_stor2
		.fbsd_escaped
			ld a, c
			call fbsd_unpackc
			ld c, a
			ld a, b
			add a, 32
		.fbsd_stor2
			ld (de), a
			inc de
			ret
	
		.fbsd_unpackc
			ld      b, 0x08
		.fbsd_bucle
			call    fbsd_getbit
			rl      b
			jr      nc, fbsd_bucle
			ret
	
		.fbsd_getbit
			add     a, a
			ret     nz
			ld      a, (hl)
			inc     hl
			rla
			ret        
			
		.fbsd_fin
			ld (de), a	
			;
			;					
	#endasm

	// String is depacked into the buffer, now let's show it.
	// First depacked byte in each string tells how many lines + 64 (for encoding reasons).

	gpit = text_buff [0] - 64;
	rda = 3 + (gpit << 1); 		// Bottom of the text box

	// Draw frame. Characters # $ % & ' ( ) and * are used to draw it
	
	_x = 3; _y = 3; _t = 6; _gp_gen = (unsigned char *) ("#$$$$$$$$$$$$$$$$$$$$$$$$%"); print_str ();
	
	for (_y = 4; _y < rda; _y ++) {
		_x = 3; _gp_gen = (unsigned char *) ("&                        '"); print_str ();
	}

	_x = 3; _gp_gen = (unsigned char *) ("())))))))))))))))))))))))*"); print_str ();

	// Draw text drom text_buff [1] onwards. 0 marks the EOL
	_y = 4; _x = 4; _gp_gen = text_buff + 1;

	keyp = 1;
	stepbystep = 1;
	while (rda = *_gp_gen ++) {
		if (rda == '%') {
			_x = 4; _y += 2;
		} else {
			// Output char
			#asm
					; enter:  A = row position (0..23)
					;         C = col position (0..31/63)
					;         D = pallette #
					;         E = graphic #

					ld  a, (_rda)
					sub 32
					ld  e, a

					ld  d, 71
					
					ld  a, (__x)
					ld  c, a

					ld  a, (__y)

					call SPPrintAtInv
			#endasm
			_x ++;
		}

		if (stepbystep) {
			beep_fx (1); 
			sp_UpdateNow ();
		}

		if (button_pressed ()) {
			if (keyp = 0) stepbystep = 0;
		} else keyp = 0;
	}

	sp_UpdateNow ();
	while (button_pressed ());
	espera_activa (5000);
}
