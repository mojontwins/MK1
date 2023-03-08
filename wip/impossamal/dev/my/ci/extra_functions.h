// MTE MK1 (la Churrera) v5.10
// Copyleft 2010-2014, 2020-2023 by the Mojon Twins

	void blackout_area (void) {
		#asm
			ld  de, 22528 + 32 * VIEWPORT_Y + VIEWPORT_X
			ld  b, 20
		.bal1
			push bc
			ld  h, d 
			ld  l, e
			ld  (hl), 0
			inc de
			ld  bc, 29
			ldir
			inc de
			inc de
			pop bc
			djnz bal1
		#endasm
	}

	void break_horizontal (void) {		
		if (at1 & 16) {
			_x = cx1; _y = cy1; break_wall ();
		} 
		if (cy1 != cy2 && (at2 & 16)) {
			_x = cx1; _y = cy2; break_wall ();
		}
	}

	void break_vertical (void) {			
		if (at1 & 16) {
			_y = cy1; _x = cx1; break_wall ();
		} 
		if (cx1 != cx2 && (at2 & 16)) {
			_y = cy1; _x = cx2; break_wall ();
		}	
	}
	