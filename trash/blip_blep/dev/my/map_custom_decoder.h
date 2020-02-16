// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// This custom decoder works in three steps:
// 1.- Decode a RLE53 map to the buffers
// 2.- Embellish the buffer
// 3.- Renders the buffer

#define RLE_FORMAT 53

	// Step 1: Decode to buffers

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
			ld  bc, (_gpit)
			ld  b, 0
			
			ld  de, (_rdc)
			ld  d, 0
			ld  hl, _behs
			add hl, de
			ld  a, (hl)

			ld  hl, _map_attr
			add hl, bc
			ld  (hl), a

			ld  a, (_rdc)
			ld  hl, _map_buff
			add hl, bc
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

// Step 3: Embellish

// Rules:
// - Tile 1: alternate 1, 2 @ random
// - Tile 1: substitute by 3 if t!=1 beneath
// - Tile 5: substitute by 4 if t!=4 above
// - Tile 5: substitute by 5 if t!=5 beneath
// - Tile 10: substitute by 11 if t!=10 above
// - Tile 0: substitute by 29 if 28 or 29 above
for (gpit = 0; gpit < 150; ++ gpit) {
	rda = map_buff [gpit];
	if (gpit > 15) {
		rdb = map_buff [gpit - 15];
		switch (rda) {
			case 5:
				if (rdb != 4) rda = 4;
				break;
			case 10:
				if (rdb != 20) rda = 11;
				break;
			case 0:
				if (rdb == 28 || rdb == 29)
					rda = 29;
				break;
		}
	}
	if (gpit < 135) {
		rdb = map_buff [gpit + 15];
		switch (rda) {
			case 1: 
				if (rdb != 1) rda = 3;
				break;
			case 5;
				if (rdb != 5) rdb = 6;
				break;
		}
	}
	if (rda == 1) {
		rda += (rand () & 1);
	}
	map_buff [gpit] = rda;
}

// Step 4: Render buffer

