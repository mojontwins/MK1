// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

void persist_tile (void) {
	// c_screen_address must be set
	// gpaux must be COORDS (_x, _y)
	// rdt = substitute with this tile

	/*	
	_gp_gen = (c_screen_address + (gpaux >> 1));
	rda = *_gp_gen;

	if (gpaux & 1) {
		// Modify right nibble
		rda = (rda & 0xf0) | rdt;
	} else {
		// Modify left nibble
		rda = (rda & 0x0f) | (rdt<<4);
	}

	*_gp_gen = rda;
	*/

	#asm
			ld  a, (_rdt)
			ld  e, a

			ld  a, (_gpaux)
			ld  d, a
			srl a 
			ld  b, 0
			ld  c, a
			ld  hl, (_c_screen_address)
			add hl, bc
			ld  c, (hl)

			// gpaux is odd or even?
			ld  a, d
			and 1
			jr  z, persist_modify_left_nibble

		.persist_modify_right_nibble
			ld  a, c 
			and 0xf0 
			or  e 
			jr  persist_write

		.persist_modify_left_nibble
			sla e 
			sla e 
			sla e 
			sla e 
			
			ld  a, c
			and 0x0f
			or  e

		.persist_write
			ld  (hl), a
	#endasm
}
