// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// This custom decoder works in three steps:
// 1.- Decode a RLE53 map to the buffers
// 2.- Embellish the buffer
// 3.- Renders the buffer

#define RLE_FORMAT 53

// Step 1: Decode to buffer. It uses map_attr as a temporal scratchpad.

	#asm
		// Get screen address from index.
		// RLE format

		._draw_scr_get_scr_address
			ld  a, (_n_pant)
			sla a
			ld  d, 0
			ld  e, a
			ld  hl, _mapa
			add hl, de 		; HL = map + (n_pant << 1)
			ld  e, (hl)
			inc hl
			ld  d, (hl) 	; DE = index
			ld  hl, _mapa
			add hl, de      ; HL = map + index
			ld  (_map_pointer), hl

		// Now decode & render the current screen 

		._draw_scr_rle
			xor a
			ld  (_gpit), a
			ld  (__x), a
			ld  (__y), a

		._draw_scr_loop
			ld  a, (_gpit)
			cp  150
			jr  z, _draw_scr_loop_done

			ld  hl, (_map_pointer)
			ld  a, (hl)
			inc hl
			ld  (_map_pointer), hl
			
			ld  c, a
		#if RLE_FORMAT == 44
			and 0x0f
		#elif RLE_FORMAT == 53
			and 0x1f
		#else
			and 0x3f
		#endif			
			ld  (_rdc), a

			ld  a, c
			ld  (_rdn), a

		._draw_scr_advance_loop
			ld  a, (_rdn)
		#if RLE_FORMAT == 44
			cp  0x10
		#elif RLE_FORMAT == 53			
			cp  0x20
		#else
			cp  0x40
		#endif

			jr  c, _draw_scr_advance_loop_done

		#if RLE_FORMAT == 44
			sub 0x10
		#elif RLE_FORMAT == 53
			sub 0x20
		#else
			sub 0x40
		#endif
			ld  (_rdn), a

			call _advance_worm

			// That's it!

			jr _draw_scr_advance_loop

		._draw_scr_advance_loop_done
			call _advance_worm

			jr _draw_scr_loop

		._advance_worm
			// Fill buffers
			// Note that this version just copies the tile value to map_attr
			// as it will be used as a scratchpad. Actual values are written later.
			ld  bc, (_gpit)
			ld  b, 0			
			ld  hl, _map_attr
			add hl, bc

			ld  a, (_rdc)
			ld  (hl), a

			// Advance cursor
			ld  a, (__x)
			inc a
			cp  15
			jr  c, _advance_worm_continue

			ld  a, (__y)
			inc a
			ld  (__y), a
			
			xor a
					
		._advance_worm_continue
			ld  (__x), a

			ld  hl, _gpit
			inc (hl)
			ret

		._draw_scr_loop_done			
	#endasm	

// Step 2: Embellish

	// Rules: are in the embellishments array which is N * { t C p s }, 0xff terminated.
	// you can reuse this embellishments processor if you like.
	/*
	for (gpit = 0; gpit < 150; ++ gpit) {
		_t = map_attr [gpit];
		_gp_gen = embellishments;
		while ((rda = *_gp_gen) != 0xff) {
			if (rda == _t) { 
			
				++_gp_gen; 
				rdc = *_gp_gen; ++_gp_gen; 	// command
				rdd = *_gp_gen; ++_gp_gen;	// parameter
				rdn = *_gp_gen; ++_gp_gen; 	// substitute
				rdb = 0x99;

				if (rdc & 2) {
					// Above or below
					if (rdc & 4) {
						// Below
						rda = gpit < 135 ? map_attr [gpit + 15] : 0xff;
					} else {
						// Above
						rda = gpit > 14 ? map_attr [gpit - 15] : 0xff;
					}

					// Compare
					if (rdc & 1) {
						// Not equal
						if (rda != rdd) rdb = rdn;
					} else {
						// Equal
						if (rda == rdd) rdb = rdn;
					}
				} else {
					rdb = rdn;
				}

				if (rdb != 0x99) {
					if (rdb & 0xc0) {
						rdb = (rdb & 0x3f) + (rand () & (rdb >> 6));
					}
					_t = rdb; 
					break;
				}
			} else _gp_gen += 4;
		}

		map_buff [gpit] = _t;
	}
	*/
	#asm

		._embellishment_processor
			xor a
			ld  (_gpit), a

		._mcd_ep_outter_loop
			ld  bc, (_gpit)
			ld  b, 0
			ld  hl, _map_attr
			add hl, bc
			ld  a, (hl)
			ld  (__t), a

			ld  hl, _embellishments
		._mcd_ep_inner_loop
			ld  a, (hl) 				// Tile number
			cp  0xff
			jp  z, _mcd_ep_continue

			ld  c, a 					// C -> Tile number
			ld  a, (__t) 				// A -> Current tile number
			cp  c
			jr  nz, _mcd_ep_next		// Not this one

			inc hl
			
			ld  a, (hl)
			ld  c, a
			ld  (_rdc), a 				// Command
			inc hl

			ld  a, (hl)
			ld  (_rdd), a 				// Parameter
			inc hl

			ld  a, (hl)
			ld  (_rdn), a 				// Substitute
			inc hl

			// Above/Below or same?
			ld  a, c
			and 2
			jr  z, _mcd_ep_check_same
			
			ld  a, c
			and 4
			jr  z, _mcd_ep_check_above

		._mcd_ep_check_below
			ld  a, (_gpit)
			cp  135
			jr  nc, _mcd_ep_inner_loop 	// Does not apply. Next.

			add 15
			jr  _mcd_ep_docheck

		._mcd_ep_check_above
			ld  a, (_gpit)
			cp  15
			jr  c, _mcd_ep_inner_loop	// Does not apply. Next.

			sub 15

		._mcd_ep_docheck
			ld  d, 0
			ld  e, a

			push hl
			ld  hl, _map_attr
			add hl, de
			ld  a, (hl)		
			pop hl
			
			ld  b, a 					// Save temp. to B
			ld  a, c
			and 1
			jr  z, _mcd_ep_docheck_equal

		._mcd_ep_docheck_not_equal
			ld  a, (_rdd) 				// Parameter
			cp  b 						// Saved
			jr  z, _mcd_ep_inner_loop	// Does not apply. Next.
			jr  _mcd_ep_check_same

		._mcd_ep_docheck_equal
			ld  a, (_rdd) 				// Parameter
			cp  b 						// Saved
			jr  nz, _mcd_ep_inner_loop	// Does not apply. Next.

		._mcd_ep_check_same
			ld  a, (_rdn) 				// Substitute
			ld  (__t), a 				// Do
			
			and 0xc0 					// Bit mask
			jr  z, _mcd_ep_continue

			call _rand 					// -> L

			ld  a, (__t)
			srl a
			srl a
			srl a
			srl a
			srl a
			srl a
			ld  b, a 					// B = _t >> 6
			ld  a, l 					// A = rand ()
			and b 						// A = rand () & (_t >> 6)
			ld  b, a 					// B = rand () & (_t >> 6)

			ld  a, (__t)
			add b
			ld  (__t), a
				
			jr  _mcd_ep_continue 		// And don't iterate further.

		._mcd_ep_next
			ld  bc, 4
			add hl, bc
			jp  _mcd_ep_inner_loop

		._mcd_ep_continue
			ld  bc, (_gpit)
			ld  b, 0
			ld  hl, _map_buff
			add hl, bc
			ld  a, (__t)
			ld  (hl), a

			ld  a, c
			inc a
			ld  (_gpit), a
			cp  150
			jp  nz, _mcd_ep_outter_loop

	#endasm

// Step 3: Render buffer and build map_attr

	rdx = rdy = 0;
	for (gpit = 0; gpit < 150; ++ gpit) {
		_x = rdx; _y = rdy; _t = map_buff [gpit]; 
		draw_coloured_tile_gamearea ();
		map_attr [gpit] = behs [_t];
		++ rdx; if (rdx == 15) { rdx = 0; ++ rdy; }
	}

// Wanna collab? Make the assembly code in this file better.
