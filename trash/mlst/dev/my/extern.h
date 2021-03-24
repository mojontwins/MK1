// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// External custom code to be run from a script

unsigned char temp_string [] = "                        ";
unsigned char *gp_text;

//                        XXXXXXXXXXXXXXXXXXXXXX
unsigned char text0 [] = "AYUDAME, METETE POR%"
						 "LA PUERTA MAGICA Y%"
						 "TRAEME UNA BOTELLA.";

unsigned char text1 [] = "OLE TU TOTO MORENO!";	

unsigned char *texts [] = {
	text0, text1
};	 

void redraw_from_buffer (void) {
	#asm
			ld  a, VIEWPORT_X
			ld  (__x), a
			ld  a, VIEWPORT_Y
			ld  (__y), a
			
			xor a
		.redraw_from_buffer_loop
			ld  (_gpit), a

			ld  bc, (_gpit)
			ld  b, 0
			ld  hl, _map_buff
			add hl, bc
			ld  a, (hl)
			ld  (__t), a

			call _draw_coloured_tile
			call _invalidate_tile

			ld  a, (__x)
			add a, 2
			cp  VIEWPORT_X + 30
			jr  nz, redraw_from_buffer_set_x
			ld  a, (__y)
			add a, 2
			ld  (__y), a
			ld  a, VIEWPORT_X
		.redraw_from_buffer_set_x
			ld  (__x), a

			ld  a, (_gpit)
			inc a
			cp  150
			jr  nz, redraw_from_buffer_loop
	#endasm
}

void clear_temp_string (void) {
	#asm
			ld  hl, _temp_string
			ld  de, _temp_string+1
			ld  bc, 23
			ld  a, 32
			ld  (hl), a
			ldir
	#endasm
}

void show_text_box (unsigned char n) {
	gp_text = texts [n];

	// Text renderer will read the string and
	// build substrings for draw_text.

	//clear_temp_string ();
	_x = 4; _y = 6; _t = 48; _gp_gen = temp_string; print_str ();
	rdy = 7;

	while (1) {
		#asm
				// Fill buffer
				ld  de, _temp_string + 1
				ld  hl, (_gp_text)

			.fill_buffer_loop
				ld  a, (hl)
				or  a
				jr  z, fill_buffer_end
				cp  '%'
				jr  z, fill_buffer_end

				ld  (de), a

				inc hl
				inc de
				jr  fill_buffer_loop

			.fill_buffer_end
				ld  (_gp_text), hl
		#endasm

		_x = 4; _y = rdy ++; _t = 48; _gp_gen = temp_string; print_str ();
		clear_temp_string ();
		_x = 4; _y = rdy ++; _t = 48; _gp_gen = temp_string; print_str ();

		sp_UpdateNowEx (0);
		
		#asm
				ld  b, 20
			.textbox_delay
				halt
				djnz textbox_delay
		#endasm
	
		if (*gp_text == 0) break;
		gp_text ++;
	}	

	espera_activa (1000);
	redraw_from_buffer ();
}


void do_extern_action (unsigned char n) {
	// Add custom code here.	
	show_text_box (n);
}
