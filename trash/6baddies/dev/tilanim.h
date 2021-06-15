// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// tilanim.h

void tilanims_reset (void) {
	#asm		
			ld  hl, _tilanims_ft
			ld  de, _tilanims_ft + 1 
			ld  bc, MAX_TILANIMS - 1
			xor a
			ld  (hl), a
			ldir
			ld  (_tacount), a
			ld  (_tait), a
			ld  (_max_tilanims), a
	#endasm
}

void tilanims_add (void) {
	#asm
			ld  de, (_max_tilanims)
			ld  d, 0

			ld  a, (__n)			
			ld  hl, _tilanims_xy
			add hl, de
			ld  (hl), a

			ld  a, (__t)
			ld  hl, _tilanims_ft
			add hl, de
			ld  (hl), a

			ld  a, e
			inc a
			ld  (_max_tilanims), a
	#endasm
}

void tilanims_do (void) {
	#asm
			ld  a, (_max_tilanims)
			or  a
			ret z

			ld  a, (_tait)
			add TILANIMS_PRIME
			cp  MAX_TILANIMS
			jr  c, _tilanims_tait_0_skip
			sub MAX_TILANIMS
		._tilanims_tait_0_skip
			ld  (_tait), a

			// Check counter for tilanim #tait
			ld  d, 0
			ld  e, a

			// Check of active
			ld  hl, _tilanims_ft
			add hl, de
			ld  a, (hl)
			or  a
			ret z

			// Flip bit 7
			ld  hl, _tilanims_ft
			add hl, de
			ld  a, (hl)
			xor 128
			ld  (hl), a			
			
			// Which tile?
			bit 7, a
			jr  z, _tilanims_no_flick

			inc a
		._tilanims_no_flick
			and 127
			ld  (__t), a
		
		// Draw tile
			ld  hl, _tilanims_xy
			add hl, de
			ld  a, (hl)
			ld  c, a
			srl a
			srl a
			srl a
			and 0xfe
			add VIEWPORT_X
			ld  (__x), a

			ld  a, c
			and 15
			sla a
			add VIEWPORT_Y
			ld  (__y), a

			call _draw_coloured_tile
			call _invalidate_tile
	#endasm
}
