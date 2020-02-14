// MTE MK1 (la Churrera) v5.0
// Copyleft 2010-2014, 2020 by the Mojon Twins

// In case you wanna do your own.

// This screen renderer decodes a RLE62 map and was created for a revamped version of Tenebra Macabre.
#define RLE_FORMAT 62
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
			ld  a, VIEWPORT_X
			ld  (__x), a
			ld  a, VIEWPORT_Y
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

			// Draw a tile
			// _x, _y are set; set _t (which happens to be on A)
			ld  (__t), a
			call _draw_coloured_tile

			// Advance cursor
			ld  a, (__x)
			add a, 2
			cp  VIEWPORT_X + 30
			jr  c, _advance_worm_continue

			ld  a, (__y)
			add a, 2
			ld  (__y), a
			
			ld  a, VIEWPORT_X
					
		._advance_worm_continue
			ld  (__x), a

			ld  hl, _gpit
			inc (hl)
			ret

		._draw_scr_loop_done			
	#endasm	
